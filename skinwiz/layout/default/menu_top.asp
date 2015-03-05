<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database
%>
<table width="900" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="15%"><%=util.getBanner("top", 112, 50)%></td>
    <td width="20">&nbsp;</td>
    <td align="right" valign="top"><table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td bgcolor="D7D8DD" height="10" width="1"></td>
              </tr>
              <tr>
                <td bgcolor="87888B" height="10"></td>
              </tr>
            </table></td>
          <td width="30" valign="bottom">&nbsp;<a href="/">홈</a></td>
          <td valign="bottom"><table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td bgcolor="D7D8DD" height="10" width="1"></td>
              </tr>
              <tr>
                <td bgcolor="87888B" height="10"></td>
              </tr>
            </table></td>
          <td width="70" valign="bottom">&nbsp;<a href="wizbag.asp">장바구니</a></td>
          <td valign="bottom"><table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td bgcolor="D7D8DD" height="10" width="1"></td>
              </tr>
              <tr>
                <td bgcolor="87888B" height="10"></td>
              </tr>
            </table></td>
          <td width="90" valign="bottom">&nbsp;<a href="wizmember.asp?smode=order">주문내역보기</a></td>
          <td valign="bottom"><table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td bgcolor="D7D8DD" height="10" width="1"></td>
              </tr>
              <tr>
                <td bgcolor="87888B" height="10"></td>
              </tr>
            </table></td>
          <td width="70" valign="bottom">&nbsp;<a href="wizmember.asp?smode=order">배송정보</a></td>
          <td valign="bottom"><table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td bgcolor="D7D8DD" height="10" width="1"></td>
              </tr>
              <tr>
                <td bgcolor="87888B" height="10"></td>
              </tr>
            </table></td>
          <td width="80" valign="bottom">&nbsp;<a href="wizmember.asp?smode=mypage">마이페이지</a></td>
          <td valign="bottom"><table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td bgcolor="D7D8DD" height="10" width="1"></td>
              </tr>
              <tr>
                <td bgcolor="87888B" height="10"></td>
              </tr>
            </table></td>
          <td width="80" valign="bottom">&nbsp;<a href="wizboard.asp?BID=board01&GID=root">고객게시판</a></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="./skinwiz/layout/<%=LayoutSkin%>/images/topbg.gif">
  <tr>
    <td><table width="900" border="0" cellpadding="0" cellspacing="0" background="./skinwiz/layout/<%=LayoutSkin%>/images/topbg.gif">
        <tr>
          <td height="39" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="54"><img src="./skinwiz/layout/<%=LayoutSkin%>/images/notice_title.gif" width="54" height="13" align="absmiddle"></td>
                      <td height="25" valign="middle"><marquee id=mainmarquee direction="left" width=400, height=15>
<%
bid = "board02"
gid = "root"
strSQL = "select top 5 * from wizboard_"&bid&"_"&gid&" where bd_level=0 and notice <> 1 order by uid desc"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
uid = objRs("uid")
subject = left(objRs("subject"), 20)
'' 신규 글 아이콘 등록		
difftime = DateDiff("h",objRs("regdate"),now())
if difftime <= 24 then
	New_Icon =  "<img src=""wizboard/skin/default/icon/new_btn.gif"" align=absmiddle>"
else
	New_Icon = ""
end if
%>	
                        → <a href='wizboard.asp?bmode=view&bid=<%=bid%>&gid=<%=gid%>&uid=<%=uid%>&category=<%=category%>'><%=subject%></a>
<%=New_Icon%>
                       <%=FormatDateTime(objRs("regdate"),2)%>
<%
Response.Write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
objRs.movenext
Wend
Set objRs = NOTHING
%>		
                        </marquee></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
          <td width="320" align="right" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <script language="JavaScript">
<!--
function SearchCheckForm(){

var f=document.SearchCheck;

  if(f.keyword.value == ''){
  alert('검색어를 입력해주세요');
  f.keyword.focus();
  return false;
  }
 }
//-->
</script>
              <form action="wizsearch.asp" name="SearchCheck" onsubmit='return SearchCheckForm();'>
                <input type="hidden" name="smode" value="search">
                <input type="hidden" name="Target" value="all">
                <tr>
                  <td><img src="./skinwiz/layout/<%=LayoutSkin%>/images/search_icon.gif" width="61" height="15"></td>
                  <td><input type="text" name="keyword" class="input"></td>
                  <td><input type="image" src="./skinwiz/layout/<%=LayoutSkin%>/images/search_btn1.gif" width="35" height="18" hspace="2">
                    <a href="wizsearch.asp"><img src="./skinwiz/layout/<%=LayoutSkin%>/images/search_btn.gif" width="55" height="18" hspace="2" border="0"></a></td>
                </tr>
              </form>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
