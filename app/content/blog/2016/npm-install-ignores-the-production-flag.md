---
title: NPM Install Ignores the --production Flag
date: "2016-02-24"
summary: When running npm install with the --production flag, the presence of a shrinkwrap file can cause it to install packages not listed as production dependencies.
aliases:
  - /code/npm-install-ignores-the-production-flag.html
  - /blog/2016/npm-install-ignores-the-production-flag.html
---

I recently came across an issue where `npm install --production` was installing modules listed in the `devDependencies` section of my `package.json` — in other words, it appeared that the `--production` flag was being ignored.

Turns out this was because they were listed in `npm-shrinkwrap.json` — all dependencies listed in `npm-shrinkwrap.json` will be installed in production, even if they are not in the `dependencies` section of your `package.json`.

Hopefully this saves you some time! :)
