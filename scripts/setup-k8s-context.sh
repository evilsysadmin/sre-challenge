#!/usr/bin/env bash

set -e

project_id=$(cat terraform/shared-vars/terraform.tfvars | grep project_id | awk {'print $3'} | sed 's/\"//g')
cluster_name=$(cat terraform/shared-vars/terraform.tfvars | grep cluster_name | awk {'print $3'} | sed 's/\"//g')

echo "Ok.I am going to setup your kubeconfig for cluster ${cluster_name} of ${project_id}"

gcloud container clusters get-credentials ${cluster_name} --region us-west1 --project ${project_id}