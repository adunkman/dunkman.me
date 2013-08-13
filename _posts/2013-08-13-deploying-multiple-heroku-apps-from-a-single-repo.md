---
layout: article
title: Deploying Multiple Heroku Apps From a Single Repo
categories: code
---

<div class="cross-post">Cross-posted from the <a href="http://techtime.getharvest.com/blog/deploying-multiple-heroku-apps-from-a-single-repo">Harvest Tech Time</a> blog.</div>

We’ve been toying around with [socket.io](http://socket.io) recently at Harvest to make our apps more responsive — and one of the big challenges that presented itself was how to manage and deploy a polyglot application on [Heroku](http://heroku.com) (as most of our application code is in Ruby, but socket.io is a [node.js](http://nodejs.org) project).

Since the “web” process is the only process to receive HTTP traffic and only one web process per application is allowed, we needed to deploy the Ruby and node.js parts of the application separately.

Traditionally, there is a one-to-one mapping of repositories to apps on Heroku — but we wanted to keep both apps in the same repository (as they’re really the same thing, conceptually) and yet deploy them as two apps on Heroku. So, what’s standing in the way?

## Heroku Buildpacks

Heroku uses this thing called [buildpacks](https://devcenter.heroku.com/articles/buildpacks) — the utilities and frameworks that are required to fetch your app and install dependencies. There are different buildpacks for [ruby](https://github.com/heroku/heroku-buildpack-ruby) and [node.js](https://github.com/heroku/heroku-buildpack-nodejs) on Heroku.

Buildpacks are usually automatically chosen — but since we’re pushing the same code to both apps, the order in which buildpacks are selected matters. Turns out that ruby is preferred over node.js.

No worries, you can [select a buildpack manually](https://devcenter.heroku.com/articles/buildpacks#using-a-custom-buildpack) with an environmental variable on Heroku’s server — which is what we did to the node.js app, and it worked like a charm.

## Procfiles and Foreman

The only other thing standing in our way was the way that Heroku starts web workers — using Foreman and a Procfile to define processes.

With ruby applications, the [Procfile is optional](https://devcenter.heroku.com/articles/procfile) — it will try to start a Rails application if it isn’t specified.

When deploying node.js to Heroku, you must specify a Procfile — there is no default command to start a server. Since we want to be able to push the same code to both Heroku remotes without any modifications, we got a little clever with the web process in the Procfile — it executes a shell script which examines the environment and runs the proper web process.

```bash
#!/bin/bash

if [ "$RAILS_DEPLOYMENT" == "true" ]; then
  bundle exec rails server -p $PORT
else
  node node/index.js
fi
```

Procfile:

```
web: bin/web
```

Hat tip to [David Dollar](http://david.dollar.io/) (the creator of Foreman) [for the idea](https://github.com/ddollar/anvil/blob/e1e98999fe7b1c53e9761c9b3ec804b6a3256e73/bin/web).

Happy polyglotin’!

<style>
  .cross-post {
    margin-bottom: 1em;
    color: #aaa;
  }

  .cross-post a, .cross-post a:link {
    color: #aaa;
    text-decoration: underline;
  }

  .cross-post a:hover {
    color: #333;
  }
</style>
