<%@LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim path

Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database
Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename, fileinfo, filename



DefaultPath = PATH_SYSTEM & "config\webhard\"

' // 컴포넌트 지정
attached_count = util.SetUploadComponent

' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
Dim upd : upd	= UPLOAD("file_up_path")
DefaultPath = upd

' // 체크가 모두 끝나면 파일 저장한다.
filename	= util.FileUploadModule(UPLOAD("attached"), "", "")

path = Server.MapPath("../../config/webhard/") & "\"&mid(upd,3)

Response.Redirect "./folderView.asp?Directory="&upd
%>
