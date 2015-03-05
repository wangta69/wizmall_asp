<!-- #include file = "../../../lib/cfg.board.asp" -->
<SCRIPT>
function board_del() 
{
	if (document.frm1.check_pwd.value == "")
	{
	alert("비빌번호를 입력해주세요");

	document.frm1.check_pwd.focus();
	return false;

	}
	return true;

}

</script>
<br>
<br>
<table width="300"  border="0" align="center" cellpadding="0" cellspacing="0">
<form name="frm1" method="post" action="./wizboard/board_delete.asp" onsubmit="return board_del();">
<input type="hidden" name="bid" value="<%=bid%>">
<input type="hidden" name="gid" value="<%=gid%>">
<input type="hidden" name="adminmode" value="<%=adminmode%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="search_category" value="<%=search_category%>">
<input type="hidden" name="search_word" value="<%=search_word%>">
<input type="hidden" name="category" value="<%=category%>">
<input type="hidden" name="order_c" value="<%=order_c%>">
<input type="hidden" name="order_da" value="<%=order_da%>">
  <tr>
    <td background="<%=skin_path%>t_bg.gif" height="15"></td>
  </tr>
  <tr>
    <td height="20" align="center">Delete Board</td>
  </tr>
  <tr>
    <td bgcolor="#F7F7F7">
			<table cellpadding="0" cellspacing="0" width="100%">
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
</form>
</table>
