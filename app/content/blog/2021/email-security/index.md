---
title: Configuring DNS to send secure email in 2021
date: "2021-01-12"
summary: Even if you use a third-party email service like Mailchimp, Sendgrid, or AWS Simple Email Service, the security and deliverability of your emails depends on a set of DNS records on your domain.
---

{{<figure src="marvin-meyer-unsplash.jpg" width="5995" height="2186" alt="A stock photo depicting a group of laptops around a messy coffee shop table." caption="Designing the perfect email doesn’t matter if it’s sent to spam." attr="Marvin Meyer" attrlink="https://unsplash.com/photos/SYTO3xs06fU" >}}

Similar to how DNS indicates to web browsers which servers to contact to view a website at a domain, DNS also indicates to email clients which servers are authorized to send and receive email at a domain.

This problem is a bit different than web hosting, because emails are received, rather than requested. When loading a website, the browser performs a series of checks to determine which server to reach out to — however, when an email is received, how does the email client know the email originated from a trustworthy source? Let’s break this down, starting with a quick summary.

- **SPF** verifies that an email originated from an authorized server.

- **DKIM** verifies that the email was sent from an authorized source on the authorized server.

- **DMARC** lets email clients know what kind of security to expect when receiving email, and what to do when emails are received which do not have those security mechanisms.

- And lastly, **DNSSEC** proves that a DNS server is the authorized source of information for a domain.

## SPF verifies that an email originated from an authorized server

The Simple Mail Transport Protocol (SMTP) doesn’t include any assurances that an email is from an authorized source. In other words, anyone can contact an email host and claim to be sending email from any address at any domain.

The Sender Policy Framework (SPF) solves this problem by providing a list of authorized email servers.

When an email client receives an email, it makes a DNS request out to the sending email domain to check for a list of email servers authorized to send email.

A SPF DNS record is a `TXT` record with a specific format. For example, an SPF record for a domain which authorizes email to be sent from AWS Simple Email Service would be:

```text
v=spf1 include:amazonses.com -all
```

If the server sending the email is not on the list of authorized domains, the email fails the SPF check and is either rejected or delivered to a spam folder.

## DKIM verifies that the email was sent from an authorized source

Many applications use hosted email providers like Mailchimp, Sendgrid, or AWS Simple Email Service rather than running their own email server, and so any other application using the same email host has the same SPF headers. In other words, anyone using the same email host as you can pretend to be your application.

The DomainKeys Identified Mail (DKIM) standard solves this problem by signing outgoing emails using public/private key encryption.

When an email client receives an email with a DKIM signature, it makes a DNS request out to the sending email domain to request the public key used to generate the signature.

A DKIM DNS record can be either a `TXT` record of the signature itself or a `CNAME` indicating a redirect to a domain with the `TXT` record configured (to enable email services to manage their key renewals automatically).

```text
k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGMjj8MVaESl30KSPYdLaEreSYzvOVh15u9YKAmTLgk1ecr4BCRq3Vkg3Xa2QrEQWbIvQj9FNqBYOr3XIczzU8gkK5Kh42P4C3DgNiBvlNNk2BlA5ITN/EvVAn/ImjoGq5IrcO+hAj2iSAozYTEpJAKe0NTrj49CIkj5JI6ibyJwIDAQAB
```

If the message signature was not created by the public key retrieved or the key cannot be found, the email fails the DKIM check and is either rejected or delivered to a spam folder.

Additionally, since the message itself is signed, if content or headers within an email with a DKIM signature is changed while it is being delivered, the DKIM check fails.

## DMARC gives email clients a security policy to follow

Since email can still be sent and received without SPF (listing authorized servers) and DKIM (signing emails from a domain), an email client can’t know if an email is invalid (is missing security features and is spoofed or fake) or just not using modern security practices.

A Domain-based Message Authentication, Reporting, and Conformance (DMARC) policy solves this problem by indicating what security features are in use and what an email client should do if an email fails validation.

When an email client receives an email, it makes a DNS request out to the sending email domain to request the DMARC policy of the server.

A DMARC DNS record is a `TXT` record with a specific format. For example, to tell clients to reject emails which fail SPF and DKIM checks:

```text
v=DMARC1; p=reject; rua=mailto:dmarc-failure-reports@example.com; pct=100; adkim=s; aspf=s
```

Additionally, a DMARC policy can specify a report location where email clients can report emails which fail the policy, allowing you to be aware of fraudulent emails that are being sent from attackers.

## DNSSEC proves that a DNS server is the authorized source of information

The email client can now prove that the email message it received is sent from an authorized server, from an authorized source on that server and has not been tampered with as it has been delivered, and knows what to do if the email message fails validation methods. However, how does the email client know if they’ve been receiving information from an authorized DNS server?

Domain Name System Security Extensions (DNSSEC) solves this problem by performing a similar signing operation as DKIM, except to the DNS records themselves. The public key used for DNSSEC is published by your registrar under the top-level domain like `.com` or `.biz` using a `DS` record.

Your DNS provider will generate the `DS` record for you, and you will need to give it to your registrar to publish.

When an email client is making DNS requests to validate SPF, DKIM, or retrieving the domain’s DMARC policy, it can check the signature of the DNS response with your registrar’s `DS` record and verify that the DNS server is authorized to provide records for your domain.

Additionally, since the DNS response itself is signed, if any DNS records are changed while it is being delivered, the DNSSEC check fails.
