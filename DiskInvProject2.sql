
-- Original Author:Derek Dombek
-- Date Created:03/5/2020
-- Version:inserts
-- Date Last Modified:03/5/2020
-- Modified by:Derek Dombek
-- Modification log: --3/5/2020- added inserts to the disk database
					--3/12/2020- added joins
					--4/8/2020- added stored procedures

use master;
go

--drop & create tables
drop database if exists disk_inventorydd;
go
create database disk_inventorydd;
go
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


--All THE INSERTs


USE [disk_inventorydd]
GO
--insert status
INSERT INTO [dbo].[status]
           ([description])
     VALUES
           ('available'),
		   ('on loan'),
		   ('damaged'),
		   ('missing');
GO
--insert genres
INSERT INTO [dbo].[genre]
           ([description])
     VALUES
           ('classic rock'),
		   ('country'),
		   ('rock'),
		   ('rap'),
		   ('metal');
GO
--insert cd types
INSERT INTO [dbo].[cd_type]
           ([description])
     VALUES
           ('cd'),
		   ('vinyl'),
		   ('8track'),
		   ('cassestte'),
		   ('dvd');
GO
--insert artist types
INSERT INTO [dbo].[artist_type]
           ([description])
     VALUES
           ('solo'),
		   ('group');
		   
GO
--insert cd rows
INSERT INTO [dbo].[cd]
           ([cd_name]
           ,[rel_date]
           ,[genre_id]
           ,[status_id]
           ,[cd_type_id])
     VALUES
           ('Crazy Train', '1/1/1995', 1,1,2),
		   ('sinner', '1/1/2016', 2,1,1),
		   ('coma witch', '1/1/2014', 5,2,2),
		   ('gravebloom', '3/1/2017', 5,3,2),
		   ('all get out', '2/1/2008', 3,1,2),
		   ('southern weather', '1/1/2007', 3,4,2),
		   ('heat', '1/1/2008', 5,1,2),
		   ('mono', '1/1/2017', 5,1,2),
		   ('still firing', '2/1/2017', 5,2,2),
		   ('come now sleep', '2/1/2007', 3,1,2),
		   ('chaos', '2/1/2016', 5,1,2),
		   ('outlawed', '1/1/2011', 5,1,2),
		   ('country was', '1/1/2002', 2,3,2),
		   ('heavy breathing', '1/1/2010', 5,1,2),
		   ('el camino', '2/1/2011', 1,1,2),
		   ('kill', '1/1/2006', 5,1,2),
		   ('acid rap', '1/1/2013', 4,2,1),
		   ('in the night', '3/1/2016', 2,1,2),
		   ('the valley', '1/1/2019', 2,4,1),
		   ('self inflited', '4/1/2017', 5,3,2),
		   ('traveller', '1/1/2015', 2,1,1);
         
GO


--update cd row
UPDATE [dbo].[cd]
   SET 
      [rel_date] = '11/11/2011'

 WHERE cd_id = 20;
GO




--insert borrower rows
INSERT INTO [dbo].[borrower]
           ([borrower_firt_name]
           ,[borrower_last_name]
           ,[phone])
     VALUES
           ('Derek', 'Dombek', '216-300-3000'),
		   ('pete', 'miller', '216-300-3001'),
		   ('charley', 'hovan', '216-300-3002'),
		   ('mike', 'hill', '216-300-3003'),
		   ('matt', 'rose', '216-300-3004'),
		   ('alex', 'ross', '216-300-3005'),
		   ('meredith', 'morgan', '216-300-3006'),
		   ('pam', 'peterson', '216-300-3007'),
		   ('sue', 'murdoch', '216-300-3008'),
		   ('fred', 'wade', '216-300-3009'),
		   ('will', 'garret', '216-300-3010'),
		   ('tim', 'mayfield', '216-300-3011'),
		   ('fran', 'landry', '216-300-3012'),
		   ('bob', 'chubb', '216-300-3013'),
		   ('bill', 'hunt', '216-300-3014'),
		   ('dan', 'vernon', '216-300-3015'),
		   ('tammy', 'ward', '216-300-3016'),
		   ('jen', 'higgins', '216-300-3017'),
		   ('jake', 'gibbons', '216-300-3018'),
		   ('evan', 'mcghee', '216-300-3019'),
		   ('tim', 'mcgraw', '216-300-3019');
GO

--delete the last borrower
delete borrower
where borrower_id = 20;


--insert artist rows
INSERT INTO [dbo].[artist]
           ([artist_firt_name]
           ,[artist_type_id])
     VALUES
           ('ozzy ozbourne',2),
		   ('aaron lewis',1),
		   ('the acacia strain',2),
		   ('all get out',2),
		   ('the almost',2),
		   ('american me',2),
		   ('alpha wolf',2),
		   ('american me',2),
		   ('as cities burn',2),
		   ('attila',2),
		   ('the avett brothers',2),
		   ('black breath',2),
		   ('the black keys',2),
		   ('cannibal corpse',2),
		   ('chance the rapper',1),
		   ('charley crockett',1),
		   ('chelsea grin',2),
		   ('chris stapleton',1),
		   ('circa survive',2),
		   ('colter wall',1);
GO



--insert cd_borrower rows
INSERT INTO [dbo].[cd_borrower]
           ([cd_id]
           ,[borrower_id]
           ,[borrower_date]
           ,[return_date])
     VALUES
           (2,4,'03/10/2019','03/11/2019'),
		   (3,5,'05/10/2019','05/12/2019'),
		   (3,6,'02/20/2019','03/25/2019'),
		   (2,7,'03/10/2019','03/14/2019'),
		   (5,2,'04/10/2019','04/15/2019'),
		   (5,7,'01/1/2019','03/10/2019'),
		   (5,7,'02/10/2019','03/10/2019'),
		   (5,8,'07/10/2019','07/20/2019'),
		   (11,12,'02/15/2019','03/17/2019'),
		   (12,15,'03/17/2019','03/18/2019'),
		   (13,15,'10/10/2019','10/12/2019'),
		   (14,11,'11/10/2019',null),
		   (15,11,'08/26/2019','08/28/2019'),
		   (15,12,'12/10/2019','12/31/2019'),
		   (8,8,'06/15/2019','06/20/2019'),
		   (9,4,'08/10/2019','09/10/2019'),
		   (10,9,'07/10/2019','08/11/2019'),
		   (4,3,'04/22/2019','04/23/2019'),
		   (7,4,'05/13/2019','05/23/2019'),
		   (2,14,'08/12/2019','08/13/2019');
GO

--insert 
INSERT INTO [dbo].[cd_artist]
           ([cd_id]
           ,[artist_id])
     VALUES
           (1,1),
		   (2,1),
		   (3,3),
		   (4,4),
		   (5,6),
		   (6,8),
		   (7,8),
		   (8,8),
		   (8,6),
		   (8,7),
		   (9,12),
		   (10,12),
		   (11,18),
		   (12,16),
		   (13,15),
		   (14,15),
		   (15,12),
		   (15,15),
		   (16,16),
		   (17,17);
GO

--
select borrower_id as borrower_id, cd_id as cd_id, borrower_date as borrower_date, return_date as returned_date
from cd_borrower
where return_date is null;


--Project 4
--3.
select cd_name as 'CD name', convert(varchar(10),rel_date, 101) as 'Release Date', artist_firt_name as 'Artist First name', artist_last_name as 'Artist Last name' 

from cd join cd_artist 
	on cd.cd_id = cd_artist.cd_id join artist
	on cd_artist.artist_id = artist.artist_id
where artist_type_id = 1
order by artist_last_name, artist_firt_name, cd_name;
go
--4.
create view View_Individual_Artist as 
	select artist_id, artist_firt_name, artist_last_name
	from artist
	where artist_type_id = 1;
go
select artist_firt_name as 'FirstName', artist_last_name as 'LastName'
from View_Individual_Artist
order by artist_firt_name, artist_last_name

--5.
select cd_name as 'CD name', convert(varchar(10),rel_date, 101) as 'Release Date', artist_firt_name as 'Group Name' 
from cd join cd_artist 
	on cd.cd_id = cd_artist.cd_id join artist
	on cd_artist.artist_id = artist.artist_id
where artist.artist_id not in (select artist_id from View_Individual_Artist)
order by cd_name;

--6.
select borrower_firt_name as 'First', borrower_last_name as 'Last', cd_name as 'CD Name', borrower_date as 'Borrowed Date', return_date as 'Returned Date'
from borrower b join cd_borrower cdb
	on b.borrower_id = cdb.borrower_id join cd d
	on cdb.cd_id = d.cd_id
order by cd_name, borrower_last_name, borrower_firt_name, borrower_date, return_date;

--7.
select d.cd_id, cd_name, count(*) as 'Times Borrowed'
from cd d join cd_borrower cdb
	on d.cd_id = cdb.cd_id
group by d.cd_id, cd_name
order by d.cd_id;

--8.
select cd_name as 'CD Name', borrower_date as Borrowed, return_date as Returned, borrower_last_name as 'Last Name'
from cd d join cd_borrower cdb
	on d.cd_id = cdb.cd_id join borrower b
	on cdb.borrower_id = b.borrower_id
where return_date is null
order by cd_name;




go



--project 5 stored procedures
--2 artist procedures.

drop procedure if exists sp_ins_artist;
go
create procedure sp_ins_artist
	@artist_firt_name varchar(60), @artist_last_name varchar(60) = null, @artist_type_id int
as
	begin try
		INSERT INTO [dbo].[artist]
				   ([artist_firt_name]
				   ,[artist_last_name]
				   ,[artist_type_id])
			 VALUES
				   (@artist_firt_name
				   ,@artist_last_name
				   ,@artist_type_id)
		end try
		begin catch
			print 'an error has occured.';
			print 'message: ' + convert(varchar(200), error_message());
		end catch
GO
grant execute on sp_ins_artist to diskUserdd;
exec sp_ins_artist 'john prine', null, 1; 
exec sp_ins_artist 'jimmy buffet', null, 11;
go



drop procedure if exists sp_upd_artist;
go
create procedure sp_upd_artist
	@artist_id int, @artist_firt_name varchar(60), @artist_last_name varchar(60) = null, @artist_type_id int
as

begin try
	UPDATE [dbo].[artist]
	   SET [artist_firt_name] = @artist_firt_name
		  ,[artist_last_name] =  @artist_last_name
		  ,[artist_type_id] = @artist_type_id
	 WHERE artist_id = @artist_id
end try
	begin catch
		print 'an error has occured.';
		print 'message: ' + convert(varchar(200), error_message());
	end catch
GO


grant execute on sp_upd_artist to diskUserdd
exec sp_upd_artist 22, 'john prine', 'updated', 2; 
exec sp_upd_artist 23, 'jimmy buffet', null, 11;
go


drop procedure if exists sp_del_artist;
go
create procedure sp_del_artist
	@artist_id int
as

begin try
	delete from [dbo].[artist]
		WHERE artist_id = @artist_id
end try
	begin catch
		print 'an error has occured.';
		print 'message: ' + convert(varchar(200), error_message());
	end catch
GO


grant execute on sp_del_artist to diskUserdd
exec sp_del_artist 22; 
exec sp_del_artist 1;
go


--3 borrower procedures.
drop procedure if exists sp_ins_borrower;
go
create procedure sp_ins_borrower
	@borrower_firt_name varchar(60), @borrower_last_name varchar(60), @phone varchar(50)
as
	begin try
		INSERT INTO [dbo].[borrower]
				   ([borrower_firt_name]
				   ,[borrower_last_name]
				   ,[phone])
			 VALUES
				   (@borrower_firt_name
				   ,@borrower_last_name
				   ,@phone)
		end try
		begin catch
			print 'an error has occured.';
			print 'message: ' + convert(varchar(200), error_message());
		end catch
GO
grant execute on sp_ins_borrower to diskUserdd;
exec sp_ins_borrower'doogie', 'hoozer', '2081112222'; 
exec sp_ins_borrower'doogie', null, '2081112222';
go


drop procedure if exists sp_upd_borrower;
go
create procedure sp_upd_borrower
	@borrower_id int, @borrower_firt_name varchar(60), @borrower_last_name varchar(60), @phone varchar(50)
as
		begin try
			UPDATE [dbo].[borrower]
			   SET [borrower_firt_name] = @borrower_firt_name
				  ,[borrower_last_name] = @borrower_last_name
				  ,[phone] =  @phone
			 WHERE borrower_id = @borrower_id
		end try
		begin catch
			print 'an error has occured.';
			print 'message: ' + convert(varchar(200), error_message());
		end catch
GO
grant execute on sp_upd_borrower to diskUserdd;
exec sp_upd_borrower 22, 'doogie', 'hoozer', '208-111-2222'; 
exec sp_upd_borrower 21, 'doogie', null, '2081112222';
go


drop procedure if exists sp_del_borrower;
go
create procedure sp_del_borrower
	@borrower_id int
as
		begin try
			DELETE FROM [dbo].[borrower]
				  WHERE borrower_id = @borrower_id
		end try
		begin catch
			print 'an error has occured.';
			print 'message: ' + convert(varchar(200), error_message());
		end catch
GO
grant execute on sp_del_borrower to diskUserdd;
exec sp_del_borrower 22; 
exec sp_del_borrower 21;
exec sp_del_borrower 2;
go

--4 cd procedures.
drop procedure if exists sp_ins_cd;
go
create procedure sp_ins_cd
	@cd_name varchar(60), @rel_date datetime, @genre_id int, @status_id int, @cd_type_id int
as
	begin try
		INSERT INTO [dbo].[cd]
				   ([cd_name]
				   ,[rel_date]
				   ,[genre_id]
				   ,[status_id]
				   ,[cd_type_id])
			 VALUES
				   (@cd_name
				   ,@rel_date
				   ,@genre_id
				   ,@status_id
				   ,@cd_type_id)
	end try
	begin catch
		print 'an error has occured.';
		print 'message: ' + convert(varchar(200), error_message());
	end catch
GO
grant execute on sp_ins_cd to diskUserdd;
exec sp_ins_cd 'thunder', '3/5/2020', 4,1,1; 
exec sp_ins_cd 'doogie', '2/2/2002', null,1,1;
go

drop procedure if exists sp_upd_cd;
go
create procedure sp_upd_cd
	@cd_id int, @cd_name varchar(60), @rel_date datetime, @genre_id int, @status_id int, @cd_type_id int
as
	begin try
		UPDATE [dbo].[cd]
		   SET [cd_name] = @cd_name
			  ,[rel_date] = @rel_date
			  ,[genre_id] = @genre_id
			  ,[status_id] = @status_id
			  ,[cd_type_id] =  @cd_type_id
		 WHERE cd_id = @cd_id
	end try
	begin catch
		print 'an error has occured.';
		print 'message: ' + convert(varchar(200), error_message());
	end catch
GO
grant execute on sp_upd_cd to diskUserdd;
exec sp_upd_cd 22, 'thunder updated', '3/10/2020', 3,2,2; 
exec sp_upd_cd 22, 'doogie', '2/2/2002', null,1,1;
go

drop procedure if exists sp_del_cd;
go
create procedure sp_del_cd
	@cd_id int
as
	begin try
		DELETE FROM [dbo].[cd]
			  WHERE cd_id = @cd_id
	end try
	begin catch
		print 'an error has occured.';
		print 'message: ' + convert(varchar(200), error_message());
	end catch
GO
grant execute on sp_del_cd to diskUserdd;
exec sp_del_cd 22; 
exec sp_del_cd 5;
go