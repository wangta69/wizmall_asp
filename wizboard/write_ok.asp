<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.board.asp" -->
<!--#include file="../lib/JSON_2.0.4.asp"-->

<%
' powered by 폰돌
'Reference URL : http://www.shop-wiz.com
'Contact Email : master@shop-wiz.com
'Free Distributer : 
'Copyright shop-wiz.com
'*** Updating List ***

Dim attached_file(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim UPLOAD, attached_count, old_filename

Dim smode,adminmode,page,uid,search_category,search_word,redirection,userid,upload_notice,notice,upload_name
Dim spamfree,name,upload_email,email,upload_homepage,homepage,upload_subject,subject,flag,txtbold,txtcolor,upload_pass,pass,upload_sub_subject1
Dim sub_subject1,upload_sub_subject2,sub_subject2,upload_content,content,upload_sub_content1,sub_content1
Dim upload_sub_content2,sub_content2,upload_category,option_html,option_secret,option_notice,op_flag_value
Dim setsecurityiframe, setsecurityscript
Dim thistime,tmp_up,category
Dim UploadedFileName, attached, file_del, path, avaext, ufilename, fileinfo, filename, Result_Ext
Dim strSQL,objRs, maxuid, maxidx_num, maxidx_bd_num, filesize, intCookie, intCategory
Dim db,util,board
Set util = new utility	
Set db = new database
Set board = new boards


Dim gid : gid	= Request("gid")
Dim bid : bid	= Request("bid")
Dim table_name : table_name = "wizboard_" & bid & "_" & gid
Dim ip : ip	= Request.Servervariables("REMOTE_ADDR")
Dim DefaultPath : DefaultPath = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"

	' // 업로드 컴포넌트 컴포넌트 지정
	CALL util.folderMaker(DefaultPath)''폴더 비존재시 에러 방지
	attached_count = util.SetUploadComponent
	

	smode						= UPLOAD("smode")
	page						= UPLOAD("page")
	uid							= UPLOAD("uid")
	search_category   		 	= UPLOAD("search_category")
	search_word      		   	= UPLOAD("search_word")
	redirection					= UPLOAD("redirection")
	userid						= UPLOAD("userid")
	spamfree					= UPLOAD("spamfree")
'userid
	if spamfree = "" then Call util.js_alert("잘못된 경로로 접근하였습니다.","")
	
	if smode <> "edit" And spamfree + 5 > util.Linuxtime() then Call util.js_alert("잘못된 경로로 접근하였습니다.\n입력시간이 너무 짧습니다.","")
	
	if userid  = "" then userid = user_id
' // 파일 저장 경로


	''
	''바로 받아서 함수에 넣을 경우 일부 업로드 컴포넌트에 따라 에러가 발생하여 아래와 같이 변수에 넣은후 다시 처리한다.
	upload_notice 			= UPLOAD("notice")
	notice					= util.getReplaceInput(upload_notice, "")
	if notice = "" then notice = 0
	upload_name 			= UPLOAD("name")
	name					= util.getReplaceInput(upload_name, "ns")
	upload_email 			= UPLOAD("email")
	email					= util.getReplaceInput(upload_email, "ns")
	upload_homepage 			= UPLOAD("homepage")
	homepage				= util.getReplaceInput(upload_homepage, "ns")
	upload_subject 			= UPLOAD("subject")
	subject				= util.getReplaceInput(upload_subject, "")
	txtbold					= UPLOAD("txtbold")
	txtcolor				= UPLOAD("txtcolor")
	
	upload_pass 				= UPLOAD("pass")
	pass					= util.getReplaceInput(upload_pass, "")
	upload_sub_subject1 		= UPLOAD("sub_subject1")
	sub_subject1				= util.getReplaceInput(upload_sub_subject1, "")
	upload_sub_subject2 		= UPLOAD("sub_subject2")
	sub_subject2				= util.getReplaceInput(upload_sub_subject2, "")
	upload_content 			= UPLOAD("content")
	content				= util.getReplaceInput(upload_content, "")
	
	upload_sub_content1 		= UPLOAD("sub_content1")
	sub_content1				= util.getReplaceInput(upload_sub_content1, "")
	upload_sub_content2 		= UPLOAD("sub_content2")
	sub_content2				= util.getReplaceInput(upload_sub_content2, "")
	upload_category 			= UPLOAD("category")
	category				= trim(upload_category) : IF category = "" THEN category = 0
	option_html				= UPLOAD("option_html") : IF option_html = "" THEN option_html = "0"
	option_secret				= UPLOAD("option_secret") : IF option_secret = "" THEN option_secret = "0"
	option_notice				= UPLOAD("option_notice") : IF option_notice = "" THEN option_notice = "0"
	adminmode				= UPLOAD("adminmode")'관리자화면에서 넘어오는 경우
	thistime				= UPLOAD("thistime")'multi upload 
	attached				= UPLOAD("attached")
	file_del				= UPLOAD("file_del")
	
	'' 추가필드 : 게시판 제작시 추가로 필드가 필요한 경우 cont1, cont2... 등으로 write.asp 에서 필드명을 주고 이곳에서 처리하여 sub_content1 로 입력
	'' 이경우 sub_content1의 값을 사용하는지 책크하여 만약 사용되면 sub_content2 혹은 새로운 Colum을 만들어 사용한다.
	Dim cont1, cont2, cont3
	cont1					= UPLOAD("cont1")
	cont2					= UPLOAD("cont2")
	cont3					= UPLOAD("cont3")
	sub_content1				= cont1 & "::" & cont2 & "::" & cont3

	'' flag 를 json으로 변경하여 db에 입력
	Dim flagJson
	Set flagJson	= jsObject()

	flagJson("txtbold")	= txtbold
	flagJson("txtcolor")	= txtcolor
	flag	= flagJson.jsString
	''flag	= util.getReplaceInput(flagJson.jsString, "")
	''flag	= "aaa"

	
	
	op_flag_value = option_html & "|" & option_secret & "|" & option_notice & "|" & "|" & "|" & "|"

	
	
'// 수정시 현재 등록된 정보및 패스워드를 체크 한다.
	IF smode = "edit" THEN '' and adminmode <> "true" 
		strSQL = "select uid, pass, filename from wizboard_" & bid & "_" & gid & " where uid = '" & uid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			IF objRs("pass") <> pass and user_id <> "admin"  THEN CALL ExecError("게시글의 비밀번호가 일치하지 않습니다.", 1, bid, gid)
			if objRs("filename") <> "" then 
				'REDIM old_filename
				old_filename = split(objRs("filename"), "|")
			end if
		
	END IF
	
	''금지 스크립트 처리

	if option_html = "1" then ''html일경우만 문제가 발생하므로 처리한다. 
		if setsecurityiframe = "1" then if InStr(content, "<script") then Call util.js_alert("보안상 <script>는 사용하실 수 없습니다.","")
		if setsecurityscript = "1" then if InStr(content, "<iframe") then Call util.js_alert("보안상 <iframe>는 사용하실 수 없습니다.","")

	end if


''Response.End()


''if Check_Ext(filename,avaext) = "false" then
''	Response.Write("금지된 확장자가 첨부화일에 포함되었습니다.")
''end if
'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
fileinfo	= util.FileUploadInfo(UPLOAD("attached"))

' // 체크가 모두 끝나면 파일 저장한다.
path = PATH_SYSTEM&"config\wizboard_group\"&gid&"\"&bid&"\allow_file_ext.txt"
avaext		= util.FileReadTxt(path)
 ''Call util.js_alert(avaext,"")
filename	= util.FileUploadModule(UPLOAD("attached"), smode, file_del, avaext)

	''금지 확장자 파일 처리
''	UploadedFileName = split(filename, "|")
''	path = PATH_SYSTEM&"config\wizboard_group\"&gid&"\"&bid&"\allow_file_ext.txt"
''	avaext = util.FileReadTxt(path)


''	for each ufilename in UploadedFileName
''		ufilename = Mid(ufilename, InstrRev(ufilename, "\")+1)
''		if trim(ufilename) <> "" then 
''			Result_Ext = util.Check_Ext(ufilename,avaext)
''			if Result_Ext = False then  Call util.js_alert("허용되지 않은 확장자("&ufilename&")가 첨부화일에 포함되었습니다.","")
''		end if
''	next


''Response.Write(filename)
''Response.Write(UPLOAD("attached"))
''Response.Write(attached)
''Response.End()
''filename = util.getReplaceInput(filename, "")

'' 이전 글에서 정보를 불러온다.
''	IF (smode = "qin") OR (smode = "reple") THEN
''		strSQL = "SELECT TOP 1 [uid], [bd_idx_num], [bd_num] FROM " & table_name & " ORDER BY [bd_idx_num] DESC "
''		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

''		IF NOT(objRs.EOF) THEN
''			maxuid			= objRs("uid")
''			maxidx_num		= objRs("bd_idx_num") + 1
''			maxidx_bd_num	= objRs("bd_num") + 1
''		ELSE
''			maxuid			= 1
''			maxidx_num		= 1
''			maxidx_bd_num	= 1
''		END IF
''	END IF
	
	SELECT CASE smode
	CASE "qin", "edit", "reple"
	
		if thistime <> "" then
			strSQL = "select * from wizTable_multi_tmp where thistime = '"&thistime&"'"
			Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			
			attached = ""
			cnt = 0
			while not objRs.eof
				filename = objRs("filename")
				CALL MoveAFile(PATH_SYSTEM & "config\wizboard_group\tmpdir\"&filename, DefaultPath&filename)
				attached = attached & filename & "|"
				
			objRs.movenext
			cnt = cnt+1
			wend
			objRs.close()
			
			for i=cnt to 25
			 	attached = attached & "|"	
			next
			filename = attached
			strSQL = "delete from wizTable_multi_tmp where thistime = '"&thistime&"'"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		
		end if
				
		
		Set db = new database
		Dim paramInfo(20)
			paramInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,30, smode)
			paramInfo(1) = db.MakeParam("@tablename", adVarChar, adParamInput,30, table_name)
			paramInfo(2) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)
			paramInfo(3) = db.MakeParam("@notice", adTinyInt, adParamInput, 11, notice)
			paramInfo(4) = db.MakeParam("@category", adTinyInt, adParamInput, 11, category)
			paramInfo(5) = db.MakeParam("@id", adVarChar, adParamInput,20, userid)
			paramInfo(6) = db.MakeParam("@name", adVarwChar, adParamInput,30, name)
			paramInfo(7) = db.MakeParam("@email", adVarChar, adParamInput,64, email)
			paramInfo(8) = db.MakeParam("@homepage", adVarChar, adParamInput,100, homepage)
			paramInfo(9) = db.MakeParam("@pass", adVarChar, adParamInput,20, pass)
			'paramInfo(10) = db.MakeParam("@subject", adVarChar, adParamInput,200, "N'"&subject&"'")
			paramInfo(10) = db.MakeParam("@subject", adVarwChar, adParamInput,200, subject)
			paramInfo(11) = db.MakeParam("@flag", adVarwChar, adParamInput,100, flag)
			paramInfo(12) = db.MakeParam("@sub_subject1", adVarwChar, adParamInput,200, sub_subject1)
			paramInfo(13) = db.MakeParam("@sub_subject2", adVarwChar, adParamInput,200, sub_subject2)
			'' LenB(content) adLongVarWChar : 1073741823, adLongVarcha : 2147483647
			paramInfo(14) = db.MakeParam("@content", adLongVarWChar, adParamInput, LenB(content), content)
			paramInfo(15) = db.MakeParam("@sub_content1", adLongVarWChar, adParamInput,LenB(sub_content1), sub_content1)
			paramInfo(16) = db.MakeParam("@sub_content2", adLongVarWChar, adParamInput,LenB(sub_content2), sub_content2)
			''text 처리 Parameters.Append .CreateParameter("@strContent", adVarWChar, adParamInput, 2147483647 , strContent) 			
			paramInfo(17) = db.MakeParam("@op_flag", adVarChar, adParamInput,20, op_flag_value)
			paramInfo(18) = db.MakeParam("@filename", adVarChar, adParamInput,250, filename)
			paramInfo(19) = db.MakeParam("@filesize", adVarChar, adParamInput,80, filesize)
			paramInfo(20) = db.MakeParam("@ip", adVarChar, adParamInput,15, ip)
			Response.Write("flag:"&flag)
			Call db.ExecSP("usp_board", paramInfo, DbConnect) 
			
''"qin", "edit", "reple"
			
			Dim max_uid

			If smode = "qin" Or smode = "reple" then
			''content 다시 한번 처리해 준다.
				strSQL = "select max(uid) from " & table_name
				
				objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				''Response.Write(objRs(0))
				max_uid	=objRs(0)
			''Response.End()
			ElseIf smode = "edit" Then
				max_uid = uid
			End If

			content	= util.htmleditorImg_board(content,gid, bid, max_uid)
			strSQL = "update " & table_name & " set content = N'" &content& "' where uid = " & max_uid
			''Response.Write strSQL
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			db.Dispose : Set db = nothing	

	END SELECT

	IF smode = "reple" THEN
			''답변글 메일링에 관한 프로그램(추후 진행예정)
		Set db = new database
		Dim fromname, frommail, toname, tomail, inputhtml, memo

		fromname      = name
		frommail      = email

		strSQL = "select * from wizboard_" & bid & "_" & gid & " where uid=" & uid
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		Dim option_value : option_value      = SPLIT(objRs("op_flag"),"|")

		IF option_value(1) = "1" THEN

			toname         = objRs("name")
			tomail         = objRs("email")
			temp_option_value = objRs("option")

			Dim strFilename1, strFilesize1, strFilename2, strFilesize2, sendSubject

			strFilename1         = attached_file(i)
			strFilesize1         = insert_dbfilesize1
			strFilename2         = insert_dbfile2
			strFilesize2         = insert_dbfilesize2

			sendSubject = " 게시물이 전달되었습니다. "


			strWriter = "<font color='#1e8ea6'>" & fromname & " (</font> <a href='mailto:" & frommail & "'><img src=" & PATH_URL & "wizboard/images/mail.gif width=14 height=10 border=0></a> <a href='" & strHomepage & "' target='_blank'><img src=" & PATH_URL & "wizboard/images/mail_home.gif width=10 height=10 border=0></a> ) <font color='#1e8ea6'>게시글 작성일자 : " & NOW() & "</font>"

			strContent = getReplaceInput(strContent, "")
			strContent = ReplaceHtmlText(strUseHtml, strContent)

			IF strFilename1 <> "" AND ISNULL(strFilename1) = False THEN
				strFilesize1 = getFilesize(strFilesize1)
				strFilename1 = "<img src=" & PATH_URL & "wizboard/images/down.gif width=12 height=12 border=0>&nbsp;<a href=" & PATH_URL & "wizboard/filedown.asp?bid=" & bid & "&gid=" & gid & "&uid=" & objRs("uid") & "&file=1>" & strFilename1 & "</a> [ <b>" & strFilesize1 & "]</b>"
			END IF

			IF strFilename2 <> "" AND ISNULL(strFilename2) = False THEN
				strFilesize2 = getFilesize(strFilesize2)
				strFilename2 = "<img src=" & PATH_URL & "wizboard/images/down.gif width=12 height=12 border=0>&nbsp;<a href=" & PATH_URL & "wizboard/filedown.asp?bid=" & bid & "&gid=" & gid & "&uid=" & objRs("uid") & "&file=2>" & strFilename2 & "</a> [ <b>" & strFilesize2 & "]</b>"
			END IF

			Dim dateEditDate
			dateEditDate = "게시글 최종 수정 일자 : " & NOW()

			Dim sendContent
			sendContent = "<html>" & vbcrlf
			sendContent = sendContent & "<head>" & vbcrlf
			sendContent = sendContent & "<meta http-equiv=content-type content=text/html; charset=euc-kr>" & vbcrlf
			sendContent = sendContent & "<title>게시글 메일로 보내기</title>" & vbcrlf
			sendContent = sendContent & "<link rel=StyleSheet HREF=" & PATH_URL & "Library/style.css type=text/css title=style>" & vbcrlf
			sendContent = sendContent & "</head>" & vbcrlf
			sendContent = sendContent & "<body>" & vbcrlf
			sendContent = sendContent & "<table width='100%'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td>" & vbcrlf
			sendContent = sendContent & "			<table width='100%'  border='0' cellpadding='5' cellspacing='1' bgcolor='F8F8F8'>" & vbcrlf
			sendContent = sendContent & "				<tr align='center' bgcolor='EEE9C8'>" & vbcrlf
			sendContent = sendContent & "					<td height='27' colspan='2'><font color='#694d09'><b>게시물 발송 정보</b></font></td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			sendContent = sendContent & "				<tr>" & vbcrlf
			sendContent = sendContent & "					<td width='15%' align='right' bgcolor='F8F5E8'>보낸 사람&nbsp;</td>" & vbcrlf
			sendContent = sendContent & "					<td width='85%' bgcolor='#FFFFFF'>" & fromname & "(<a href=mailto:" & frommail & "><img src=" & PATH_URL & "wizboard/images/mail.gif width=14 height=10 border=0></a>)</td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			sendContent = sendContent & "				<tr>" & vbcrlf
			sendContent = sendContent & "					<td align='right' bgcolor='F8F5E8'>보낸 날짜&nbsp;</td>" & vbcrlf
			sendContent = sendContent & "					<td bgcolor='#FFFFFF'>" & now() & "</td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			sendContent = sendContent & "				<tr>" & vbcrlf
			sendContent = sendContent & "					<td align='right' bgcolor='F8F5E8'>남긴 메시지&nbsp; </td>" & vbcrlf
			sendContent = sendContent & "					<td bgcolor='#FFFFFF'>" & vbcrlf
			sendContent = sendContent & "						<table width='100%'  border='0' cellspacing='0' cellpadding='0'>" & vbcrlf
			sendContent = sendContent & "							<tr>" & vbcrlf
			sendContent = sendContent & "								<td style='padding:5 5 5 5'>답변글이 배달되었습니다.</td>" & vbcrlf
			sendContent = sendContent & "							</tr>" & vbcrlf
			sendContent = sendContent & "							<tr>" & vbcrlf
			sendContent = sendContent & "								<td height='22' align='right'><a href=" & PATH_URL & "wizboard/wizboard.asp?exe=view&bid=" & bid & "&gid=" & gid & "&uid=" & objRs("uid") & " target=_blank>[원본 게시글을 보시려면 클릭하세요]</a>&nbsp;&nbsp;</td>" & vbcrlf
			sendContent = sendContent & "							</tr>" & vbcrlf
			sendContent = sendContent & "							<tr>" & vbcrlf
			sendContent = sendContent & "								<td height='22' align='right'>This Mail Message From <a href='" & PATH_URL & "' target=_blank><strong>" & PATH_URL & "</strong></a>&nbsp;&nbsp;</td>" & vbcrlf
			sendContent = sendContent & "							</tr>" & vbcrlf
			sendContent = sendContent & "						</table>" & vbcrlf
			sendContent = sendContent & "					</td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			sendContent = sendContent & "			</table>" & vbcrlf
			sendContent = sendContent & "		</td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td>&nbsp;</td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td height='30'>" & strWriter & "</td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td height='2' bgcolor='EEE9C8'></td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td height='30' align='center'>" & strSubject & "</td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td height='1' bgcolor='F1EEDD'></td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td style='padding:10 10 10 10'>" & vbcrlf
			sendContent = sendContent & "			<table width='100%'  border='0' cellpadding='10' cellspacing='0' bgcolor='F8F8F8'>" & vbcrlf
			sendContent = sendContent & "				<tr>" & vbcrlf
			sendContent = sendContent & "					<td>" & strContent & "</td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			sendContent = sendContent & "				<tr>" & vbcrlf
			sendContent = sendContent & "					<td>&nbsp;</td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			IF strFilename1 <> "" OR strFilename2 <> "" THEN
				sendContent = sendContent & "				<tr>" & vbcrlf
				sendContent = sendContent & "					<td>" & strFilename1 & "&nbsp;&nbsp;" & strFilename2 & "</td>" & vbcrlf
				sendContent = sendContent & "				</tr>" & vbcrlf
			END IF
			sendContent = sendContent & "				<tr>" & vbcrlf
			sendContent = sendContent & "					<td align='right'>" & NOW() & "</td>" & vbcrlf
			sendContent = sendContent & "				</tr>" & vbcrlf
			sendContent = sendContent & "			</table>" & vbcrlf
			sendContent = sendContent & "		</td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "	<tr>" & vbcrlf
			sendContent = sendContent & "		<td height='1' bgcolor='F1EEDD'></td>" & vbcrlf
			sendContent = sendContent & "	</tr>" & vbcrlf
			sendContent = sendContent & "</table>" & vbcrlf
			sendContent = sendContent & "</body>" & vbcrlf
			sendContent = sendContent & "</html>" & vbcrlf

			''CALL util.fnc_sendmail(mail_component, toname, tomail, fromname, frommail, sendSubject, sendContent)

		End If
		db.Dispose : Set db = nothing	
	END IF



' // 쿠키에 정보를 저장한다.

	Set objRs = Nothing : Set UPLOAD = Nothing
	Set util	= Nothing : Set board = Nothing

	DIm goto_url
	''Response.End()
	goto_url = "../wizboard.asp?adminmode="&adminmode&"&bmode=list&bid=" & bid & "&gid=" & gid & "&page=" & page & "&category=" & intCategory & "&search_category=" & search_category & "&search_word=" & search_word & "&redirection=" & redirection
	IF (smode = "edit") OR (smode = "reple") THEN goto_url = goto_url & "&uid=" & uid
	RESPONSE.REDIRECT goto_url

	db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
