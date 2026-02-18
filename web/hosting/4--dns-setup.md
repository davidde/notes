# Configuring DNS records
To link a domain name to a VPS server, the **Domain Name System or DNS** has to be properly configured.  
This is the overarching system that is used to **map IP addresses to domain names**.  
This mapping is performed by *nameservers* that are usually managed by either your domain name registrar
or your hosting company.  
It is generally recommended to use your registrar's nameservers;
after all it is their core function to maintain good DNS service. And more importantly,
using your hosting company's nameservers needlessly adds an extra vulnerability to the equation;
now your domain can be hijacked in two places.

## Configuring DNS records through your registrar
Once a domain is registered by someone, its owner can edit the domain's DNS Host Records.
We will walk you through the required steps for our registrar of choice, Porkbun.
However, the process is similar on other registrars (and most registrars have decent documentation on how to do this).

* Log in to your domain registrar’s dashboard, find your domain and click the `Details` (or `MANAGE`) button.
* Find the `DNS RECORDS` option and click edit.
Scroll down, and you will be presented with a table of the currently present records.
Most likely these are 2 'A' records, one for your root domain, and one for all subdomains.  
`A Record` stands for "Address Record", and this is where you will place your server IP address.
Right now these A records are pointing to a Porkbun IP address indicating your site is 'Parked on the Bun'
(visit your site to view the Porkbun piglet ;)  
Simply delete these A records, as we need to replace them.
(If there are TXT records present, leave them be, as they are relevant for SSL encryption.)  
* Scroll back up to the top of the Manage DNS Records screen to add the correct A records.   
There are four fields you must fill in:
  - Type: Type of the record, e.g. A = Address Record.
  - Host: Either enter a subdomain, or leave blank for the root domain.
  - Answer/Value: Paste your server’s IP address here.
  - TTL: Time To Live. This is how long DNS servers should keep this record in cache,
  but DNS servers don’t always use this value the same way. Your domain registrar should have
  an optimized default setting, so just keep that. A TTL value of 300 seconds (5 minutes) would mean that,
  if a DNS record was changed on the nameserver, DNS servers around the world could still be showing
  the old value from their cache for up to 5 minutes after the change.

  Generally, you want one record for requests to the root domain `example.com` (without the `www.`)
  and one for the subdomain `www.example.com`:    
  - The first record, the root domain `example.com`:   
    * Type: `A - Address record`
    * Host: should be left blank
    * Answer: IP address provided by your web host  
    Then click `Add`. 
  - The second record, the www subdomain `www.example.com`:
    * Type: `A - Address record`
    * Host: `www`
    * Answer: IP address provided by your web host  
    Then hit `Add`.

* That's it, we're done!
