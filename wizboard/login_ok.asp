<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility : Set db = new database
Dim paramInfo(3)

	DIm admin_id, admin_pwd
	admin_id   = util.secstr(REQUEST("admin_id"))'' 특수문자 제거
	admin_pwd  = util.secstr(REQUEST("admin_pwd"))'' 특수문자 제거
	If admin_id = "" Then Call util.js_alert("아이디를 입력해 주세요", "")
	If admin_pwd = "" Then Call util.js_alert("패스워드를 입력해 주세요", "")

	paramInfo(0) = db.MakeParam("@member", adVarChar, adParamInput,30, "root")
	paramInfo(1) = db.MakeParam("@id", adVarChar, adParamInput,30, admin_id)
	paramInfo(2) = db.MakeParam("@pwd", adVarChar, adParamInput,30, admin_pwd)
	paramInfo(3) = db.MakeParam("@return_out", adInteger, adParamOutput,2, 1)	

	Set objRs = db.ExecSPReturnRS("getLogininfo", paramInfo, DbConnect)
	result = db.GetValue(paramInfo, "@return_out")
	Set objRs	= Nothing
	db.Dispose
	Set db		= Nothing
	
	if result = 1 then
		Call util.js_alert("아이디가 일치하지 않습니다.","")
	elseif result = 2 then
		Call util.js_alert("패스워드가 일치하지 않습니다..\n\n관리자에게 문의해 주세요","")		
	elseif result = 3 then
		Call util.js_alert("탈퇴된 회원입니다.\n\n관리자에게 문의해 주세요","")
	elseif result = 4 then
		Call util.js_alert("승인되지 않은 회원입니다.\n\n관리자에게 문의해 주세요","")
	elseif result = 0 then
			session("user_info")	= "admin|"&admin_pwd&"|관리자|0|0"
			RESPONSE.REDIRECT "default.asp"	
	end If
	Set util = Nothing
%>