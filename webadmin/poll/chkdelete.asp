<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
	Dim strSQL,objRs
	Dim db,util
	Set util = new utility	
	Set db = new database

	chk			= request("chk")
	menushow	= request("menushow")
	theme		= request("theme")
	
	if chk = "" then
   		
   		Response.Write "<script language=javascript>"
    		Response.Write "alert('체크박스를 선택해 주세요!');"
    		Response.Write "history.back();"
    		Response.Write "</script>"		
		Response.End  
	
	end if 
   	
   	prevParam = true
	for each key in request.form("chk")
		if prevParam = true then
			domain = "'" & key & "'"
			prevParam = false
		else
			domain = domain & ",'" & key & "'"
		end if
	next
	
	'항시 먼져 설문항목을 삭제하기 이전에 그것에 달려있는 평가 기록을 먼져 지워준다..안그러면..데이터부하..
	strSQL = "DELETE FROM wizpoll_value WHERE pv_p_no IN (" & domain & ")"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	'지웠으면,실제 설문항목 살제..
	strSQL = "DELETE FROM wizpoll WHERE p_idx_no IN (" & domain & ")"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)

	response.redirect "./main.asp?menushow="&memushow&"&theme=poll/poll_list"
   	
%>
