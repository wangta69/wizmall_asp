<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->

<%
' powered by 숍위즈
'Reference URL : http://www.shop-wiz.com
'Contact Email : master@shop-wiz.com
'Free Distributer : 
'Copyright shop-wiz.com
'*** Updating List ***

''CREATE TABLE [dbo].[wizmall_product_qna](
''	[uid] [int] IDENTITY(1,1) NOT NULL,
''	[pid] [int] NOT NULL,
''	[bd_idx_num] [int] NOT NULL,
''	[bd_num] [int] NOT NULL,
''	[bd_step] [tinyint] NOT NULL CONSTRAINT [DF_wizmall_product_qna_bd_step]  DEFAULT ((0)),
''	[bd_level] [tinyint] NOT NULL CONSTRAINT [DF_wizmall_product_qna_bd_level]  DEFAULT ((0)),
''	[id] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL,
''	[name] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL,
''	[pass] [nvarchar](20) COLLATE Korean_Wansung_CI_AS NULL,
''	[subject] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL,
''	[content] [ntext] COLLATE Korean_Wansung_CI_AS NULL,
''	[op_flag] [nvarchar](10) COLLATE Korean_Wansung_CI_AS NULL,
''	[count] [smallint] NOT NULL CONSTRAINT [DF_wizmall_product_qna_count]  DEFAULT ((0)),
''	[reccount] [smallint] NULL CONSTRAINT [DF_wizmall_product_qna_reccount]  DEFAULT ((0)),
''	[replecount] [smallint] NULL CONSTRAINT [DF_wizmall_product_qna_replecount]  DEFAULT ((0)),
''	[filename] [nvarchar](250) COLLATE Korean_Wansung_CI_AS NULL,
''	[ip] [nvarchar](15) COLLATE Korean_Wansung_CI_AS NOT NULL,
''	[moddate] [smalldatetime] NULL CONSTRAINT [DF_wizmall_product_qna_moddate]  DEFAULT (getdate()),
''	[regdate] [smalldatetime] NOT NULL,



Dim attached_file(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim UPLOAD, attached_count, old_filename

Dim qry,adminmode,page,uid,search_category,search_word,redirection,userid
Dim option_html, option_secret, option_notice
Dim pid, bd_idx_num, bd_num, bd_step, bd_level, id, name, pass, subject, content, op_flag, count 

Dim upload_name, upload_subject, upload_pass, upload_content

Dim reccount, replecount, filename, moddate, regdate, spamfree

Dim thistime, attached, file_del, UploadedFileName, op_flag_value, smode

Dim db,util, objRs
Set util = new utility	
Set db = new database



Dim table_name : table_name = "wizmall_product_qna"
Dim ip : ip	= Request.Servervariables("REMOTE_ADDR")
Dim DefaultPath : DefaultPath = PATH_SYSTEM & "config\shop\"

	CALL util.folderMaker(DefaultPath)
	attached_count = util.SetUploadComponent
	

	qry							= UPLOAD("qry")
	
	page						= UPLOAD("page")
	uid							= UPLOAD("uid")
	userid						= UPLOAD("userid")
	spamfree					= UPLOAD("spamfree")

	''if spamfree = "" then Call util.js_alert("","")
	''if qry <> "edit" And spamfree + 5 > util.Linuxtime() then Call util.js_alert("","")
	if userid  = "" then userid = user_id

	pid							= UPLOAD("pid")
	upload_name 				= UPLOAD("name")
	name						= util.getReplaceInput(upload_name, "ns")
	
	upload_subject 				= UPLOAD("subject")
	subject						= util.getReplaceInput(upload_subject, "")
	upload_pass 				= UPLOAD("pass")
	pass						= util.getReplaceInput(upload_pass, "")
	upload_content 				= UPLOAD("content")
	content						= util.getReplaceInput(upload_content, "")
	

	option_html					= UPLOAD("option_html") : IF option_html = "" THEN option_html = "0"
	option_secret				= UPLOAD("option_secret") : IF option_secret = "" THEN option_secret = "0"
	option_notice				= UPLOAD("option_notice") : IF option_notice = "" THEN option_notice = "0"
	thistime					= UPLOAD("thistime")'multi upload 
	attached					= UPLOAD("attached")
	file_del					= UPLOAD("file_del")
	
	UploadedFileName = split(attached, ",")
	op_flag_value = option_html & "|" & option_secret & "|" & option_notice & "|" & "|" & "|" & "|"

	''Response.End()

''	IF qry = "edit" THEN '' and adminmode <> "true" 
		''strSQL = "select uid, pass, filename from " & table_name & " where uid = '" & uid & "'"
		''Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	''END IF
	''


''fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
''filename	= util.FileUploadModule(UPLOAD("attached"), qry, file_del)
	
	SELECT CASE qry
		CASE "qna_in", "qna_up", "qna_reply" '', , "reple", qin
		
			Select Case qry
				Case "qna_in":
					smode	= "qin"
				Case "qna_up":
					smode	= "edit"
				Case "qna_reply":
					smode	= "reple"
			End Select
			Dim paramInfo(10)
			paramInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,30, smode)
			paramInfo(1) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)
			paramInfo(2) = db.MakeParam("@pid", adTinyInt, adParamInput, 11, pid)
			paramInfo(3) = db.MakeParam("@id", adVarChar, adParamInput,20, userid)
			paramInfo(4) = db.MakeParam("@name", adVarChar, adParamInput,30, name)
			paramInfo(5) = db.MakeParam("@pass", adVarChar, adParamInput,20, pass)
			paramInfo(6) = db.MakeParam("@subject", adVarChar, adParamInput,200, subject)
			paramInfo(7) = db.MakeParam("@content", adLongVarChar, adParamInput,LenB(content), content)
		
			paramInfo(8) = db.MakeParam("@op_flag", adVarChar, adParamInput,20, op_flag_value)
			paramInfo(9) = db.MakeParam("@filename", adVarChar, adParamInput,250, filename)
			paramInfo(10) = db.MakeParam("@ip", adVarChar, adParamInput,15, ip)
			''Response.Write("usp_board")
			Call db.ExecSP("usp_product_qna", paramInfo, DbConnect) 
		
	END SELECT	

	db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>