<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<%
	Dim login_id,login_pwd,rtnurl,fromlogin,loginflag1,loginflag2,loginflag3,loginflag4,frompopup,saveflag
	Dim strSQL, objRs, cmd, params, result
	Dim paramInfo(3)
	Dim db,util
	Set util = new utility	
	Set db = new database



	login_id 	= util.secstr(Request("login_id"))
	login_pwd 	= util.secstr(Request("login_pwd"))
	If login_id = "" Then Call util.js_alert("아이디를 입력해 주세요", "")
	If login_pwd = "" Then Call util.js_alert("패스워드를 입력해 주세요", "")

	rtnurl		= Request("rtnurl")
	fromlogin	= Request("fromlogin")
	loginflag1	= Request("loginflag1")
	loginflag2	= Request("loginflag2")
	loginflag3	= Request("loginflag3")
	loginflag4	= Request("loginflag4")
	frompopup	= Request("frompopup")
	saveflag		= Request("saveflag")
	
	if saveflag <> "" then 
		response.cookies("saveid") = login_id
		response.cookies("saveid").expires=date+30
	else
		response.cookies("saveid") = ""
		response.cookies("saveid").expires=date
	end if
	
	
	
	paramInfo(0) = db.MakeParam("@member", adVarChar, adParamInput,30, "general")
	paramInfo(1) = db.MakeParam("@id", adVarChar, adParamInput,30, login_id)
	paramInfo(2) = db.MakeParam("@pwd", adVarChar, adParamInput,30, login_pwd)
	paramInfo(3) = db.MakeParam("@return_out", adInteger, adParamOutput,2, 1)

	Set objRs = db.ExecSPReturnRS("getLogininfo", paramInfo, DbConnect)
	result = db.GetValue(paramInfo, "@return_out")
	
	

	if result = 1 then
		Call util.js_alert("아이디가 일치하지 않습니다.","")
	elseif result = 2 then
		Call util.js_alert("패스워드가 일치하지 않습니다..\n\n관리자에게 문의해 주세요","")		
	elseif result = 3 then
		Call util.js_alert("탈퇴된 회원입니다.\n\n관리자에게 문의해 주세요","")
	elseif result = 4 then
		Call util.js_alert("승인되지 않은 회원입니다.\n\n관리자에게 문의해 주세요","")
	elseif result = 0 Then
		session("user_info")	= objRs("mid")&"|"&objRs("mpwd")&"|"&objRs("mname")&"|"&objRs("mgrade")&"|"&objRs("mpoint")
		''멤버 패스워드를 세션에 가져가는 것은 위험함
			''wizboard/functon.asp에서 분리하여 사용 추후 이방식으로 솔루션 변경
		''장바구니 아이디가 있을 경우 현재 장바구니도 업데이트(비회원 -> 회원 코드) 한다.
		If session("CART_CODE") <> "" Then
			strSQL = "update wizcart set user_id = '" & objRs("mid") & "' where oid = '" & session("CART_CODE") & "'"
			''db.ExecSQL(objRs)
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		End If
	end If
	
	db.Dispose : Set db = nothing
	Set objRs	= Nothing
	
	if frompopup = "1" then
		Call util.js_location("", "close_reload")
	elseif rtnurl <> "" then
		Response.Redirect(rtnurl)		
	elseif fromlogin = "wizboard.asp" then
		Response.Redirect("../"&fromlogin&"?gid="&loginflag1&"&bid="&loginflag2&"&category="&loginflag3&"&adminmode="&loginflag4)
	elseif fromlogin = "wizbag.asp" then
		Response.Redirect("../"&fromlogin&"?smode="&loginflag1)
	elseif fromlogin = "wizmember.asp" then
		Response.Redirect("../"&fromlogin&"?smode="&loginflag1)
		Response.end()
	elseif fromlogin <> "" Then ''fromlogin=<% Response.Write Request.ServerVariables("path_info")&"?"&server.Urlencode(Request.ServerVariables("QUERY_STRING"))
		Response.Redirect(fromlogin) 
	else  	
		Call util.js_alert("로그인 되셨습니다\n\n즐거운 하루 되시기를 바랍니다", "../")
	end if	
	
%>
