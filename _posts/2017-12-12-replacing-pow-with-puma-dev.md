---
layout: blog
title: Migrating from .dev to .localhost with puma-dev
summary:
category: blog
---

I’ve been a long-time user of [Pow](http://pow.cx) to manage my local development environment. If you’re not familiar, it maps local hostnames like `http://myapp.dev` to a folder (say, `~/projects/myapp`) and will start/stop the `myapp` project’s development server with [Rack](https://rack.github.io/).

<p class="lede">This worked great… until Chrome 63.</p>

Chrome 63, released December 6, 2017, requires all `.dev` domains to be loaded over `https` because <a href="https://icannwiki.org/.dev">Google purchased the `.dev` top-level domain</a> and decided it would require `https` via [HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security).

I found this gem in the Pow [release notes](http://pow.cx/manual.html#section_6):

> This is the last release for the forseeable future. Check out [puma-dev](https://github.com/puma/puma-dev#readme) for a contemporary alternative.

# Migrating from pow to puma-dev

Although I could have upgraded Pow to fix the issue, Pow hasn’t been working well with features required to build more modern apps like websockets and SSL certificates — so I was well ready to move along to something new. My upgrade steps:

1. Uninstalled pow.

    ```bash
    curl get.pow.cx/uninstall.sh | sh
    ```
2. Installed puma-dev.

    ```bash
    brew install puma/puma/puma-dev
    ```
3. Ran `sudo puma-dev -setup` to do some more junk (configuring /etc/resolver, but you don’t need to know anything about that).
4. Ran `puma-dev -install -d localhost` to bind puma-dev to `.localhost` domains. I chose `.localhost` because it’s obvious what it’s doing (`myapp.localhost` clearly points to your machine) instead of the other newly-emerging standard, `.test`.
5. Ran `puma-dev link` in each app directory to symlink them to subdomains of `.localhost`.

Now, I’m able to access `http://myapp.localhost` happily (as well as `https://myapp.localhost`) again!
