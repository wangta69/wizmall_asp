<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<%
dim fromlogin, loginflag1, loginflag2, loginflag3, loginflag4, gid, bid
'' 점차적으로rtnurl 로 변경처리
rtnurl			= Request("rtnurl")
fromlogin		= Request("fromlogin")
loginflag1	= Request("loginflag1")
loginflag2	= Request("loginflag2")
loginflag3	= Request("loginflag3")
loginflag4	= Request("loginflag4")
%>
<script language="JavaScript">
<!--
function CheckForm(f){
	if(autoCheckForm(f)){
		return true;
	}else return false;
}
//-->
</script>
<%
if fromlogin <> "wizboard.asp" Then
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="40" valign="top"> <table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22" class="company">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="./wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22" class="company">Home &gt; 로그인</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr> 
          <td bgcolor="#EEEEEE">- 온라인 회원으로 가입하시면 회원들간 정보 공유는 물론, 각종 이벤트 참여 및 정보제공을<br> 
            &nbsp;&nbsp; 받으실 수 있습니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center"><%
end if ''if fromlogin <> "wizboard.asp" Then
%>   <form name="loginForm" method="post" action="./wizmember/log_check.asp" onSubmit="return CheckForm(this)">
<input type="hidden" name="rtnurl" value="<%=rtnurl%>">
<input type="hidden" name="fromlogin" value="<%=fromlogin%>">
<input type="hidden" name="loginflag1" value="<%=loginflag1%>">
<input type="hidden" name="loginflag2" value="<%=loginflag2%>">
<input type="hidden" name="loginflag3" value="<%=loginflag3%>">
<input type="hidden" name="loginflag4" value="<%=loginflag4%>">	<table width="95%" border="0" cellspacing="0" cellpadding="0">

          <!-- 기타쿼리값 : 예, smode, qry, -->
          <tr> 
            <td align="center">&nbsp;</td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
          </tr>
          <tr> 
            <td align="center"> <table width="564" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td background="./wizmember/<%=MemberSkin%>/images/bg_top.gif" height="16" colspan="3"></td>
                </tr>
                <tr> 
                  <td width="16" background="./wizmember/<%=MemberSkin%>/images/bg_left.gif">&nbsp;</td>
                  <td height="120" align="center"> <table width="531" border="0" cellpadding="0" cellspacing="0">
                      <tr> 
                        <td width="132"><img src="" width="146" height="119"></td>
                        <td valign="bottom"> <table width="389" border="0" cellpadding="0" cellspacing="0">
                            <tr height="1"> 
                              <td width="24"></td>
                              <td colspan="3" bgcolor="D4D0C8"></td>
                            </tr>
                            <tr> 
                              <td width="24">&nbsp;</td>
                              <td width="24"><img src="./wizmember/<%=MemberSkin%>/images/img_id.gif" width="76" height="30"></td>
                              <td width="165" align="center" bgcolor="F2F2F2"><input name="login_id" type="text" size="17"></td>
                              <td width="176">&nbsp;</td>
                            </tr>
                            <tr height="1"> 
                              <td width="24"></td>
                              <td colspan="3" bgcolor="D4D0C8"></td>
                            </tr>
                            <tr> 
                              <td width="24">&nbsp;</td>
                              <td><img src="./wizmember/<%=MemberSkin%>/images/img_pass.gif" width="76" height="30"></td>
                              <td width="165" align="center" bgcolor="F2F2F2"><input name="login_pwd" type="password" size="17"></td>
                              <td><input name="image" type=image tabindex=3 src="./wizmember/<%=MemberSkin%>/images/but_login.gif" width="77" height="30"></td>
                            </tr>
                            <tr height="1"> 
                              <td width="24"></td>
                              <td colspan="3" bgcolor="D4D0C8"></td>
                            </tr>
                            <tr> 
                              <td width="24">&nbsp;</td>
                              <td>&nbsp;</td>
                              <td bgcolor="F2F2F2"><a href="./wizmember.asp?smode=idpasssearch"><img src="./wizmember/<%=MemberSkin%>/images/but_idpass.gif" width="165" height="18" border="0"></a></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="24">&nbsp;</td>
                              <td>&nbsp;</td>
                              <td bgcolor="F2F2F2"><a href="./wizmember.asp?smode=regis_step1"><img src="./wizmember/<%=MemberSkin%>/images/but_member.gif" width="165" height="18" border="0"></a></td>
                              <td>&nbsp;</td>
                            </tr>
                          </table></td>
                      </tr>
                    </table></td>
                  <td width="16" background="./wizmember/<%=MemberSkin%>/images/bg_left.gif">&nbsp;</td>
                </tr>
                <tr> 
                  <td background="./wizmember/<%=MemberSkin%>/images/bg_top.gif" height="16" colspan="3"></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
          </tr>
       
      </table> </FORM><%
if fromlogin <> "wizboard.asp" Then
%> </td>
  </tr>
  <!----------------------------------------- 로그인(성인인증제외)끝 --------------------->
<% 
if loginflag1 = "order" then'' 비회원 주문배송조회
%>
  <!----------------------------------------------------------------------------------------->
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr> 
          <td bgcolor="#EEEEEE">- 비회원으로 주문하신 고객께서는 주문번호를 입력하시면 주문/배송조회를 하실 수 있습니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr height="10"> 
          <td height="10" align="right"></td>
        </tr>
        <tr> 
          <td align="center"> <table width="564" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td background="./wizmember/<%=MemberSkin%>/images/bg_top.gif" height="16" colspan="3"></td>
              </tr>
              <tr> 
                <td width="16" background="./wizmember/<%=MemberSkin%>/images/bg_left.gif">&nbsp;</td>
                <td height="50" align="center"> <table width="363" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <FORM ACTION='./wizmember.asp'>
                      <INPUT TYPE=HIDDEN NAME=smode VALUE='non_member_order'>
                      <tr> 
                        <td width="81" height="35">▣ 주문번호</td>
                        <td width="4" height="35">:</td>
                        <td width="162" align="center"> <input name="codevalue" type="text" class="form" size="20"> 
                        </td>
                        <td width="84" align="center"><input name="image2" type=image src="./wizmember/<%=MemberSkin%>/images/but_ok2.gif" width="68" height="28"></td>
                      </tr>
                    </form>
                  </table></td>
                <td width="16" background="./wizmember/<%=MemberSkin%>/images/bg_left.gif">&nbsp;</td>
              </tr>
              <tr> 
                <td background="./wizmember/<%=MemberSkin%>/images/bg_top.gif" height="16" colspan="3"></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>

  <!----------------------------------------------------------------------------------------->
<%
end if 
%>
    <tr> 
    <td align="center">&nbsp;</td>
  </tr>
  <tr> 
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
</table>
<% end if ''if fromlogin <> "wizboard.asp" Then
%>
