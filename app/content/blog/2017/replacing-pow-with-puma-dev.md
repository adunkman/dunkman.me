---
title: Migrating from .dev to .localhost with puma-dev
date: "2017-12-12"
summary: I’ve been a long-time user of Pow, but with Google’s purchase of the .dev top-level domain, I’m in search of a new way of running Rack-compatible local applications. I’ve found puma-dev to work well over the new top-level domain of .localhost.
aliases:
  - /blog/2017/replacing-pow-with-puma-dev.html
---

I’ve been a long-time user of [Pow](http://pow.cx) to manage my local development environment. If you’re not familiar, it maps local hostnames like `http://myapp.dev` to a folder (say, `~/projects/myapp`) and will start/stop the `myapp` project’s development server with [Rack](https://rack.github.io/).

This worked great… until Chrome 63.

Chrome 63, released December 6, 2017, requires all `.dev` domains to be loaded over `https` because [Google purchased the `.dev` top-level domain](https://icannwiki.org/.dev) and decided it would require `https` via [HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security).

I found this gem in the Pow [release notes](http://pow.cx/manual.html#section_6):

> This is the last release for the forseeable future. Check out [puma-dev](https://github.com/puma/puma-dev#readme) for a contemporary alternative.

# Migrating from pow to puma-dev

Although I could have upgraded Pow to fix the issue, Pow hasn’t been working well with features required to build more modern apps like WebSockets and SSL certificates — so I was well ready to move along to something new. My upgrade steps:

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
6. You may need to resolve a Root CA issue, see below.

Now, I’m able to access `http://myapp.localhost` happily (as well as `https://myapp.localhost`) again!

# Resolved Root CA Issue

After following the above steps, I began to have an issue where the automatically-generated SSL certificates used for HTTPS were only trusted in some cases. Turns out the issue was that puma-dev had installed the root CA certificate in my login keychain, and not in the system one. To fix:

1. Launch “Keychain Access” from Applications.
2. Search for the “Puma-dev CA” certificate.
3. Drag the certificate to the “System” keychain.
4. Enter your password to allow the change.
5. Restart the application where certificates were not trusted (Chrome, for example).
