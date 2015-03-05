<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
dim query, db_id, db_pass
query = Request("query")
db_id = Request("db_id")
db_pass = Request("db_pass")
if query = "select" then
	if Db_Odbc_User <> db_id then 
		msg = "아이디가 일치하지 않습니다."
	elseif Db_Odbc_Pass <> db_pass then 
		msg = "패스워드가 일치하지 않습니다."
	else
		strSQL = "SELECT adminid, adminpwd FROM wiztable_main"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		msg = "아이디 : "&objRs("adminid")&", 패스워드 : "&objRs("adminpwd")
	end if
else
	msg = "아래 필드값을 채우시면 <br>관리자 아이디/패스워드를 찾을수 있습니다."
end if
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
</head>

<body>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
  <form name="PassFindForm" method="post" action="./findpass.asp">
    <input type="hidden" name="query" value="select">
    <tr> 
      <td colspan="2"><%=msg%></td>
    </tr>
    <tr> 
      <td>db_id</td>
      <td><input name="db_id" type="text" id="db_id"></td>
    </tr>
    <tr> 
      <td>db_pass</td>
      <td><input name="db_pass" type="text" id="db_pass"></td>
    </tr>
   <tr> 
      <td colspan="2"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
  </form>
</table>
</body>
</html>
