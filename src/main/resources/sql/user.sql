create table miaosha_user
(
	id bigint not null comment '用户ID，手机号码'
		primary key,
	nickname varchar(255) null,
	password varchar(32) null comment 'MD5(MD5(pass明文+固定salt)+salt)',
	salt varchar(10) null,
	head varchar(128) null comment '头像，云存储ID',
	register_date datetime null,
	last_login_date datetime null,
	login_count int null
)
;

