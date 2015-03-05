<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim query,uid,page,iid,theme,menushow
Dim BOARD_NAME,list_att,attached, filename, filepath, Loopcnt
Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database

query		= Request("query")
uid			= Request("uid")
page		= Request("page")
iid			= Request("iid")
theme		= Request("theme")
menushow	= Request("menushow")
BOARD_NAME	= "wizInquire"
if query = "qde" then
	

	''첨부화일 정보를 가져온다.
	strSQL="select attached FROM "&BOARD_NAME&" WHERE uid='"&uid&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		list_att = objRs("attached")
	attached = split(list_att, "|")
	filepath = PATH_SYSTEM & "config\wizinquire\"
	for Loopcnt=0 to Ubound(attached)
		filename = attached(Loopcnt)
		Call util.FileDelete(filepath, filename)
	next
	
	''****** 테이블로 부터 정보 삭제 *********/
	'' 
	strSQL="DELETE FROM "&BOARD_NAME&" WHERE uid='"&uid&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)

	response.Write"<script>alert('삭제했습니다.');opener.location.replace('../main.asp?menushow="&menushow&"&theme=inquire/inquire1&IID="&IID&"&page="&page&"');self.close();</script>"
	Response.End()
end if
Set util = Nothing : db.Dispose : Set db = Nothing : Set objRs = Nothing
%>
<head>
<title>글 삭제</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<body>
<center>
  <table border=0 style=font-family:'굴림';font-size:12px;line-height:20px;color:#333333>
    <form name=xx action="inquire_del.asp" method=post>
      <input type='hidden' name='query' value='qde'>
      <input type='hidden' name='uid' value='<%=uid%>'>
      <input type='hidden' name='page' value='<%=page%>'>
      <input type='hidden' name='IID' value='<%=IID%>'>
      <input type='hidden' name='theme' value='<%=theme%>'>
      <input type='hidden' name='menushow' value='<%=menushow%>'>
      <tr>
        <td colspan="2" bgcolor="#EEF7FF" height="25" align="center"><p>삭제된 데이트는 복구되지 않습니다. </p>
          <p>삭제하시겠습니까?</p></td>
      </tr>
      <tr>
        <td colspan="2" align="center" bgcolor="#EEF7FF" height="25"><input type="submit" value="예" name="Submit">
          <input type="button" value="아니요" onClick="window.close()" name="button">
        </td>
      </tr>
    </form>
  </table>
</center>
