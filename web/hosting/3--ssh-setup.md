# Setting up SSH on your VPS
General info about SSH and how to generate your SSH keypair can be found in the [SSH Intro](../ssh.md#how-to).

## Setting up passwordless (key-based) SSH authentication
* Copy your local machine's public key to the server:  
(On your local machine terminal:)   
$ `ssh-copy-id remote_username@remote_ip_address`  
Use the -i flag for a non-default public key, e.g.:   
$ `ssh-copy-id remote_username@remote_ip_address -i ~/.ssh/github_rsa.pub`

* Check if everything went properly by logging in:  
$ `ssh remote_username@remote_ip_address`  
If everything went well, you will be logged in immediately.

  **Note**:   
  It's unsafe and considered bad practice to put your public key onto the remote machine's root user, since this allows SSHing straight into the root.   
  So do NOT execute:   
  $ `ssh-copy-id root@remote_ip_address`  

  Accessing the root user should be done by SSHing into the non-root user with sudo access:   
  $ `ssh sudo_user@remote_ip_address`  
  And afterwards escalating privileges to access the root, with either of:   
  $ `su -`   
  $ `sudo -i`   
  $ `sudo [command]`

## Disabling SSH Password Authentication
To add an extra layer of security to your server you can disable the password authentication so your server
is no longer exposed to brute-force attacks.

**Before disabling the SSH password authentication make sure you can log in to your server without a password
(using your SSH keys), and the user you are logging in to has
[sudo privileges](./2--vps-setup.md#create-a-non-root-user-with-sudo-access-on-your-vps).**

When the above conditions are met:   
- Open the SSH configuration file `/etc/ssh/sshd_config` on the server:   
$ `sudo vi /etc/ssh/sshd_config`  
- Modify the following entries to `no`:   
  ```
  PasswordAuthentication no   
  ChallengeResponseAuthentication no   
  UsePAM no   
  ```
  Make sure none of them remains commented out with a `#`!
- To actually implement the changes we just made, we must restart the service with either:   
$ `sudo service ssh restart`   
$ `sudo systemctl restart ssh`
- If everything went well, SSHing into the root should no longer be possible, and present you with the following error:   
`Permission denied (publickey).`

## Using the SSH Config File
If you are regularly connecting to multiple remote systems over SSH on a daily basis,
you’ll find that remembering all of the remote IP addresses, usernames and ports is simply not practical.
That's why all these variables can simply be stored in the SSH config file, located at `~/.ssh/config`.  
Process for setting up your SSH Config file:   
(Be sure to set it up locally, and not in a terminal tab logged in to your remote!)
- By default the SSH configuration file does not exist, so you need to create it using the touch command:  
$ `touch ~/.ssh/config`  
- This file must be readable and writable only by the user, and not accessible by others:  
$ `chmod 600 ~/.ssh/config`
- Basic config example:   
  ```
  Host vultr
    HostName 198.13.59.103
    Port 22
    User root
    IdentityFile ~/.ssh/vultr_rsa
  ```
  Now you can simply type:  
  $ `ssh vultr`  
  Which is equivalent to:  
  $ `ssh root@198.13.59.103 -i ~/.ssh/vultr_rsa -p 22`  
  You are free to leave out any entries you don't require, for example if your remote user is the same as your local user,
  simply leave out the 'User' line, and it will work automatically.
- Check the man pages for more info:   
$ `man ssh_config`

## Disabling SSH completely
If for some reason you want to disable SSH on your Ubuntu server, so no one can SSH into it,
you can simply stop the SSH service by running:   
$ `sudo systemctl stop ssh`  

To start it again run:  
$ `sudo systemctl start ssh`  

To disable the SSH service to start during system boot run:  
$ `sudo systemctl disable ssh`  

To enable it again type:  
$ `sudo systemctl enable ssh`
