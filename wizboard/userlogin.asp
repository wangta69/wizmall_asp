<!-- #include file = "../lib/cfg.board.asp" -->
<%
if bmode = "qde" then
	txt_title = "게시물삭제"
elseif bmode = "view" then
	txt_title = "비밀글 로그인"
else 
	txt_title="게시물수정"	
end if
%>
<SCRIPT>
function board_del() 
{
	if (document.frm1.check_pwd.value == "")
	{
	alert("비밀번호를 입력해주세요");

	document.frm1.check_pwd.focus();
	return false;

	}
	return true;

}

</script>
<br>
<br>

<table width="300" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#CCCCCC"><form name="frm1" method="post" action="./wizboard/userlogin_check.asp" onsubmit="return board_del();"><table width="300"  border="0" align="center" cellpadding="0" cellspacing="1">

<input type="hidden" name="bid" value="<%=bid%>">
<input type="hidden" name="gid" value="<%=gid%>">
<input type="hidden" name="adminmode" value="<%=adminmode%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="search_category" value="<%=search_category%>">
<input type="hidden" name="search_word" value="<%=search_word%>">
<input type="hidden" name="category" value="<%=category%>">
<input type="hidden" name="smode" value="<%=smode%>">
<input type="hidden" name="bmode" value="<%=bmode%>">
  <tr>
    <td height="15" bgcolor="#CCCCCC"></td>
  </tr>
  <tr>
            <td height="20" align="center" style="font-size:15px"><strong><%=txt_title%></strong></td>
  </tr>
  <tr>
    <td bgcolor="#F7F7F7">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="40"><p align="center">패스워드를 입력해 주시기 바랍니다.</p></td>
				</tr>
				<tr>
					<td height="30" align="center">Password <input name="check_pwd" type="password" class="input" size="14"></td>
				</tr>
				<tr>
					
            <td height="45" align="center"> 
              <input type="submit" name="Submit" value="확인"></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#000000"></td>
  </tr>
  <tr>
      <td height="40" align="center"><a href="javascript:history.back(-1);"> 취소 </a>&nbsp;<a href="./wizboard.asp?bmode=list&bid=<%=bid%>&gid=<%=gid%>&adminmode=<%=adminmode%>&page=<%=page%>&search_category=<%=search_category%>&search_word=<%=search_word%>&category=<%=category%>&order_c=<%=order_c%>&order_da=<%=order_da%>">리스트</a></td>
  </tr>

</table></form></td>
  </tr>
</table>
