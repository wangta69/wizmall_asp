<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../lib/class.cart.asp" -->
<%
Dim strSQL,objRs
Dim db,util,cart
''Set util = new utility	
''Set db = new database
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
          <tr bgcolor="#F6F6F6">
            <td width="15" height="22" class="company">&nbsp;</td>
            <td width="18" height="22" valign="middle"><img src="./skinwiz/cart/<%=CartSkin%>/images/sn_arrow.gif" width="13" height="13" /></td>
            <td height="22" class="company">Home &gt; <strong>장바구니</strong></td>
          </tr>
        </table>
              <br />
        </td>
      </tr>
      <tr>
        <td valign="middle" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="15">&nbsp;</td>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="988" align="center"><table width="95%" height="67" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial'; font-size: 12px; color:#666666; line-height:140%;">
                  <tr>
                    <td width="96%" bgcolor="EEEEEE"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                      <tr>
                        <td width="140" valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">. <strong>고객님의
                            선택상품</strong></td>
                        <td width="10" valign="top">|</td>
                        <td width="519">상품 수량을 조정하시면 각 상품별 소계 금액과 총액 금액이 자동으로
                          계산됩니다.<br />
                          모드 선택이 끝나셨으면 <font color="#FF6633">&quot;바로 구매하기&quot;</font>를
                          클릭해 주세요.<br />
                          다른 상품을 더 구매하시려면 <font color="#6666FF">&quot;쇼핑 계속하기&quot;</font>를
                          클릭해 주세요</td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
            </table>
                    <br />
            </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="right">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" bgcolor="#FFFFFF"><!-- inner start -->
              <!-- #include file = "./cart_view.asp" -->
              <table width='100%' cellspacing=0 cellpadding=0 border=0>
                <tr>
                  <td align=CENTER><a href='./skinwiz/cart/cart_query.asp?smode=trash' onclick="return really();"><img src='./skinwiz/cart/<%=CartSkin%>/images/but_draw.gif' border=0 /></a> <a href='./'><img src='./skinwiz/cart/<%=CartSkin%>/images/but_shopping.gif' border=0 /></a> <a href='./wizbag.asp?smode=step1'><img src='./skinwiz/cart/<%=CartSkin%>/images/but_member.gif' border=0 /></a> <a href='./wizbag.asp?smode=step2'><img src='./skinwiz/cart/<%=CartSkin%>/images/but_customer.gif' border=0 /></a> </td>
                </tr>
              </table>
          <br />
              <br />
              <!-- inner end --></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
