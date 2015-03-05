<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim qry,ONLINE_ENABLE,ZIRO_LIST,CARD_ENABLE,PG_PACK,CARD_ID,CARD_PASS,CARD_ENABLE_MONEY
Dim PHONE_ENABLE,AUTOBANKING_ENABLE,POINT_ENABLE,POINT_ENABLE_MONEY,TACKBAE_MONEY,TACKBAE_CUTLINE,TACKBAE_ALL

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

qry					= Request("qry")
ONLINE_ENABLE		= Request("ONLINE_ENABLE")
ZIRO_LIST			= Request("ZIRO_LIST")
CARD_ENABLE			= Request("CARD_ENABLE")
PG_PACK				= Request("PG_PACK")
CARD_ID				= Request("CARD_ID")
CARD_PASS			= Request("CARD_PASS")
CARD_ENABLE_MONEY	= Request("CARD_ENABLE_MONEY")
PHONE_ENABLE		= Request("PHONE_ENABLE")
AUTOBANKING_ENABLE	= Request("AUTOBANKING_ENABLE")
POINT_ENABLE		= Request("POINT_ENABLE")
POINT_ENABLE_MONEY	= Request("POINT_ENABLE_MONEY")
TACKBAE_MONEY		= Request("TACKBAE_MONEY")
TACKBAE_CUTLINE		= Request("TACKBAE_CUTLINE")
TACKBAE_ALL			= Request("TACKBAE_ALL")

if qry = "pay_write" then
	Call util.makeFile_cartInfo()
    Call util.makeFile_bankInfo()
end if

Response.Redirect("../main.asp?menushow=menu1&theme=basicinfo/basic_info3")
%>
