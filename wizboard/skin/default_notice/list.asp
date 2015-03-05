<% Option Explicit %>
<!-- #include file = "../../../lib/exe.board.asp" -->
<%
Set db = new database : set board = new boards : Set util = new utility	
''selectfield = "*" ''가져올 필드(이부분이 주석처리 된 경우 기본적으로 uid,name,content,subject,count,op_flag,filename,replecount,bd_level,regdate 필드만 가져옮
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="center"> 
      <!-- ##################board list 테이블시작입니다##########################-->
      <table width="100%" height="35" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td align="center">&nbsp;</td>
          <td width="270" align="center"><table border="0" cellspacing="0" cellpadding="0">
        <form name="FindForm" action="wizboard.asp" method="get" onSubmit="return b_search_check(this);">
          <input type=hidden name=bmode value="list">
          <input type=hidden name=bid value="<%=bid%>">
          <input type=hidden name=gid value="<%=gid%>">
		  <input type=hidden name=adminmode value="<%=adminmode%>">
          <input type=hidden name=page value="1">		  
              <tr> 
                <td><select name="search_title" class="select" id="search_title">
                      <option value="subject" selected>제목</option>
                      <option value="content">내용</option>
                      <option value="name">등록자</option>
                  </select></td>
                <td><input name="search_keyword" type="text" id="search_keyword" size="20"></td>
                <td><input type="image" src="<%=skin_path%>icon/search_btn.gif" width="60" height="18"></td>
              </tr></form>
            </table></td>
        </tr>
        <tr> 
          <td align="center"></td>
          <td height="5" align="right"></td>
        </tr>
      </table>
      <table width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="D7D7D7">
        <tr> 
          <td bgcolor="F3F3F3"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr valign="bottom"> 
                <td width="33" align="center">번호</td>
                <td width="2"><img src="<%=skin_path%>images/bar_1.gif" width="2" height="15"></td>
                <td align="center">제목</td>
                <td width="2"><img src="<%=skin_path%>images/bar_1.gif" width="2" height="15"></td>
                <td width="78" align="center">날짜</td>
                <td width="1"><img src="<%=skin_path%>images/bar_1.gif" width="2" height="15"></td>
                <td width="50" align="center">조회수</td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
<%
Set db = new database
Dim setNoticeNum, NoticeWhere
setNoticeNum = 5
NoticeWhere = " WHERE ( notice = 1 )"
strSQL = "select TOP " & setNoticeNum & " * from " & table_name & NoticeWhere & " and uid not in (SELECT TOP " & ((page - 1) * setNoticeNum) & " uid from " & table_name & NoticeWhere & " ORDER BY bd_idx_num desc) ORDER BY bd_idx_num desc " 
SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
	Call board.boardlist()
%>	    <tr> 
          <td width="33" height="26" align="center">공지</td>
          <td width="2">&nbsp;</td>
          <td align="left">&nbsp;<%=Reple_Icon%><%=board.linkStr(subject)%>&nbsp;<%=New_Icon%><%=Reple_count%>&nbsp;</td>
          <td width="2">&nbsp;</td>

          <td width="76" align="center"><%=FormatDateTime(regdate,2)%></td>
          <td width="2">&nbsp;</td>
          <td width="53" align="center"><%=count%></td>
        </tr>
        <tr bgcolor="E6E6E6"> 
          <td height="1" colspan="9"></td>
        </tr>
<%
	objRs.MOVENEXT
	WEND

if setlistorder <> "" And  not isnull(setlistorder) then 
	tmporder = split(setlistorder, "@")
	orderby = " ORDER BY "& tmporder(0) & " " &tmporder(1)
else
	orderby = " ORDER BY bd_idx_num desc"
end If

strSQL = "select TOP " & setPageSize & " * from " & table_name & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from " & table_name & whereis & orderby & ") " & orderby 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 
if objRs.EOF then
%>	  
        <tr> 
          <td height="26" colspan="9" align="center" >등록된글이없습니다</td>
        </tr>
        <tr bgcolor="E6E6E6"> 
          <td height="1" colspan="9"></td>
        </tr>
<%
else WHILE NOT objRs.EOF
	Call board.boardlist()
%>		
        <tr> 
          <td width="33" height="26" align="center"><% Response.Write ListNum %></td>
          <td width="2">&nbsp;</td>
          <td align="left">&nbsp;<%=Reple_Icon%><%=board.linkStr(subject)%>&nbsp;<%=New_Icon%><%=Reple_count%><%=SecretImg%>&nbsp;</td>
          <td width="2">&nbsp;</td>
          <td width="76" align="center"><%=FormatDateTime(regdate,2)%></td>
          <td width="2">&nbsp;</td>
          <td width="53" align="center"><%=count%></td>
        </tr>
        <tr bgcolor="E6E6E6"> 
          <td height="1" colspan="9"></td>
        </tr>
<%
	ListNum = ListNum -1
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
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td align="center"><%
Dim preimg : preimg = skin_path & "icon/prev_btn.gif"
Dim nextimg : nextimg = skin_path & "icon/next_btn.gif"	
Dim design
Dim linkurl : linkurl = "wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&search_title=" & search_title & "&search_keyword=" & search_keyword & "&adminmode=" & adminmode & "&category=" & category
Call board.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set board = Nothing
%></td>
        </tr>
        <tr> 
          <td align="right"><a href="wizboard.asp?bmode=list&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=1&category=<%=category%>"><img src="<%=skin_path%>icon/list_btn.gif" border="0"></a>&nbsp;<% if setadminonly = False or util.is_Admin = True then %><a href="wizboard.asp?bmode=write&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=<%=page%>&uid=&smode=qin&search_category=&search_word=&category=<%=category%>"><img src="<%=skin_path%>icon/write_btn.gif" border="0"></a><% end if %></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
db.Dispose : Set db	= Nothing : Set objRs = Nothing : Set board = Nothing : Set util = Nothing
%>
