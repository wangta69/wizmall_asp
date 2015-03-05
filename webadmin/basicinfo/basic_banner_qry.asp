<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/cfg.array.asp" -->
<%
Dim uid, flag1, ordernum, subject, url, target, attached, showflag, wdate, smode
Dim menushow, theme
Dim LoopCount
Dim strSQL,objRs
Dim db,util

Set util = new utility	
Set db = new database



Dim attached_file(20),delete_file,file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename(1)
Dim fileinfo, filename

DefaultPath	= PATH_SYSTEM & "config\banner\"
smode		= Request("smode")

'' // 컴포넌트 지정
attached_count = util.SetUploadComponent

menushow	= upload("menushow")
theme		= upload("theme")
uid			= upload("uid")
flag1		= upload("flag1")
ordernum	= upload("ordernum")
subject		= upload("subject")
url			= upload("url")
target		= upload("target")
showflag	= upload("showflag")

If smode = "qin" Then  
	Dim max
	'' 파일 업로딩 시작 
	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
		
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), smode, delete_file, "gif,jpeg,jpg,png")
	filename	= Left(filename, Len(filename)-1)
	'' 파일 업로딩 끝
	''ordernum을 구한다.
	strSQL		= "select max(ordernum) from wizbanner where flag1 = " & flag1 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	If isnull(objRs(0)) then 
		max	= 1
	Else
		max	= objRs(0) + 1
	End If

	''데이타 저장
	strSQL = "insert into wizbanner (flag1, ordernum, url, target, attached) values('" & flag1 & "', '" & max & "', '" & url & "','" & target & "', '" & filename &"')"
	Response.Write(strSQL)
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
ElseIf smode = "qup" Then
	''기존 첨부 화일 정보가져오기
	strSQL		= "select attached from wizbanner where uid = '" & uid & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if objRs("attached") <> "" then  old_filename(0) = objRs("attached")
			
	
	''파일 업로딩 시작 
	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
		
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "edit", delete_file, "gif,jpeg,jpg,png")
	filename	= Left(filename, Len(filename)-1)
	''파일 업로딩 끝	
	
	strSQL = "update wizbanner set ordernum='" & ordernum & "', url='" & url & "', target='" & target & "', attached='" & filename & "' where uid=" & uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
End If
	Response.Redirect("../main.asp?menushow=" & menushow & "&theme=basicinfo/basic_banner")
%>