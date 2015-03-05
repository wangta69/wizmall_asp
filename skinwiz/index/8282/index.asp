<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><%=util.getBanner("maintop", 719, 179)%></td>
  </tr>
</table>
<table width="720" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	
<%
Dim bannerList(3)
Call util.getBanners(4, 230, 80)
%>	
	<table width="720" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="240"><%=bannerList(0)%></td>
          <td width="240" align="center"><%=bannerList(1)%></td>
          <td width="240" align="right"><%=bannerList(2)%></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="./skinwiz/index/<%=MainSkin %>/images/title_hit.gif" width="134" height="29"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td bgcolor="C28299" width="130" height="5"></td>
          <td bgcolor="C5C5C5" width="590"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td><table border="0" cellpadding="5" cellspacing="0">
        <tr>
          <%
ListNo = 10
code = 20
whereis = "WHERE SUBSTRING(option3, 5, 1) = '1' and pdisplay <> 1"
strSQL = "select TOP " & ListNo & " * from wizMall " & whereis & " ORDER by uid desc "  
cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
    PictureArr = split(objRs("Picture"), "|")
	pname = objRs("pname")
	price = objRs("price")
	
	if objRs("pnone") = "1"  then 
		VIEW_LINK = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
	else 
		VIEW_LINK = "'./wizmart.asp?smode=view&code="&objRs("Category")&"&no="&objRs("UID")&"'"
	end if
%>
          <td width="144" align="center"><table width="134" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="144" bgcolor="#CCCCCC"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                      <td height="120" bgcolor="#FFFFFF"><a href=<%=VIEW_LINK%>><img src="./config/wizstock/<% if ubound(PictureArr) > 0 then Response.Write PictureArr(0)%>" width="132" height="132" border="0"></a></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            <table width="134" height="42" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center"><%=pname%></td>
              </tr>
              <tr>
                <td align="center"><strong><font color="C28299"><%=FormatNumber(price, 0)%>원</font></strong> </td>
              </tr>
            </table></td>
          <%
cnt = cnt + 1
if cnt mod 5 = 0 then 
	Response.Write "</tr></table><table border='0' cellpadding='5' cellspacing='0'><tr>"
else
	Response.Write("")
end if
objRs.movenext
wend
tmpcnt = cnt mod 5
if tmpcnt <> 0 then
	for i = tmpcnt to 5
		Response.Write("<td width='144'></td>")
	next
end if
%>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="./skinwiz/index/<%=MainSkin %>/images/title_new.gif" width="134" height="29"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td bgcolor="C28299" width="130" height="5"></td>
          <td bgcolor="C5C5C5" width="590"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td><table border="0" cellpadding="5" cellspacing="0">
        <tr>
          <%
ListNo = 10
code = 20
whereis = "where SUBSTRING(option3, 1, 1) = '1' and pdisplay <> 1"
strSQL = "select TOP " & ListNo & " * from wizMall " & whereis & " ORDER by uid desc "  

cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
    PictureArr = split(objRs("Picture"), "|")
	pname = objRs("pname")
	price = objRs("price")
	
	if objRs("pnone") = "1"  then 
		VIEW_LINK = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
	else 
		VIEW_LINK = "'./wizmart.asp?smode=view&code="&objRs("Category")&"&no="&objRs("UID")&"'"
	end if
%>
          <td width="144" align="center"><table width="134" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="144" bgcolor="#CCCCCC"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                      <td height="120" bgcolor="#FFFFFF"><a href=<%=VIEW_LINK%>><img src="./config/wizstock/<% if ubound(PictureArr) > 0 then Response.Write PictureArr(0)%>" width="132" height="132" border="0"></a></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            <table width="134" height="42" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center"><%=pname%></td>
              </tr>
              <tr>
                <td align="center"><strong><font color="C28299"><%=FormatNumber(price, 0)%>원</font></strong> </td>
              </tr>
            </table></td>
<%
cnt = cnt + 1
if cnt mod 5 = 0 then 
	Response.Write "</tr></table><table border='0' cellpadding='5' cellspacing='0'><tr>"
else
	Response.Write("")
end if
objRs.movenext
wend
tmpcnt = cnt mod 5
if tmpcnt <> 0 then
	for i = tmpcnt to 5
		Response.Write("<td width='144'></td>")
	next
end if
%>
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
