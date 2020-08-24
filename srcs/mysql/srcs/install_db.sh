#!/bin/ash

openrc reboot
/etc/init.d/mariadb setup
/etc/init.d/mariadb start
mariadb < create_tables.sql
mariadb < config_db.sql
mariadb < wordpress.sql
