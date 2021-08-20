---
title: Running one-off tools from docker compose profiles
date: "2021-08-19"
summary: Your development tools deserve to be versioned, easily installed, and quickly run from docker — and using docker compose with profiles enabled can make your team happier and more productive.
---

{{<figure src="guillaume-bolduc-unsplash.jpg" width="4430" height="1311" alt="A stock photo of a wall of shipping containers stacked densely." caption="Containers keep your application and its dependencies versioned, why wouldn’t you do the same for your one-off tools?" attr="Guillaume Bolduc" attrlink="https://unsplash.com/photos/uBe2mknURG4" >}}

Docker compose is a tool for running a set of container images — think an application and its database layer — at once and in order. It provides `docker compose up` — a single command to boot all containers.

One of its benefits is the configuration of what ports to expose to your host operating system, what folders to mount where within the image, what environment variables to set, and how to network the containers together in a yaml configuration file named `docker-compose.yml`.

But what about the ad-hoc commands you need to run when building an application? Your database migrations, linters, security scanners, and deployment tools?

## Keeping tools separate with docker compose run

Another tool in the compose toolbox is `docker compose run`. You might have used `run` to open a command line within your application’s docker image to debug something or connecting to a database terminal within a `postgres` image.

Another useful way to use `docker compose run` is with small, single-purpose docker images that expose a single command or tool — like [`aws`](https://hub.docker.com/r/amazon/aws-cli), [`terraform`](https://hub.docker.com/r/hashicorp/terraform/), or [`zap`](https://hub.docker.com/r/owasp/zap2docker-stable/). It’s especially handy to have the versions of these tools and their dependencies locked down across your team.

Adding these tools to your `docker-compose.yml` file as services allows you to run them directly from docker compose — for example, `docker compose run aws s3 sync` or `docker compose terraform plan` — and you’ll always have the correct version installed and running. Great! No more fighting over terraform state versions.

However, now when you run `docker compose up`, you’ve got a bunch of extra images booting…

## Using profiles to limit which containers start

Docker compose has a less-known feature called [profiles](https://docs.docker.com/compose/profiles/) that allows you to configure groups of services to boot under different conditions. If we group all of our one-off commands into a profile that we never boot, we can get our desired behavior with a slick command line interface.

**For your application services,** like your app code and database layer, leave no profile configured. They’ll always start when running `docker compose up`.

**For your one-off commands or utilities,** add them to a profile (any name will do, since you don’t intend to use it by name). This prevents them from starting when running `docker compose up`, but still allows you to access the images with `docker compose run`:

```yaml
services:
  aws:
    profiles: ["utilities"]
```

Hope this helps keep your tooling versioned, within reach, and improves your experience using docker compose!
