<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../config/membercheck_info.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<%
Dim qry, gotosmode
Dim id, cpw, pwd, name,nickname, age, gender, jumin1, jumin2
Dim zip1, czip, address1, address2, caddress1, caddress2, tel1, tel2, tel3
Dim email, emailenable, url, birthdate, birthtype, companynum, companyname, president
Dim contents, mgrantsta, mpoint, mgrade, mloginnum,ch_mgrade
Dim  pcontent, pflag, pmode, uid
Dim strSQL, objRs, cmd, params
Dim db, util
Set util = new utility
Set db = new database
	
	
qry				= trim(Request.Form("qry"))
gotosmode		= trim(Request.Form("gotosmode"))
id				= trim(Request.Form("id"))
cpw				= trim(Request.Form("cpw"))
pwd				= trim(Request.Form("pwd"))
name			= trim(Request.Form("name"))
nickname		= trim(Request.Form("nickname"))
age				= trim(Request.Form("age"))
gender			= trim(Request.Form("gender"))
jumin1			= trim(Request.Form("jumin1"))
jumin2			= trim(Request.Form("jumin2"))
zip1			= trim(Request.Form("zip1_1")) & "-" & trim(Request.Form("zip1_2"))
address1		= trim(Request.Form("address1"))
address2		= trim(Request.Form("address2"))
czip			= trim(Request.Form("zip2_1")) & "-" & trim(Request.Form("zip2_2"))  
caddress1		= trim(Request.Form("caddress1"))
caddress2		= trim(Request.Form("caddress2"))
tel1				= trim(Request.Form("tel1_1")) & "-" & trim(Request.Form("tel1_2")) & "-" & trim(Request.Form("tel1_3"))
tel2				= trim(Request.Form("tel2_1")) & "-" & trim(Request.Form("tel2_2")) & "-" & trim(Request.Form("tel2_3"))
tel3				= trim(Request.Form("tel3_1")) & "-" & trim(Request.Form("tel3_2")) & "-" & trim(Request.Form("tel3_3"))
email				= trim(Request.Form("email_1")) & "@" & trim(Request.Form("email_2"))
emailenable		= trim(Request.Form("emailenable"))
url						= trim(Request.Form("url"))
birthdate				= trim(Request.Form("birthy")) & "/" & trim(Request.Form("birthm")) & "/" & trim(Request.Form("birthd"))
birthtype				= trim(Request.Form("birthtype"))
companynum		= trim(Request.Form("companynum1")) & "-" & trim(Request.Form("companynum2")) & "-" & trim(Request.Form("companynum3"))
companyname		= trim(Request.Form("companyname"))
president				= trim(Request.Form("president"))
contents				= trim(util.getReplaceInput(Request.Form("contents"),""))
mgrantsta			= EGrantSta
mpoint				= 0
mgrade				= trim(Request.Form("mgrade"))
ch_mgrade			= trim(Request.Form("ch_mgrade"))''등급 변경용
if mgrade = "" then mgrade = "10"

 
if qry = "qin" then
''response.write("1")
	''공백 여부를 한번더 책크하고 현재 등록된 아이디 인지를 책크 
	if id = "root" or id = "super" or id = "admin" then Call util.js_alert("등록하신 id는 예약어로 등록될 수 없습니다", "")	
	strSQL	= "select mid from wizmembers where mid = '" & id & "'"
  	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if not objRs.eof then
		Call util.js_alert("이미 등록된 아이디 입니다.\n\n신규아이디를 선택해주세요\n\n", "")	
	end if 

	''주민등록중복책크
	strSQL = "select mid from wizmembers_ind where jumin1 = '" & jumin1 & "' and jumin2 = '"&jumin2&"'"
  	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if not objRs.eof then
		Call util.js_alert("이미 등록된 주민등록번호 입니다.\n\n관리자에게 문의주시기 바랍니다.\n\n", "")	
	end if 
	Set objRs	= Nothing
Elseif qry = "qup" then
	'패스워드 책크 
	strSQL = "select mid, mpwd from wizmembers where mpwd = '" & cpw & "' and mid = '" & user_id & "'"
  	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if objRs.eof then
		Call util.js_alert("패스워드가 일치하지 않습니다.\n\n새로 입력해 주세요\n\n","")	
	end if 
	
	if pwd = "" then pwd = cpw
else
response.write("3")
end if	
	

if qry = "qin" or qry = "qup" then
	Set db = new database
	Dim paramInfo(30)
	''wizmembers 용
	paramInfo(0) = db.MakeParam("@qry", adVarChar, adParamInput,15, qry)
	if qry = "qin" then user_id = id

	paramInfo(1) = db.MakeParam("@mid", adVarChar, adParamInput,15, user_id)
	paramInfo(2) = db.MakeParam("@mpwd", adVarChar, adParamInput, 15, pwd)
	paramInfo(3) = db.MakeParam("@mname", adVarChar, adParamInput,30, name)
	paramInfo(4) = db.MakeParam("@mgrantsta", adVarChar, adParamInput,11, mgrantsta)
	paramInfo(5) = db.MakeParam("@mpoint", adInteger , adParamInput, 11, mpoint)
	paramInfo(6) = db.MakeParam("@mgrade", adVarChar, adParamInput, 2, mgrade)
	paramInfo(7) = db.MakeParam("@mloginnum", adInteger, adParamInput,11, mloginnum)
	''wizmebers_ind용
	paramInfo(8) = db.MakeParam("@nickname", adVarChar, adParamInput,20, nickname)
	paramInfo(9) = db.MakeParam("@jumin1", adVarChar, adParamInput,6, jumin1)
	paramInfo(10) = db.MakeParam("@jumin2", adVarChar, adParamInput,7, jumin2)
	paramInfo(11) = db.MakeParam("@tel1", adVarChar, adParamInput,20, tel1)
	paramInfo(12) = db.MakeParam("@tel2", adVarChar, adParamInput,20, tel2)
	paramInfo(13) = db.MakeParam("@tel3", adVarChar, adParamInput,20, tel3)
	paramInfo(14) = db.MakeParam("@zip1", adVarChar, adParamInput,7, zip1)
	paramInfo(15) = db.MakeParam("@address1", adVarChar, adParamInput,90, address1)
	paramInfo(16) = db.MakeParam("@address2", adVarChar, adParamInput,50, address2)
	paramInfo(17) = db.MakeParam("@email", adVarChar, adParamInput,30, email)
	paramInfo(18) = db.MakeParam("@emailenable", adVarChar, adParamInput,1, emailenable)
	paramInfo(19) = db.MakeParam("@url", adVarChar, adParamInput,50, url)
	paramInfo(20) = db.MakeParam("@age", adInteger, adParamInput,3, age)
	paramInfo(21) = db.MakeParam("@birthdate", adVarChar, adParamInput,15, birthdate)
	paramInfo(22) = db.MakeParam("@birthtype", adVarChar, adParamInput,2, birthtype)
	paramInfo(23) = db.MakeParam("@gender", adInteger, adParamInput,1, gender)
	paramInfo(24) = db.MakeParam("@companynum", adVarChar, adParamInput,12, companynum)
	paramInfo(25) = db.MakeParam("@companyname", adVarChar, adParamInput,30, companyname)
	paramInfo(26) = db.MakeParam("@president", adVarChar, adParamInput,20, president)
	paramInfo(27) = db.MakeParam("@czip", adVarChar, adParamInput,7, czip)
	paramInfo(28) = db.MakeParam("@caddress1", adVarChar, adParamInput,80, caddress1)
	paramInfo(29) = db.MakeParam("@caddress2", adVarChar, adParamInput,50, caddress2)
	''paramInfo(29) = db.MakeParam("@contents", adLongVarChar, adParamInput,LenB(contents), contents)
	paramInfo(30) = db.MakeParam("@contents", adVarWChar, adParamInput,2147483647, contents)
		''text 처리 Parameters.Append .CreateParameter("@contents", adVarWChar, adParamInput, 2147483647 , contents) 

	Call db.ExecSP("usp_member", paramInfo, DbConnect) 
	db.Dispose : Set db	= Nothing
	
	if qry = "qin" then 
		user_point = util.PointProc(user_id, EPoint, 1, pcontent, pflag, pmode, uid)
		Call util.js_alert("정상적으로 등록되었습니다.\n\n 로그인후 이용해 주시기 바랍니다.","../")	
	
	elseif qry = "qup" then
		Call util.js_alert("정상적으로 변경되었습니다.","../wizmember.asp?smode=info")
	end if
	
  
end If

Set util = Nothing
%>
