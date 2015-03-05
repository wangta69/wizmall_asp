<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../lib/cfg.board.asp" -->
<%
Dim reple_uid
reple_uid = Request("reple_uid")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="JavaScript">
<!--
function reple_del(){


}
//-->
</script>
<table width="300"  border="0" align="center" cellpadding="0" cellspacing="0" style="font-family: '굴림'; font-size: 9pt; color: #666666; line-height: 12pt">
  <form name="frm1" method="post" action="../../reple_delete.asp" onsubmit="return reple_del();">
    <input type="hidden" name="bid" value="<%=bid%>">
    <input type="hidden" name="gid" value="<%=gid%>">
    <input type="hidden" name="uid" value="<%=uid%>">
	<input type="hidden" name="reple_uid" value="<%=reple_uid%>">
    <tr> 
      <td background="<%=skin_path%>t_bg.gif" height="15"></td>
    </tr>
    <tr> 
      <td height="20" align="center"><strong>Delect Comment </strong></td>
    </tr>
    <tr> 
      <td bgcolor="#F7F7F7"> <table cellpadding="0" cellspacing="0" width="100%" style="font-family: '굴림'; font-size: 9pt; color: #666666; line-height: 12pt">
          <tr> 
            <td height="40"><p align="center">패스워드를 입력해 주시기 바랍니다.</p></td>
          </tr>
          <tr> 
            <td height="30" align="center">Password 
              <input name="passwd" type="password" class="input" size="14"></td>
          </tr>
          <tr> 
            <td height="45" align="center"><input type="submit" name="Submit" value="삭제"> 
              &nbsp; <input type="button" name="Submit2" value="닫기" onClick="window.close()" style="cursor:pointer"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td height="1" bgcolor="#000000"></td>
    </tr>
  </form>
</table>
</body>
</html>
