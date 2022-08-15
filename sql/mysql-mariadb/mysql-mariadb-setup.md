# How to set up a MySQL/MariaDB database
## MySQL Workbench Setup Instructions
1. Download and install MySQL or MariaDB
2. Download and install MySQL Workbench
3. Open MySQL Workbench
4. In the left column, SQL Development, look at list of connections, if localhost is present skip to step 11
5. Click on New Connection to display the Setup New Connection dialog
6. Set Connection Name to localhost
7. Specify the user login and password (if no user was specified then the login will be root)
8. Click the Test Connection button
9. If all ok, click OK to create the connection
10. The connection will now be listed, and in future you can just double-click on it directly
11. Double-click on the database to open the SQL Editor
12. To create a new database (called a Schema in MySQL and MariaDB) click on the Create New
Schema button (it is the one that looks like a yellow barrel with a + sign next to it), this will
display a dialog box.
13. Set name to tysql, you can leave all the other fields blank and click Apply. You’ll be prompted for
verification and click Apply again to create the database
14. You can now type SQL in the editor window, but you must first make sure that your newly
created database is selected. If it is selected its name will be in bold and the name will be
displayed in the title bar. If something other than tysql is selected, double-click on tysql in the
Object Browser
15. Copy and paste contents of Create (may see warnings about keys, ok)
16. Execute Query button (yellow lightning bolt) to execute
17. Copy and paste contents if Populate
18. Test it with SELECT * FROM Customers;


## Command line / Debian
Useful links:  
* https://www.digitalocean.com/community/tutorials/a-basic-mysql-tutorial  
* https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql  
* https://www.digitalocean.com/community/tutorials/how-to-import-and-export-databases-in-mysql-or-mariadb )

1. `sudo apt install mysql-server`

2. `sudo mysql -u root (-p)`

3. ```
   mysql> CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';  
   mysql> GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';  
   mysql> FLUSH PRIVILEGES;
   ```
   Note that in this example we are granting 'newuser' full root access to
   everything in our database, which puts security at high risk.  
   To delete:  
   ```
   mysql> DROP USER 'newuser'@'localhost';
   ```
4. Test out new user:  
   `mysql -u 'newuser' -p`

5. mysql> `CREATE DATABASE 'db_name';`  
   To delete:  
   mysql> `DROP DATABASE 'db_name';`

6. Log out the MySQL shell by pressing **CTRL+D** or entering `quit`, so we can load a database from a file:  
   `mysql -u 'newuser' -p 'db_name' < data-dump.sql`

7. Log back in and inspect database:  
   $ `mysql -u 'newuser' -p`  
   mysql> `USE 'db_name';`  
   mysql> `SHOW TABLES;`  
