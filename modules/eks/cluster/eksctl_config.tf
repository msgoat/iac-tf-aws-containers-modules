locals {
  eksctl_config = <<EOT
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: ${local.eks_cluster_name}
  region: ${var.region_name}
  version: ${var.kubernetes_version}
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
      attachIDs: [ "sg-01b86aa832c6b1d31" ]
%{ endfor ~}
EOT
}