<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
	Dim db,strSQL,objRs
	''Dim util
	''Set util = new utility	
	Set db = new database

query			= Request("query")
menushow		= Request("menushow")
theme			= Request("theme")
category		= Request("category")
display_order	= Request("display_order")
db				= split(display_order, ",")
if query = "up" then    
	for i = 0 to ubound(db)
		j = i + 1
		strSQL = "update wizcategory set cat_order = " & j & "where uid = " & db(i)
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
    next 
	 
	Response.Write( "<script>alert('순서를 변경하였습니다.');location.href ='../main.asp?menushow=" & menushow & "&theme=" & theme & "&category=" & category & "' ;</script>")
	Response.End()
end if
%>
