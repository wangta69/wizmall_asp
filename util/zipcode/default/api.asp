<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../lib/JSON_2.0.4.asp" -->
<!-- #include file = "../../../lib/JSON_UTIL_0.1.1.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim sel_db, jsa, cat_name, cat_value
sel_db = Request("sido")

''strSQL = "select * from zipcode where dong like '%" & keyword & "%' order by sido asc, gugun asc"
strSQL = "select distinct(sigungu) from " & sel_db & " order by sigungu asc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
Set jsa = jsArray()
Set jsa(Null) = jsObject()
while not objRs.eof
	cat_name	= objRs("sigungu")
	cat_value	= objRs("sigungu")
	jsa(Null)(cat_value) = cat_name

objRs.MOVENEXT
Wend
jsa.Flush 
SET objRs =Nothing

''echo json_encode($rows);
%>