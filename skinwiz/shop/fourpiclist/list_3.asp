<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
Set db		= new database
Set mall	= new malls
%>
<table width="100%" height="500" border="0" cellpadding="0" cellspacing="0"><tr>
    <td valign="top"> 
      <table width="100%" height="18" border="0" cellpadding="0" cellspacing="0">
        <tr bgcolor="#F6F6F6"> 
                <td width="15" height="22">&nbsp;</td>
                <td width="18" height="22" valign="middle"><img src="./skinwiz/shop/<%=ShopSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td width="576" height="22" bgcolor="#F6F6F6">Home 
            <%=route%>
          </td>
              </tr>
            </table>
            <br>
			
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="180" rowspan="2" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="10">&nbsp; </td>
                <td width="10" bgcolor="#BBBBBB">&nbsp;</td>
                <td width="10">&nbsp; </td>
                <td> 
                  <%=title%>
                </td>
              </tr>
              <tr>
                <td height="1"> </td>
                <td bgcolor="#BBBBBB"> </td>
                <td bgcolor="#BBBBBB"> </td>
                <td bgcolor="#BBBBBB"> </td>
              </tr>
            </table></td>

          <td width="15" rowspan="2" valign="top" class="company">:: </td>
          <td class="company"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
<%
Dim strSQL1, objRs1
strSQL = "select count(cat_no) from wizCategory WHERE len(cat_no) = 6 AND Right(cat_no, 3) = '"&big_code&"' and cat_flag = 'wizmall' and (cat_disable is null or cat_disable <> 1)"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
if objRs(0) > 1 then
	strSQL = "select cat_no, cat_name from wizCategory WHERE len(cat_no) = 6 AND Right(cat_no, 3) = '"&big_code&"' and cat_flag = 'wizmall' and (cat_disable is null or cat_disable <> 1) order by cat_order ASC"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs.EOF
%>
                  <table width="100%" border="0" cellpadding="5" cellspacing="0">
                    <tr>
                      <td width="120"><a href="./wizmart.asp?code=<%=objRs("cat_no")%>"> 
                        <%=objRs("cat_name")%>
                        </a></td>
                      <td><%
if objRs("cat_no") <> "" then					  
	strSQL1 = "select cat_no, cat_name from wizCategory WHERE len(cat_no) = 9 AND right(cat_no, 6) = '"&objRs("cat_no")&"' and cat_flag='wizmall' and (cat_disable is null or cat_disable <> 1) order by cat_order ASC"
	Set objRs1	= db.ExecSQLReturnRS(strSQL1, Nothing, DbConnect)
	WHILE NOT objRs1.EOF
%>
[ <a href="./wizmart.asp?code=<%=objRs1("cat_no")%>"><%=objRs1("cat_name")%></a> ]
<%
	objRs1.MOVENEXT
	WEND
End If	
%></td>				 
</tr>
</table>
<%
	objRs.MOVENEXT
	WEND
End If	
%>
</td>
              <tr> 
                <td height="1" bgcolor="#CCCCCC"></td>
              </tr>
            </table></td>

        </tr>
      </table>
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
