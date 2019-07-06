# Installing SSL Certificates
* Create the nginx ssl directory with the proper permissions:  
$ `sudo mkdir /etc/nginx/ssl`   
$ `sudo chmod 700 /etc/nginx/ssl`   

* Prepare your bundled SSL certificate and SSL private key for copying.  
The PEM format is the most widely used by Certificate authorities,
and will usually have extensions of .pem, .cert, .crt, .cer or .key.  
Your bundled certificate contains the domain certificate **and** intermediate certificate,
and you can generate it by concatenating the intermediate certificate to the domain certificate:   
(First append two newlines to the domain certificate so that they are properly separated:)  
$ `echo '\n\n' >> domain.cert.pem`   
$ `cat domain.cert.pem intermediate.cert.pem > [mydomain.com].bundled.cert`   
The private key will look like `private.key.pem`. It's better to rename it for clarity:  
$ `mv private.key.pem [mydomain.com].private.key`

* Copy your bundled SSL certificate and your SSL private key to '/etc/nginx/ssl'.

* Change the Nginx configuration to use ssl:   
$ `sudo vi /etc/nginx/sites-available/default`   
  ```
  # server indicating 301 error (moved permanently)
  # this will also move the requests from port 80 to port 443
  server {
      listen 80 default_server;
      listen [::]:80 default_server;
      server_name [mydomain.com];
      return 301 https://$server_name$request_uri;
  }

  server {
      # SSL configuration:
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
  ```

* Save and exit, and run `sudo nginx -t` to check if the configuration is ok.   
If you do get an error, there is a good chance the 'bundled.crt' is improperly formatted.  
(Make sure all `BEGIN CERTIFICATE` and `END CERTIFICATE`s have their separate lines.
The key itself has to be multiline too!)

* When everything is ok, go ahead and restart nginx:   
$ `sudo nginx -s reload`   

* To check if a deployed SSL certificate covers subdomains:  
Click on the lock next to the address bar in Google Chrome > `Certificate` > `Details` >
in the `Certificate Fields` section, scroll down to `Extensions`, and click `Certificate Subject Alternative Name`:
this will display all the subdomains it covers, or `*.mydomain.com` to indicate a Wildcard SSL certificate.  
A Wildcard SSL Certificate allows users to secure an unlimited number of subdomains (no sub subdomains though)
for one domain in one certificate.
