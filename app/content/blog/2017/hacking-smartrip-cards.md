---
title: Hacking WMATA SmarTrip Cards
date: "2017-03-30"
summary: An overview of the technical details of Washington DC’s transit cards, including which off-the-shelf RFID readers were able to read card data.
aliases:
  - /blog/2017/hacking-smartrip-cards.html
---

Many residents of Washington, DC carry RFID WMATA Smartrip transit cards in their wallets. What if we used those cards to sign in to Meetups?

This was the question which started my quest to understand more about the Washington-area transit cards — and although I never followed through on implementing anything further than a proof-of-concept, here’s what I learned along the way.

## The cards

Smartrip cards are [ISO-14443 Type A](https://en.wikipedia.org/wiki/ISO/IEC_14443) conforming cards, operating at 13.56 MHz (RFID HD). The current iteration of Smartrip cards are [MIFARE Plus X](https://en.wikipedia.org/wiki/MIFARE) cards, which use [AES-128](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard) encryption to store card data used to access fare information.

I was able to read basic data off the card, including a card identifier that can be used as an autentication mechanism (although, since this is in the unencrypted block of data, it certainly isn’t a good idea to use the identifier for anything critical). I originally used an Arduino Yún with an [Adafruit PN532 NFC/RFID Controller Shield](https://www.adafruit.com/products/789) attached, but I’ve also had success reading the card identifier using a [generic USB reader](https://www.amazon.com/gp/product/B00BYKPHSU/) I purchased off Amazon for less than $20 (it emulates a USB keyboard and simply types the card ID when a card is scanned).

## Resources

The most useful source of information I came across was [Security of the Metro System Cards](http://ece.gmu.edu/coursewebpages/ECE/ECE646/F15/project/F13_Project_Resources/F12_subway_report.pdf), a paper published by Aaron Hunter and Cesar Corzo out of George Mason University.

Hope this helps you with your Smartrip hacks! Let me know if this helped you out, and especially if you come up with a project!
