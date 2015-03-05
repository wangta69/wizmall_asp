<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%

	if user_grade="" or  user_grade > 3 then
	
		response.redirect "../../webadmin/default.asp?login=webhard"
		
	end if
%>