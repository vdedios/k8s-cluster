<?php
/**
 * Only one server
 */
$i = 1;

/* Authentication type */
$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;

/**
 * Variable definition
 */
$cfg['Servers'][$i]['host'] = "mysql";
$cfg['Servers'][$i]['port'] = "3306";
$cfg['Servers'][$i]['user'] = "admin";
$cfg['Servers'][$i]['password'] = "admin";

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
