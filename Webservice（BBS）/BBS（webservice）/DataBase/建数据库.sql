------------------------------------------------------------------------------------------------------
													--�������ͽ���

--char [ ( n ) ] 
--�̶����ȣ��� Unicode �ַ����ݣ�����Ϊ n ���ֽڡ�n ��ȡֵ��ΧΪ 1 �� 8,000���洢��С�� n ���ֽڡ�char �� SQL 2003 ͬ���Ϊ character��
--
--varchar [ ( n | max ) ] 
--�ɱ䳤�ȣ��� Unicode �ַ����ݡ�n ��ȡֵ��ΧΪ 1 �� 8,000��max ָʾ���洢��С�� 2^31-1 ���ֽڡ��洢��С���������ݵ�ʵ�ʳ��ȼ� 2 ���ֽڡ����������ݵĳ��ȿ���Ϊ 0 ���ַ���SQL-2003 �е� varchar ���� char varying �� character varying��

--nchar [ ( n ) ]
--
--n ���ַ��Ĺ̶����ȵ� Unicode �ַ����ݡ�n ֵ������ 1 �� 4,000 ֮�䣨�������洢��СΪ���� n �ֽڡ�nchar �� SQL-2003 ͬ���Ϊ national char �� national character��


-------------------------------------------------------------------------------------------------------------

use master
GO
----------------------------------------------------------------
							--�����ݿ�
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
							--����BBS_DB���ݿ���������
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
					--���û���Ϣ��
---------------------------------------------------------------------------
if object_id('UserInfo')is not null
		drop table UserInfo;
go
create table UserInfo
(
	userID int identity(1,1) primary key not null,---�û�ID��������identity(1,1)��˼���Ǹ����Զ���������1��ʼÿ��������1��
	userName char(10)  not null,---------------------�û�����
	userNick char(10)  not null,---------------------�û��ǳ�
	userPass char(10)  not null,---------------------�û�����
	userEmail varchar(50) not null,------------------�û������ʼ�
	userMark  varchar(500) not null,-----------------�û���ע
	userGroup int	,		-------------------------�û���
	userLevel int			-------------------------�û��ȼ�				
);

insert into UserInfo values('Admin','����Ա','root','user@sina.com','This is Admin',0,1)
insert into UserInfo values('Alan','hah','1234','sfa','af',1,0)

go
--------------------------------------------------------------------------
					--����̳����ı����б�
---------------------------------------------------------------------------
if object_id('TitleList')is not null
		drop table TitleList;
create table TitleList
(
	noteId int  primary key identity(1,1) not null ,----��̳����ı���id
	userNick char(10)  not null,-----------------------�����û��ǳ�
	noteTitle text not null,---------------------------���ӱ���
	contTime datetime not null,------------------------����ʱ��
	noteGroup char(10) not null,-----------------------���������ķ���
	noteContent text not null,-------------------------���ӵ���������
	username  char(10) not null,-----------------------�����û�����
);

insert into TitleList values('����Ա','asdf',getdate(),'վ��֪ͨ','sdf','Admin')
insert into TitleList values('Alan_Yan','����������������������',getdate(),'�Ļ�����','�Ļ�������','�ų�')
insert into TitleList values('Alan_Yan','����������',getdate(),'��Ϣ����','ÿ���˵ĵ��Զ���������ʱ������Ҫѧ��ȥ������Щ�쳣���','Alan_Yan')
insert into TitleList values('С��','NBA',getdate(),'��������','��̽��������','��ҹ�ǳ�')
insert into TitleList values('c#����Ա','��c#�����ŵ���ͨ��',getdate(),'ѧϰ���','�����������θ�Ч��ѧϰc#��������','��̰�����')

go
--------------------------------------------------------------------------
					--����̳���ӵ�������ظ���Ϣ�б�
---------------------------------------------------------------------------
if object_id('NoteContent')is not null
		drop table NoteContent;
create table NoteContent
(
	returnId int primary key identity(1,1) not null ,------------------------------�ظ���ID
	noteId int foreign key references TitleList(noteId) not null,------------------����ID
	noteContent varchar(500) not null,----------------�ظ�����
	userNick  char(10) not null,----------------------�ظ��û��ǳ�
	noteTime  datetime not null,----------------------�ظ�ʱ��
	userName  char(10) not null,----------------------�ظ��û���
);

insert into NoteContent values(1,'sadf','����Ա',getdate(),'Admin')

go
--------------------------------------------------------------------------
					--����¼ͶƱ������Ϣ�б�
---------------------------------------------------------------------------
if object_id('Subject')is not null
		drop table Subject;
create table Subject
(
	SubjectId int primary key identity(1,1) not null,--ͶƱ����ID
	SubjectName varchar(50) not null,------------------����ͶƱ�û��ǳ�
	SumNumber  int ,-----------------------------------���ӱ�������
);

insert into Subject values('adf',null)
go
--------------------------------------------------------------------------
					--����¼ͶƱ��Ŀ��Ϣ�б�
---------------------------------------------------------------------------
if object_id('Ballot')is not null
		drop table Ballot;
create table Ballot
(
	OptionID int primary key identity(1,1) not null ,----------------����ID
	SubjectId int foreign key references Subject(SubjectId) not null,----------------------------ͶƱ��Ŀid
	OptionName varchar(50) not null, ------------------ͶƱ��Ŀ����
	CountNumer int ,-----------------------------------ͶƱ��
)
insert into Ballot values(1,'asdf',null)
insert into Ballot values(1,'asdm',null)
insert into Ballot values(1,']asdf',null)
insert into Ballot values(1,'sdfsdf',null)
insert into Ballot values(1,'g',null)
insert into Ballot values(1,'g',null)
insert into Ballot values(1,'h',null)