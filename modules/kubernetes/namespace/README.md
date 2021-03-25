# Terraform Module: kubernetes/namespace

This Terraform module creates a preconfigured namespace on a given Kubernetes cluster.

## Input Variables

| Name | Type | Description | Default | Example |
| --- | --- | --- | --- | --- | 
| region_name | string | Name of an Azure region that hosts this solution (like West Europe) | | |
| region_code | string | Code of an Azure region that hosts this solution (like westeu for West Europe) | | |
| solution_name | string | Name of this Azure solution | | |
| solution_stage | string | Stage of this Azure solution (like E, K, P) | | |
| resource_group_name | string | The name of the resource group supposed to own all allocated resources | | |
| resource_group_location | string | The location of the resource group supposed to own all allocated resources | | |
| common_tags | map(string) | Map of common tags to be attached to all managed Azure resources

## Output Values

| Name | Type | Description |
| --- | --- | --- | 
