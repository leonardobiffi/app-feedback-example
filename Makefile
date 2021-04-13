# HELP
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

init: tf-init ## Execute terraform init

# Create Environment
create: tf-apply dc-up ## ## Execute terraform apply and docker-compose up

tf-init:
	cd terraform && terraform init --backend-config="key=feedback/terraform.tfstate" \
	--backend-config="bucket=${AWS_BUCKET_TFSTATE}" \
	--backend-config="region=${AWS_DEFAULT_REGION}"

tf-apply:
	cd terraform && terraform apply -auto-approve

# Up Environment
up: dc-up ## Execute docker-compose up

dc-up:
	docker-compose up -d --build

# Down Environment
down: dc-down ## Execute docker-compose down

dc-down:
	docker-compose down

# Terraform destroy
destroy: dc-down tf-destroy ## Exexute docker-compose down and terraform destroy

tf-destroy:
	cd terraform && terraform destroy -auto-approve

# Test Request
test: curl-test ## Execute test request to API

curl-test:
	curl --location --request POST 'http://localhost/v1/feedback' --header 'Content-Type: application/json' --data-raw '{"feedback": "Feedback Test"}'