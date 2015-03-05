<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->

<%
' powered by 숍위즈
'Reference URL : http://www.shop-wiz.com
'Contact Email : master@shop-wiz.com
'Free Distributer : 
'Copyright shop-wiz.com
'*** Updating List ***

Dim qry, page, uid
Dim db, util, objRs, strSQL
Set util = new utility	
Set db = new database



Dim table_name : table_name = "wizmall_product_qna"

	qry							= Request("qry")
	page						= Request("page")
	uid							= Request("uid")

	Select Case qry
	
		Case "qna_del"

			strSQL = "delete from wizmall_product_qna where uid = " & uid
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		Case "review_del"
			strSQL = "delete from wizmall_comment where uid = " & uid
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
	End Select

	db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
