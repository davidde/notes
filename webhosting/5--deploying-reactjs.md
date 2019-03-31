# Deploying a React/Javascript app
* SSH into your VPS and update:  
$ `sudo apt update`

* Install Node.js & npm:  
In production, it is generally recommended to use the [Long Term Support versions](https://nodejs.org/en/about/releases/).  
These are the even-numbered versions at which node.js is considered production-ready.  
The odd number versions are not LTS and you should generally stay away from them.  
The current LTS release is 10 (check in above link). If you want to install a different version
you can change the 10 to whatever version you’d like. Since we need Node.js only for deploying,
and not for development purposes, we will be using apt and the NodeSource repository
(instead of the Default Ubuntu repository).  
NodeSource is a company focused on providing enterprise-grade Node support and they maintain
a repository containing the latest versions of Node.js.
(The Default Ubuntu repository only contains a single Node.js version, and very likely not a LTS release.)   

  > **Note:**  
  > For development purposes it is recommended to install Node.js using the NVM script.
  > NVM, or Node Version Manager, is a bash script used to
  > [manage multiple active Node.js versions](https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/#install-node-js-and-npm-using-nvm).
  

  NodeSource allows us to install a specific Node.js version on our VPS:  
  - Enable the NodeSource repository with the following curl command:   
  $ `curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -`  
  - Once the NodeSource repository is enabled, install Node.js and npm by typing:  
  $ `sudo apt install nodejs`  
  The nodejs package contains both the node and npm binaries.
  - Verify that Node.js and npm were installed successfully by printing their versions:  
  $ `node --version`  
  $ `npm --version`  

* Create the directory the web app will reside in:   
$ `sudo mkdir /www`  
$ `cd /www`  

* Constantly using sudo increases the chances of accidentally trashing the system,
so let's give our user ownership to this directory:   
$ `sudo chown -R david:www-data /www`   
This changes the user from 'root' to 'david'. We also change the group from 'root' to 'www-data';
this is the group under which common web servers like Apache and Nginx run.
This is necessary because Nginx also needs access to the files.
(Note that using the '-R' flag is pointless if the directory is still empty.)

* Since we also want newly created files/directories to inherit the group of its parent directory (www-data)
instead of its creator (e.g. 'david'), we set the setgid bit on the /www directory:   
$ `sudo chmod g+s /www`   
The setgid bit will be inherited on subdirectories when they are created.
This is exactly what we need: effectively all files/directories/subdirectories inside '/www' will inherit
the group from '/www' ('www-data').   
(Note that if you forget sudo, it will NOT set the setgid bit, and return no error of failure (Ubuntu bug).
Make sure it's effectively set with `ls -l`; there should be an 's' instead of an 'x' in the group execute permissions.)  
See [chmod.md](../chmod.md) for more details on its functioning.

* Create a directory for our website/domain, and cd into it:   
$ `mkdir [domain]`   
$ `cd [domain]`   

* $ `git clone [Repository-URL]`   
Use https to `git clone`, since we haven't set up a deploy key for SSH yet, then cd into it and install:   
(you should never need to use sudo with npm)   
$ `cd [React-App-Repo]`   
$ `npm install`   
$ `npm run build`   
This will create an optimized production build.

* Optionally, to increase security, we can also restrict access permissions for 'other' by combining
the 'find' command with the 'chmod' command:   
$ `find /www -type f -exec chmod 0640 {} \;`   
$ `sudo find /www -type d -exec chmod 2750 {} \;`   
Be sure to not forget sudo and the leading '2' in the permissions in the last command,
otherwise you will unset the setgid bit.
(Buggy Ubuntu behaviour: if we are not a member of the group a file belongs to,
any use of chmod that does not actively set setgid will actually unset it.
Alternatively, we could add ourself to the www-data group with `sudo adduser david www-data`.)
See [this](../bash.md#-find) for an explanation of the `find` command.  
Note that the only case where www-data needs write permissions is for directories storing uploads
and other locations which needs to be written, so we do not assign any group write permissions.

* Optionally, we can change the umask so all files created in the future will restrict access for 'other',
by putting `umask 027` in `~/.bashrc` or `~/.zshrc`. Note that this is a global setting for the server.

* Install Nginx to serve our application:   
$ `sudo apt install nginx`   

* Configuring Nginx:   
$ `sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak`   
$ `sudo vi /etc/nginx/sites-available/default`   
Inside vi in the 'default' file, you have to set the website root and your domain name:   
  ```
  server {
      listen 80 default_server;
      listen [::]:80 default_server;

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
If it's not, knowing there is an error in the config file is already a great step towards solving the problem.
Make sure spelling and syntax is ok. Pay attention to what the error tells you and troubleshoot.

* When everything is ok, start up Nginx!   
$ `sudo service nginx start`

* If you changed the repository or made changes to the configuration, you can restart Nginx with:   
$ `sudo service nginx restart`
