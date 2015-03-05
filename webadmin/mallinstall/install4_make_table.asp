<%

Set db = new database
''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_main]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wiztable_main]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_main]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "create table " & Db_Owner & "wiztable_main (" & vbcrlf
strSQL = strSQL & "	bid [nvarchar] (30) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	gid [nvarchar] (30) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	adminid [nvarchar] (30) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	adminpwd [nvarchar] (30) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	adminname [nvarchar] (30) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	adminmail [nvarchar] (100) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	adminhome [nvarchar] (100) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "	datesigndate smalldatetime null " & vbcrlf
strSQL = strSQL & ") on [PRIMARY]" & vbcrlf
strSQL = strSQL & "" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_category]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wiztable_category]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_category]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = "if not exists (select * from dbo.sysobjects where name = 'wiztable_category') " & vbcrlf 
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wiztable_category](" & vbcrlf 
strSQL = strSQL & "[bid] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf 
strSQL = strSQL & "[gid] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf 
strSQL = strSQL & "[intcategorynum] [tinyint] NOT NULL   DEFAULT ((0))," & vbcrlf 
strSQL = strSQL & "[intcategorycount] [smallint] NOT NULL   DEFAULT ((0))," & vbcrlf 
strSQL = strSQL & "[categoryname] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NOT NULL DEFAULT ('전체')," & vbcrlf 
strSQL = strSQL & "CONSTRAINT [pk_wiztable_category] PRIMARY KEY CLUSTERED " & vbcrlf 
strSQL = strSQL & "(" & vbcrlf 
strSQL = strSQL & "[bid] ASC," & vbcrlf 
strSQL = strSQL & "[gid] ASC," & vbcrlf 
strSQL = strSQL & "[intcategorynum] ASC" & vbcrlf 
strSQL = strSQL & ") "& vbcrlf
 ''WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
strSQL = strSQL & ") ON [PRIMARY]" & vbcrlf 
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_group_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wiztable_group_config]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_group_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wiztable_group_config](" & vbcrlf
strSQL = strSQL & "[intnum] [smallint] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "[gid] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf ''그룹아이디
strSQL = strSQL & "[gname] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf ''그룹명
strSQL = strSQL & "[setopengroup] [bit] NULL CONSTRAINT [df_wiztable_group_config_setopengroup]  DEFAULT ((1))," & vbcrlf
strSQL = strSQL & "[setgroupheadfile] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setgroupheadmsg] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setgroupfootfile] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setgroupfootmsg] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[dateregdate] [smalldatetime] NOT NULL CONSTRAINT [df_wiztable_group_config_dateregdate]  DEFAULT (getdate())," & vbcrlf
strSQL = strSQL & "CONSTRAINT [pk_wiztable_group_config] PRIMARY KEY CLUSTERED " & vbcrlf
strSQL = strSQL & "(" & vbcrlf
strSQL = strSQL & "[gid] ASC" & vbcrlf
strSQL = strSQL & ") " & vbcrlf
''WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
strSQL = strSQL & ") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


Function InsertGroup()
	strSQL = "select count(*) from " & Db_Owner & "[wiztable_group_config] where gid = 'root'"
	objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	If objRs(0) = 0 Then 
		strSQL = "insert into " & Db_Owner & "[wiztable_group_config]  " & vbcrlf
		strSQL = strSQL & " ([gid],[setopengroup],[dateregdate]) " & vbcrlf
		strSQL = strSQL & " values"
		strSQL = strSQL & "('root', 0, getdate())"
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
	End if
End Function

Call InsertGroup()

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_board_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wiztable_board_config]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wiztable_board_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wiztable_board_config](" & vbcrlf
strSQL = strSQL & "[intnum] [smallint] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "[setorder] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "[bid] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[gid] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[settitle] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setskin] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[sethtmleditor] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_sethtmleditor]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[setheadfile] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setheadmsg] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setfootfile] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setfootmsg] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setsubjectcut] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setsubjectcut]  DEFAULT ((10))," & vbcrlf
strSQL = strSQL & "[setpagesize] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setpagesize]  DEFAULT ((10))," & vbcrlf
strSQL = strSQL & "[setpagelink] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setpagelink]  DEFAULT ((10))," & vbcrlf
strSQL = strSQL & "[setadminonly] [bit] NOT NULL," & vbcrlf
strSQL = strSQL & "[setboardwidth] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setboardwidthstep] [nvarchar](2) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setboardalign] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setmemberonly] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setmemberonly]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[memberonly_mode] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[setrepleenable] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setrepleenable]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[setcategoryenable] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setcategoryenable]  DEFAULT ((0))," & vbcrlf''카테고리 사용여부(0, 1)
strSQL = strSQL & "[setlistinview] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "[setlistorder] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[setmallinclude] [smallint] NULL," & vbcrlf
strSQL = strSQL & "[setfileenable] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "[setfilenum] [smallint] NOT NULL CONSTRAINT [DF_wiztable_board_config_setfilenum]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[setsecurityflag] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "CONSTRAINT [pk_wiztable_board_config] PRIMARY KEY CLUSTERED " & vbcrlf
strSQL = strSQL & "(" & vbcrlf
strSQL = strSQL & "[bid] ASC," & vbcrlf
strSQL = strSQL & "[gid] ASC" & vbcrlf
strSQL = strSQL & ") " & vbcrlf
''WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
strSQL = strSQL & ") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf

Call db.ExecSQL(strSQL, Nothing, DbConnect)


Set board	= new boards
Call board.MakeInitFile("board01", "root", "고객게시판", "default",True)
Call board.MakeInitFile("board02", "root", "공지사항", "default_notice",True)
Call board.MakeInitFile("board03", "root", "자주하는 질문", "default",True)
Call board.MakeInitFile("board04", "root", "커뮤니티", "default",True)
Set baord = Nothing

Set db = new Database
''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizTable_multi_tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & "drop table " & Db_Owner & "[wizTable_multi_tmp]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizTable_multi_tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizTable_multi_tmp] (" & vbcrlf
strSQL = strSQL & "[thistime] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL , " & vbcrlf
strSQL = strSQL & "[filename] [nvarchar] (250) COLLATE Korean_Wansung_CI_AS NULL  " & vbcrlf
strSQL = strSQL & ") ON [PRIMARY] " & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizfiletable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizfiletable]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizfiletable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizfiletable] ( " & vbcrlf
strSQL = strSQL & "[fid] [int] IDENTITY (1, 1) NOT NULL , " & vbcrlf
strSQL = strSQL & "[tid] [int] NULL ," & vbcrlf
strSQL = strSQL & "[filename1] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL , " & vbcrlf
strSQL = strSQL & "[filename2] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NULL , " & vbcrlf
strSQL = strSQL & "[flag1] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL , " & vbcrlf
strSQL = strSQL & "[flag2] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,  " & vbcrlf
strSQL = strSQL & "[wdate] [smalldatetime] NULL   " & vbcrlf
strSQL = strSQL & ") ON [PRIMARY] " & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)
db.Dispose : Set db=Nothing
%>
