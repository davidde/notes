# GPG
> See the Arch Wiki on [GPG](https://wiki.archlinux.org/index.php/GnuPG) and [SSH keys](https://wiki.archlinux.org/index.php/SSH_keys), as well as the [GPG F.A.Q.](https://gnupg.org/faq/gnupg-faq.html) for more information.

* Check gpg version and supported algorithms:
  ```bash
  $ gpg --version
  # output:
  gpg (GnuPG) 2.2.26
  libgcrypt 1.8.7
  Copyright (C) 2020 Free Software Foundation, Inc.
  License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.

  Home: /home/david/.gnupg
  Supported algorithms:
  Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
  Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
          CAMELLIA128, CAMELLIA192, CAMELLIA256
  Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
  Compression: Uncompressed, ZIP, ZLIB, BZIP2
  ```
  Do make sure you're using gpg version > 2.

  We will be using the following algorithms:
  - Pubkey: EDDSA
  - Cipher: AES256
  - Hash: SHA512
  - (Compression: keep default ZIP for maximum compatibility with PGP)

## Creating a master key
* Execute gpg with the `--expert` flag to get the advanced options:
  ```
  gpg --expert --full-gen-key
  ```
  This returns:
  ```
  gpg (GnuPG) 2.2.26; Copyright (C) 2020 Free Software Foundation, Inc.
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.

  Please select what kind of key you want:
    (1) RSA and RSA (default)
    (2) DSA and Elgamal
    (3) DSA (sign only)
    (4) RSA (sign only)
    (7) DSA (set your own capabilities)
    (8) RSA (set your own capabilities)
    (9) ECC and ECC
    (10) ECC (sign only)
    (11) ECC (set your own capabilities)
    (13) Existing key
    (14) Existing key from card
  Your selection?
  ```
  The default choice of `RSA and RSA` allows you not only to sign communications, but also to encrypt files. However, this is not recommended, see below.

  A gpg key can have 4 capabilities:
  - **[C] = Certify** (master keys only):  
    The key can create subkeys, mandatory for master keys.
  - **[S] = Sign:**  
    The key can create cryptographic signatures that others can verify with the public key.
  - **[E] = Encrypt:**  
    The key can encrypt data, that only the private key can decrypt.
  - **[A] = Authenticate:**  
    The key can authenticate with various non-GnuPG programs, e.g. use as SSH key.

  The `xxx and xxx` options indicate that 2 key pairs will be created; a master key with CS capabilities (Certify + Sign), and a subkey with E (encrypt) capability. Note that both this master key and the encrypt subkey are really key pairs; a pair of private and public keys.

  The master key is simply the key that can certify other keys, i.e. with C capability set. It is recommended to *only* set the Certify capability for the master key, and use subkeys for all other capabilities. This way, you do not need the master key for daily usage, and can keep it somewhere safe offline. This also makes it more straightforward to revoke specific subkeys when necessary (e.g. your laptop gets stolen).

  You can accomplish this by choosing the `set your own capabilities` option and only set the Certify capability.

* Elliptic Curve Cryptography (ECC) is currently the most advanced. Therefore, we choose `(11) ECC (set your own capabilities)`, and are asked to specify the capabilities we want:
  ```
  Your selection? 11

  Possible actions for a ECDSA/EdDSA key: Sign Certify Authenticate
  Current allowed actions: Sign Certify

    (S) Toggle the sign capability
    (A) Toggle the authenticate capability
    (Q) Finished

  Your selection? s
  ```
  Accepting these defaults, the key would be able to sign and certify. Since we want a "certify-only" master key, we press `s` to toggle off the sign capability, then `q` to finish.

* Afterwards, we can choose which elliptic curve we want to use (If we picked 9 or 10 above, we would've gotten straight to this menu, skipping the capabilities above):
  ```
  (Your selection? 9/10)
  Please select which elliptic curve you want:
    (1) Curve 25519
    (3) NIST P-256
    (4) NIST P-384
    (5) NIST P-521
    (6) Brainpool P-256
    (7) Brainpool P-384
    (8) Brainpool P-512
    (9) secp256k1
  Your selection?
  ```
  `Curve 25519` is currently the most widely recommended elliptic curve for public keys (but has poor support in smartcards). `Ed25519` is an [EdDSA](https://en.wikipedia.org/wiki/EdDSA) signature scheme using SHA-512 (SHA-2) and Curve25519. We press `1`.

* Then we'll have to decide about the expiration of the key:
  ```
  Please specify how long the key should be valid.
          0 = key does not expire
        <n>  = key expires in n days
        <n>w = key expires in n weeks
        <n>m = key expires in n months
        <n>y = key expires in n years
  Key is valid for? (0) 4y
  Key expires at Sun 19 Jan 2025 12:22:59 PM CET
  Is this correct? (y/N) y
  ```
  It is recommended to use a key with an expiration date for security reasons; if the key is compromised, it could be used forever when it has no expiration. There is really no reason not to set an expiration date; even if it has expired, you can still [renew it](https://superuser.com/questions/813421/can-you-extend-the-expiration-date-of-an-already-expired-gpg-key).

* Up next, the user ID. You should enter your real name and a current email address:
  ```
  GnuPG needs to construct a user ID to identify your key.

  Real name: David Deprost
  Email address: dadeprost@gmail.com
  Comment:
  You selected this USER-ID:
      "David Deprost <dadeprost@gmail.com>"

  Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
  ```
  Leave the comment blank, as this would become a part of your ID (not a good idea). Press `o` to confirm the user ID.

* Now it will ask for the passphrase:
  ```
  ┌──────────────────────────────────────────────────────┐
  │ Please enter the passphrase to                       │
  │ protect your new key                                 │
  │                                                      │
  │ Passphrase: ________________________________________ │
  │                                                      │
  │       <OK>                              <Cancel>     │
  └──────────────────────────────────────────────────────┘
  ```
  After entering it twice, you'll be presented with the following:
  ```
  We need to generate a lot of random bytes. It is a good idea to perform
  some other action (type on the keyboard, move the mouse, utilize the
  disks) during the prime generation; this gives the random number
  generator a better chance to gain enough entropy.
  gpg: key 8E2DA5DBE2726B2F marked as ultimately trusted
  gpg: directory '/home/david/.gnupg/openpgp-revocs.d' created
  gpg: revocation certificate stored as '/home/david/.gnupg/openpgp-revocs.d/F40F58865176D010B38796D98E2DA5DBE2726B2F.rev'
  public and secret key created and signed.

  pub   ed25519 2021-01-20 [C] [expires: 2025-01-19]
        F40F58865176D010B38796D98E2DA5DBE2726B2F
  uid                      David Deprost <dadeprost@gmail.com>
  ```
  Note that a revocation certificate is generated automatically. It is located at `~/.gnupg/openpgp-revocs.d`, with the fingerprint of the master key indicating to which key it belongs. You should keep a backup of this file. We are now done with the master key! Now let's set up the "Sign" and "Encrypt" subkeys.

## Creating a "Sign" subkey
* To add subkeys to an existing master key, we need to use the `--edit-key` option with either the key ID or the email address. The key id can be either the short id (last 8 characters of the fingerprint, here `E2726B2F`) or the long id (last 16 characters of the fingerprint, here `8E2DA5DBE2726B2F`):
  ```
  gpg --expert --edit-key dadeprost@gmail.com
  ```
  This will enter an interactive gpg mode:
  ```
  gpg (GnuPG) 2.2.26; Copyright (C) 2020 Free Software Foundation, Inc.
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.

  Secret key is available.

  gpg: checking the trustdb
  gpg: marginals needed: 3  completes needed: 1  trust model: pgp
  gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
  gpg: next trustdb check due at 2025-01-19
  sec  ed25519/8E2DA5DBE2726B2F
      created: 2021-01-20  expires: 2025-01-19  usage: C   
      trust: ultimate      validity: ultimate
  [ultimate] (1). David Deprost <dadeprost@gmail.com>

  gpg> 
  ```
  Note that to exit this interactive mode after updating/creating something, you have to type `save`!

* We enter the `addkey` subcommand:
  ```
  gpg> addkey
  ```
  This will bring us back to the menu to choose the type of key:
  ```
  Please select what kind of key you want:
     (3) DSA (sign only)
     (4) RSA (sign only)
     (5) Elgamal (encrypt only)
     (6) RSA (encrypt only)
     (7) DSA (set your own capabilities)
     (8) RSA (set your own capabilities)
    (10) ECC (sign only)
    (11) ECC (set your own capabilities)
    (12) ECC (encrypt only)
    (13) Existing key
    (14) Existing key from card
  Your selection? 10
  ```
  This time, we choose `(10) ECC (sign only)`. The following is very similar to creating the master key, and not worth expanding on. After setting the expiration date, you'll be asked:
  ```
  Really create? (y/N) y
  ```
  After which you'll have to enter the master key password, and the key will be created:
  ```
  We need to generate a lot of random bytes. It is a good idea to perform
  some other action (type on the keyboard, move the mouse, utilize the
  disks) during the prime generation; this gives the random number
  generator a better chance to gain enough entropy.

  sec  ed25519/8E2DA5DBE2726B2F
      created: 2021-01-20  expires: 2025-01-19  usage: C   
      trust: ultimate      validity: ultimate
  ssb  ed25519/39BAD4A5F980CEB1
      created: 2021-01-20  expires: 2025-01-19  usage: S   
  [ultimate] (1). David Deprost <dadeprost@gmail.com>
  ```
  That's it for the sign subkey. Now let's add the "Encrypt" subkey.

## Creating an "Encrypt" subkey
* Without leaving the above interactive menu, we can just enter `addkey` again, and do the same, this time choosing `(12) ECC (encrypt only)`:
  ```
  Please select what kind of key you want:
     (3) DSA (sign only)
     (4) RSA (sign only)
     (5) Elgamal (encrypt only)
     (6) RSA (encrypt only)
     (7) DSA (set your own capabilities)
     (8) RSA (set your own capabilities)
    (10) ECC (sign only)
    (11) ECC (set your own capabilities)
    (12) ECC (encrypt only)
    (13) Existing key
    (14) Existing key from card
  Your selection? 12
  ```
  After going through everything similar to above, you should see something like:
  ```
  We need to generate a lot of random bytes. It is a good idea to perform
  some other action (type on the keyboard, move the mouse, utilize the
  disks) during the prime generation; this gives the random number
  generator a better chance to gain enough entropy.

  sec  ed25519/8E2DA5DBE2726B2F
      created: 2021-01-20  expires: 2025-01-19  usage: C   
      trust: ultimate      validity: ultimate
  ssb  ed25519/39BAD4A5F980CEB1
      created: 2021-01-20  expires: 2025-01-19  usage: S   
  ssb  cv25519/203B54872126D48C
      created: 2021-01-20  expires: 2025-01-19  usage: E   
  [ultimate] (1). David Deprost <dadeprost@gmail.com>
  ```
  That's it for the "Encryption" subkey! We will now create an SSH "Authenticate" subkey.

## Creating an "Authenticate" subkey for SSH usage
* Enter the `addkey` again, and this time select `(11) ECC (set your own capabilities)`:
  ```
  Please select what kind of key you want:
     (3) DSA (sign only)
     (4) RSA (sign only)
     (5) Elgamal (encrypt only)
     (6) RSA (encrypt only)
     (7) DSA (set your own capabilities)
     (8) RSA (set your own capabilities)
    (10) ECC (sign only)
    (11) ECC (set your own capabilities)
    (12) ECC (encrypt only)
    (13) Existing key
    (14) Existing key from card
  Your selection? 11
  ```
* Toggle `s` to disable the "Sign" capability, toggle `a` to enable the "Authenticate" capability, then `q` to finish.
* Next, enter `1` for `Curve 25519`.
* For the expiration, we use `0` (no expiration date), since ssh keys do not come with an expiration date. You could use one here, but ssh will likely ignore it anyway.
* Enter `y` twice to verify and confirm, and then enter the password of the GPG master key. When everything went all right, you will see something like:
  ```
  We need to generate a lot of random bytes. It is a good idea to perform
  some other action (type on the keyboard, move the mouse, utilize the
  disks) during the prime generation; this gives the random number
  generator a better chance to gain enough entropy.

  sec  ed25519/8E2DA5DBE2726B2F
      created: 2021-01-20  expires: 2025-01-19  usage: C   
      trust: ultimate      validity: ultimate
  ssb  ed25519/39BAD4A5F980CEB1
      created: 2021-01-20  expires: 2025-01-19  usage: S   
  ssb  cv25519/203B54872126D48C
      created: 2021-01-20  expires: 2025-01-19  usage: E   
  ssb  ed25519/13E61E897CAD4605
      created: 2021-01-20  expires: never       usage: A   
  [ultimate] (1). David Deprost <dadeprost@gmail.com>
  ```
  And that is it for the "Authenticate" subkey.

* Enter `save` to exit the interactive gpg prompt.

* To check your gpg keys, you can use:
  ```
  gpg --list-keys
  ```
  This will list **all** keys, including public keys from other people/companies/organizations.

  To only list **your** keys, use:
  ```bash
  gpg --list-secret-keys
  # Use `--keyid-format short/long` to also return the key ids:
  gpg --list-secret-keys --keyid-format long
  # Or `--with-subkey-fingerprint` for the complete fingerprints:
  gpg --list-secret-keys --with-subkey-fingerprint
  ```


## Backup the private keys
* Backup the private keys with the following command:
  ```
  gpg --export-secret-keys --armor --output privatekeys.asc dadeprost@gmail.com
  ```
  `--armor, -a`: Create ASCII armored output. This is useful for printing on paper later, because the default is to create binary OpenPGP output. If a paper print is not desired, this can be left out.  
  The email field can also use the *key id* as input to identify the key. Whichever you use, this should return a prompt to enter the password with the following text:
  ```
  Please enter the passphrase to export the OpenPGP secret key:
  "David Deprost <dadeprost@gmail.com>"
  256-bit EDDSA key, ID 8E2DA5DBE2726B2F,
  created 2021-01-20.
  ```
  Note that this backs up all secret keys (i.e. master, signing, encrypt and authenticate) in a single file named `privatekeys.asc` in the current working directory. Move it to a safe place on a different device or encrypted drive, as this is the only possibility to regain control of your keys after e.g. theft, loss or disk failure.

* Also note that if you press "Cancel" in the above prompt, you will be given the choice to backup the subkeys one by one. It is generally not required to backup signing and authentication subkeys, as they can be easily replaced with the master key. However, it is useful to backup encryption keys, as it would be impossible to decrypt previously encrypted data without them. Since the above command includes all keys, there is no need for additional backups.

  However, if you ever want to backup a subkey separately, use the following command:
  ```bash
  # Use `gpg --list-secret-keys --keyid-format long` if you do not know the key id (here 203B54872126D48C)
  gpg --export-secret-subkeys --armor --output private-encrypt-subkey-203B54872126D48C.asc 203B54872126D48C!
  ```
  Note the exclamation mark `!` after the key id! Without it, all subkeys will be exported into a single file, similar to the previous `--export-secret-keys` command. This should return:
  ```
  Please enter the passphrase to export the OpenPGP secret subkey:
  "David Deprost <dadeprost@gmail.com>"
  256-bit ECDH key, ID 203B54872126D48C,
  created 2021-01-20 (main key ID 8E2DA5DBE2726B2F).
  ```
  Verify you're exporting the correct key to the correct file name, and that's it!

  This command is also useful to migrate subkeys to another system without the master key included, which you may want to keep more secure.

* You may want to do the same for the public keys:
  ```
  gpg --export --armor --output publickeys.asc dadeprost@gmail.com
  ```
  This is less critical then the private keys, but may turn out useful if you haven't uploaded your public keys to a keyserver.

* To later import the private keys on another system:
  ```
  gpg --import privatekeys.asc
  ```

## Backup the revocation certificate
As mentioned previously, a revocation certificate is automatically generated, and located in `~/.gnupg/openpgp-revocs.d/`. The filename of the certificate is the fingerprint of the key it will revoke. A new revocation certificate can also be generated manually with:
```
gpg --gen-revoke --armor --output revoc-cert.asc dadeprost@gmail.com
```
This certificate can be used to revoke a key if it is ever lost or compromised. A backup will be useful if you no longer have access to the secret key, meaning you can no longer generate a new revocation certificate. Note that anyone with access to this revocation certificate can revoke the key publicly, so make sure to keep it safe.

## Using a GPG key as SSH key
* Add the following to your `.bashrc` or `.zshrc`:
  ```bash
  # Make sure GPG agent is used instead of SSH agent:
  unset SSH_AGENT_PID

  # When gpg-agent is started as `gpg-agent --daemon /bin/sh` the shell
  # inherits the SSH_AUTH_SOCK variable from its parent gpg-agent process,
  # and should not be set here:
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    # Setting SSH_AUTH_SOCK will make SSH use gpg-agent instead of ssh-agent:
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi

  # Configure pinentry to use the correct TTY by setting GPG_TTY:
  export GPG_TTY=$(tty)
  # Refresh the TTY in case the user switched into an X session:
  gpg-connect-agent updatestartuptty /bye >/dev/null
  ```
  This will make sure SSH makes use of gpg-agent under the hood, instead of ssh-agent.

* To effectively use a GPG key as SSH key, we need to add the GPG Authenticate subkey to the GPG `sshcontrol` file:
  ```bash
  # This requires the keygrip of the Authenticate subkey:
  # (A keygrip is similar in concept to the key id/fingerprint,
  # but protocol agnostic, meaning it is the same for
  # all pgp implementations, e.g. gpg, openpgp, etc.)
  gpg --list-secret-keys --with-keygrip
  # Then echo the listed keygrip of the Authenticate subkey to the sshcontrol file:
  echo 7910BA0643CD042B92564181AF2EAC2A230CDC0F >> ~/.gnupg/sshcontrol
  ```

* At this point, we should be able to verify the key was added correctly with `ssh-add -L/-l`:
  ```
  ssh-add -L
  ```
  If `The agent has no identities` is returned, make sure the shell was reloaded (`. ~/.zshrc`). After reloading, the single key we just added should be returned.

* Before using the `ssh` command together with a gpg key, we need to enable SSH support for GPG first:
  ```
  echo enable-ssh-support >> ~/.gnupg/gpg-agent.conf
  ```
  The shell will need to be reloaded again for it to take effect:
  ```
  source ~/.zshrc
  ```

* Finally, we also need to move the public key part of the GPG/SSH key to the server we want to SSH into. We can retrieve the public key by running:
  ```
  gpg --export-ssh-key <key-id-of-authenticate-subkey>
  ```
  This should return a single line starting with `ssh-ed25519`.

* To make this work with e.g. Github, copy that line to the key field at `Github > Settings > SSH and GPG keys > New SSH key`. The title can be anything that is meaningful to you, e.g. `arch-desktop`.

* To test [connecting to Github](https://docs.github.com/en/github/authenticating-to-github/testing-your-ssh-connection), simply run:
  ```
  ssh -T git@github.com
  ```
  The first time you run this, this will return:
  ```
  The authenticity of host 'github.com (140.82.121.4)' can't be established.
  RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
  Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
  ```
  Verify that the Github RSA key fingerprint that is returned equals the [fingerprint listed on Github](https://docs.github.com/en/github/authenticating-to-github/githubs-ssh-key-fingerprints), and enter `yes`:
  ```
  Warning: Permanently added 'github.com,140.82.121.4' (RSA) to the list of known hosts.
  Hi davidde! You've successfully authenticated, but GitHub does not provide shell access.
  ```
  We get feedback that we have successfully authenticated! If this throws an error instead, you can run the same command with the verbose flag for more info:
  ```
  ssh -vT git@github.com
  ```
  See [Permission Denied](https://docs.github.com/en/github/authenticating-to-github/error-permission-denied-publickey) or [Agent admitted failure to sign](https://docs.github.com/en/github/authenticating-to-github/error-agent-admitted-failure-to-sign) for more info about those errors. Make sure you have `enable-ssh-support` in `~/.gnupg/gpg-agent.conf`, as that would be a possible cause of a "Permission denied" error.

  Note that on a fresh boot, this may again throw a "Permission denied" error, because [systemd starts gpg-agent with its own settings](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=835394), ignoring everything we just set up. A simple shell reload should fix this:
  ```
  source ~/.zshrc
  ```
  This seems to be a race condition, and does not trigger on every boot. You may want to [disable gnome-keyring's SSH component](https://wiki.archlinux.org/index.php/GNOME/Keyring#Disable_keyring_daemon_components) and check if it has any impact:
  ```
  cp /etc/xdg/autostart/gnome-keyring-ssh.desktop ~/.config/autostart/gnome-keyring-ssh.desktop
  echo Hidden=true >> ~/.config/autostart/gnome-keyring-ssh.desktop
  ```
  Then log out and back in.

* You'll notice that with the current setup, we are prompted by the pinentry dialog on every authentication. Entering the lengthy master key password every time is quite bothersome, so caching the password would be a good idea. This is straightforward to do by adding `default-cache-ttl-ssh` and `max-cache-ttl-ssh` to `~/.gnupg/gpg-agent.conf`. (Note that they are specific for SSH emulation mode; for normal mode use `default-cache-ttl` and `max-cache-ttl`.) Each of these define the timespan in seconds that gpg-agent will cache the passwords, so set them to something very high if you do not want to be bothered again (you could turn it up to months or even years):
  ```bash
  default-cache-ttl-ssh 90000 # 25 hours
  max-cache-ttl-ssh 6048000   # 10 weeks
  ```
  The difference between both is that the "default" ones reset the timer after every use of GPG, while the "max" ones set the maximum timespan after which the cache will expire, even if it was accessed recently.
