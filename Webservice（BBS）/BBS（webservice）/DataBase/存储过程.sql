USE MYBBS_DB
GO
----------------------------------------------------��¼��֤ģ��-------------------------

----------------------------------------------------������¼�洢����-------------------------

CREATE PROCEDURE pd_Login
(
	@Name char(10),
	@Pass char(10)
)
AS
begin
	SELECT 
		userNick,userLevel
	FROM
		UserInfo
	WHERE
		(userPass=@Pass)and(userName=@Name)
	return
end
GO
--exec pd_Login @Pass='root',@Name='admin'
----------------------------------------------------��������Ϸ��û��洢����-------------------------
CREATE PROCEDURE pd_ChceckUser
(
	@Name char(10)
)
as

begin
	select userName from UserInfo where userName=@Name
	if @@Rowcount<1--���ص���Ӱ��������������Ӱ�������򷵻�0�����򷵻�1--
	return 0
else 
	return 1 
end
Go
----------------------------------------------------����ע���û��洢����-------------------------
CREATE PROCEDURE pd_regedit
(
	@Name char(10),
	@nick char(10),
	@Pass char(10),
	@email char(50),
	@mark varchar(500)
)
AS
begin
	insert into UserInfo values(@Name,@nick,@Pass,@email,@mark,1,0)
if	@@Rowcount<1
	return 0
else
	return 1
end
GO





----------------------------------------------------��������ģ��-------------------------


----------------------------------------------------����ͨ����Ż�õ��췢��������洢����-------------------------
create procedure pd_GetNewList
(
	@group char(10)
)
/*��õ��췢���������,ע��ñ��в�û�б������������*/
as
begin
	select noteTitle,contTime,userNick,noteId
	from TitleList
	where noteGroup=@group and (convert(varchar,contTime,101)=convert(varchar,getdate(),101))
if @@rowcount<1
	return 0
else
	return 1
end
GO
--exec pd_GetNewList 'վ��֪ͨ'

----------------------------------------------------����ͨ������id��ȡ�������ݵĴ洢����-------------------------
create procedure pd_GetTitle
(
	@id int
)
as
begin
	/*����������ݣ������������Ҳû���ض��ķ���ֵ�����ص���һ�ű�*/
	select userNick,noteTitle,contTime,noteContent,userName
	from TitleList
	where noteId=@id
	return
end
GO

----------------------------------------------------������ȡ�ض�����������Ĵ洢����-------------------------
create procedure pd_sortList
(
	@group char(10)
)
as
/*����ض����������*/
begin
	select noteTitle,userNick,contTime,noteId
	from TitleList
	where noteGroup=@group
	order by contTime
end
go
----------------------------------------------------��������������Ĵ洢����-------------------------
create procedure pd_appearNote
(
	@nick char(10),
	@name char(10),
	@title text,
	@time datetime,
	@group char(10),
	@content text
)
/*����������*/
as
begin
	insert into TitleList values(@nick,@title,@time,@group,@content,@name)
	if @@rowcount<1
	return 0
	else
	return 1
end
GO

----------------------------------------------------�������Ӿ���ֵ�Ĵ洢����-------------------------
create procedure pd_GetExp
(
	@name char(10),
	@exp int
)
/*����û�����ֵ*/
as
begin
	update UserInfo
	set userLevel=@exp where userName=@name
	return
end
go
----------------------------------------------------�����޸��������ݵĴ洢����-------------------------
create procedure pd_alterNode
(
	@id int,
	@title text,
	@content text
)
as
begin
/*�޸�����*/
	update TitleList
	set noteTitle=@title,noteContent=@content
	where noteId=@id
if @@rowcount<1
	return 0
else 
	return 1 
end
GO
----------------------------------------------------����ɾ�����⣨���ӣ����ݵĴ洢����-------------------------
create procedure pd_DelNote
(
	@id int
)
/*�������ӵ�����ɾ��������*/
as
begin
	delete from titleList where noteId=@id
	return
end
go
----------------------------------------------------����ɾ�����⣨���ӣ��ظ��Ĵ洢����-------------------------
create procedure pd_DelRes
(
	@id int
)
/*ɾ������������лظ���Ϣ*/
as
begin
	delete from NoteContent where noteId=@id
	return
end
GO
----------------------------------------------------�����ظ��������ݵĴ洢����-------------------------
create procedure pd_ResNote
(
	@id int,
	@Content text,
	@userNick char(10),
	@noteTime datetime,
	@name char(10)
)
/*�ظ�����*/
as
begin
	insert into NoteContent values(@id,@Content,@userNick,@noteTime,@name)
	if @@rowcount<1
	return 0
	else
	return 1
end
GO

----------------------------------------------------��ûظ�������Ϣ-------------------------
create procedure pd_GetContent
(
	@id int
)
/*ʹ��id�����Ӧ����ظ�*/
as
begin
	select noteContent,userNick,noteTime
	from NoteContent
	where noteId=@id
	return
end
GO

----------------------------------------------------����ʱ����Ϣ-------------------------
create procedure pd_ChangeTime
(
	@id int
)
as
begin
	update TitleList
	set contTime=(select getdate())
	where noteId=@id
	return
end
----------------------------------------------------ͶƱģ��-------------------------

go
----------------------------------------------------�������ͶƱ�����Ƿ���ڵĴ洢����-------------------------
create procedure pd_checkSubject
(
	@subject varchar(50)
)
/*�����Ŀ�Ƿ����*/
as
begin
	select count(*)
	from Subject
	where SubjectName=@Subject
	return
end
GO
----------------------------------------------------��������ͶƱ����Ĵ洢����-------------------------
create procedure pd_addSubject
(
	@subject varchar(50)
)
/*����ͶƱ��Ŀ*/
as
begin
	insert into Subject(SubjectName)
	values(@subject)
	return
end
go
----------------------------------------------------��������ͶƱ����������ø�ͶƱ��ID�Ĵ洢����-------------------------
create procedure pd_GetSubjectId
(
	@subject varchar(50)
)
/*���ͶƱ��Ŀ��ID*/
as
begin
	select SubjectId
	from Subject
	where SubjectName=@subject
	return
end
GO
----------------------------------------------------������ʾ��ǰ���ڵ�����ͶƱ����Ĵ洢����-------------------------
create procedure pd_ShowSubject
/*��ʾ����ͶƱ����*/
as
begin
	select *
	from Subject
	return
end
GO

----------------------------------------------------�������ͶƱ����Ĵ洢����-------------------------
create procedure pd_GetSubject
(
	@id int
)
/*�����Ŀ��*/
as
begin
	select OptionName,CountNumber,OptionID
	from Ballot
	where SubjectID=@id
	return
end
GO

----------------------------------------------------��������ͶƱ����Ĵ洢����-------------------------
create procedure pd_UpdateBallot
(
	@option int,
	@subject int
)
/*����ͶƱ��Ŀ*/
as
begin
	update Ballot
/*ָ����ĿƱ��+1*/
	set CountNumber=CountNumber+1
	where OptionID=@option
	
	update Subject
	set SumNumber=SumNumber+1
	where SubjectID=@subject
	return
end
GO
----------------------------------------------------��������ͶƱ��Ĵ洢����-------------------------
create procedure pd_AddBallot
(
	@Name varchar(50),
	@Id int
)
/*����ͶƱ��*/
as
begin
	insert into Ballot(SubjectID,OptionName)
	values(@Id,@Name)
	return
end
GO

----------------------------------------------------����ɾ��ͶƱ�Ĵ洢����-------------------------
create procedure pd_DelSubject
(
	@id int
)
/*����ͶƱID��ɾ��ͶƱ*/
as
begin
	delete from Ballot
	where SubjectId=@id
	
	delete from Subject
	where SubjectId=@id
	return
end
go
----------------------------------------------------�û�����ģ��------------------------

----------------------------------------------------��������û���Ϣ�Ĵ洢����-------------------------
create procedure pd_GetUserInfo
(
	@name char(10)
)
/*ͨ���û�������û���Ϣ*/
as
begin
	select * from UserInfo where userName=@name
end
GO

----------------------------------------------------���������û���Ϣ�Ĵ洢����-------------------------
create procedure pd_UpdateUser
(
	@name char(10),
	@nick char(10),
	@pass char(10),
	@email varchar(50),
	@mark varchar(500)
)
/*�����û���Ϣ*/
as
begin
	update UserInfo set userNick=@nick,userPass=@pass,userEmail=@email,userMark=@mark
	where userName=@name
if @@rowcount<1
	return 0
else
	return 1
end
GO
----------------------------------------------------��������û���������Ĵ洢����-------------------------
create procedure pd_GetUserTitle
(	
	@name char(10),
	@group char(10)
)
/*����û������������*/
as
begin
	select noteTitle,contTime,userNick,noteId
	from TitleList
	where noteGroup=@group and userName=@name
if @@rowcount<1
	return 0
else
	return 1
end
GO

----------------------------------------------------��������û��ظ�����Ĵ洢����-------------------------
create procedure pd_GetUserRes
(
	@name char(10)
)
/*����û�������*/
as
begin
	select noteContent,noteTime
	from NoteContent
	where userName=@name
	return
end
GO