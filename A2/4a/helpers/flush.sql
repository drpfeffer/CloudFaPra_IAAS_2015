use mysql;
update user set host='%' where user='wordpressuser';
update db set host='%' where db='wordpressdb';
flush privileges;
