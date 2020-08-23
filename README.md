[![Build status for the main branch on CircleCI](https://circleci.com/gh/adunkman/dunkman.me/tree/main.svg?style=svg)](https://circleci.com/gh/adunkman/dunkman.me/tree/main)

This repository holds the application code and infrastructure for [dunkman.me](https://www.dunkman.me).

## Architecture

### Runtime environment

The site is a static site that runs on [Amazon Web Services (AWS)](https://aws.amazon.com/).

  - The files are stored in an [S3 bucket](https://aws.amazon.com/s3/) configured for [static web hosting](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html).
  - They are presented to you via [CloudFront](https://aws.amazon.com/cloudfront/), which uses a TLS certificate for https generated and auto-renewed by [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/).
  - DNS which points the domain to the appropriate CloudFront distribution is managed by [Route 53](https://aws.amazon.com/route53/).

The domain is purchased through [Namecheap](https://www.namecheap.com/).

  - Namecheap’s nameservers are overridden manually to point to Route53’s nameservers as configured in this repository.

### Deployment process

- The site is built with [Hugo](https://gohugo.io/).
- All infrastructure changes are automated with [Terraform](https://www.terraform.io/).
- On code changes [CircleCI](https://circleci.com/) uses [Docker](https://www.docker.com/) to apply any infrastructure changes, build the site, and upload it.

## Running locally

To get started in development, you’ll need [Docker](https://www.docker.com/) installed. Then, run the following command in the project directory after it’s been cloned:

```bash
docker-compose up hugo
```

- The website will be accessible at [localhost:1313](http://localhost:1313/).
- The site will live reload on updates to the source files.

To quit the command, hit <kbd>Ctrl</kbd>+<kbd>C</kbd>.

### Running without Docker

Running the application without Docker is not recommended. If you must, review the [app Dockerfile](app/Dockerfile) to see what dependencies are needed, manually install those specific versions locally, and run the application as the Dockerfile describes.

## Deploying

The site deploys automatically in CircleCI. To preview changes made by Terraform, use Docker.

```bash
docker-compose run terraform plan
```

**Note:** This command requires access to the application’s AWS account. Credentials are configured through `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_DEFAULT_REGION` environment variables.

To make things simpler for routine use, these variables are also read out of a `.env` file in the project root directory (which is git ignored) [automatically by docker-compose](https://docs.docker.com/compose/env-file/).

```bash
AWS_ACCESS_KEY_ID=[Your key]
AWS_SECRET_ACCESS_KEY=[Your secret]
AWS_DEFAULT_REGION=us-east-1
```

## Rebuilding the Docker images

Rebuild the Docker images when versions of installed dependencies change:

```bash
docker-compose build
```

## Contributing

Yes please! I’d love to have your contributions to this project — including typo fixes, infrastructure changes, and everything in-between.

- For larger changes, feel free to [open an issue](https://github.com/adunkman/dunkman.me/issues/new/choose) to discuss the changes if you’d like to discuss before investing time in it.

Continue reading in [CONTRIBUTING](CONTRIBUTING.md).
