<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim id : id		= Request("id")
Dim htmleditimgfolder : htmleditimgfolder = session.SessionID

if id <> "" then 
	''Dim strSQL,objRs
	Dim db,util
	Set util = new utility	
	''Set db = new database

	Dim DefaultPath : DefaultPath = PATH_SYSTEM & "config\tmp_file\editor\" & htmleditimgfolder & "\"
	Dim tmpfile, smode, loopcnt
	Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
	Dim UPLOAD, attached_count, old_filename(), delete_file()
	Dim fileinfo, filename

	Call util.folderMaker(DefaultPath)
	attached_count = util.SetUploadComponent
	
	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "", "")
	tmpfile	= split(filename,"|")
	For loopcnt=0 to Ubound(tmpfile)
		if loopcnt = 0 then filename = tmpfile(loopcnt)
	next

	if filename <> "" then  
		Response.Write("<script language='javascript' type='text/javascript'>")
		Response.Write("parent.parent.insertIMG('" & id & "','" & PATH_URL & "config/tmp_file/editor/"& htmleditimgfolder &"/"& filename &"');")
		Response.Write("parent.parent.oEditors.getById[""" & id & """].exec(""SE_TOGGLE_IMAGEUPLOAD_LAYER"");")
		Response.Write("</script>")
	end if
end If
	Set util = Nothing
%>