.DEFAULT_GOAL := help

.PHONY: start
start: ## Runs the full application stack locally
	@docker-compose up

.PHONY: test
test: ## Run automated tests
	@docker-compose run test

.PHONY: build
build: ## Generate compiled application files to prepare for a deployment
	@docker-compose run hugo --

.PHONY: docker-rebuild-app
docker-rebuild-app: ## Rebuild docker image used for hugo
	@docker-compose build hugo

.PHONY: docker-rebuild-metascraper
docker-rebuild-metascraper: ## Rebuild docker image used for metascraper
	@docker-compose build metascraper

.PHONY: docker-rebuild-terraform
docker-rebuild-terraform: ## Rebuild docker image used for terraform
	@docker-compose build terraform

.PHONY: clean
clean: ## Reset docker and clear temporary files
	@rm -rf ./app/public/
	@rm -rf ./app/resources/
	@rm -rf ./metascraper/node_modules/
	@rm -rf ./terraform/.terraform/
	@rm -rf ./terraform/plan
	@rm -rf ./test/node_modules/
	@docker-compose down

.PHONY: tfsec
tfsec: ## Runs tfsec to scan for security issues
	@docker-compose run tfsec /terraform

.PHONY: deploy
deploy: ## 🔒 Deploys compiled application files to static host
	@docker-compose run hugo deploy --maxDeletes -1

.PHONY: terraform-init
terraform-init: ## 🔒 Runs terraform init
	@docker-compose run terraform init

.PHONY: terraform-plan
terraform-plan: ## 🔒 Runs terraform plan
	@docker-compose run terraform plan -out=plan

.PHONY: terraform-apply
terraform-apply: ## 🔒 Runs terraform apply
	@docker-compose run terraform apply plan

.PHONY: help
help:
	@echo "Usage: make [task]\n\nAvailable tasks:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-27s\033[0m %s\n", $$1, $$2}'
	@echo "\n\033[33m(🔒) These tasks require AWS credentials configured via environment variables.\033[0m"
