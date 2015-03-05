<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/JSON_2.0.4.asp" -->
<!-- #include file = "../../lib/JSON_UTIL_0.1.1.asp" -->
<%
Dim step,flag,cate,form,length,Loopcnt
Dim orderby, whereis,str,target
Dim strSQL,objRs
Dim db,util
Dim cat_name, cat_value
Dim jsa
''Set util = new utility	
Set db = new database

step	= Request("step")
flag	= Request("flag")
if flag = "" then flag = "wizmall" end if
cate	= Request("cate")
form	= Request("form")

orderby		= " ORDER BY cat_order ASC"
if step = "1" then
	whereis = "where cat_flag = '" & flag & "' and LEN(cat_no) = 6 and Right(cat_no, 3) = '"&Right(cate,3)&"'"
elseif step = "2" then
	whereis = "where cat_flag = '" & flag & "' and LEN(cat_no) = 9 and Right(cat_no, 6) = '"&Right(cate,6)&"'"
end if

strSQL = "select cat_no, cat_name from wizCategory " & whereis & orderby
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
Set jsa = jsArray()
Set jsa(Null) = jsObject()
while not objRs.eof
	cat_name	= objRs("cat_name")
	cat_value	= objRs("cat_no")
	jsa(Null)(cat_value) = cat_name
objRs.movenext
wend
jsa.Flush 
%>
