locals {
  generated_eksctl_config_filename = "${local.eks_cluster_name}.yaml"
  normalized_eksctl_config_dirname = trimsuffix(var.eksctl_config_file_dir, "/")
  eksctl_config_filename = "${local.normalized_eksctl_config_dirname}/${local.generated_eksctl_config_filename}"
  eksctl_config = <<EOT
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: ${local.eks_cluster_name}
  region: ${var.region_name}
  version: "${var.kubernetes_version}"
  tags:
%{ for key, value in local.module_common_tags ~}
    ${key}: "${value}"
%{ endfor ~}

vpc:
  subnets:
    public:
%{ for subnet in data.aws_subnet.subnets ~}
      ${subnet.availability_zone}: { id: "${subnet.id}" }
%{ endfor ~}
  clusterEndpoints:
    publicAccess: true
    privateAccess: true

nodeGroups:
%{ for subnet in data.aws_subnet.subnets ~}
  - name: ng-${subnet.availability_zone}-spot-v1
    minSize: ${var.node_group_min_size}
    maxSize: ${var.node_group_max_size}
    availabilityZones:
      - ${subnet.availability_zone}
    instancesDistribution:
      maxPrice: 0.04
      instanceTypes:
        - m6g.large
        - m5a.large
        - m5.large
        - m4.large
        - t3a.large
        - t3.large
        - t2.large
      onDemandBaseCapacity: 0
      onDemandPercentageAboveBaseCapacity: 0
      spotInstancePools: 10
    iam:
      withAddonPolicies:
        imageBuilder: true
        autoScaler: true
        externalDNS: true
        certManager: true
        appMesh: true
        ebs: true
        fsx: true
        efs: true
        albIngress: true
        xRay: true
        cloudWatch: true
    tags:
%{ for key, value in local.module_common_tags ~}
      ${key}: "${value}"
%{ endfor ~}
    securityGroups:
      withShared: true
      withLocal: true
      attachIDs: [ "${aws_security_group.ingress.id}" ]
%{ endfor ~}
    targetGroupARNs:
      - ${data.aws_alb_target_group.cluster.arn}

EOT
}

# creates a eksctl config file named like the EKS cluster at the given location
resource local_file eksctl_config_at_dirname {
  content = local.eksctl_config
  filename = local.eksctl_config_filename
}
