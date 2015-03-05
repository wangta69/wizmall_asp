<% Option Explicit%>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
Set db		= new database
Set mall	= new malls

%>
<table width="100%" height="500" border="0" cellpadding="0" cellspacing="0"><tr>
    <td valign="top"> 
      <table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6"> 
                <td width="15" height="22">&nbsp;</td>
                <td width="18" height="22" valign="middle"><img src="./skinwiz/shop/<%=ShopSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td width="576" height="22" bgcolor="#F6F6F6">Home 
            &gt;<%=opval%>
          </td>
              </tr>
            </table>
            <br>
            <br>
<%
''"./skinwiz/shop/" & ShopSkin & "/" & "list_product.asp"
SERVER.EXECUTE("./skinwiz/shop/" & ShopSkin & "/" & "list_product.asp")  
%>
    </td>
  </tr></table>
  <%
''카테고리 매장 분류에서 사용자 정의가 되어있어면 아래와 같이 실행된다.
''Response.Write(codelist("cat_bottom"))
''카테고리 매장 분류에서 사용자 정의가 되어있어면 상기와 같이 실행된다.
%>
<%
db.Dispose : Set db		= Nothing : Set util	= Nothing : Set mall = Nothing
%>
