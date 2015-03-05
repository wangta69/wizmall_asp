<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
	Dim db,strSQL,objRs
	Dim query, menushow, theme, display_order, order
	Dim i, j
	''Dim util
	''Set util = new utility	
	Set db = new database

query				= Request("query")
menushow		= Request("menushow")
theme				= Request("theme")
display_order	= Request("display_order")
order					= split(display_order, ",")
if query = "qup" then    
	for i = 0 to ubound(order)
		j = i + 1
		strSQL = "update wizmall set userorder = " & j & "where uid = " & order(i)
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
    next 
	Response.Write( "<script>alert('순서를 변경하였습니다.');location.href ='../main.asp?menushow=" & menushow & "&theme=" & theme & "' ;</script>")
	Response.End()
end if
%>
