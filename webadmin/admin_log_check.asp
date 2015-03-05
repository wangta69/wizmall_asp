<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<%
	DIm admin_id, admin_pwd, AdminGrade, saveflag, login
	Dim strSQL, objRs, cmd, params, result
	Dim db,util
	Set util = new utility	
	Set db = new database
		
	admin_id	= util.secstr(REQUEST("admin_id"))
	admin_pwd 	= util.secstr(REQUEST("admin_pwd"))
	If admin_id = "" Then Call util.js_alert("아이디를 입력해 주세요", "")
	If admin_pwd = "" Then Call util.js_alert("패스워드를 입력해 주세요", "")

	AdminGrade	= REQUEST("AdminGrade")
	saveflag	= REQUEST("saveflag")
	login		= Request("login")

	if saveflag <> "" then 
		response.cookies("saveid") = admin_id
		response.cookies("saveid").expires=date+30
	else
		response.cookies("saveid") = ""
		response.cookies("saveid").expires=date
	end if
	
	If login = "webhard" Then ''웹하드 로그인 일경우
		strSQL = "select mpwd, mname, mgrade  from wizmembers where mid = '" & admin_id & "'"
		Set objRs = db.ExecSQLReturnRS(strSQL, paramInfo, DbConnect)
		If Not objRs.EOF Then
			If objRs("mpwd") <> admin_pwd Then
				Call util.js_alert("패스워드가 일치하지 않습니다.","")
			ElseIf objRs("mgrade") > 3 Then
				Call util.js_alert("사용권한이 없습니다.","")
			Else

				session("user_info")	= admin_id & "|"&admin_pwd&"|" & objRs("mname") & "|" & objRs("mgrade") & "|0"
				RESPONSE.REDIRECT "../util/webhard/Ftp.asp"
				Response.End()
			End If
		Else
			Call util.js_alert("아이디가 일치하지 않습니다.","")
		End If

	Else
		
		Set db = new database
		Dim paramInfo(3)	
		if AdminGrade = 1 then '관리자 로그인일 경우
			paramInfo(0) = db.MakeParam("@member", adVarChar, adParamInput,30, "root")
		elseif AdminGrade = 2 then '일반 로그인일경우
			paramInfo(0) = db.MakeParam("@member", adVarChar, adParamInput,30, "general")
		end if
		
		paramInfo(1) = db.MakeParam("@id", adVarChar, adParamInput,30, admin_id)
		paramInfo(2) = db.MakeParam("@pwd", adVarChar, adParamInput,30, admin_pwd)
		paramInfo(3) = db.MakeParam("@return_out", adInteger, adParamOutput,2, 1)	
		Set objRs = db.ExecSPReturnRS("getLogininfo", paramInfo, DbConnect)
		result = db.GetValue(paramInfo, "@return_out")
		Set objRs	= Nothing
		db.Dispose
		Set db		= nothing
		
		''Response.Write(result)
		''Response.End()

		if result = 1 then
			Call util.js_alert("아이디가 일치하지 않습니다.","")
		elseif result = 2 then
			Call util.js_alert("패스워드가 일치하지 않습니다..\n\n관리자에게 문의해 주세요","")		
		elseif result = 3 then
			Call util.js_alert("탈퇴된 회원입니다.\n\n관리자에게 문의해 주세요","")
		elseif result = 4 then
			Call util.js_alert("승인되지 않은 회원입니다.\n\n관리자에게 문의해 주세요","")
		elseif result = 0 then
			if AdminGrade = 1 then session("user_info")	= "admin|"&admin_pwd&"|관리자|0|0"
			RESPONSE.REDIRECT "main.asp?theme=front&menushow=menu0"
			Response.End()		
		end if
		Set util = Nothing
	End If
%>