------------------------------------------------------------------------------------------------------
													--数据类型解析

--char [ ( n ) ] 
--固定长度，非 Unicode 字符数据，长度为 n 个字节。n 的取值范围为 1 至 8,000，存储大小是 n 个字节。char 的 SQL 2003 同义词为 character。
--
--varchar [ ( n | max ) ] 
--可变长度，非 Unicode 字符数据。n 的取值范围为 1 至 8,000。max 指示最大存储大小是 2^31-1 个字节。存储大小是输入数据的实际长度加 2 个字节。所输入数据的长度可以为 0 个字符。SQL-2003 中的 varchar 就是 char varying 或 character varying。

--nchar [ ( n ) ]
--
--n 个字符的固定长度的 Unicode 字符数据。n 值必须在 1 到 4,000 之间（含）。存储大小为两倍 n 字节。nchar 的 SQL-2003 同义词为 national char 和 national character。


-------------------------------------------------------------------------------------------------------------

use master
GO
----------------------------------------------------------------
							--建数据库
--------------------------------------------------------------
if db_id('MYBBS_DB') is not null
        drop database MYBBS_DB;

go
create database MYBBS_DB
on
(
	name=MYBBS_DB,
	filename='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\MYBBS_DB.mdf',
	size=10,
	maxsize=50,
	filegrowth=5
)
Log on
(
	name=MYBBS_DB_LOG,
	filename='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\MYBBS_DB.ldf',
	size=5mb,
	maxsize=25mb,
	filegrowth=5mb
);
go
-------------------------------------------------------------------------
							--利用BBS_DB数据库来创建表
--------------------------------------------------------------------------
use MYBBS_DB
go
if object_id('UserInfo')is not null
		drop table UserInfo;
if object_id('TitleList')is not null
		drop table TitleList;
if object_id('NoteContent')is not null
		drop table NoteContent;
if object_id('Subject')is not null
		drop table Subject;
if object_id('Ballot')is not null
		drop table Ballot;
go
--------------------------------------------------------------------------
					--建用户信息表
---------------------------------------------------------------------------
if object_id('UserInfo')is not null
		drop table UserInfo;
go
create table UserInfo
(
	userID int identity(1,1) primary key not null,---用户ID，主键，identity(1,1)意思就是该列自动增长，由1开始每次增加是1，
	userName char(10)  not null,---------------------用户名称
	userNick char(10)  not null,---------------------用户昵称
	userPass char(10)  not null,---------------------用户密码
	userEmail varchar(50) not null,------------------用户电子邮件
	userMark  varchar(500) not null,-----------------用户备注
	userGroup int	,		-------------------------用户组
	userLevel int			-------------------------用户等级				
);

insert into UserInfo values('Admin','管理员','root','user@sina.com','This is Admin',0,1)
insert into UserInfo values('Alan','hah','1234','sfa','af',1,0)

go
--------------------------------------------------------------------------
					--建论坛主题的标题列表
---------------------------------------------------------------------------
if object_id('TitleList')is not null
		drop table TitleList;
create table TitleList
(
	noteId int  primary key identity(1,1) not null ,----论坛主题的标题id
	userNick char(10)  not null,-----------------------发帖用户昵称
	noteTitle text not null,---------------------------帖子标题
	contTime datetime not null,------------------------发帖时间
	noteGroup char(10) not null,-----------------------帖子所属的分区
	noteContent text not null,-------------------------帖子的正文内容
	username  char(10) not null,-----------------------发帖用户名称
);

insert into TitleList values('管理员','asdf',getdate(),'站务通知','sdf','Admin')
insert into TitleList values('Alan_Yan','在艺术的世界里享受生活',getdate(),'文化艺术','文化？艺术','张成')
insert into TitleList values('Alan_Yan','电脑死机了',getdate(),'信息技术','每个人的电脑都有死机的时候，我们要学会去处理这些异常情况','Alan_Yan')
insert into TitleList values('小三','NBA',getdate(),'休闲娱乐','马刺今年会夺冠吗？','昨夜星辰')
insert into TitleList values('c#程序员','《c#从入门到精通》',getdate(),'学习天地','本书介绍了如何高效的学习c#这门语言','编程爱好者')

go
--------------------------------------------------------------------------
					--建论坛帖子的内容与回复信息列表
---------------------------------------------------------------------------
if object_id('NoteContent')is not null
		drop table NoteContent;
create table NoteContent
(
	returnId int primary key identity(1,1) not null ,------------------------------回复表ID
	noteId int foreign key references TitleList(noteId) not null,------------------主题ID
	noteContent varchar(500) not null,----------------回复内容
	userNick  char(10) not null,----------------------回复用户昵称
	noteTime  datetime not null,----------------------回复时间
	userName  char(10) not null,----------------------回复用户名
);

insert into NoteContent values(1,'sadf','管理员',getdate(),'Admin')

go
--------------------------------------------------------------------------
					--建记录投票主题信息列表
---------------------------------------------------------------------------
if object_id('Subject')is not null
		drop table Subject;
create table Subject
(
	SubjectId int primary key identity(1,1) not null,--投票主题ID
	SubjectName varchar(50) not null,------------------发起投票用户昵称
	SumNumber  int ,-----------------------------------帖子标题数量
);

insert into Subject values('adf',null)
go
--------------------------------------------------------------------------
					--建记录投票项目信息列表
---------------------------------------------------------------------------
if object_id('Ballot')is not null
		drop table Ballot;
create table Ballot
(
	OptionID int primary key identity(1,1) not null ,----------------主题ID
	SubjectId int foreign key references Subject(SubjectId) not null,----------------------------投票项目id
	OptionName varchar(50) not null, ------------------投票项目名称
	CountNumer int ,-----------------------------------投票数
)
insert into Ballot values(1,'asdf',null)
insert into Ballot values(1,'asdm',null)
insert into Ballot values(1,']asdf',null)
insert into Ballot values(1,'sdfsdf',null)
insert into Ballot values(1,'g',null)
insert into Ballot values(1,'g',null)
insert into Ballot values(1,'h',null)