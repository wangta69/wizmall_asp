<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../config/admin_info.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="E6E6E6">
        <tr>
          <td width="170" height="40">&nbsp;</td>
          <td width="10">&nbsp;</td>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><a href="wizhtml.asp?html=company">회사소개</a> | <a href="wizhtml.asp?html=privacy">개인정보보호정책</a> | <a href="wizhtml.asp?html=agreement">이용약관</a> | <a href="wizhtml.asp?html=customercenter">고객센터</a> </td>
                <td align="right"><a href="#topAnchor"><img src="./skinwiz/layout/<%=LayoutSkin%>/images/icon_top.gif" width="44" height="17" border="0"></a></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="F6F6F6">
        <tr>
          <td width="170" height="35"><%=util.getBanner("bottom", 149, 89)%></td>
          <td width="10">&nbsp;</td>
          <td>상호 : <%=mall_company%> | 대표 : <%=mall_ceo%> | 사업자등록번호 : <%=mall_company_no%> | 통신판매업신고 : <%=mall_reg_no%><br>
            주소 : <%=mall_address%><br>
            대표전화 : <%=mall_tel%> | 팩스 : <%=mall_fax%> | E-mail : <%=mall_email%></td>
        </tr>
      </table></td>
  </tr>
</table>
