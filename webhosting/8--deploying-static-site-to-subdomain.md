# Deploying a static site to a subdomain
## Deploying Hugo blog to `blog.mydomain.com`
The [static site generator](https://www.staticgen.com/) of choice is [Hugo](https://gohugo.io/),
but things are similar for other static site generators. 
To make things simple, we will deploy the Hugo blog to the subdomain `blog` of `mydomain.com`; `blog.mydomain.com`.

* The first thing to do is log in to your registrar, Porkbun, to add a new DNS record for the subdomain.
Make sure that Type is set to "A - Address record", the Host is "blog", and the Answer is the IP address
provided by your web host, then hit Add.

* Next, ssh into your vps and cd into your website in `/www`:   
$ `cd /www/[domain]`

* `git clone` your blog from its remote repository and cd into it:  
$ `git clone [Repository-URL]`   
$ `cd [Blog-Repository]`   

* Very important is to activate the theme; which should be in its own git submodule:  
$ `git submodule init`  
$ `git submodule update`  
If you don't do this, the `themes/[my-theme]` directory will be empty, and this will either result in errors when building, or no errors but an imcomplete build.

* Install Hugo:  
$ `sudo apt install hugo`

* Before building, make sure your `config.toml` is set up correctly.
For instance, `baseURL` should equal the correct url for your **subdomain**: `https://blog.mydomain.com/`.

* Build your blog for production:  
$ `hugo`   
This should output the same summary as your final development build with $ `hugo server`.
Pay special attention to the `pages` and `static files`. If they match up with what you saw in development,
everything is working ok. If not, remove the production build, rebuild with the `-v` flag for more verbose output,
and troubleshoot from there:  
$ `rm -rf public`  
$ `hugo -v`   

* The production build is located in the `public` directory. When you rebuild the blog with $ `hugo`,
you have to first remove this existing build:  
$ `rm -rf public`

* Next, we need to configure Nginx to serve the hugo blog. We do this by adding 2 new server blocks for the subdomain;
1 for ssl, and for regular port 80.   
Be aware that these server blocks cannot have the `default_server` part in the `listen` directives;
`default_server` should only go in the root domain, and not in the subdomains.   
Other than that, you can pretty much copy the 2 server blocks that are already present,
change the root location to the `/www/[domain]/[Blog-Repository]/public` directory,
and change the `server_name` to the subdomain instead of the root domain:   
$ `sudo vi /etc/nginx/sites-available/default`  
```
# Root domain setup:
server {
    # Notice presence of `default_server`:
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name [mydomain.com];
    return 301 https://$server_name$request_uri;
}

server {
    # SSL configuration:
    # Notice presence of `default_server`:
    listen 443 ssl default_server;
    listen [::]:443 ssl default_server;

    ssl_certificate /etc/nginx/ssl/[mydomain.com].bundled.cert;
    ssl_certificate_key /etc/nginx/ssl/[mydomain.com].private.key;

    root /www/[domain]/[React-App-Repo]/build;

    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;

    server_name [mydomain.com];

    location / {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            try_files $uri $uri/ =404;
    }
}

# Hugo blog setup for subdomain:
server {
    # Notice absence of `default_server`:
    listen 80;
    listen [::]:80;
    # Change the server_name to the subdomain:
    server_name [blog.mydomain.com];
    return 301 https://$server_name$request_uri;
}

server {
    # SSL configuration:
    # Notice absence of `default_server`:
    listen 443 ssl;
    listen [::]:443 ssl;

    ssl_certificate /etc/nginx/ssl/[mydomain.com].bundled.cert;
    ssl_certificate_key /etc/nginx/ssl/[mydomain.com].private.key;

    # Change root location to the blog's public folder:
    root /www/[domain]/[Blog-Repository]/public;

    index index.html index.htm index.nginx-debian.html;

    # Change the server_name to the subdomain:
    server_name [blog.mydomain.com];

    location / {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            try_files $uri $uri/ =404;
    }
}
```

* Save and exit, and run `sudo nginx -t` to check if the configuration is ok.
If you do get an error, make sure you did not forget anything, like removing the `default_server`s for the subdomain.

* When everything is ok, go ahead and restart nginx:   
$ `sudo service nginx restart`

* Your blog should now be availabe on `https://blog.mydomain.com`.
