<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database

Dim theme, menushow,qry
Dim id,current_pwd,pwd,name,nickname,age,jumin1,jumin2,strage,zip1,address1,address2
Dim tel1,tel2,tel3,czip,caddress1,caddress2,email,url,mailenable,smsenable,birthdate,birthtype
Dim marrdate,companynum,companyname,president,contents,mregdate,mpoint,mgrade,mgrantsta
Dim old_id,ispopup,memid,mpwd,mname,mailreceive,mloginnum,mlogindate,emailenable,gender
Dim applytype, filenameArr
Dim Loopcnt
	
	

Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename
Dim fileinfo, filename, smode

DefaultPath = PATH_SYSTEM & "config\memberimg\"

'' // 컴포넌트 지정
attached_count = util.SetUploadComponent

theme			= upload("theme")
menushow		= upload("menushow")
qry			= trim(upload("qry"))

if qry = "qin" then ''다음에는 이부분도 통일

	id				= trim(upload("id"))
	current_pwd		= trim(upload("current_pwd"))
	pwd				= trim(upload("pwd"))
	name			= trim(upload("name"))
	nickname		= trim(upload("nickname"))
	age				= trim(upload("age"))
	jumin1			= trim(upload("jumin1"))
	jumin2			= trim(upload("jumin2"))
	strage			= trim(upload("age"))
	zip1			= trim(upload("zip1_1")) & "-" & trim(upload("zip1_2"))
	address1		= trim(upload("address1"))
	address2		= trim(upload("address2"))
	''tel1			= trim(upload("tel1_1")) & "-" & trim(upload("tel1_2")) & "-" & trim(upload("tel1_3"))
	''tel2			= trim(upload("tel2_1")) & "-" & trim(upload("tel2_2")) & "-" & trim(upload("tel2_3"))
	''tel3			= trim(upload("tel3_1")) & "-" & trim(upload("tel3_2")) & "-" & trim(upload("tel3_3"))
	tel1			= trim(upload("tel1"))
	tel2			= trim(upload("tel2"))
	tel3			= trim(upload("tel3"))
	caddress1		= trim(upload("caddress1"))
	email			= trim(upload("email")) : If email = "" then email = trim(upload("email1")) & "@" & trim(upload("email2"))
	url				= trim(upload("url"))
	mailenable		= trim(upload("mailenable"))
	smsenable		= trim(upload("smsenable"))
	birthdate		= trim(upload("birthy")) & "/" & trim(upload("birthm")) & "/" & trim(upload("birthd"))
	birthtype		= trim(upload("birthtype"))
	marrdate		= trim(upload("marry")) & "/" & trim(upload("marrm")) & "/" & trim(upload("marrd"))
	companynum		= trim(upload("companynum1")) & "-" & trim(upload("companynum2")) & "-" & trim(upload("companynum3"))
	companyname		= trim(upload("companyname"))
	president		= trim(upload("president"))
	contents		= trim(util.getReplaceInput(upload("contents"),""))
	mregdate		= Date & " " & HOUR(NOW) & ":" & MINUTE(NOW) & ":" & SECOND(NOW)
	mpoint			= ""
	mgrade			= trim(upload("mgrade")) : If mgrade = "" then mgrade = "10"
	
	mgrantsta		= "03"
elseif qry = "qup" Then
	smode		= "edit"
	old_id		= upload("old_id")
	ispopup		= upload("ispopup")
	memid		= upload("mid")
	mpwd		= upload("mpwd")
	mname		= upload("mname")
	mgrantsta	= upload("mgrantsta")
	mpoint		= upload("mpoint")
	mgrade		= upload("mgrade")
	mailreceive	= upload("mailreceive")
	mloginnum	= upload("mloginnum")
	mlogindate	= upload("mlogindate")
	
	nickname	= upload("nickname")
	jumin1		= upload("jumin1")
	jumin2		= upload("jumin2")
	tel1		= upload("tel1")
	tel2		= upload("tel2")
	tel3		= upload("tel3")
	zip1		= upload("zip1")
	address1	= upload("address1")
	address2	= upload("address2")
	caddress1	= trim(upload("caddress1"))
	email		= upload("email")
	url			= upload("url")
	emailenable	= upload("emailenable")
	age			= upload("age")
	birthdate	= upload("birthdate")
	birthtype	= upload("birthtype")
	gender		= upload("gender")
	companynum	= upload("companynum")
	companyname	= upload("companyname")
	president	= upload("president")
	czip		= upload("czip")
	caddress1	= upload("caddress1")
	caddress2	= upload("caddress2")
	contents	= upload("contents")
	smsenable	= upload("smsenable")
	applytype	= upload("applytype")
end if

if qry = "qin" then 
	'공백 여부를 한번더 책크하고 현재 등록된 아이디 인지를 책크 
	strSQL = "select mid from wizmembers where mid = '" & id & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if not objRs.eof then Call util.js_alert("이미 등록된 아이디 입니다.\n\n신규아이디를 선택해주세요\n\n","")	
	
	' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
		
		
	' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "", "", "gif,jpeg,jpg,png")
	
	
	strSQL = "INSERT INTO wizmembers ( "  
	strSQL = strSQL & "  mid, mpwd, mname, mregdate, mgrantsta,mpoint,mgrade "
	strSQL = strSQL & ") VALUES ( " 
	strSQL = strSQL & "  '"& id &"', '"& pwd &"', '"& name &"', "
	strSQL = strSQL & "  '"& mregdate &"', '"& mgrantsta &"', '"& mpoint &"', '"& mgrade &"'"
	strSQL = strSQL & ") "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	
	strSQL = "INSERT INTO wizmembers_ind ( "  
	strSQL = strSQL & "  mid,nickname,jumin1,jumin2,tel1,tel2,tel3,zip1,address1,address2,email,url,emailenable,age,birthdate,birthtype,gender,companynum,companyname,president,czip,caddress1,caddress2,contents"
	strSQL = strSQL & ") VALUES ( " 
	strSQL = strSQL & "  '"& id &"', '"& nickname &"', '"& jumin1 &"', '"& jumin2 &"', '"& tel1 &"', '"& tel2 &"','"& tel3 &"', '"& zip1 &"', "
	strSQL = strSQL & "  '"& address1 &"', '"& address2 &"', '"& email &"', '"& url &"', '"& emailenable &"', "
	strSQL = strSQL & "  '"& age &"', '"& birthdate &"', '"& birthtype &"', "
	strSQL = strSQL & "  '"& gender &"', '"& companynum &"', '"& companyname &"', '"& president &"', '"& czip &"', "
	strSQL = strSQL & "  '"& caddress1 &"', '"& caddress2 &"', '"& contents &"'"
	strSQL = strSQL & ") "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

	filenameArr = split(filename, "|")
	for Loopcnt=0 to Ubound(filenameArr)
		if filenameArr(Loopcnt) <> "" then
			strSQL = "insert into wizfiletable (filename, flag1, flag2) values ('"&filenameArr(Loopcnt)&"','wizmember','"&id&"')"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		end if
	next
	Call util.js_location("../main.asp?menushow=menu6&theme=member/member1","")
	
elseif qry = "qup" then

	' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
		
		
	' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "", "", "gif,jpeg,jpg,png")
	
	
	strSQL = "update wizmembers set mid = '"&memid&"', mpwd = '"&mpwd&"', mname = '"&mname&"', mgrade = '"&mgrade&"' where mid = '"&old_id&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL = "update wizmembers_ind set "
	strSQL = strSQL & "mid = '"&memid&"', "
	strSQL = strSQL & "nickname = '"&nickname&"', "
	strSQL = strSQL & "jumin1 = '"&jumin1&"', "
	strSQL = strSQL & "jumin2 = '"&jumin2&"', "
	strSQL = strSQL & "tel1 = '"&tel1&"', "
	strSQL = strSQL & "tel2 = '"&tel2&"', "
	strSQL = strSQL & "tel3 = '"&tel3&"', "
	strSQL = strSQL & "zip1 = '"&zip1&"', "
	strSQL = strSQL & "address1 = '"&address1&"', "
	strSQL = strSQL & "address2 = '"&address2&"', "
	strSQL = strSQL & "caddress1 = '"&caddress1&"', "
	strSQL = strSQL & "companyname = '"&companyname&"', "
	strSQL = strSQL & "president = '"&president&"', "
	strSQL = strSQL & "email = '"&email&"', "
	strSQL = strSQL & "emailenable = '"&emailenable&"', "
	strSQL = strSQL & "url = '"&url&"', "
	strSQL = strSQL & "age = '"&age&"', "
	strSQL = strSQL & "birthdate = '"&birthdate&"', "
	strSQL = strSQL & "birthtype = '"&birthtype&"', "
	strSQL = strSQL & "contents = '"&contents&"', "
	strSQL = strSQL & "gender = '"&gender&"' "
	strSQL = strSQL & "where mid = '"&old_id&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)	
	

	filenameArr = split(filename, "|")
	for Loopcnt=0 to Ubound(filenameArr)
		if filenameArr(Loopcnt) <> "" then
			strSQL = "insert into wizfiletable (filename, flag1, flag2) values ('"&filenameArr(i)&"','wizmember','"&memid&"')"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		end if
	next
	Call util.js_location("./member1_1.asp?mid=" & memid,"")
end if	
db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
