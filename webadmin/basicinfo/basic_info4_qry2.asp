<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->

<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim CAT_SKIN,CAT_SKIN_VIEWER,uid,menushow

Dim db,strSQL,objRs
Dim util
''Set util = new utility	
Set db = new database

CAT_SKIN		= Request("CAT_SKIN")
CAT_SKIN_VIEWER	= Request("CAT_SKIN_VIEWER")
uid				= Request("uid")
menushow		= Request("menushow")
strSQL = "update wizcategory set cat_skin = '"&CAT_SKIN&"', cat_skin_viewer = '"&CAT_SKIN_VIEWER&"' where uid = '"&uid&"'"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

db.Dispose : Set db = Nothing

Response.Redirect("./main.asp?menushow=" & menushow & "&theme=basicinfo/basic_info4")
	
%>
