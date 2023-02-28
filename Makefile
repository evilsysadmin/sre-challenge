install:
	scripts/apps_setup.sh install

uninstall:
	scripts/apps_setup.sh uninstall

setup-k8s-context:
	scripts/setup-k8s-context.sh

tf-remote-state:
	terraform -chdir=terraform/remote-state init
	terraform -chdir=terraform/remote-state plan -var-file=../shared-vars/terraform.tfvars -out=plan.out 
	terraform -chdir=terraform/remote-state apply plan.out 

tf-remote-state-destroy:
	terraform -chdir=terraform/remote-state init
	terraform -chdir=terraform/remote-state plan -var-file=../shared-vars/terraform.tfvars -out=plan.out -destroy
	terraform -chdir=terraform/remote-state apply plan.out

tf-init:
	terraform -chdir=terraform init

tf-plan: tf-init
	terraform -chdir=terraform plan -var-file=shared-vars/terraform.tfvars -out=plan.out

tf-apply: tf-init tf-plan
	terraform -chdir=terraform apply plan.out

tf-destroy: tf-init 
	terraform -chdir=terraform plan -var-file=shared-vars/terraform.tfvars -out=plan.out -destroy
	terraform -chdir=terraform apply plan.out 
	@make tf-remote-state-destroy

bootstrap: tf-remote-state tf-init tf-plan tf-apply
	@scripts/setup-k8s-context.sh
	@install

