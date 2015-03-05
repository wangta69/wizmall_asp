<% Option Explicit %>
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%

' // 검색 모드시 isSearch 변수에 1을 넣음
	Dim isSearch, TotalCount, TotalPage, whereis, tablename, search_title, search_keyword
	IF LEN(search_word) <> 0 THEN isSearch = 1 ELSE isSearch = 0
	
tablename = "Diary"

F_Year = CInt(Request("F_Year"))
if F_Year = 0 then F_Year = Year(date)
F_Month = CInt(Request("F_Month"))
if F_Month = 0 then F_Month = Month(date)
F_Day = CInt(Request("F_Day"))
	
search_title = Request("search_title")
search_keyword =  Request("search_keyword")
category =  Request("category")
page =  Request("page")
if page = "" then page = 1
setPageSize = 10
setSubjectCut = 20
setPageLink = 10

if F_Day <> 0 then 
	intMday = F_Year&"-"&F_Month&"-"&F_Day
	whereis = " cc_id <> '' and  datediff(""d"",cc_sdate,'"&intMday&"') = 0 "
else
	intMday = F_Year&"-"&right("0"&F_Month,2)
	'intMday = F_Year&"-"&F_Month
	whereis = " cc_id <> '' and left(convert(varchar, cc_sDate, 120), 7) = '"&intMday&"' "
end if
' // 게시글 토탈 카운팅
if search_title <> "" and search_keyword <> "" then whereis = whereis & " and " & search_title & " like '%" & search_keyword & "%'"


if category <> "" then whereis = whereis & " and category = " & category 

	strSQL = "SELECT COUNT(cc_id) FROM " & tablename & " WHERE " & whereis & " "
	'Response.Write(strSQL)
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
' // 전체 게시물 및 전체 페이지

	

	TotalCount = objRs(0)
	TotalPage = TotalCount / setPageSize
	IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
		TotalPage = int(TotalPage) + 1
	Else
		TotalPage = int(TotalPage)
	End if

' // 루프 기본 변수
	Dim intNotice, intIndexSize
	read_uid = uid
	
%>


<script>
<!--
function search_check(){
 var f=document.FindForm
 if(f.search_keyword.value==""){
 	alert('키워드를 입력해 주세요');
	f.search_keyword.focus();
	return false; 
 }else return true;
}
//-->
</script>
<table width="540" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td align="center" valign="top"> 
                              <!-- ##################일정등록달력 list 테이블시작입니다##########################-->
                              <table width="540" height="35" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td align="center">&nbsp;</td>
                                  <td width="270" align="center"><table border="0" cellspacing="0" cellpadding="0">
                                              <form name="FindForm" action="./leftpage_06.asp" method="get" onSubmit="return search_check();">
          <input type=hidden name=page value="1"><tr> 
                                        <td><select name="search_title" class="select">
                           <option value="cc_Title" selected>제목</option>
                      <option value="cc_Desc">내용</option>
                      <option value="cc_m_name">이름</option>
                                          </select> &nbsp;</td>
                                        <td><input name="search_keyword" type="text" class="input2" size="20"> 
                                          &nbsp;</td>
                                        <td><input type="image" src="../image/board/bt_search10.gif" width="60" height="18"></td>
                                      </tr></form>
                                    </table></td>
                                </tr>
                                <tr> 
                                  <td align="center"></td>
                                  <td height="5" align="right"></td>
                                </tr>
                              </table>
                              <table width="540" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="D7D7D7">
                                <tr> 
                                  <td bgcolor="F3F3F3"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                      <tr valign="bottom"> 
                                        <td width="33" align="center" class="font1">번호</td>
                                        <td width="2"><img src="../image/board/bar_1.gif" width="2" height="15"></td>
                                        <td width="80" align="center" class="font1">일정</td>
                                        <td width="10"><img src="../image/board/bar_1.gif" width="2" height="15"></td>
                                        <td width="291" align="center" class="font1">제목</td>
                                        <td width="2"><img src="../image/board/bar_1.gif" width="2" height="15"></td>
                                        <td width="68" align="center" class="font1">성명</td>
                                        <td width="2"><img src="../image/board/bar_1.gif" width="2" height="15"></td>
                                        <td align="center" class="font1">조회수</td>
                                      </tr>
                                    </table></td>
                                </tr>
                              </table>
                              <table width="540" border="0" cellpadding="0" cellspacing="0">
                                <%
intIndexSize = 500
intNotice = 0

strSQL = "select TOP " & setPageSize & " * from " & tablename & " Where " & whereis & " and cc_id not in (SELECT TOP " & ((page - 1) * setPageSize) & " cc_id from " & tablename & " ORDER BY cc_id desc) ORDER BY cc_id desc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
if objRs.EOF then
%>
                                <tr> 
                                  <td height="26" colspan="9" align="center">등록된 일정이 없습니다.</td>
                                </tr>
                                <tr bgcolor="E6E6E6"> 
                                  <td height="1" colspan="9"></td>
                                </tr>								
                                <%
else WHILE NOT objRs.EOF
	cc_id 		= objRs("cc_id")
	cc_m_name = objRs("cc_m_name")
	cc_desc = objRs("cc_desc")
	cc_count = objRs("cc_count")
	if cc_count = "" then cc_count = 0
	'cc_desc = util.ReplaceHtmlText(enable_html, objRs("cc_desc"))
	cc_sdate = objRs("cc_sdate")
	cc_title = objRs("cc_title")
	'cc_title = objRs("cc_title")
	'cc_title = objRs("cc_title")
		
	'optionArr	= SPLIT(objRs("option"), "|")
	'enable_html	= optionArr(0)
	
	'filenameArr	= SPLIT(objRs("filename"), "|") 
	
' // HTML 태그 정리 부분 (글쓴이, 제목, 글내용, 메일주소, 홈페이지)

	'email = util.getEmailChange(objRs("email"))
	'homepage = util.getReplaceInput(objRs("homepage"),"")
	'IF homepage = "http://" OR homepage = "HTTP://" THEN homepage = ""


' // 글자 길이 제한
	IF INT(getLenSubject(cc_title)) > INT(setSubjectCut) THEN cc_title = LEFT(cc_title, INT(setSubjectCut) - 3) & "..."
	subject = getSearchFontChange(isSearch, search_category, search_word, subject)
	


		LoopNum = LoopNum + 1
		ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - LoopNum + 1
		'end if
%>
                                <tr> 
                                  <td width="33" height="26" align="center"><% Response.Write ListNum %></td>
                                  <td width="2">&nbsp;</td>
                                  <td width="80" align="center"><%=cc_sdate%></td>
                                  <td width="10">&nbsp;</td>
                                  <td width="291"><a href="./leftpage_06_view.asp?page=<%=page%>&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>&F_Day=<%=F_Day%>&cc_id=<%=cc_id%>"><%=cc_title%></a></td>
                                  <td width="2">&nbsp;</td>
                                  <td width="68" align="center"><%=cc_m_name%></td>
                                  <td width="2">&nbsp;</td>
                                  <td align="center"><%=cc_count%></td>
                                </tr>
                                <tr bgcolor="E6E6E6"> 
                                  <td height="1" colspan="9"></td>
                                </tr>
                                <%
	objRs.MOVENEXT
	WEND
end if	
%>
                                <tr> 
                                  <td height="26" colspan="9" align="center"><table width="100%" height="26"  border="0" cellpadding="0" cellspacing="1" bgcolor="D7D7D7">
                                      <tr> 
                                        <td height="15" bgcolor="#F3F3F3">&nbsp;</td>
                                      </tr>
                                    </table></td>
                                </tr>
                              </table>
                              <table width="540" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td height="10"></td>
                                </tr>
                                <tr> 
                                  <td align="center">
<%
Dim TransDate
TransData = "&bmode=list&bid=" & bid & "&gid=" & gid & "&search_title=" & search_title & "&search_keyword=" & search_keyword
%>
<table width="155" height="30" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center"> <%
	IntStart = INT((((page - 1) \ setPageLink)) * setPageLink + 1)
	IntEnd = INT(((((page - 1) + setPageLink) \ setPageLink)) * setPageLink)
	
	
	
	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(page) > INT(setPageLink) THEN
			RESPONSE.WRITE "<a href='leftpage_06.asp?page=" & int(page - setPageLink) & TransData & "'><img src='../image/board/pre.gif'>"
			RESPONSE.WRITE "<a href='leftpage_06.asp?page=1" & TransData & "'></a>.. &nbsp;"
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
				RESPONSE.WRITE "&nbsp;"&i&"</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href='leftpage_06.asp?page=" & I & TransData & "'>&nbsp;"& I & "&nbsp;</a>"
			END IF
		NEXT
%></td>
    <td align="center"> <%
		IF INT(TotalPage - IntStart + 1) > INT(setPageLink) THEN RESPONSE.WRITE "<a href='leftpage_06.asp?page=" & TotalPage & TransData & "'></a>"

		IF INT(page) + setPageLink > TotalPage + 1 THEN
		ELSEIF INT(page) + setPageLink < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href='leftpage_06.asp?page=" & INT(page + setPageLink) & TransData & "'><img src='../image/board/next.gif'>"
		END IF
%> </td>
  </tr>
</table>
</td>
                                </tr>
                                <tr> 
                                  <td align="right"><a href="./leftpage_06.asp?page=<%=page%>&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>&F_Day=<%=F_Day%>"><img src="../image/board/bt_objRs.gif" width="60" height="18" border="0"></a>&nbsp;<a href="./leftpage_06_write.asp?smode=qin&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>&F_Day=<%=F_Day%>"><img src="../image/board/bt_write.gif" width="60" height="18" border="0"></a></td>
                                </tr>
                              </table>
                              <!-- ##################일정등록달력 list 테이블끝입니다##########################-->
                            </td>
                          </tr>
                        </table>
