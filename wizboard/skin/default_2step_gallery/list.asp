<% Option Explicit %>
<!-- #include file = "../../../lib/exe.board.asp" -->
<%
Set db = new database : set board = new boards : Set util = new utility	
''selectfield = "*" ''가져올 필드(이부분이 주석처리 된 경우 기본적으로 uid,name,content,subject,count,op_flag,filename,replecount,bd_level,regdate 필드만 가져옮
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="35" align="right" valign="bottom" style="padding-bottom:2px" class="paging">Total <strong><%=TotalCount%></strong> Articles | Viewing 
            page : <strong><%=page%>/<%=TotalPage%></strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#DDDDDD" height="1"></td>
        </tr>
        <tr>
          <td height="28" bgcolor="#EFEFEF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="60" align="center" class="ft1">번호</td>
                <td align="center" class="ft1">제목</td>
                <td width="90" align="center"  class="ft1">작성자</td>
                <td width="70" align="center"  class="ft1">날짜</td>
                <td width="40" align="center"  class="ft1">조회</td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#DDDDDD" height="1"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
  <tr>
    <td><!--############### 보드 리스트 시작 ##################################################-->
<%
Set db = new database
Dim setNoticeNum, NoticeWhere
setNoticeNum = 5
NoticeWhere = " WHERE ( notice = 1 )"
strSQL = "select TOP " & setNoticeNum & " * from " & table_name & NoticeWhere & " and uid not in (SELECT TOP " & ((page - 1) * setNoticeNum) & " uid from " & table_name & NoticeWhere & " ORDER BY bd_idx_num desc) ORDER BY bd_idx_num desc " 
SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
	Call board.boardlist()
%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr onMouseOver="this.style.backgroundColor='#68B9B8'" onMouseOut="this.style.backgroundColor=''" bgcolor="#68B9B8">
          <td width="60" height="24" align="center" class="num"><font color="red">공지</font></td>
          <td class="text"><!--##### 제 목 #####-->
          <%=Reple_Icon%><a href='wizboard.asp?bmode=view&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&category=<%=category%>&search_category=&search_word=&order_c=bd_idx_num&order_da=desc'><font color="white"><%=subject%></font></a>&nbsp;<%=New_Icon%><%=Reple_count%> </td>
          <td width="90" align="center" class="text"><font color="white"><%=name%></font></td>
          <td width="70" align="center" class="text-smalltahoma"><font color="white"><%=FormatDateTime(regdate,2)%></font></td>
          <td width="40" align="center" class="text-smalltahoma"><font color="white"><%=count%></font></td>
        </tr>
        <tr bgcolor="#DDDDDD">
          <td height="1" colspan="10"></td>
        </tr>
      </table>
<%
	objRs.MOVENEXT
	WEND

Dim orderby, ListNum
if setlistorder <> "" And  not isnull(setlistorder) then 
	tmporder = split(setlistorder, "@")
	orderby = " ORDER BY "& tmporder(0) & " " &tmporder(1)
else
	orderby = " ORDER BY bd_idx_num desc"
end If

strSQL = "select TOP " & setPageSize & " * from " & table_name & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from " & table_name & whereis & orderby & ") " & orderby 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 
if objRs.EOF thenxecSQLReturnRS(strSQL, Nothing, DbConnect)
if objRs.EOF then
%>	  
      	  
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr onMouseOver="this.style.backgroundColor='#F1F1F1'" onMouseOut="this.style.backgroundColor=''">
          <td height="24" align="center" class="num">등록된 글이 없습니다.</td>
        </tr>
        <tr bgcolor="#DDDDDD">
          <td height="1" colspan="6"></td>
        </tr>
      </table>
<%
else WHILE NOT objRs.EOF
	Call board.boardlist()
%>	  
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr onMouseOver="this.style.backgroundColor='#F1F1F1'" onMouseOut="this.style.backgroundColor=''">
          <td width="60" height="24" align="center" class="num"><% Response.Write ListNum %></td>
          <td class="text">
           <%=Reple_Icon%><a href='wizboard.asp?bmode=view&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&category=<%=category%>&search_category=&search_word=&order_c=bd_idx_num&order_da=desc'  style="TEXT-DECORATION: none;COLOR: #777777"><%=subject%></a>&nbsp;<%=New_Icon%><%=Reple_count%><%=SecretImg%>&nbsp;
          </td>
          <td width="90" align="center" class="text"><%=name%></td>
          <td width="70" align="center" class="text-smalltahoma"><%=FormatDateTime(regdate,2)%></td>
          <td width="40" align="center" class="text-smalltahoma"><%=count%></td>
        </tr>
        <tr bgcolor="#DDDDDD">
          <td height="1" colspan="10"></td>
        </tr>
      </table>
<%
	objRs.MOVENEXT
	WEND
	LoopCount = LoopCount + 1
end if	
%></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
  <tr>
    <td height="40" bgcolor="#F1F1F1"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="250" style="padding-left:20px"><%
Dim preimg : preimg = skin_path & "icon/prev_btn.gif"
Dim nextimg : nextimg = skin_path & "icon/next_btn.gif"	
Dim design
Dim linkurl : linkurl = "wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&search_title=" & search_title & "&search_keyword=" & search_keyword & "&adminmode=" & adminmode & "&category=" & category
Call board.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set board = Nothing
%></td>
          <td align="right" style="padding-right:12px"><table border="0" cellspacing="0" cellpadding="0">
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
                <td><input name="search_keyword" type="text"  style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:12px; color:#5E5E5E; HEIGHT: 18px; width: 100px" id="search_keyword" size="20"></td>
                <td><input type="image" src="<%=skin_path%>icon/search_btn.gif" width="45" height="18"></td>
              </tr></form>
          </table></td>
        </tr>
      </table></td>
  </tr>
</table><table width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr> 
          <td align="right"><a href="wizboard.asp?bmode=list&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=1&category=<%=category%>"><img src="<%=skin_path%>icon/list_btn.gif" border="0"></a>&nbsp;<% if setadminonly = False or util.is_Admin = True then %><a href="wizboard.asp?bmode=write&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=<%=page%>&uid=&smode=qin&search_category=&search_word=&category=<%=category%>"><img src="<%=skin_path%>icon/write_btn.gif" border="0"></a><% end if %></td>
        </tr>
      </table>
<%
db.Dispose : Set db	= Nothing : Set objRs = Nothing : Set board = Nothing : Set util = Nothing
%>
