use master;
go

--drop & create tables
drop database if exists disk_inventorydd;

create database disk_inventorydd;

use disk_inventorydd;
go

create table genre (
	genre_id int not null primary key identity,
	description varchar(60) not null
);

create table status (
	status_id int not null primary key identity,
	description varchar(60) not null
);

create table cd_type (
	cd_type_id int not null primary key identity,
	description varchar(60) not null
);

create table artist_type (
	artist_type_id int not null primary key identity,
	description varchar(60) not null
);

create table borrower (
	borrower_id int not null primary key identity,
	borrower_firt_name varchar(60) not null,
	borrower_last_name varchar(60) not null,
	phone varchar(60) not null
);

create table artist (
	artist_id int not null primary key identity,
	artist_firt_name varchar(60) not null,
	artist_last_name varchar(60) null,
	artist_type_id int not null references artist_type(artist_type_id)
);

create table cd (
	cd_id int not null primary key identity,
	cd_name varchar(60) not null,
	rel_date datetime not null,
	genre_id int not null references genre(genre_id),
	status_id int not null references status(status_id),
	cd_type_id int not null references cd_type(cd_type_id)
);

create table cd_artist (
	cd_id int not null references cd(cd_id),
	artist_id int not null references artist(artist_id),
	primary key(artist_id, cd_id)
);

create table cd_borrower (
	cd_id int not null references cd(cd_id),
	borrower_id int not null references borrower(borrower_id),
	borrower_date date not null,
	return_date date null,
	primary key(borrower_id, cd_id, borrower_date)
);

--drop & create login/user
if suser_id('diskUserdd') is null
	create login diskUserdd with password = 'Pa$$w0rd',
	default_database = disk_inventorydd;

drop user if exists diskUserdd;

create user diskUserdd for login diskUserdd;

alter role db_datareader add member diskUserdd;
