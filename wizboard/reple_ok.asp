<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.board.asp" -->
<%
Dim attached_file(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim UPLOAD, attached_count, old_filename, smode
Dim UploadedFileName, attached, file_del, path, avaext, ufilename, fileinfo, filename, Result_Ext
Dim uid, id, name, pass, content, subject, email, adminmode, page, category, search_title, search_keyword, spamfree

Dim strSQL,objRs
Dim db,util,board
Set util	= new utility	
Set db		= new database
Set board	= new boards
	

Dim gid : gid	= Request("gid")
Dim bid : bid	= Request("bid")
Dim table_name : table_name = "wizboard_" & bid & "_" & gid
Dim ip : ip	= Request.Servervariables("REMOTE_ADDR")
Dim DefaultPath : DefaultPath = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"

	' // 업로드 컴포넌트 컴포넌트 지정
	CALL util.folderMaker(DefaultPath)''폴더 비존재시 에러 방지
	''Response.End()
	attached_count = util.SetUploadComponent
	

	uid			= UPLOAD("uid")
	id			= UPLOAD("id")
	name		= UPLOAD("name")
	pass		= UPLOAD("pass")
	content		= UPLOAD("content")
	subject		= UPLOAD("subject")
	adminmode	= UPLOAD("adminmode")
	spamfree	= UPLOAD("spamfree")
	name		= util.getReplaceInput(name,"ns")
	ip			= Request.Servervariables("REMOTE_ADDR")
	IF (name = "") and SESSION("admin") <> "" then name="관리자"
	IF (name = "") OR (isNull(name) = True) THEN CALL ExecError("이름을 입력해 주시기 바랍니다.", 1, bid, gid)
	IF util.getLenStr(name) > 30 THEN CALL ExecError("이름은 30자 이내로 입력해 주시기 바랍니다.", 1, bid, gid)

	pass = util.getReplaceInput(pass,"")
	IF pass = "" and SESSION("admin") = "" THEN CALL ExecError("비밀번호를 입력해 주시기 바랍니다.", 1, bid, gid)

	if spamfree = "" then Call util.js_alert("잘못된 경로로 접근하였습니다.","")
	
	if smode <> "edit" And spamfree + 5 > util.Linuxtime() then Call util.js_alert("잘못된 경로로 접근하였습니다.\n입력시간이 너무 짧습니다.","")

	UploadedFileName = split(attached, ",")

	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))

	' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), smode, file_del)

	''Response.Write(filename)
	''Response.End()
	strSQL = "insert into wizboard_" & bid & "_" & gid & "_reply ("
	strSQL = strSQL & " [b_uid],[id],[name],[email],[pass],[subject],[content],[filename],[ip],[regdate]"
	strSQL = strSQL & " )values("
	strSQL = strSQL & " '" & uid & "','" & id & "','" & name & "','" & email & "','" & pass & "','" & subject & "','" & content &"','" & filename &"','" & ip &"',getdate()"
	strSQL = strSQL & ")"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL = "update wizboard_" & bid & "_" & gid &""
	strSQL = strSQL & " set replecount = replecount+1"
	strSQL = strSQL & " where uid = " & uid
	''Response.Write(strSQL)
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	RESPONSE.WRITE "<script language=javascript>" & vbcrlf
	RESPONSE.WRITE "location.replace('../wizboard.asp?bmode=view&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&page="&page&"&category="&category&"&adminmode="&adminmode&"&search_title="&search_title&"&search_keyword="&search_keyword&"');" & vbcrlf
	RESPONSE.WRITE "</script>" & vbcrlf

db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
