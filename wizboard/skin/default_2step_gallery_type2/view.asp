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
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
<% 
''if adminmode = "true" or util.is_Admin = True then
%>	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" style="padding-left:15; padding-right:15; padding-top:12; padding-bottom:15"><!-- #include file = "./sub_list.asp" --></td>
        </tr>
      </table>
<%
''end if
%>
<% if setrepleenable = 1 then %>
<!-- 한줄쓰기 시작 -->

<!-- #include file = "./reple_inc.asp" -->
<!-- 한줄 쓰기 끝 -->
<% end if %></td>
  </tr>
  <tr>
    <td><img src="/admin/kor_board/images/blank.gif" width="1" height="2"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
              </tr>
              <tr>
                <td width="100" height="26" align="center" bgcolor="#efefef" class="text-smalltahoma"><strong>prev</strong></td>
                <td align="left" bgcolor="#f7f7f7" class="text" style="padding-left:5"><!--######################### 이전글 제목 보여주기 #########################-->
                <% if preuid <> "" then 
					Response.Write("<a href='wizboard.asp?bmode=view&bid="&bid&"&gid="&gid&"&adminmode="&adminmode&"&uid="&preuid&"&page="&page&"&category="&category&"'>"&presubject&"</a>")
				else
				Response.Write("이전글이 없습니다.")
				end if
				%></td>
              </tr>
              <tr>
                <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="100" height="26" align="center" bgcolor="#efefef" class="text-smalltahoma"><strong>next</strong></td>
                <td align="left" bgcolor="#f7f7f7" class="text" style="padding-left:5"><% if nextuid <> "" then 
				Response.Write("<a href='wizboard.asp?bmode=view&bid="&bid&"&gid="&gid&"&adminmode="&adminmode&"&uid="&nextuid&"&page="&page&"&category="&category&"'>"&nextsubject&"</a>")
				else
				Response.Write("다음글이 없습니다.")
				end if
				%></td>
              </tr>
              <tr>
                <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="1"></td>
        </tr>
      </table></td>
  </tr>
</table><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="10"></td>
          <td></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="D7D7D7"></td>
          <td bgcolor="D7D7D7"></td>
        </tr>
        <tr> 
          <td height="40"><table height="30" border="0" cellpadding="0" cellspacing="0">
        <tr> 

       
		  <td width="80"><a href="wizboard.asp?bmode=list&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=<%=page%>&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/list_btn.gif" border="0"></a></td>
        </tr>
      </table></td>
          <td align="right"><table height="30" border="0" cellpadding="0" cellspacing="0">
        <tr> 
<% if setadminonly = False or util.is_Admin = True then %>		
          <td width="62"><a href="./wizboard.asp?bmode=write&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&smode=reple&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/reply_btn.gif" border="0"></a></td>
          <td width="62"><a href="./wizboard.asp?bmode=write&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&smode=edit&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/modify_btn.gif" border="0"></a></td>
          <td width="62"><a href="./wizboard.asp?bmode=qde&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&uid=<%=uid%>&page=<%=page%>&search_title=<%=search_title%>&search_keyword=<%=search_keyword%>&category=<%=category%>"><img src="<%=skin_path%>icon/del_btn.gif" border="0"></a></td>
 <% end if %>          
        </tr>
      </table></td>
        </tr>
      </table>
<%
SET objRs = NOTHING : Set board = Nothing : Set util = Nothing
%>
