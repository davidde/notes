# SSH intro
SSH (Secure SHell) is a networking protocol, commonly used to 'log in' to a VPS or cloud server.  

The `ssh` command is used like this:   
$ ssh remote_username@remote_ipaddress (-i /path/to/privatekey)    
SSH into the server with IP address 'remote_ipaddress' as user 'remote_username'.  
If your username is the same locally and on the server, you can leave it out:  
$ ssh ipaddress  
-i: Only required when using a private key not named '~/.ssh/id_rsa'.  
-p: Port to connect to on the remote host. Only required when it's a non-standard port number for ssh.   
-vvv: verbosity, useful for debugging.   
Enter `exit` or press **CTRL + D** to exit the remote server.

## Core packages
- openssh-client:  
Installed on your local computer to initiate a connection with the VPS server using the `ssh` command;   
$ `ssh username@vpsserver`  
- openssh-server:  
Installed on the VPS server to securely access it from your local computer.  

=> When not present:  
$ `sudo apt install openssh-client/openssh-server`  

When installing openssh-server, the server's public and private keys are generated automatically.
For the client, you'll have to do that on your own (i.e. with the `ssh-keygen` command, see ahead).
When you, the client, connects with a server, public keys are exchanged. You'll receive the servers one,
and the server yours. The first time you receive the server public key, you'll be asked to accept it.
The public keys are stored in **~/.ssh/known_hosts** on the client, and in **~/.ssh/authorized_keys**
on the server.
  
## SSH key pairs
SSH key pairs are two cryptographically secure keys used to authenticate a client to an SSH server.
Each key pair consists of a public key and a private key. The private key is retained by the client
and should be kept absolutely secret (it can be encrypted on disk with a passphrase). The associated
public key can be shared freely without any negative consequences, and is used to encrypt messages
that only the private key can decrypt. This property is employed as a way of authenticating using the key pair.

**The public key is uploaded to a remote server that you want to be able to log into with SSH.**
The key is added to a special file within the user account you will be logging into called ~/.ssh/authorized_keys.
When a client attempts to authenticate using SSH keys, the server can test the client
on whether they are in possession of the private key. If the client can prove that it owns the private key,
a shell session is spawned or the requested command is executed.

## How-to
The first step to configure SSH key authentication to your server is to generate an SSH key pair on your local computer:  
$ ssh-keygen (-C `your_email@example.com`)  
(-C: comment; this can be any random string. This flag is not required, but exists so people can recognize
what/who each key belongs to; in professional environments there are often multiple network techs, 
and typical authorized_keys files can hold dozens of keys. The comment flag can be used however you like,
but is often used to specify an email address to identify who generated the key if there is potential for ambiguity.
Sentences with spaces are also allowed!)  
Your shell will prompt you to select a location for both keys. By default, the keys will be stored in the ~/.ssh directory. 
The private key will be called id_rsa and the associated public key will be called id_rsa.pub.
It is usually best to stick with the default location, so your SSH client will automatically find
your SSH keys when attempting to authenticate. However, if you have previously generated ~/.ssh/id_rsa,
you will be asked permission to overwrite; obviously do not overwrite if you still need to be able to authenticate
using the old key! In this case you need to specify a different name (but note that is is probably more convenient
to simply reuse your existing key).

*Optionally* provide a **passphrase**, which is used to encrypt the private key file on disk.
This is an additional security that makes the private key by itself useless to an attacker.  
Possible security concerns:
- Private keys could be compromised for example if you are not careful with old harddisks or backups,
or your computer itself was compromised.
- The more places a single key is authorized, the more valuable that key becomes.
If that key gets compromised, more targets are put at risk.
- The more places the private key is stored (e.g. desktop, laptop, work computer, backup storage, etc.),
the more places there are for an attacker to grab a copy.

A private key corresponds to a single "identity" for a given user, whatever that means to you.
If, to you, an "identity" is a single person, or a single person on a single machine,
or perhaps a single instance of an application running on a single machine. The level of granularity is up to you.
**There are NO universally-applicable guidelines on how to run your security**; the more additional security you add,
the more convenience you give up.   
E.g. when using a passphrase you have to enter it every time you use this key,
unless you are running `ssh-agent` software that stores the decrypted key.  
However, **keeping your private key encrypted with a passphrase adds a significant amount of security**.

You can change the passphrase for an existing private key without regenerating
the keypair by typing the following command:  
$ `ssh-keygen -p`  
(You will be prompted to specify the file in which the private key resides.)   
To delete a single entry from known_hosts:    
$ `ssh-keygen -R [hostname or IP address]`

## Do SSH keys have to be named 'id_rsa'?
**NO**, you can give them any name you like, or even place them in a different directory.  
(Another name is required when you don't want a single ssh key pair for sshing into multiple servers.)  
However, if they are not named `~/.ssh/id_rsa`, then you need to explicitly reference the key
in the ssh command like so:  
$ ssh user@server -i /path/to/mykey  

It is not uncommon to use multiple key pairs. Instead of running `$ ssh user@server -i /path/to/mykey`,
you can use a **configuration file, ~/.ssh/config**:  
```
Host yourhost
   IdentityFile ~/.ssh/id_dsa
   IdentityFile ~/.ssh/custom_key
```
Common settings are the IdentityFile (= the private keys) and Host. If you omit 'Host yourhost',
the settings will apply to all SSH connections. This configuration will check "id_dsa" and "custom_key" only
as private keys when connecting with `$ ssh youruser@yourhost`.

Example to tell git which private key to use:
```
host github.com
 HostName github.com
 IdentityFile ~/.ssh/github_rsa
 User git
```
Now you can do `$ git clone git@github.com:username/repo.git`.

Another **~/.ssh/config** example for Vultr:  
```
Host vultr
 HostName 198.13.59.103
 Port 22
 User root
 IdentityFile ~/.ssh/vultr_rsa
```
Now you can simply type:   
$ ssh vultr   
Which is equivalent to:   
$ ssh root@198.13.59.103 -i ~/.ssh/vultr_rsa -p 22   
(It would find everything it needs in your  ~/.ssh/config, under the `Host vultr` entry.)
 
**NOTE**: If the config file is new, don't forget to do `$ chmod 600 ~/.ssh/config`.  
Also verify that the permissions on IdentityFile are 400! SSH will reject, in a not clearly explicit manner,
SSH keys that are too readable. It will just look like a credential rejection. The solution, in this case, is:  
$ chmod 400 ~/.ssh/github_rsa

Generally speaking though, using a **single ssh key pair WITH a passphrase** holds a fair middle ground
between security and convenience, especially with the help of `ssh-agent`. But on the other hand, reusing
a single key on too many services *will* make it inconvenient if you ever decide/require to renew it.

## Setting up `ssh-agent`
(This is only necessary when you have set a passphrase for your private key,
and you don't want to specify it on every authentication)
1. Start the ssh-agent in the background:  
$ eval $(ssh-agent)
2. Add your SSH private key to the ssh-agent:
   - If it has the standard 'id_rsa' name, simply run:  
   $ ssh-add  
   - If you created your key with a different name/path, add the path to the command:  
   $ ssh-add ~/.ssh/user1_host1  
   - Enter the passphrase for the specific private key
   
## Adding your public key to a remote server
### a) Github/Gitlab/etc.
- Open the id_rsa.pub file (or use `$ cat ~/.ssh/id_rsa.pub`) and copy the entire content of that file.
- Login to your account and go to the 'SSH key Settings'.
- Paste the exact content of the public key into the Key input.
- Give it a descriptive name, which will still be meaningful to you 2 years from now.
- Click 'Add SSH key'.
- Once the string is saved to the service, you should be good to go.   

### b) VPS server, e.g. DigitalOCean, Vultr, Linode, etc.
The recommended way to add your public key to a VPS is through the command line, since trying to do this through
your hosting company's online UI often results in more trouble than it's worth.   
In your local terminal, it's as simple as:   
$ ssh-copy-id remote_username@remote_ip_address   
Use the -i flag for a non-default public key, e.g.:   
$ ssh-copy-id remote_username@remote_ip_address -i ~/.ssh/github_rsa.pub

Then check if everything went properly by logging in:  
$ ssh remote_username@remote_ip_address  
If everything went well, you will be logged in immediately.

**Note**:   
It's unsafe and considered bad practice to put your public key onto the remote machine's root user,
since this allows SSHing straight into the root.   
So do NOT execute:   
$ ssh-copy-id root@remote_ip_address  

Accessing the root user should be done by escalating privileges after SSHing
into the non-root user with sudo privileges, using either:   
$ su -   
$ sudo -i   
$ sudo 'command'
