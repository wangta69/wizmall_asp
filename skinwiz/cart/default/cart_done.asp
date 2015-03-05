<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file="../../../config/skin_info.asp" -->

<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim codevalue, mailpath
''Dim strSQL,objRs
''Dim db,util
''Set util = new utility	
''Set db = new database


''이곳에서 주문완료 메일을 보내다. 
codevalue				= Request("codevalue")
session("tmpcodevalue")	= codevalue
mailpath				= "skinwiz/cart/"&CartSkin&"/img_ordermail/orderqry.asp"
SERVER.EXECUTE(mailpath)
%>
<table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
  <tr bgcolor="#F6F6F6">
    <td width="15" height="22" class="company">&nbsp;</td>
    <td width="18" height="22" valign="middle"><img src="./skinwiz/cart/<%=CartSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
    <td height="22" class="company">Home &gt; <strong>결재완료</strong></td>
  </tr>
</table>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="564" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td background="img/member/bg_top.gif" height="16" colspan="3"></td>
        </tr>
        <tr>
          <td width="16" background="img/member/bg_left.gif">&nbsp;</td>
          <td align="center"><table width="531" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="132"><img src="./skinwiz/cart/<%=CartSkin%>/images/img_orderend.gif" width="181" height="171"></td>
                <td height="172"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="399" style="font-family:굴림,Verdana,Arial; font-size:15pt; font-style: normal; line-height: 20pt; font-weight: bolder; color: #000000";><font color="#FF6600">주문이 
                        완료</font>되었습니다.<br>
                        <br>
                      </td>
                    </tr>
                    <tr>
                      <td style="font-family:굴림,Verdana,Arial; font-size:9pt; font-style: normal; font-weight: bold; color: #666666";>- 
                        저희 쇼핑몰을 이용해 주셔서 감사합니다.</td>
                    </tr>
                    <tr>
                      <td style="font-family:굴림,Verdana,Arial; font-size:9pt; font-style: normal; font-weight: bold; color: #666666";>- 주문하신 내용이 정상적으로 처리되었습니다.</td>
                    </tr>
                    <tr>
                      <td style="font-family:굴림,Verdana,Arial; font-size:9pt; font-style: normal; font-weight: bold; color: #666666";>&nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
          <td width="16" background="img/member/bg_left.gif">&nbsp;</td>
        </tr>
        <tr>
          <td background="img/member/bg_top.gif" height="16" colspan="3"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="right"><table width="564" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="36" align="center" valign="bottom"><table width="200" height="42" border="0" cellpadding="0" cellspacing="0">
              <tr align="center">
                <td><a href="./"><img src="./skinwiz/cart/<%=CartSkin%>/images/but_ok2.gif" width="68" height="28" border="0"></a></td>
              </tr>
            </table>
            <br>
          </td>
        </tr>
      </table></td>
  </tr>
</table>
