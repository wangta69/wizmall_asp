<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename, fileinfo, filename

Dim qry,smode,theme,menushow,page,uid,pskinname,pwidth,pheight,ptop,pleft
Dim psubject,click_url,pcontents,imgposition,popupenable,phtmlenable
Dim pshtmlenable,pbgenable,options
	
	
	DefaultPath = PATH_SYSTEM & "config\wizpopup\"
	'' // 컴포넌트 지정
	
	attached_count = util.SetUploadComponent

	qry					= UPLOAD("qry")
	smode				= UPLOAD("smode")
	theme				= UPLOAD("theme")
	menushow			= UPLOAD("menushow")
	page				= UPLOAD("page")	: If page = "" then page = 1
	uid					= UPLOAD("uid")
	pskinname			= UPLOAD("pskinname")
	pwidth				= UPLOAD("pwidth")
	pheight				= UPLOAD("pheight")
	ptop				= UPLOAD("ptop")
	pleft				= UPLOAD("pleft")
	psubject			= UPLOAD("psubject")
	psubject			= util.getReplaceInput(psubject, "")
	click_url			= UPLOAD("click_url")
	
	pcontents			= UPLOAD("pcontents")
	pcontents			= util.getReplaceInput(pcontents, "")
	imgposition			= UPLOAD("imgposition")
	popupenable			= UPLOAD("popupenable")
	phtmlenable			= UPLOAD("popupenable")	: If phtmlenable	= "" then phtmlenable = 0
	pshtmlenable		= UPLOAD("popupenable")	: If pshtmlenable	= "" then pshtmlenable = 0
	pbgenable			= UPLOAD("popupenable")	: If pbgenable		= "" then pbgenable = 0
	options = phtmlenable & "|"& pshtmlenable & "|" & pbgenable & "|"

if qry = "qin" then

	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "", "", "gif,jpeg,jpg,png")

	strSQL = "insert into wizpopup (pskinname,pwidth,pheight,ptop,pleft,psubject,click_url,pcontents,pattached,imgposition,popupenable,options) "
	strSQL = strSQL &"  values('" & pskinname & "','" & pwidth & "','" & pheight & "','" & ptop & "','" & pleft & "','" & psubject & "','" & click_url & "','" & pcontents & "','" & filename & "','" & imgposition & "','" & popupenable & "','" & options & "') "

	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Call util.js_alert("성공적으로 저장되었습니다.","../main.asp?menushow="&menushow&"&theme=util/popup1")
elseif qry = "qup" then
	''등록된 이미지 구하기
	strSQL			= "select pattached from wizpopup where uid = " & uid 
	Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	old_filename	= split(objRs("pattached"), "|")
	
	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "edit", UPLOAD("file_del"), "gif,jpeg,jpg,png")
	
	strSQL = " update wizpopup set pskinname='" & pskinname & "',pwidth='" & pwidth & "',pheight='" & pheight & "',ptop='" & ptop & "',pleft='" & pleft & "', "
	strSQL = strSQL & " psubject='" & psubject & "',click_url='" & click_url & "',pcontents='" & pcontents & "',pattached='" & filename & "',imgposition='" & imgposition & "',popupenable='" & popupenable & "',options='" & options & "' "
	strSQL = strSQL & " where uid="&uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Call util.js_alert("성공적으로  수정 되었습니다.","../main.asp?menushow="&menushow&"&theme=util/popup1")
end If
db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
