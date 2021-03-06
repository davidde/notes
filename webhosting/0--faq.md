# Webhosting FAQ

* \[Subjective] What are the best domain name registrars, considering pricing vs quality (and ease of use)?  
  - Cloudflare registrar
  - Namesilo
  - Porkbun
  
  => Since at the time of writing, `.app` domains were not yet available from Cloudflare and Namesilo,  
     we ended up going for Porkbun. No regrets, they're great on all counts.

* \[Subjective] What are the best VPS hosting providers, considering pricing vs quality (and ease of use)?  
  - Digital Ocean
  - Vultr
  - Linode
  
  => We ended up going for Vultr because of the great UI and an $2.5/month plan
     that is ideal for small test projects. **But** since this plan seems to be permanently sold out,
     we might as well try Digital Ocean next time since they have other advantages.

* What is a subdomain?  
  Domain: `www.mydomain.com`  
  TLD (Top Level Domain): `com`  
  SLD (Second Level Domain): `mydomain`  
  Subdomain: `www`

  The good news here is that you don't *have* to use 'www' as your subdomain; you can basically replace it with almost any word to create a subdomain with a unique webaddress without having to purchase a new domain name.  
  E.g.: blog, account, dev, store, photos, menu, news, etc.  
  => blog.mydomain.com, account.mydomain.com, etc.

* Can a single domain host several progressive web apps (= pwa's)?  
Yes.

* Can a single domain serve static sites in combination with pwa's?  
Yes.
