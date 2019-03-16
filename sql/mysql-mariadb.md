# How to set up a MySQL/MariaDB database

(useful links:  
https://www.digitalocean.com/community/tutorials/a-basic-mysql-tutorial  
https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql  
https://www.digitalocean.com/community/tutorials/how-to-import-and-export-databases-in-mysql-or-mariadb )

1. $ `sudo apt install mysql-server`

2. $ `sudo mysql -u root (-p)`

3. mysql> `CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';`  
   mysql> `GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';`  
   mysql> `FLUSH PRIVILEGES;`  
   Note that in this example we are granting 'newuser' full root access to
   everything in our database, which puts security at high risk.  
   To delete:  
   mysql> `DROP USER 'newuser'@'localhost';`

4. Test out new user:  
   $ `mysql -u 'newuser' -p`

5. mysql> `CREATE DATABASE 'db_name';`   
   To delete:   
   mysql> `DROP DATABASE 'db_name';`

6. Log out the MySQL shell by pressing **CTRL+D** or entering `quit`, so we can load a database from a file:  
   $ `mysql -u 'newuser' -p 'db_name' < data-dump.sql`

7. Log back in and inspect database:  
   $ `mysql -u 'newuser' -p`  
   mysql> `USE 'db_name';`  
   mysql> `SHOW TABLES;`  
