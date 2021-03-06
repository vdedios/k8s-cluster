GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'admin'@'0.0.0.0' IDENTIFIED BY 'admin';
GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'admin'@'%' IDENTIFIED BY 'admin';

GRANT ALL PRIVILEGES ON *.* TO 'admin'@'0.0.0.0' IDENTIFIED BY 'admin' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION;

CREATE DATABASE wordpress;
GRANT ALL ON wordpress.* TO 'admin'@'0.0.0.0' IDENTIFIED BY 'admin' WITH GRANT OPTION;
GRANT ALL ON wordpress.* TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION;
