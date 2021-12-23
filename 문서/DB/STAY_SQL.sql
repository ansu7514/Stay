#회원
create table member(
	id varchar(20) not null primary key,
	pass varchar(20) not null,
	name varchar(20) not null,
	birth date not null,
	hp varchar(20) not null,
	addr varchar(100) not null,
	photo varchar(100),
	likes int default 0,
	e_mail varchar(100) not null
);

#회원신고
create table report_member(
	no int auto_increment primary key not null,
	black_id varchar(20),
	report_id varchar(20),
	reason varchar(500) not null,
	foreign key (black_id) references member(id) on update cascade on delete set null,
	foreign key (report_id) references member(id) on update cascade on delete cascade
);

#숙소
create table room(
	no int auto_increment primary key,
	host_id varchar(20) not null,
	type varchar(50) not null,
	addr_load varchar(100) not null,
	addr_detail varchar(100) not null,
	max_per tinyint not null,
	content varchar(5000) not null,
	name varchar(500) not null,
	photos varchar(1000) not null,
	price int not null,
	hosting tinyint(1) default 1,
	foreign key (host_id) references member(id) on update cascade on delete cascade
);

#숙소변경가격
create table room_price(
	no int not null,
	change_date date not null,
	price int not null,
	primary key (no,change_date),
	foreign key (no) references room(no)
);

#숙소변경호스팅
create table room_hosting(
	no int not null,
	change_date date not null,
	hosting tinyint(1) not null,
	primary key (no,change_date),
	foreign key (no) references room(no)
);

#결제카드
create table pay_card(
	num varchar(20) primary key not null,
	id varchar(20) not null,
	name varchar(50) not null,
	end_date date not null,
	cvc smallint not null,
	pass smallint not null,
	foreign key (id) references member(id)
);

#수령계좌
create table receive_account(
	account varchar(50) primary key not null,
	id varchar(20) not null,
	bank varchar(20) not null,
	foreign key (id) references member(id)
);

#예약
create table reservation(
	no int not null auto_increment primary key,
	guest_id varchar(20) not null,
	host_id varchar(20) not null,
	start_date date not null,
	end_date date not null,
	price int not null,
	pay_method varchar(30) not null,
	card_num varchar(20),
	account_num varchar(50),
	pay_date date not null,
	foreign key (guest_id) references member(id) on update cascade,
	foreign key (host_id) references member(id) on update cascade,
	foreign key (card_num) references pay_card(num),
	foreign key (account_num) references receive_account(account)
);

#예약영수증
create table receipt(
	id int auto_increment not null,
	no int not null,
	primary key (id, no),
	foreign key (no) references reservation(no)
);

#예약취소
create table can_reservation(
	no int primary key not null,
	can_date date not null,
	refund int not null,
	refund_check varchar(20) default "ing",
	foreign key (no) references reservation(no)
);

#예약취소영수증
create table can_receipt(
	id int auto_increment not null,
	no int not null,
	primary key (id, no),
	foreign key (no) references can_reservation(no)
);

#공동게스트
create table join_guest(
	no int not null,
	id varchar(20) not null,
	primary key (no, id),
	foreign key (no) references reservation(no),
	foreign key (id) references member(id)
);

#게스트댓글
create table guest_comment(
	no int not null,
	guest_id varchar(20) not null,
	content varchar(500) not null,
	rating float not null,
	likes int default 0,
	primary key (no, guest_id),
	foreign key (no) references reservation(no),
	foreign key (guest_id) references member(id)
);

#호스트답글
create table host_comment(
	no int not null,
	guest_id varchar(20) not null,
	host_id varchar(20) not null,
	content varchar(500) not null,
	primary key (no, guest_id, host_id),
	foreign key (no) references reservation(no),
	foreign key (guest_id) references member(id),
	foreign key (host_id) references member(id)
);

#위시리스트
create table wishlist(
	room_no int not null,
	guest_id varchar(20) not null,
	primary key (room_no, guest_id),
	foreign key (room_no) references room(no),
	foreign key (guest_id) references member(id)
);

#채팅
create table chat(
	id int auto_increment primary key,
	msg varchar(5000),
	sender varchar(20),
	receiver varchar(20),
	foreign key (sender) references member(id),
	foreign key (receiver) references member(id)
);