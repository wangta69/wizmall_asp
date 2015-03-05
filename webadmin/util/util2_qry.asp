<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../util/wizdiary/schedule/cal_logic.asp"-->
<!-- #include file = "../../util/wizdiary/schedule/lunartosol.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim menushow,theme,query,page,F_Year,F_Month,F_Day,cc_id,m_id,cc_m_name,cc_Title,cc_Desc,cc_m_id,cc_sDate

Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database


menushow	= Request("menushow")
theme		= Request("theme")
query		= Request("query")
page		= Request("page")	: If page = "" then page = 1
F_Year		= Request("F_Year")
F_Month		= Request("F_Month")
F_Day		= Request("F_Day")
cc_id		= Request("cc_id")
m_id		= Request("m_id")
cc_m_name	= Request("cc_m_name")
cc_Title	= Request("cc_Title")
cc_Desc		= Request("cc_Desc")
if m_id <> "" then
	cc_m_id		= m_id
else
	cc_m_id		= user_id
end if
cc_sDate	= F_Year&"-"&F_Month&"-"&F_Day


if query = "qin" then
	strSQL = "insert into wizDiary (cc_m_id,cc_m_name,cc_Title,cc_Desc,cc_sDate) values('"&cc_m_id&"','"&cc_m_name&"','"&cc_Title&"','"&cc_Desc&"','"&cc_sDate&"')"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
elseif query = "qup" then
	strSQL = "update wizDiary set cc_m_name='"&cc_m_name&"',cc_Title='"&cc_Title&"',cc_Desc='"&cc_Desc&"' where cc_id = '"&cc_id&"' and cc_m_id = '"&cc_m_id&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
elseif query = "qde" then
	strSQL = "delete wizDiary where cc_id = '"&cc_id&"' and cc_m_id = '"&cc_m_id&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
end if

Response.Redirect("./main.asp?menushow="&menushow&"&theme=util/util2&m_id=" & m_id & "&d=d&F_Year="&F_Year&"&F_Month="&F_Month)
%>
