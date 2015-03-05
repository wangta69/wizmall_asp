<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->


<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''Dim strSQL,objRs
Dim db,util
Set util	= new utility	
''Set db	= new database
Dim qry,menushow,theme,LayoutSkin,MainSkin,MenuSkin,ShopSkin,IconSkin,ListNo,PageNo,SubListNo
Dim DefaultOrder,ViewerSkin,GoodsDisplayEstim,GoodsDisplayPid,CartSkin,CoorBuySkin,MemberSkin
Dim SearchSkin,WishSkin,ZipCodeSkin,HtmlSkin


qry					= Request("qry")
menushow			= Request("menushow")
theme				= Request("theme")
LayoutSkin			= Request("LayoutSkin")
MainSkin			= Request("MainSkin")
MenuSkin			= Request("MenuSkin")
ShopSkin			= Request("ShopSkin")
IconSkin			= Request("IconSkin")
ListNo				= Request("ListNo")
PageNo				= Request("PageNo")
SubListNo			= Request("SubListNo")
DefaultOrder		= Request("DefaultOrder")
ViewerSkin			= Request("ViewerSkin")
GoodsDisplayEstim	= Request("GoodsDisplayEstim")
GoodsDisplayPid		= Request("GoodsDisplayPid")
CartSkin			= Request("CartSkin")
CoorBuySkin			= Request("CoorBuySkin")
MemberSkin			= Request("MemberSkin")
SearchSkin			= Request("SearchSkin")
WishSkin			= Request("WishSkin")
ZipCodeSkin			= Request("ZipCodeSkin")
HtmlSkin			= Request("HtmlSkin")
if qry = "qup" then Call util.makeFile_skinInfo()

Set util = Nothing

	Response.Redirect("../main.asp?menushow="&menushow&"&theme="&theme)
%>
