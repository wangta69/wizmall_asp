<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim step,flag,trigger,form,length,Loopcnt
Dim orderby, whereis,str,target
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database

step	= Request("step")
flag	= Request("flag")
trigger	= Request("trigger")
form	= Request("form")

orderby		= " ORDER BY cat_order ASC"

if step = "1" then
	whereis = "where cat_flag = '" & flag & "' and LEN(cat_no) = 6 and Right(cat_no, 3) = '"&Right(trigger,3)&"'"
	strSQL = "select cat_no, cat_name, (select count(1) from wizCategory " & whereis & " ) as tcount from wizCategory " & whereis & orderby
	str = "중분류"
	target = "category2"
	''Response.Write(strSQL)
elseif step = "2" then
	whereis = "where cat_flag = '" & flag & "' and LEN(cat_no) = 9 and Right(cat_no, 6) = '"&Right(trigger,6)&"'"
	strSQL = "select cat_no, cat_name, (select count(1) from wizCategory " & whereis & " ) as tcount from wizCategory " & whereis & orderby
	str = "소분류"
	target = "category3"
end if
''Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
if not objRs.eof then
	length = objRs("tcount")+1
		Response.Write "document.forms['" & form & "'].elements['" & target & "'].length = " & length & ";" & Chr(13)&Chr(10)
		Response.Write "document.forms['" & form & "'].elements['" & target & "'].options[0].text = '" & str & "';" & Chr(13)&Chr(10)
		Response.Write "document.forms['" & form & "'].elements['" & target & "'].options[0].value = '';" & Chr(13)&Chr(10)
		
	Loopcnt=1
	while not objRs.eof
		Response.Write "document.forms['" & form & "'].elements['" & target & "'].options[" & Loopcnt & "].text = '" & objRs("cat_name") & "';" & Chr(13)&Chr(10)
		Response.Write "document.forms['" & form & "'].elements['" & target & "'].options[" & Loopcnt & "].value = '" & objRs("cat_no") & "';" & Chr(13)&Chr(10)
	Loopcnt=Loopcnt+1
	objRs.movenext
	wend
	Response.Write "document.forms['" & form & "'].elements['" & target & "'].options[0].selected = true;" & Chr(13)&Chr(10)
else
	if step = "1" then
		Call resetField(form, "category2", "중분류")
	elseif step = "2" then
		Call resetField(form, "category3", "소분류")
	end if
end if

Function resetField(form,claretarget,targetstr)
	Response.Write "document.forms['"&form&"'].elements['"&claretarget&"'].length = 1;" & Chr(13)&Chr(10)
	Response.Write "document.forms['"&form&"'].elements['"&claretarget&"'].options[0].text = '" & targetstr & "';" & Chr(13)&Chr(10)
	Response.Write "document.forms['"&form&"'].elements['"&claretarget&"'].options[0].value = '';" & Chr(13)&Chr(10)
END Function	
%>
