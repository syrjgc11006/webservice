USE MYBBS_DB
GO
----------------------------------------------------登录验证模块-------------------------

----------------------------------------------------创建登录存储过程-------------------------

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
----------------------------------------------------创建检验合法用户存储过程-------------------------
CREATE PROCEDURE pd_ChceckUser
(
	@Name char(10)
)
as

begin
	select userName from UserInfo where userName=@Name
	if @@Rowcount<1--返回的受影响的行数，如果无影响行数则返回0，否则返回1--
	return 0
else 
	return 1 
end
Go
----------------------------------------------------创建注册用户存储过程-------------------------
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





----------------------------------------------------发表主题模块-------------------------


----------------------------------------------------创建通过组号获得当天发表新主题存储过程-------------------------
create procedure pd_GetNewList
(
	@group char(10)
)
/*获得当天发表的新主题,注意该表中并没有保存主题的内容*/
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
--exec pd_GetNewList '站务通知'

----------------------------------------------------创建通过主题id获取主题内容的存储过程-------------------------
create procedure pd_GetTitle
(
	@id int
)
as
begin
	/*获得主题内容，无输出参数，也没有特定的返回值，返回的是一张表*/
	select userNick,noteTitle,contTime,noteContent,userName
	from TitleList
	where noteId=@id
	return
end
GO

----------------------------------------------------创建获取特定组的主题帖的存储过程-------------------------
create procedure pd_sortList
(
	@group char(10)
)
as
/*获得特定组的主题帖*/
begin
	select noteTitle,userNick,contTime,noteId
	from TitleList
	where noteGroup=@group
	order by contTime
end
go
----------------------------------------------------创建发表新主题的存储过程-------------------------
create procedure pd_appearNote
(
	@nick char(10),
	@name char(10),
	@title text,
	@time datetime,
	@group char(10),
	@content text
)
/*发表新主题*/
as
begin
	insert into TitleList values(@nick,@title,@time,@group,@content,@name)
	if @@rowcount<1
	return 0
	else
	return 1
end
GO

----------------------------------------------------创建增加经验值的存储过程-------------------------
create procedure pd_GetExp
(
	@name char(10),
	@exp int
)
/*获得用户经验值*/
as
begin
	update UserInfo
	set userLevel=@exp where userName=@name
	return
end
go
----------------------------------------------------创建修改主题内容的存储过程-------------------------
create procedure pd_alterNode
(
	@id int,
	@title text,
	@content text
)
as
begin
/*修改主题*/
	update TitleList
	set noteTitle=@title,noteContent=@content
	where noteId=@id
if @@rowcount<1
	return 0
else 
	return 1 
end
GO
----------------------------------------------------创建删除主题（帖子）内容的存储过程-------------------------
create procedure pd_DelNote
(
	@id int
)
/*根据帖子的留言删除该主题*/
as
begin
	delete from titleList where noteId=@id
	return
end
go
----------------------------------------------------创建删除主题（帖子）回复的存储过程-------------------------
create procedure pd_DelRes
(
	@id int
)
/*删除该主题的所有回复信息*/
as
begin
	delete from NoteContent where noteId=@id
	return
end
GO
----------------------------------------------------创建回复主题内容的存储过程-------------------------
create procedure pd_ResNote
(
	@id int,
	@Content text,
	@userNick char(10),
	@noteTime datetime,
	@name char(10)
)
/*回复主题*/
as
begin
	insert into NoteContent values(@id,@Content,@userNick,@noteTime,@name)
	if @@rowcount<1
	return 0
	else
	return 1
end
GO

----------------------------------------------------获得回复主题信息-------------------------
create procedure pd_GetContent
(
	@id int
)
/*使用id获得相应主题回复*/
as
begin
	select noteContent,userNick,noteTime
	from NoteContent
	where noteId=@id
	return
end
GO

----------------------------------------------------更改时间信息-------------------------
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
----------------------------------------------------投票模块-------------------------

go
----------------------------------------------------创建检查投票主题是否存在的存储过程-------------------------
create procedure pd_checkSubject
(
	@subject varchar(50)
)
/*检查项目是否存在*/
as
begin
	select count(*)
	from Subject
	where SubjectName=@Subject
	return
end
GO
----------------------------------------------------创建新增投票主题的存储过程-------------------------
create procedure pd_addSubject
(
	@subject varchar(50)
)
/*增加投票项目*/
as
begin
	insert into Subject(SubjectName)
	values(@subject)
	return
end
go
----------------------------------------------------创建根据投票主题名，获得该投票的ID的存储过程-------------------------
create procedure pd_GetSubjectId
(
	@subject varchar(50)
)
/*获得投票项目的ID*/
as
begin
	select SubjectId
	from Subject
	where SubjectName=@subject
	return
end
GO
----------------------------------------------------创建显示当前存在的所有投票主题的存储过程-------------------------
create procedure pd_ShowSubject
/*显示所有投票内容*/
as
begin
	select *
	from Subject
	return
end
GO

----------------------------------------------------创建获得投票结果的存储过程-------------------------
create procedure pd_GetSubject
(
	@id int
)
/*获得项目名*/
as
begin
	select OptionName,CountNumber,OptionID
	from Ballot
	where SubjectID=@id
	return
end
GO

----------------------------------------------------创建更新投票结果的存储过程-------------------------
create procedure pd_UpdateBallot
(
	@option int,
	@subject int
)
/*更新投票项目*/
as
begin
	update Ballot
/*指定项目票数+1*/
	set CountNumber=CountNumber+1
	where OptionID=@option
	
	update Subject
	set SumNumber=SumNumber+1
	where SubjectID=@subject
	return
end
GO
----------------------------------------------------创建增加投票项的存储过程-------------------------
create procedure pd_AddBallot
(
	@Name varchar(50),
	@Id int
)
/*增加投票项*/
as
begin
	insert into Ballot(SubjectID,OptionName)
	values(@Id,@Name)
	return
end
GO

----------------------------------------------------创建删除投票的存储过程-------------------------
create procedure pd_DelSubject
(
	@id int
)
/*根据投票ID号删除投票*/
as
begin
	delete from Ballot
	where SubjectId=@id
	
	delete from Subject
	where SubjectId=@id
	return
end
go
----------------------------------------------------用户管理模块------------------------

----------------------------------------------------创建获得用户信息的存储过程-------------------------
create procedure pd_GetUserInfo
(
	@name char(10)
)
/*通过用户名获得用户信息*/
as
begin
	select * from UserInfo where userName=@name
end
GO

----------------------------------------------------创建更新用户信息的存储过程-------------------------
create procedure pd_UpdateUser
(
	@name char(10),
	@nick char(10),
	@pass char(10),
	@email varchar(50),
	@mark varchar(500)
)
/*更新用户信息*/
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
----------------------------------------------------创建获得用户发表主题的存储过程-------------------------
create procedure pd_GetUserTitle
(	
	@name char(10),
	@group char(10)
)
/*获得用户所发表的主题*/
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

----------------------------------------------------创建获得用户回复主题的存储过程-------------------------
create procedure pd_GetUserRes
(
	@name char(10)
)
/*获得用户的留言*/
as
begin
	select noteContent,noteTime
	from NoteContent
	where userName=@name
	return
end
GO