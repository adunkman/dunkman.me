---
layout: article
title: Disabling the Mac OS X Startup Chime
categories: code
---

**Update:** This is no longer compatible with newer Macs (OS X 10.6.8 and newer).

A big complaint about Mac laptops is that pretentious "startup chime" that quickly identifies to everyone within hearing distance that someone nearby has started their Mac. I've seen a few solutions that require `defaults write` but they have never seemed to work for me. I've finally found a working solution, and it's elegant(ish).

The solution comes from [Arcana Research](http://www5e.biglobe.ne.jp/~arcana/index.en.html). They've created a Preferences Pane for your Mac's System Preferences that allows you to adjust the volume of your startup chime (or mute it!). It's [available as freeware](http://www5e.biglobe.ne.jp/~arcana/software.en.html) and compatible with OS X 10.4 <del>and later</del> through 10.6.8.

It might take a reboot before the software takes affect. In actuality what the software does is save your current volume setting on shutdown, adjust your volume to your "startup volume" setting, and after the computer boots, changes your volume back to where it was.
