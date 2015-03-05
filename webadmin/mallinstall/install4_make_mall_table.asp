<%
''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcategory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizcategory]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

''Response.Write("Db_Owner:"&Db_Owner)
Set db = new database
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcategory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "	CREATE TABLE " & Db_Owner & "[wizcategory] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[cat_order] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[cat_flag] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_no] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_name] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_skin] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_skin_viewer] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_top] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_price] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_bottom] [ntext] COLLATE Korean_Wansung_CI_AS NULL, " & vbcrlf
strSQL = strSQL & "	[cat_disable] [int] NULL ," & vbcrlf''1이면 카테고리 숨김
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizmall]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

Set db = new database
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "	CREATE TABLE " & Db_Owner & "[wizmall] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pid] [int] NULL ," & vbcrlf''다중카테고리 등록시 부모 uid 아이디
strSQL = strSQL & "	[userorder] [int] NULL ," & vbcrlf''사용자정의정렬시
strSQL = strSQL & "	[pname] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[brand] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[compname] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf''제조사
strSQL = strSQL & "	[price] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[price1] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[wongaprice] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[point] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[deliveryfee] [int] NULL ," & vbcrlf''제품당 택배비
strSQL = strSQL & "	[unit] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[model] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[porigin] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
''원산지
strSQL = strSQL & "	[psize] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[color] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[option1] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[option2] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[option3] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[option4] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[option5] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[picture] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[pnone] [int] NULL ," & vbcrlf
''0 : 정상판매,  1 : 일시품절, 2:생산중단
strSQL = strSQL & "	[pdisplay] [int] NULL ," & vbcrlf
''0 : 디스플레이,  1 : 숨김
strSQL = strSQL & "	[pinput] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[poutput] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[stock] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[stockouttype] [int] NULL ," & vbcrlf
''0 : 처리하지않음,  1 : 재고갯수수동처리, 2 : 재고갯수자동처리
strSQL = strSQL & "	[wdate] [datetime] NULL ," & vbcrlf
strSQL = strSQL & "	[description1] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[description2] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[description3] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[category] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cat_flag] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL CONSTRAINT [DF_wizmall_cat_flag]  DEFAULT ('wizmall')," & vbcrlf
strSQL = strSQL & "	[texttype] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf ''제품설명|제품간략설명|배송정보 html:1 , text : 0
strSQL = strSQL & "	[hit] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[getcomp] [int] NULL " & vbcrlf''공급사
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmall_comment]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "	CREATE TABLE " & Db_Owner & "[wizmall_comment](" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[pid] [int] NOT NULL," & vbcrlf''wizmall.uid
strSQL = strSQL & "	[c_id] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[c_name] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[c_pwd] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[c_email] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[c_grade] [int] NULL," & vbcrlf
strSQL = strSQL & "	[c_subject] [varchar](250) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[c_comment] [text] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[c_option] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf ''textmode|
strSQL = strSQL & "	[c_ip] [varchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[c_wdate] [datetime] NOT NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizMalloption]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "	CREATE TABLE  " & Db_Owner & "[wizMalloption](" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[ouid] [int] NULL," & vbcrlf
strSQL = strSQL & "	[oname] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[oprice] [int] NULL," & vbcrlf
strSQL = strSQL & "	[oqty] [int] NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizMalloptioncfg]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "	CREATE TABLE  " & Db_Owner & "[wizMalloptioncfg](" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[opid] [int] NULL," & vbcrlf
strSQL = strSQL & "	[oname] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[oorder] [int] NULL," & vbcrlf
strSQL = strSQL & "	[oflag] [int] NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmembers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizmembers]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmembers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizmembers] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[mid] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[mpwd] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[mname] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[mregdate] [smalldatetime] NULL ," & vbcrlf
strSQL = strSQL & "	[mgrantsta] [nvarchar] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[mpoint] [int] NOT NULL, " & vbcrlf
strSQL = strSQL & "	[mgrade] [nchar] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[mloginnum] [int] NULL CONSTRAINT [DF_wizmembers_mloginnum]  DEFAULT ((0)), " & vbcrlf
strSQL = strSQL & "	[mlogindate] [smalldatetime] NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = " CREATE  CLUSTERED  INDEX [IX_wizmembers] ON " & Db_Owner & "[wizmembers]([uid]) ON [PRIMARY]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmembers_ind]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizmembers_ind]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmembers_ind]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizmembers_ind] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[mid] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[nickname] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[jumin1] [nvarchar] (6) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[jumin2] [nvarchar] (7) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[tel1] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[tel2] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[tel3] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[zip1] [nvarchar] (7) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[address1] [nvarchar] (90) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[address2] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[email] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[emailenable] [smallint] NULL ," & vbcrlf ''1:수신, 0비수신
strSQL = strSQL & "	[url] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[age] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[birthdate] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[birthtype] [nvarchar] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf''1:음력, 2:양력
strSQL = strSQL & "	[gender] [smallint] NULL ," & vbcrlf''1:남성, 2:여성
strSQL = strSQL & "	[companynum] [nvarchar] (12) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[companyname] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[president] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[czip] [nvarchar] (7) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[caddress1] [nvarchar] (80) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[caddress2] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[contents] [ntext] COLLATE Korean_Wansung_CI_AS NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[zipcode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[zipcode]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[zipcode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[zipcode] (" & vbcrlf
strSQL = strSQL & "	[zipcode] [nvarchar] (7) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[sido] [nvarchar] (10) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[gugun] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[dong] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[bunji] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[visit_counter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[visit_counter]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[visit_counter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[visit_counter] (" & vbcrlf
strSQL = strSQL & "	[vNum] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vIP] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vYY] [smallint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vMM] [tinyint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vDD] [tinyint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vHH] [tinyint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vMT] [tinyint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vSeason] [tinyint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vDW] [tinyint] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vBrowser] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vOS] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vReferer] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[vTarget] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizinquire]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizinquire]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizinquire]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizinquire] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[iid] [nvarchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[compname] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf''
strSQL = strSQL & "	[name] [nvarchar] (100) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[juminno] [nvarchar] (15) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[tel] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[hand] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[fax] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[email] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[url] [nvarchar] (100) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[zip] [nvarchar] (7) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[address1] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[address2] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[subject] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[contents] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[contents1] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[contents2] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[option1] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[option2] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[option3] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[attached] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[wdate] [smalldatetime] NOT NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[sendmail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[sendmail]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[sendmail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[sendmail] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[subject] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[content] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[flag] [nvarchar] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[total] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[wdate] [smalldatetime] NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizsendmaillist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizsendmaillist] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[sendername] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[senderemail] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[tomember] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[reply] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[subject] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[contenttype] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "	[mailskin] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[body_txt] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[userfile] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[addsource] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "	[soption] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[mailreject] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "	[startseq] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "	[stopseq] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "	[genderselect] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "	[gradeselect] [smallint] NOT NULL," & vbcrlf
strSQL = strSQL & "	[testmailaddress] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[usermaillist] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[sdate] [smalldatetime] NOT NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[sendmailcount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[sendmailcount]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect))

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[sendmailcount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[sendmailcount] (" & vbcrlf
strSQL = strSQL & "	[mid] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[email] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[flag] [nvarchar] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[wdate] [smalldatetime] NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizDiary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizDiary]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizDiary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizDiary] (" & vbcrlf
strSQL = strSQL & "	[cc_id] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[cc_m_id] [nvarchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[cc_m_name] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_Title] [nvarchar] (80) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_Position] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_Kind] [nvarchar] (10) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_Open] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_sDate] [smalldatetime] NULL ," & vbcrlf
strSQL = strSQL & "	[cc_sHour] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_sMin] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_eHour] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_eMin] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_Desc] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_Reid] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_ReType] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_eDate] [datetime] NULL ," & vbcrlf
strSQL = strSQL & "	[cc_dType] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[cc_count] [int] NOT NULL CONSTRAINT [DF_wizDiary_cc_count]  DEFAULT (0), " & vbcrlf
strSQL = strSQL & " CONSTRAINT [PK_Diary] PRIMARY KEY CLUSTERED " & vbcrlf
strSQL = strSQL & "(" & vbcrlf
strSQL = strSQL & "	[cc_id] ASC" & vbcrlf
strSQL = strSQL & ")" & vbcrlf
''WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
strSQL = strSQL & ") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
strSQL = strSQL & "" & vbcrlf

Call db.ExecSQL(strSQL, Nothing, DbConnect)


''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizbuyer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizbuyer]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizbuyer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizbuyer] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[sname] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[sid] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[sjumin1] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[sjumin2] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[semail] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[stel1] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[stel2] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[szip] [nvarchar] (7) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[saddress1] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[saddress2] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rname] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[remail] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rtel1] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rtel2] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rzip] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[raddress1] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[raddress2] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[paytype] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[paymoney] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[totalmoney] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[bankinfo] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[inputer] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[codevalue] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[processing] [int] NULL CONSTRAINT [DF_wizbuyer_processing]  DEFAULT (0)," & vbcrlf
strSQL = strSQL & "	[deliverer] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[invoiceno] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[content] [ntext] COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rdate] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[wdate] [datetime] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pay_date] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	CONSTRAINT [PK_wizbuyer] PRIMARY KEY CLUSTERED " & vbcrl 
strSQL = strSQL & "	( " & vbcrl
strSQL = strSQL & "	[codevalue] ASC " & vbcrl
strSQL = strSQL & "	) " & vbcrl
''WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)



''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizbuyproduct]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizbuyproduct]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizbuyproduct]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizbuyproduct] (" & vbcrlf
strSQL = strSQL & "	[codevalue] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[pcode] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[ccode] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[pqty] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[pprice] [int] NULL ," & vbcrlf
strSQL = strSQL & "	[buydate] [datetime] NULL ," & vbcrlf
strSQL = strSQL & "	[rname] [nvarchar] (100) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[remail] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[sname] [nvarchar] (100) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[saddress1] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[saddress2] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rtel1] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[rtel2] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcart]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizcart]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcart]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizcart](" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[oid] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf''주문번호
strSQL = strSQL & "	[pid] [int] NOT NULL," & vbcrlf''wizmall.uid
strSQL = strSQL & "	[user_id] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[qty] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "	[price] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "	[tprice] [int] NULL," & vbcrlf''총합 : price(옵션가격포함) *qty
strSQL = strSQL & "	[point] [int] NULL," & vbcrlf
strSQL = strSQL & "	[optionflag] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[ostatus] [int] NULL," & vbcrlf''현재 주문단계 , 0, 10, 20..
strSQL = strSQL & "	[deliverer] [int] NULL," & vbcrlf''택배사
strSQL = strSQL & "	[invoiceno] [varbinary](30) NULL," & vbcrlf''택배번호
strSQL = strSQL & "	[wdate] [datetime] NOT NULL" & vbcrlf''주문일
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizpoll]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizpoll]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizpoll]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizpoll] (" & vbcrlf
strSQL = strSQL & "	[p_idx_no] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[flag] [int] NULL CONSTRAINT [DF_wizpoll_flag]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "	[p_que] [nvarchar] (500) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans_qty] [int] NULL CONSTRAINT [DF_wizpoll_p_ans_qty]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "	[p_ans1] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans2] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans3] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans4] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans5] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans6] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans7] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans8] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans9] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_ans10] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "	[p_regdate] [datetime] NULL CONSTRAINT [DF_wizpoll_p_regdate]  DEFAULT (getdate())," & vbcrlf
strSQL = strSQL & "	[p_count] [int] NULL CONSTRAINT [DF_wizpoll_p_visit]  DEFAULT ((0))" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)



''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizpopup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizpopup]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizpopup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizpopup] (" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pskinname] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pwidth] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pheight] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[ptop] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pleft] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[psubject] [nvarchar] (250) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[click_url] [nvarchar] (255) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pcontents] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[pattached] [nvarchar] (100) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[imgposition] [nvarchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "	[popupenable] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "	[options] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL " & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] " & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizpoint]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[wizpoint]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)
strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizpoint]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizpoint](" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[id] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[ptype] [int] NOT NULL," & vbcrlf
'' 포인트 내용(ptype)
'' member :1: 회원가입 ,2: 로그인포인트, 3: 회원추천->contents:추천인아이디
'' board : 11:글등록->contents(bid:gid:uid)
'' admin : 21:물품구매->contents(wizCart.uid)
'' event : 기타코드-> 기타코드

strSQL = strSQL & "	[content] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[point] [int] NULL," & vbcrlf
strSQL = strSQL & "	[flag] [int] NULL," & vbcrlf
strSQL = strSQL & "	[wdate] [datetime] NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizordermail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizordermail](" & vbcrlf
strSQL = strSQL & "	[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[flag] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[delivery_status] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[message] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[subject] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[skin] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "	[enable] [int] NOT NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmailaddressbook]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizmailaddressbook](" & vbcrlf
strSQL = strSQL & "	[idx] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[userid] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[name] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[grp] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[email] [nvarchar](40) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[company] [nvarchar](40) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[buseo] [nvarchar](40) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[work] [nvarchar](40) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[hphone] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[cphone] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[hand] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[fax] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[post] [nvarchar](7) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[addr1] [nvarchar](80) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[addr2] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[memo] [text] COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[wdate] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[shard] [nvarchar](1) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[phone] [nvarchar](1) COLLATE Korean_Wansung_CI_AS NOT NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmailaddressbook_g]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizmailaddressbook_g](" & vbcrlf
strSQL = strSQL & "	[idx] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "	[userid] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[code] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "	[subject] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL" & vbcrlf
strSQL = strSQL & "	) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizbanner]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizbanner](" & vbcrlf
strSQL = strSQL & " [uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & " [flag1] [nvarchar](10) NULL," & vbcrlf
strSQL = strSQL & " [ordernum] [int] NULL," & vbcrlf
strSQL = strSQL & " [subject] [nvarchar](255) NULL," & vbcrlf
strSQL = strSQL & " [url] [nvarchar](100) NULL," & vbcrlf
strSQL = strSQL & " [target] [nvarchar](20) NULL," & vbcrlf
strSQL = strSQL & " [attached] [nvarchar](100) NULL," & vbcrlf
strSQL = strSQL & " [showflag] [int] NULL," & vbcrlf
strSQL = strSQL & " [wdate] [datetime] NULL" & vbcrlf
strSQL = strSQL & " ) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (1, 1, '/', '_self', 'logo.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (2, 1, '/', '_self', 'logo_bottom.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (3, 1, '/', '_self', 'mainimg.jpg')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (4, 1, '/', '_self', 'mainbanner1.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (4, 2, '/', '_self', 'mainbanner2.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (4, 3, '/', '_self', 'mainbanner3.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (5, 1, '/', '_self', 'leffbanner1.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (5, 2, '/', '_self', 'leffbanner2.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (5, 3, '/', '_self', 'leffbanner3.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (5, 4, '/', '_self', 'leffbanner4.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values (5, 5, '/', '_self', 'leffbanner_blank.gif')"
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcom]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizcom](" & vbcrlf
strSQL = strSQL & " [uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & " [compsort] [int] NULL," & vbcrlf
strSQL = strSQL & " [compid] [nvarchar](15) NULL," & vbcrlf
strSQL = strSQL & " [comppass] [nvarchar](15) NULL," & vbcrlf
strSQL = strSQL & " [comppersonalid] [nvarchar](15) NULL," & vbcrlf
strSQL = strSQL & " [compname] [nvarchar](100) NULL," & vbcrlf
strSQL = strSQL & " [compnum] [nvarchar](15) NULL," & vbcrlf
strSQL = strSQL & " [compsortnum] [nvarchar](15) NULL," & vbcrlf
strSQL = strSQL & " [compkind] [nvarchar](50) NULL," & vbcrlf
strSQL = strSQL & " [comptype] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compmain] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compfoundday] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compemployeenum] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compzip1] [nvarchar](7) NULL," & vbcrlf
strSQL = strSQL & " [compaddress1] [nvarchar](100) NULL," & vbcrlf
strSQL = strSQL & " [compaddress2] [nvarchar](100) NULL," & vbcrlf
strSQL = strSQL & " [comptel] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compfax] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compprename] [nvarchar](15) NULL," & vbcrlf
strSQL = strSQL & " [compprenum1] [int] NULL," & vbcrlf
strSQL = strSQL & " [compprenum2] [int] NULL," & vbcrlf
strSQL = strSQL & " [comppretel] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compurl] [nvarchar](50) NULL," & vbcrlf
strSQL = strSQL & " [compemail] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchaname] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchatel] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchaemail] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchadep] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchalevel] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchabirthday] [nvarchar](30) NULL," & vbcrlf
strSQL = strSQL & " [compchabirthtype] [nvarchar](2) NULL," & vbcrlf
strSQL = strSQL & " [compchabirthgender] [nvarchar](2) NULL," & vbcrlf
strSQL = strSQL & " [compcontents] [ntext] NULL" & vbcrlf
strSQL = strSQL & " ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcoupon]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizcoupon](" & vbcrlf
strSQL = strSQL & " [uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & " [cname] [nvarchar](50) NULL," & vbcrlf
strSQL = strSQL & " [cdesc] [nvarchar](50) NULL," & vbcrlf
strSQL = strSQL & " [cpubtype] [int] NULL," & vbcrlf
strSQL = strSQL & " [cpubdowncnt] [int] NULL," & vbcrlf
strSQL = strSQL & " [cpubapplyall] [int] NULL," & vbcrlf
strSQL = strSQL & " [cpubapplycontinue] [int] NULL," & vbcrlf
strSQL = strSQL & " [edncnt] [int] NULL," & vbcrlf
strSQL = strSQL & " [ctype] [int] NULL," & vbcrlf
strSQL = strSQL & " [csaleprice] [int] NULL," & vbcrlf
strSQL = strSQL & " [csaletype] [nvarchar](5) NULL," & vbcrlf
strSQL = strSQL & " [capplytype] [int] NULL," & vbcrlf
strSQL = strSQL & " [capplycategory] [int] NULL," & vbcrlf
strSQL = strSQL & " [capplyproduct] [int] NULL," & vbcrlf
strSQL = strSQL & " [cimg] [int] NULL," & vbcrlf
strSQL = strSQL & " [ctermtype] [int] NULL," & vbcrlf
strSQL = strSQL & " [cterm] [int] NULL," & vbcrlf
strSQL = strSQL & " [ctermf] [datetime] NOT NULL," & vbcrlf
strSQL = strSQL & " [cterme] [datetime] NOT NULL," & vbcrlf
strSQL = strSQL & " [crestric] [int] NULL," & vbcrlf
strSQL = strSQL & " [wdate] [datetime] NOT NULL," & vbcrlf
strSQL = strSQL & " ) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizcouponapply]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE " & Db_Owner & "[wizcouponapply](" & vbcrlf
strSQL = strSQL & " [uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & " [couponid] [int] NULL," & vbcrlf
strSQL = strSQL & " [category] [int] NULL," & vbcrlf
strSQL = strSQL & " [pid] [int] NULL" & vbcrlf
strSQL = strSQL & " ) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmall_product_qna]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE [dbo].[wizmall_product_qna](" & vbcrlf
strSQL = strSQL & "[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "[pid] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "[bd_idx_num] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "[bd_num] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "[bd_step] [tinyint] NOT NULL CONSTRAINT [DF_wizmall_product_qna_bd_step]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[bd_level] [tinyint] NOT NULL CONSTRAINT [DF_wizmall_product_qna_bd_level]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[id] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[name] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[pass] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[subject] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[content] [ntext] COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[op_flag] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[count] [smallint] NOT NULL CONSTRAINT [DF_wizmall_product_qna_count]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[reccount] [smallint] NULL CONSTRAINT [DF_wizmall_product_qna_reccount]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[replecount] [smallint] NULL CONSTRAINT [DF_wizmall_product_qna_replecount]  DEFAULT ((0))," & vbcrlf
strSQL = strSQL & "[filename] [nvarchar](250) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[ip] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[moddate] [smalldatetime] NULL CONSTRAINT [DF_wizmall_product_qna_moddate]  DEFAULT (getdate())," & vbcrlf
strSQL = strSQL & "[regdate] [smalldatetime] NOT NULL," & vbcrlf
strSQL = strSQL & " ) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "if not exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[wizmall_product_qna_reply]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
strSQL = strSQL & "CREATE TABLE [dbo].[wizmall_product_qna_reply](" & vbcrlf
strSQL = strSQL & "[uid] [int] IDENTITY(1,1) NOT NULL," & vbcrlf
strSQL = strSQL & "[b_uid] [int] NOT NULL," & vbcrlf
strSQL = strSQL & "[id] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[name] [nvarchar](30) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[email] [nvarchar](64) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[pass] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[subject] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[content] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[filename] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL," & vbcrlf
strSQL = strSQL & "[ip] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL," & vbcrlf
strSQL = strSQL & "[regdate] [smalldatetime] NOT NULL CONSTRAINT [DF_wizmall_product_qna_reply_regdate]  DEFAULT (getdate())," & vbcrlf
strSQL = strSQL & " ) ON [PRIMARY]" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


db.Dispose : Set db=Nothing
%>