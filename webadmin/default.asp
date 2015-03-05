<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<%
Dim db,util
Dim login
Set util = new utility	
''Set db = new database
if user_id = "admin" and user_grade = 0 then
	Call util.js_location("./main.asp?theme=front&menushow=menu0", "")
Else

login = Request("login")
%>
<html>
<head>
<title>[관리자 페이지]</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="javascript" type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../js/admin.js"></script>
<link rel="stylesheet" href="../css/admin.css" type="text/css">
</head>
<script language=javascript>
<!--
function loginForm() {
        var f=document.ADMIN_LOG;
        if ( !f.admin_id.value.length ) {
        alert('\n아이디를 입력해 주십시오. \n');
		f.admin_id.focus();
        return false;
		}else if ( !f.admin_pwd.value.length ) {
        alert('\n패스워드를 입력해 주십시오. \n');
		f.admin_pwd.focus();
        return false;
        }
}
//-->
</script> 
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="javascript:ADMIN_LOG.admin_id.focus()";>
<script language="JavaScript" src="http://www.shop-wiz.com/register_check.js"></script>
<FORM ACTION='./admin_log_check.asp' METHOD='POST' NAME='ADMIN_LOG' onsubmit='return loginForm();'>	 
<input type="hidden" name="login" value="<%=login%>">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="middle"><table width="552" border="0" height="254" cellpadding="0" cellspacing="0" align="center">
 	
  <tr> 
          <td width="552" height="82" valign="bottom" background="./img/log01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="text-admin">
              <tr>
                <td align="center"><input name="AdminGrade" type="radio" value="1" checked>
                    관리자 
                   <!--<input type="radio" name="AdminGrade" value="2">
                    일반 --></td>
              </tr>
            </table></td>
  </tr>
  <tr>
    <td>
      <table width="552" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="./img/log02.gif" width="177" height="78"></td>
          <td width="242" height="78" background="./img/logbg.gif">
            <table width="242" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="48"><img src="./img/id.gif" width="28" height="18"></td>
                <td width="194"><font color="#333333">
                  <input size=20 name="admin_id" class="dd1" tabindex=1>
                  </td>
              </tr>
              <tr>
                <td width="48"><img src="./img/pw.gif" width="28" height="20"></td>
                <td width="194"><font color="#333333">
                  <input name="admin_pwd" type="password" class="dd1" tabindex=2 size=20>
                  </td>
              </tr>
            </table>
          </td>
          <td><input type="image" src="./img/log04.gif" width="89" height="78" tabindex=3></td>
          <td><img src="./img/log05.gif" width="44" height="78"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><img src="./img/log06.gif" width="552" height="94"></td>
  </tr>
</table><table width="552" align="center" cellpadding="0" cellspacing="0" class="text-admin">

  <tr> 

          <td width="1102"> <p>* &nbsp;이곳은 관리자 영역입니다.<br>
              * &nbsp;관리자외에 접근할 수 없도록 비밀번호관리를 잘 하여주시기 바랍니다.<br>
              * &nbsp;<a href="../">홈으로 돌아가기</a></p></td>

  </tr>

</table>
</td>
  </tr>
</table></form>
</body>
</html>
<%
	END IF
%>