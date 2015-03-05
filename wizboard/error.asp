<!-- #include file = "../lib/cfg.common.asp" -->
<%
	Dim msg
	msg = replace(request("msg"),"n","<br>")
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel=StyleSheet HREF=../Library/style.css type=text/css title=style>
<title>위즈보드 경고 메시지</title>
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      <table border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
        <tr>
          <td><table width="300"  border="0" cellpadding="1" cellspacing="1">
      <tr>
          <td height="25" align="center" bgcolor="#000000"><span class="style1">에러가 발생하였습니다</span></td>
      </tr>
      <tr>
        <td height="130" align="center" bgcolor="#FFFFFF" style="font-size:12px; padding:5 5 5 5"><p><%=msg%></p>
          <p>
            <input type="button" name="Submit" value="확      인" OnClick="history.back(-1);" style="font-size:9pt;">
          </p></td>
      </tr>
    </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
