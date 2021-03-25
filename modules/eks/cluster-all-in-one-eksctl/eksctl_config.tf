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
%{ for subnet in aws_subnet.public_subnets ~}
      ${subnet.availability_zone}: { id: "${subnet.id}" }
%{ endfor ~}
  clusterEndpoints:
    publicAccess: ${var.public_access_enabled}
    privateAccess: ${var.private_access_enabled}

managedNodeGroups:
%{ for subnet in aws_subnet.public_subnets ~}
  - name: mng-${subnet.availability_zone}-${var.kubernetes_cluster_name}-spot-v1
    amiFamily: "AmazonLinux2"
    subnets:
      - ${subnet.id}
    desiredCapacity: ${local.node_group_desired_size}
    minSize: ${var.node_group_min_size}
    maxSize: ${var.node_group_max_size}
    volumeSize: ${var.node_group_volume_size}
    volumeType: ${var.node_group_volume_type}
%{ if var.node_group_volume_encryption_enabled ~}
    volumeEncrypted: true
    volumeKmsKeyID: ${aws_kms_key.cmk.arn}
%{ endif ~}
    ssh:
      allow: false
    tags:
%{ for key, value in local.module_common_tags ~}
      ${key}: "${value}"
%{ endfor ~}
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
    instanceTypes:
%{ for instanceType in var.node_group_instance_types ~}
      - ${instanceType}
%{ endfor ~}
    spot: true
%{ endfor ~}

secretsEncryption:
  keyARN: ${aws_kms_key.cmk.arn}

EOT
}

# creates a eksctl config file named like the EKS cluster at the given location
resource local_file eksctl_config_at_dirname {
  content = local.eksctl_config
  filename = local.eksctl_config_filename
}
