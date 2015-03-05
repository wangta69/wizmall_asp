<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
Dim code, page
code = Request("code")
codelen = Len(code)
page = Request("page")
if page = "" then page = 1


'카테고리 매장 분류에서 사용자 정의가 되어있어면 아래와 같이 실행된다.
'strSQL = "select * from wizCategory where cat_no < 100 AND cat_no LIKE '%big_code'";
'sqlqry = mysql_query(strSQL) or die(mysql_error());
'codelist = mysql_fetch_array(sqlqry);

'strSQL = "select cat_top, cat_bottom from wizCategory where cat_no LIKE 'code'";
'sqlqry = mysql_query(strSQL) or die(mysql_error());
'istop = @mysql_result(sqlqry,0,0);
'isbottom = @mysql_result(sqlqry,0,1);
'if(istop) codelist[cat_top] = istop;
'if(isbottom) codelist[cat_bottom] = isbottom;
' 정의된 shop-skin이 있으면 이것으로 skin을 바꾼다.
'현재는 대분류에서 지정된 것이 일률적으로 모든 이하 페이지에 지정되도록 되어있습니다 
'echo "codelist[cat_top]";
'카테고리 매장 분류에서 사용자 정의가 되어있어면 상기와 같이 실행된다.
%>

<%
'' 대분류일경우 
if codelen >= 1 then 
big_code = Cint(right("0"&code, 2))
strSQL = "SELECT cat_no, cat_name FROM wizCategory WHERE cat_no='"&big_code&"'"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
big_name = objRs("cat_name")
route = " &gt; <a href='wizmart.asp?code="&big_code&"'>"&big_name&"</a>"
title = big_name
end if

if codelen >= 3 then 
mid_code = Cint(right("0"&code, 4))
strSQL = "SELECT cat_no, cat_name FROM wizCategory WHERE cat_no='"&mid_code&"'"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
mid_name = objRs("cat_name")
route = route & " &gt; <a href='wizmart.asp?code="&mid_code&"'>"&mid_name&"</a>"
title = mid_name
end if

if codelen >= 5 then 
small_code = Cint(right("0"&code, 6))
strSQL = "SELECT cat_no, cat_name FROM wizCategory WHERE cat_no='"&small_code&"'"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
small_name = objRs("cat_name")
route = route & " &gt; "&small_name
title = small_name
end if
%>
<table width="722" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25" align="right" valign="bottom" background="/images/sub4.gif" class="nav" style="padding-right:20px; padding-bottom:2px;">Home > 제품소개 &gt; 황사마스크 </td>
              </tr>
              <tr>
                <td><img src="/images/title6.gif" width="722" height="42"></td>
              </tr>
              
              <tr>
                <td align="center" valign="top" height="25"><table width="670" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><table width="627" border="0" cellspacing="0" cellpadding="0">
        <tr>
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
setImgWidth = 150
while not objRs.eof
    PictureArr = split(objRs("Picture"), "|")
	if ubound(PictureArr) > 0 then Picture0 = PictureArr(0)
	if objRs("pnone") = "1"  then 
		VIEW_LINK = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
	else 
		VIEW_LINK = "'./wizmart.asp?smode=view&code="&objRs("Category")&"&no="&objRs("UID")&"'"
	end if
	
if cnt mod 4 <> 0 then Response.Write("<td>&nbsp;</td>")
%>		
          <td width="150"><table width="150" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center"><table width="150" border="0" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC">
                    <tr>
                      <td align="center" bgcolor="#FFFFFF"><A HREF=<%=VIEW_LINK%>><%=getGoodsImg(Picture0, setImgWidth) %></A> </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td align="center" class="text"><span id="p_name"><A HREF=<%=VIEW_LINK%>><%=objRs("pname")%></a></span></td>
              </tr>
            </table></td>
<%
cnt = cnt + 1
if cnt mod 4 = 0 then Response.Write "</tr><tr><td height='35'>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr>"
objRs.movenext
wend
tmpcnt = cnt mod 4
if tmpcnt <> 0 then
	for i = tmpcnt to 3
		Response.Write("<td>&nbsp;</td><td width='150'></td>")
	next
end if
%>			
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="50" align="center"><table width="627" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="25" align="center" bgcolor="#FFFFFF"><%
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
			RESPONSE.WRITE "<a href='wizmart.asp?page=" & int(page - PageNo) & TransData & "'><img src='/images/btn_prev.gif' width='35' height='13'>"
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
				RESPONSE.WRITE "&nbsp;<b>["&i&"]</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href='wizmart.asp?page=" & I & TransData & "'>&nbsp;["& I & "]&nbsp;</a>"
			END IF
		NEXT
%></td>
    <td align="center"> <%
		IF INT(TotalPage - IntStart + 1) > INT(PageNo) THEN RESPONSE.WRITE "<a href='wizmart.asp?page=" & TotalPage & TransData & "'></a>"

		IF INT(page) + PageNo > TotalPage + 1 THEN
		ELSEIF INT(page) + PageNo < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href='wizmart.asp?page=" & INT(page + PageNo) & TransData & "'><img src='/images/btn_next.gif' width='35' height='13'>"
		END IF
%> </td>
  </tr>
</table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="50">&nbsp;</td>
  </tr>
</table></td>
              </tr>
              <tr>
                <td height="50" align="center" valign="top">&nbsp;</td>
              </tr>
            </table>
