<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<%
dim fromlogin, loginflag1, loginflag2, loginflag3, loginflag4
%>
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
	}else return true;
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td> <table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22" class="company">&nbsp;</td> 
          <td width="18" height="22" valign="middle"><img src="./skinwiz/cart/<%=CartSkin%>/images/sn_arrow.gif" width="13" height="13"></td> 
          <td height="22" class="company">Home &gt; <strong>주문서 작성</strong></td> 
        </tr> 
      </table> 
      <br> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td align="right"> <table width="98%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
              <tr> 
                <td width="80" bgcolor="#EEEEEE">- <strong>회원구매 :</strong> </td> 
                <td bgcolor="#EEEEEE">온라인 회원으로 가입하시면 회원들간 정부 공유는 물론, 각종 이벤트 참여 및 정보를 제공받으실 수 있습니다.</td> 
              </tr> 
            </table></td> 
        </tr> 
        <tr height="10"> 
          <td height="10" align="right"></td> 
        </tr> 
        <tr> 
          <td align="center"> <table width="564" border="0" cellpadding="0" cellspacing="0"> 
              <tr> 
                <td background="./skinwiz/cart/<%=CartSkin%>/images/bg_top.gif" height="16" colspan="3"></td> 
              </tr> 
              <tr> 
                <td width="16" background="./skinwiz/cart/<%=CartSkin%>/images/bg_left.gif">&nbsp;</td> 
                <td height="120" align="center"> <table width="531" border="0" cellpadding="0" cellspacing="0"> 
                    <tr> 
                      <td width="132"><img src="./skinwiz/cart/<%=CartSkin%>/images/img_logins.gif" width="146" height="119"></td> 
                      <td valign="bottom"> <table width="389" border="0" cellpadding="0" cellspacing="0"> 
<form name="loginForm" method="post" action="./wizmember/log_check.asp" onSubmit="return checkField()">
<input type="hidden" name="fromlogin" value="wizbag.asp">
<input type="hidden" name="loginflag1" value="step2">	
                            <tr height="1"> 
                              <td width="24"></td> 
                              <td colspan="3" bgcolor="D4D0C8"></td> 
                            </tr> 
                            <tr> 
                              <td width="24">&nbsp;</td> 
                              <td width="24"><img src="./skinwiz/cart/<%=CartSkin%>/images/img_id.gif" width="76" height="30"></td> 
                              <td width="165" align="center" bgcolor="F2F2F2"><input name="login_id" type="text" id="login_id" size="17" tabindex=1></td> 
                              <td width="176">&nbsp;</td> 
                            </tr> 
                            <tr height="1"> 
                              <td width="24"></td> 
                              <td colspan="3" bgcolor="D4D0C8"></td> 
                            </tr> 
                            <tr> 
                              <td width="24">&nbsp;</td> 
                              <td><img src="./skinwiz/cart/<%=CartSkin%>/images/img_pass.gif" width="76" height="30"></td> 
                              <td width="165" align="center" bgcolor="F2F2F2"><input name="login_pwd" type="password" id="login_pwd" size="17" tabindex=2></td> 
                              <td><input type="image" src="./skinwiz/cart/<%=CartSkin%>/images/but_login.gif" width="77" height="30" tabindex=3></td> 
                            </tr> 
                            <tr height="1"> 
                              <td width="24"></td> 
                              <td colspan="3" bgcolor="D4D0C8"></td> 
                            </tr> 
                            <tr> 
                              <td width="24">&nbsp;</td> 
                              <td>&nbsp;</td> 
                              <td height="35" bgcolor="F2F2F2">&nbsp;</td> 
                              <td>&nbsp;</td> 
                            </tr> 
                          </form> 
                        </table></td> 
                    </tr> 
                  </table></td> 
                <td width="16" background="./skinwiz/cart/<%=CartSkin%>/images/bg_left.gif">&nbsp;</td> 
              </tr> 
              <tr> 
                <td background="./skinwiz/cart/<%=CartSkin%>/images/bg_top.gif" height="16" colspan="3"></td> 
              </tr> 
            </table></td> 
        </tr> 
        <tr> 
          <td align="right">&nbsp;</td> 
        </tr> 
        <tr> 
          <td align="right"> <table width="98%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
              <tr> 
                <td width="85" bgcolor="#EEEEEE">- <strong>비회원구매 :</strong> </td> 
                <td bgcolor="#EEEEEE">비회원으로 구입하실 수 있습니다.<br> 
                  온라인 회원으로 가입하시면 각종 정보를 제공받으실 수 있습니다.</td> 
              </tr> 
            </table></td> 
        </tr> 
        <tr height="10"> 
          <td height="10" align="right"></td> 
        </tr> 
        <tr> 
          <td align="center"> <table width="564" border="0" cellpadding="0" cellspacing="0"> 
              <tr> 
                <td background="./skinwiz/cart/<%=CartSkin%>/images/bg_top.gif" height="16" colspan="3"></td> 
              </tr> 
              <tr> 
                <td width="16" background="./skinwiz/cart/<%=CartSkin%>/images/bg_left.gif">&nbsp;</td> 
                <td height="100" align="center"> <table width="500" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                    <tr> 
                      <td width="367" height="35">▣ 비회원으로 구매하시려면 아래의 확인 버튼을 눌러주세요.</td> 
                      <td width="101" height="35"><A HREF='./wizbag.asp?smode=step2'><img src="./skinwiz/cart/<%=CartSkin%>/images/but_ok2.gif" width="68" height="28" border="0"></a></td> 
                    </tr> 
                    <tr height="2"> 
                      <td background="./skinwiz/cart/<%=CartSkin%>/images/bg_right.gif" height="2" colspan="2"></td> 
                    </tr> 
                    <tr> 
                      <td height="35">▣ 회원으로 가입하신 후 주문하시면 다양한 혜택을 누릴 수 있습니다.</td> 
                      <td height="35"><A HREF='wizmember.asp?smode=regis_step1'><img src="./skinwiz/cart/<%=CartSkin%>/images/but_members.gif" width="87" height="29" border="0"></a></td> 
                    </tr> 
                    <tr height="2"> 
                      <td background="./skinwiz/cart/<%=CartSkin%>/images/bg_right.gif" height="2" colspan="2"></td> 
                    </tr> 
                  </table></td> 
                <td width="16" background="./skinwiz/cart/<%=CartSkin%>/images/bg_left.gif">&nbsp;</td> 
              </tr> 
              <tr> 
                <td background="./skinwiz/cart/<%=CartSkin%>/images/bg_top.gif" height="16" colspan="3"></td> 
              </tr> 
            </table></td> 
        </tr> 
      </table></td> 
  </tr> 
  <tr> 
    <td>&nbsp;</td> 
  </tr> 
  <tr> 
    <td>&nbsp;</td> 
  </tr> 
</table> 
