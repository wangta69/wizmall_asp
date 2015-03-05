<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->

<%
dim fromlogin, loginflag1, loginflag2, loginflag3, loginflag4
fromlogin = Request("fromlogin")
loginflag1 = Request("loginflag1")
loginflag2 = Request("loginflag2")
loginflag3 = Request("loginflag3")
loginflag4 = Request("loginflag4")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<title>
<!--#include virtual="/inc/title.htm"-->
</title>
<style type="text/css">
*{margin:0; padding:0; border:0;}
body{background:#666666; margin:0; padding:10px; font-family:Arial, Helvetica, sans-serif; color:#666666;}
p{font-family:Arial, Helvetica, sans-serif; font-size:11px; line-height:1.6em;}
h1{color:#437bb3;}
div#wrap{width:490px; background-color:#fff; padding:10px;}
.exp{padding:5px 0;}
.box{text-align:center; background-color:#F0EFEF; padding:15px 0; margin-bottom:10px;}
.join{ height:20px; text-align:right; margin:0; padding:0; padding:5px 0;}
.join img{margin-left:10px;}
</style>
<script language="JavaScript">
<!--
function checkField(){
var f = document.loginForm;
	if(f.login_id.value == ""){
		alert('아이디를 입력해 주세요');
		f.login_id.focus();
		return false;
	}else if(f.login_pwd.value == ""){
		alert('패스워드를 입력해 주세요');
		f.login_pwd.focus();
		return false;
	}else{
		return true;
		//opener.name = new Date();
		//f.target = opener.name;
		//self.close();
	}
}
//-->
</script>
<script language="JavaScript" type="text/javascript">
<!-- JavaScript
function gourA() {
 window.opener.top.location.href = "/wizmember.asp?smode=regis_step1";
 self.close();
}
//-->
</script>
<script type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>
<body>
<div id="wrap">
  <h1>LOG IN</h1>
  <p class="exp">로그인을 하시면, 더 많은 정보를 얻을 수 있습니다.<br>
    회원이 아니실 경우 회원가입을 하신후 참여하실수 있습니다.</p>

  <div class="box">
    <table width="413" border="0" cellspacing="0" cellpadding="0">
<form name="loginForm" method="post" action="../log_check.asp" onSubmit="return checkField()">
<input type="hidden" name="fromlogin" value="<%=fromlogin%>">
<input type="hidden" name="loginflag1" value="<%=loginflag1%>">
<input type="hidden" name="loginflag2" value="<%=loginflag2%>">
<input type="hidden" name="loginflag3" value="<%=loginflag3%>">
<input type="hidden" name="loginflag4" value="<%=loginflag4%>">
<input type="hidden" name="frompopup" value="1">	 
      <tr>
        <td width="283"><table width="283" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="103"><img src="./images_pop/id_label.gif" width="103" height="24"></td>
              <td><input type="text" name="login_id" id="login_id" style="width:160px; height:22px; border:1px solid #d7d7d7;" tabindex="1">
              </td>
              <td width="20">&nbsp;</td>
            </tr>
            <tr>
              <td height="8"></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td><img src="./images_pop/pw_label.gif" width="103" height="24"></td>
              <td><input type="password" name="login_pwd" id="login_pwd" style="width:160px; height:22px; border:1px solid #d7d7d7;" tabindex="2"></td>
              <td>&nbsp;</td>
            </tr>
        </table></td>
        <td><input name="image" type="image" src="./images_pop/login_btn.gif" width="107" height="40" border="0"></td>
      </tr>
  </form>
    </table>
  </div>
  <p class="join">회원가입을 원하신다면, 다음의 회원가입 버튼을 눌러주세요.<a href="javascript:gourA();"><img src="./images_pop/join_btn.gif" border="0"></a></p>
  <p class="join">아이디나 비밀번호를 잊으셨나요?<a href="javascript:location.href='pop_idpasssearch.asp'"><img src="./images_pop/id_find_btn.gif"></a></p>
</div>
</body>
</html>
