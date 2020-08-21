---
title: XMBC and Hulu
date: "2011-09-30"
summary: Hulu isn’t officially supported on XBMC (a set-top box-like media application) — but with a lot of careful hacking, it can be run.
aliases:
  - /articles/xmbc-and-hulu.html
  - /blog/2011/xmbc-and-hulu.html
---

I recently installed "[XBMC Live](http://xbmc.org/)," the Ubuntu-based standalone Linux distribution of XBMC (a set-top box-like media application). If you’re familiar with [Boxee](http://boxee.tv), Boxee is based off XBMC.

Getting Hulu up and running on XBMC isn’t the easiest, and there aren’t too many good guides available out there. Steps to get Hulu up and running follow.

> TLDR: Check the [summary](#summary) if you are impatient. This process is not for those unfamiliar with Linux.

## Downloading and installing XBMC

I downloaded XBMC Live from [their download page](http://xbmc.org/download/), burned to a DVD, and popped it into my old desktop machine (an old Athlon64 with 1GB of RAM). The live DVD booted quickly, and after playing around for a few minutes, rebooted and installed to the machine.

## Adding Hulu

Hulu isn’t available on XBMC from the get-go (they had it, but Hulu requested it’s removal). There’s this pretty cool dude, who goes by Bluecop, who has created a plugin and released it in [his repository](http://code.google.com/p/bluecop-xbmc-repo/downloads/list). Download the ZIP file available at that link, copy it to your XBMC box (SFTP is available), and install it by navigating to "System → Add-ons → Install from ZIP file…" and selecting the file downloaded from Bluecop.

After installing the repository, navigate to "Videos → Add-ons → Get more… → Hulu" and install it!

## Updating librtmp

So close! If you tried it, you’ll notice that, although you can look through videos and select items (even from your queue, if you sign in), none will play. If you `tail ~/.xbmc/temp/xbmc.log`, you’ll see that Hulu’s video providers aren’t responding with "handshake 6," but rather "handshake 9."

This change was done around March of 2011, and in order to get Hulu working, you’ll need to update your version of librtmp (the library which streams the Flash video file from Hulu’s servers).

Source of RTMPDump is [available to download](http://rtmpdump.mplayerhq.hu/), and you’ll want to copy it to your XBMC box and compile (see the [summary below](#summary) for more details).

After building, copy (and replace) the files `librtmp.so, librtmp.a, librtmp.so.0` from the `librtmp` folder to `/usr/lib/`.

And you’re all set! Reboot (you can probably get buy with just restarting XBMC, but rebooting doesn’t hurt—so fast!) and you’ll be able to watch all the Hulu you can get your hands on.

## Summary

1. Download [XBMC Live CD](http://xbmc.org/download) and burn to disk.

2. Install to your media PC’s hard disk.

3. Download [Bluecop’s Add-ins repository](http://code.google.com/p/bluecop-xbmc-repo/downloads/list) and copy the ZIP file, without extracting, to your XBMC machine.

4. Navigate to "System → Add-ons → Install from ZIP file…" and select the ZIP file to install the repository.

5. Navigate to "Videos → Add-ons → Get more… → Hulu" and install the Add-on.

6. Download the [source of RTMPDump](http://rtmpdump.mplayerhq.hu/) and copy the source to your XBMC machine.

7. Compile RTMPDump and replace the XBMC version of librmtp with the new version.

    ```bash
    $ cd rtmpdump/
    $ make SYS=posix
    $ cd librtmp/
    $ sudo cp -f librtmp.so.0 /usr/lib/librtmp.so.0
    $ sudo cp -f librtmp.a /usr/lib/librtmp.a
    $ cd /usr/lib/
    $ sudo ln -s librtmp.so.0 librtmp.so
    ```

8. Reboot, and enjoy!
