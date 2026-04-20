# Virtual Private Server Setup
We have chosen to use [Vultr](https://www.vultr.com/) for our VPS hosting needs, but the steps are very similar
if you settle on a different VPS host. In this tutorial however, we're assuming you're following along on Vultr.
So go ahead and create a Vultr account, preferably through referral from someone that gives you some free credit.
[My referral](https://www.vultr.com/?ref=7950305-4F) will give you $50 in credit to test out Vultr.
When you stick around long enough to spend your own $25, I will earn $25 as well ;)
So let's both do our best and make this work!

## Vultr account and server setup
* Log in, fund your account through credit card, Paypal or crypto and verify your email address.
* Deploy a new server by clicking the blue **+** button:
  - Choose **Vultr Cloud Compute** for hosting websites.
  - Next Choose your preferred server location; the one closest to where your web visitors are located is usually best.
  - Scroll down and choose the server type; 64 bit Ubuntu is generally your safest bet. Be sure to pick a LTS (Long Term Support) release like 16.04, 18.04, 20.04, etc.
  - Choose a server size. The $2.5/month server is permanently 'sold out', which is a rather dubious practice since it *is* marketed heavily. This means you'll need to pay up at least $5/month. You can always upgrade later if you need more resources.
  - Ignore 'Additional features' and 'Startup Script'.
  - Add your desktop's public SSH key to be able to SSH into your VPS.   
  **Attention:** Vultr does not seem to add this ssh key to neither `/root/.ssh/authorized_keys` nor `~/.ssh/authorized_keys`, so adding it here seems to be completely pointless. You will have to do it through the command line anyway ... (by using `ssh-copy-id` with the password provided in server details)
  - Give your server a logical hostname and label:
  Name it based on the domain you want to use with it. Any subdomain name should do. Let it be some domain you own because if you will be hosting a website on it, you will need to add DNS records and match it with your Vultr account IP. The label is commonly kept identical to the hostname.
  - Click 'Deploy Now'; this will begin the setup process for your server. It should only take 5–10 mins.
* Once your server has been provisioned, you will be able to access the server details via the server tab in the Vultr management panel. Here you can access its ip address and its password to login to the root user. So from your local terminal, SSH into your VPS:   
$ `ssh root@ipaddress`  
Enter the server password to log in, and proceed to create a non-root user account.

----------------------------------------------------------
(If SSHing doesn't work:)
* Check if the SSH client is installed locally:   
$ `which ssh`   
If not:   
$ `sudo apt install openssh-client`   

* When logged in on the server, you can verify that the SSH server service is running by typing
  the following command which will print its status:  
  $ `sudo systemctl status ssh`  
  Since Vultr installed SSH server during the server setup, you should see output like   
  `Active: active (running) since ...`:
  ```
  ● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2019-03-10 23:35:53 UTC; 2min 3s ago
    Process: 13255 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 13260 (sshd)
      Tasks: 1 (limit: 1110)
     CGroup: /system.slice/ssh.service
             └─13260 /usr/sbin/sshd -D

  ...
  ```
  Press q to get back to the command line prompt.  
  If the SSH server isn't running, enable it by installing the `openssh-server` package:   
  (once you are logged in as a user with sudo privileges)
    - $ `sudo apt update`
    - $ `sudo apt install openssh-server`
    - $ `sudo systemctl status ssh`
---------------------------------------------------------------

## Create a non-root user with sudo access on your VPS
* For security reasons, it is not advisable to be performing daily computing tasks using the root account.
  Instead, it is recommended to create a standard user account that will be using sudo to gain administrative privileges:   
  $ `adduser david`   
  You will be prompted to set and confirm the new user password:
  ```
  Adding user `david' ...
  Adding new group `david' (1000) ...
  Adding new user `david' (1000) with group `david' ...
  Creating home directory `/home/david' ...
  Copying files from `/etc/skel' ...
  New password:
  Retype new password:
  passwd: password updated successfully
  ```
  Then it will prompt you to set the new user’s information.
  If you want to leave all of this information blank just press ENTER to accept the defaults:
  ```
  Changing the user information for david
  Enter the new value, or press ENTER for the default
    Full Name []:
    Room Number []:
    Work Phone []:
    Home Phone []:
    Other []:
  Is the information correct? [Y/n] y
  ```
* Add the new user to the sudo group:
By default on Ubuntu systems, members of the group sudo are granted with sudo access.
Adding the user you created to the sudo group can be accomplished with several commands:   
  - $ `adduser david sudo`   
  - $ `gpasswd -a david sudo`   
  - $ `usermod -aG sudo david`  
On Debian/Ubuntu systems, [adduser](../bash.md#-sudo-adduser-david) is the generally recommended command.

* Test the sudo access:
  - Switch to the newly created user:  
  $ su - david  
  (Note `su -` here:  
  `su -` invokes a login shell after switching the user,
  which resets most environment variables, providing a clean base.
  `su` just switches the user, providing a normal shell with an environment nearly the same as with the old user.)

  - Use the sudo command to run the whoami command:
  $ `sudo whoami`  
  If the user has sudo access then the output of the whoami command will be 'root'.
