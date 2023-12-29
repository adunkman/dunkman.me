.DEFAULT_GOAL := help

.PHONY: start
start: ## Runs the full application stack locally
	@docker compose up

.PHONY: test
test: ## Run automated tests
	@docker compose run test

.PHONY: build
build: ## Generate compiled application files to prepare for a deployment
	@docker compose run hugo --

.PHONY: decrypt
decrypt: ## 🔒 Decrypts secret files to disk using SOPS
	@docker compose run --entrypoint sh sops -c "find /app/content/christmas-letters -type f -exec sops --decrypt --in-place {} \;"

.PHONY: encrypt
encrypt: ## 🔒 Encrypts secret files to disk using SOPS
	@docker compose run --entrypoint sh sops -c "find /app/content/christmas-letters -type f -exec sops --encrypt --in-place {} \;"

.PHONY: sh-metascraper
sh-metascraper: ## Open a shell in the metascraper docker image
	@docker compose run --entrypoint sh metascraper --

.PHONY: sh-hugo
sh-hugo: ## Open a shell in the hugo docker image
	@docker compose run --entrypoint sh hugo

.PHONY: sh-test
sh-test: ## Open a shell in the test docker image
	@docker compose run --entrypoint sh test

.PHONY: sh-terraform
sh-terraform: ## Open a shell in the terraform docker image
	@docker compose run --entrypoint sh terraform

.PHONY: sh-sops
sh-sops: ## Open a shell in the sops docker image
	@docker compose run --entrypoint sh sops

.PHONY: docker-rebuild-hugo
docker-rebuild-hugo: ## Rebuild docker image used for hugo
	@docker compose build hugo

.PHONY: docker-rebuild-test
docker-rebuild-test: ## Rebuild docker image used for test
	@docker compose build test

.PHONY: docker-rebuild-metascraper
docker-rebuild-metascraper: ## Rebuild docker image used for metascraper
	@docker compose build metascraper

.PHONY: docker-rebuild-terraform
docker-rebuild-terraform: ## Rebuild docker image used for terraform
	@docker compose build terraform

.PHONY: docker-rebuild-sops
docker-rebuild-sops: ## Rebuild docker image used for sops
	@docker compose build sops
.PHONY: clean
clean: ## Reset docker and clear temporary files
	@rm -rf ./app/public/
	@rm -rf ./app/resources/
	@rm -rf ./metascraper/node_modules/
	@rm -rf ./metascraper/cache/
	@rm -rf ./terraform/.terraform/
	@rm -rf ./terraform/plan
	@rm -rf ./test/node_modules/
	@docker compose down

.PHONY: tfsec
tfsec: ## Runs tfsec to scan for security issues
	@docker compose run tfsec /terraform

.PHONY: deploy
deploy: ## 🔒 Deploys compiled application files to static host
	@docker compose run hugo deploy --maxDeletes -1

.PHONY: terraform-init
terraform-init: ## 🔒 Runs terraform init
	@docker compose run terraform init

.PHONY: terraform-plan
terraform-plan: ## 🔒 Runs terraform plan
	@docker compose run terraform plan -out=plan

.PHONY: terraform-apply
terraform-apply: ## 🔒 Runs terraform apply
	@docker compose run terraform apply plan

.PHONY: help
help:
	@echo "Usage: make [task]\n\nAvailable tasks:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-27s\033[0m %s\n", $$1, $$2}'
	@echo "\n\033[33m(🔒) These tasks require AWS credentials configured via environment variables.\033[0m"
