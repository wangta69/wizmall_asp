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
		   <input type=hidden name=category value="<%=category%>">
          <input type=hidden name=page value="1">		  
              <tr> 
                <td><select name="search_title" class="select" id="search_title">
                      <option value="subject" selected>제목</option>
                      <option value="content">내용</option>
                      <option value="name">등록자</option>
                  </select></td>
                <td><input name="search_keyword" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" id="search_keyword" size="20"></td>
                <td><input type="image" src="<%=skin_path%>icon/search_btn.gif" width="60" height="18"></td>
              </tr></form>
            </table></td>
        </tr>
        <tr> 
          <td align="center"></td>
          <td height="5" align="right"></td>
        </tr>
      </table>
<!-- Image Table Start -->	  
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="center" valign="top">
<%
Set db = new database
if setlistorder <> "" And  not isnull(setlistorder) then 
	tmporder = split(setlistorder, "@")
	orderby = " ORDER BY "& tmporder(0) & " " &tmporder(1)
else
	orderby = " ORDER BY bd_idx_num desc"
end If

strSQL = "select TOP " & setPageSize & " * from " & table_name & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from " & table_name & whereis & orderby & ") " & orderby 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 
cnt = 0
WHILE NOT objRs.EOF
	Call board.boardlist()
%>    
	<td width="176"><table width="160" height="119" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" class="bd1" style="padding:3px;"><%
if ListFile1 <> "" then
	ListImg = "<img src='" & util.findThumbnail(ListFile1, attached_dir, "default", 150, 113) & "' width='150' height='113' border='0'>"
	Response.Write(board.linkStr(ListImg))
end if
%>	</td>
        </tr>
      </table>
      <table width="160" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td height="10" colspan="2"></td>
        </tr>
        <tr class="ft2">
          <td width="40" height="25" align="center" bgcolor="#E8E8E8" class="ft2 style3">제목</td>
          <td height="25"  width="115" bgcolor="#F3F3F3" class="dot"><a href='wizboard.asp?bmode=view&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&category=<%=category%>&search_category=&search_word=' class="no0"><%=subject%></a></td>
        </tr>
      </table></td>
<%	cnt = cnt + 1
	if cnt mod 3 = 0 then Response.Write "</tr><tr align='center' valign='top'><td colspan='3'>&nbsp;</td></tr></table><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr align='center' valign='top'>"
	objRs.MOVENEXT
	WEND
	tmpcnt = cnt mod 3
	if tmpcnt <> 0 then
		for i = tmpcnt to 2
			Response.Write("<td width='176'></td>")
		next
	end if
%>	  
  </tr>

</table>
<!-- Img Table End -->
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
