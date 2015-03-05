<!-- #include file = "../../../lib/exe.board.asp" -->
<%
set util	= new utility
set board	= new boards
%>
<div id="imgLayer" style="display:none;position:absolute;z-index:1000";>
  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="right"><a href="javascript:closeImgLayer()">닫기[x]</a></td>
    </tr>
    <tr>
      <td><img src="" id="popLayerImg" onclick="closeImgLayer()"></td>
    </tr>
  </table>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <!-- ##################board  view테이블시작입니다##########################-->
      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="D7D7D7">

        <tr> 
          <td bgcolor="#F3F3F3"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr valign="bottom"> 
                <td width="75" height="25" align="center" class="font1">제목</td>
                <td width="19" align="left"><img src="<%=skin_path%>images/bar_1.gif" width="2" height="15"></td>
                <td align="left"><%=v_subject%></td>
              </tr>
            </table></td>
        </tr>
      </table>
<%
for i = 1 to ubound(filenameArr) ''0번째는 그림, 1번째는 동영상파일			  
if board.getViewFile(filenameArr(i), bid, gid, setBoardWidth, imgsize_width, imgsize_height) <> FALSE THEN
%>	  
		  <table width="100%" border="0" cellpadding="0" cellspacing="10">
              <tr>
                <td align="center" class="text"><%=board.getViewFile(filenameArr(i), bid, gid, setBoardWidth, imgsize_width, imgsize_height) %></td>
              </tr>
            </table>
<%
end if
next
%>			
			<table width="100%" border="0" cellpadding="0" cellspacing="10">
              <tr>
                <td class="txt1" style="word-break:break-all;"><%=v_content%></td>
              </tr>
            </table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="1" bgcolor="D7D7D7"></td>
        </tr>
        <tr> 
          <td height="40" align="right"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="70" height="25" align="right">이전글 : &nbsp;</td>
                <td align="left"><% if preuid <> "" then 
					Response.Write("<a href='wizboard.asp?bmode=view&bid="&bid&"&gid="&gid&"&adminmode="&adminmode&"&uid="&preuid&"&page="&page&"&category="&category&"'>"&presubject&"</a>")
				else
				Response.Write("이전글이 없습니다.")
				end if
				%></td>

              </tr>
              <tr> 
                <td width="70" height="25" align="right">다음글 : &nbsp;</td>
                <td align="left"><% if nextuid <> "" then 
				Response.Write("<a href='wizboard.asp?bmode=view&bid="&bid&"&gid="&gid&"&adminmode="&adminmode&"&uid="&nextuid&"&page="&page&"&category="&category&"'>"&nextsubject&"</a>")
				else
				Response.Write("다음글이 없습니다.")
				end if
				%></td>
              </tr>
            </table></td>
        </tr>
      </table>
	  	  
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="D7D7D7"></td>
        </tr>
        <tr> 
          <td height="40" align="right"><table height="30" border="0" cellpadding="0" cellspacing="0">
        <tr> 
<% if setadminonly = False or util.is_Admin = True then %>		
        <!--  <td width="62"><a href="./wizboard.asp?bmode=write&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&smode=reple&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/reply_btn.gif" border="0"></a></td>-->
          <td width="62"><a href="./wizboard.asp?bmode=write&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&smode=edit&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/modify_btn.gif" border="0"></a></td>
          <td width="62"><a href="./wizboard.asp?bmode=qde&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/del_btn.gif" border="0"></a></td>
 <% end if %>          
		  <td width="80"><a href="wizboard.asp?bmode=list&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=<%=page%>&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/list_btn.gif" border="0"></a></td>
        </tr>
      </table></td>
        </tr>
      </table>
      <!-- ##################board  view테이블끝입니다##########################-->
    </td>
  </tr>
</table>
<br>
<br>
<% if setrepleenable = 1 then %>
<!-- 한줄쓰기 시작 -->
<!-- #include file = "./reple_inc.asp" -->
<!-- 한줄 쓰기 끝 -->
<% end if %>
<%
SET objRs = NOTHING : Set board = Nothing : Set util = Nothing
%>

