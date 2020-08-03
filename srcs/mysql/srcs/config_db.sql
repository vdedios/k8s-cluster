GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;
CREATE DATABASE wordpress;
GRANT ALL ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;
