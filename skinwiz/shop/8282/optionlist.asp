<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<table width="100%" height="500" border="0" cellpadding="0" cellspacing="0"><tr>
    <td valign="top"> 
      <table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6"> 
                <td width="15" height="22">&nbsp;</td>
                <td width="18" height="22" valign="middle"><img src="./skinwiz/shop/<%=ShopSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td width="576" height="22" bgcolor="#F6F6F6">Home 
            <%=route%>
          </td>
              </tr>
            </table>
            <br>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr> 
          <td width="180" rowspan="2" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="10">&nbsp; </td>
                <td width="10" bgcolor="#BBBBBB">&nbsp;</td>
                <td width="10">&nbsp; </td>
                <td  style="font-family: '굴림', '돋움','Arial';font-size: 20px; color:#666666;line-height:160%;font-weight: bolder"> 
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
<%
'sqlcountstr = "select count(cat_no) from wizCategory WHERE cat_no >= 100 AND cat_no < 10000 AND cat_no LIKE '%big_code' ";
'sqlcountqry = mysql_query(sqlcountstr) or die(mysql_error());
'sqlcountqry = mysql_result(sqlcountqry, 0, 0);
'if(sqlcountqry > 1):
'sqlcatstr = "select cat_no, cat_name from wizCategory WHERE cat_no >= 100 AND cat_no < 10000 AND cat_no LIKE '%big_code' order by cat_no ASC";
'sqlcatqry = mysql_query(sqlcatstr) or die(mysql_error());
'unset(count);
%>
          <td width="15" rowspan="2" valign="top" class="company">:: </td>
          <td width="365" class="company"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 

<% 'if(IsStep3):'Small Code가 있으면 %>
                  <table width="100%" border="0" cellpadding="5" cellspacing="0">
<%
'while(catlist = mysql_fetch_array(sqlcatqry)):
%>
                    <tr>
                      <td width="120"><a href="./wizmart.asp?code=<%'=catlist[cat_no]%>&lv=2"> 
                        <%'=catlist[cat_name]%>
                        </a></td>
                      <td><%
'mcode = substr(catlist[cat_no], 2);					  
'sqlsmallcatstr = "select cat_no, cat_name from wizCategory WHERE cat_no >= 10000 AND cat_no LIKE '%mcode' order by cat_no ASC";
'sqlsmallcatqry = mysql_query(sqlsmallcatstr) or die(mysql_error());
'while(smallcatlist = mysql_fetch_array(sqlsmallcatqry)):
%>
[ <a href="./wizmart.asp?code=<%'=smallcatlist[cat_no]%>&lv=3"><%'=smallcatlist[cat_name]%></a> ]
<%
'endwhile;
%></td>				 
</tr><%
'endwhile;
%>
</table>

<% 'else: ' Small Code가 없을 경우 시작%>
<%
'while(catlist = mysql_fetch_array(sqlcatqry)):
%>
                  <a href="./wizmart.asp?code=<%'=catlist[cat_no]%>&lv=2">
                  <%'=catlist[cat_name]%>
                  </a> l 
                  <%
'endwhile;
%>
<%' endif; ' Small Code 가 없을 경우 여기까지 진행 %> 
                </td>
              <tr class="company"> 
                <td height="1" bgcolor="#CCCCCC" class="company"></td>
              </tr>
            </table></td>
<%
'endif;
%>
        </tr>
      </table>
      <br>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr align="center"> 
<%
whereis = "where category = '"&code&"'"

strSQL = "SELECT COUNT(uid) FROM wizMall " & whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)
TotalPage = TotalCount / ListNo
IF (TotalPage - (TotalCount \ ListNo)) > 0 then
	TotalPage = int(TotalPage) + 1
Else
	TotalPage = int(TotalPage)
End if
	
strSQL = "select TOP " & ListNo & " * from wizMall " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * ListNo) & " uid from wizMall " & whereis & " ORDER BY uid desc) ORDER by uid desc "  

cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
setImgWidth = 120
while not objRs.eof
    PictureArr = split(objRs("Picture"), "|")
	if ubound(PictureArr) > 0 then Picture0 = PictureArr(0)
	if objRs("pnone") = "1"  then 
		VIEW_LINK = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
	else 
		VIEW_LINK = "'./wizmart.asp?smode=view&code="&objRs("Category")&"&no="&objRs("UID")&"'"
	end if
%>
          <td height="190" valign="top"> 

            <table border="0" cellpadding="0" cellspacing="0">
             <tr> 
                <td width="80" align="center"><table border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <tr> 
                      <td width="80" align="center"><table width="120" height="120" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%" bordercolor="#bababa">
                          <tr> 
                            <td align="center" bgcolor="#FFFFFF"><A HREF=<%=VIEW_LINK%>>
							<%=getGoodsImg(Picture0, setImgWidth) %></A> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td align="center" class="company">
                        <%=objRs("pname")%><% 
						if objRs("Model") <> "" then  
							Response.Write("<br>"&objRs("Model"))
						end if
						%>
                        <br> <font color="#006699"><strong>
                        <%=FormatNumber(objRs("Price"), 0)%>
                        원</strong></font></td>
                    </tr>
                  </table></td>
              </tr>
            </table>	
          </td>
<%
cnt = cnt + 1
if cnt mod 4 = 0 then Response.Write "</tr><tr align='center'><td background='img/main/bg_w.gif' height='1' colspan='4'></td></tr><tr align='center'>"
objRs.movenext
wend
tmpcnt = cnt mod 4
if tmpcnt <> 0 then
	for i = tmpcnt to 3
		Response.Write("<td width='176'></td>")
	next
end if
%>
        </tr>
      </table>
      <br>
    </td>
  </tr><tr><td align="center"><%
Dim TransDate
TransData = "&code="&code&"&lv="&lv&"&sort="&sort&"&keyword="&keyword
%>
<table width="155" height="30" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center"> <%
	IntStart = INT((((page - 1) \ PageNo)) * PageNo + 1)
	IntEnd = INT(((((page - 1) + PageNo) \ PageNo)) * PageNo)
	
	
	
	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(page) > INT(PageNo) THEN
			RESPONSE.WRITE "<a href='wizmart.asp?page=" & int(page - PageNo) & TransData & "'><img src='" & skin_path & "pre.gif' width='17' height='19'>"
			RESPONSE.WRITE "<a href='wizmart.asp?page=1" & TransData & "'></a>.. &nbsp;"
		END IF
%> </td>
    <td align="center"><%


		FOR I = IntStart TO IntEnd 
			IF I = IntStart THEN
				'TMPSPLIT = ""
			ELSE 
				'TMPSPLIT = "/"
			END IF 
			
			IF INT(I) = INT(page) THEN
				RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href='wizmart.asp?page=" & I & TransData & "'>&nbsp;"& I & "&nbsp;</a>"
			END IF
		NEXT
%></td>
    <td align="center"> <%
		IF INT(TotalPage - IntStart + 1) > INT(PageNo) THEN RESPONSE.WRITE "<a href='wizmart.asp?page=" & TotalPage & TransData & "'></a>"

		IF INT(page) + PageNo > TotalPage + 1 THEN
		ELSEIF INT(page) + PageNo < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href='wizmart.asp?page=" & INT(page + PageNo) & TransData & "'><img src='" & skin_path & "next.gif' width='17' height='19'>"
		END IF
%> </td>
  </tr>
</table></td></tr></table>
  <%
'카테고리 매장 분류에서 사용자 정의가 되어있어면 아래와 같이 실행된다.
'echo "codelist[cat_bottom]";
'카테고리 매장 분류에서 사용자 정의가 되어있어면 상기와 같이 실행된다.
%>
