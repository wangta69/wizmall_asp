<!-- #include file = "../../../lib/cfg.board.asp" -->
<!--#include file = "../../include/login_exec.asp"-->
<br>
<br>
<table cellpadding="3" cellspacing="1" bgcolor="black" align="center" width="228">
<form name = "frm1" action = "memberlogin_ok.asp" method="post" onsubmit = "return login_check();">
<input type="hidden" name="board_id" value="<%=board_id%>">
<input type="hidden" name="group_name" value="<%=group_name%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="category" value="<%=category%>">
<input type="hidden" name="search_category" value="<%=search_category%>">
<input type="hidden" name="search_word" value="<%=search_word%>">
<input type="hidden" name="order_c" value="<%=order_c%>">
<input type="hidden" name="order_da" value="<%=order_da%>">
	<tr>
		<td align="center" class="Tahoma8"><font color="white"><b>Member Login</b></font></td>
	</tr>
	<tr>
		<td bgcolor="white" height="116">
			<table cellpadding="0" cellspacing="0" width="100%" bordercolordark="black" bordercolorlight="black">
				<tr>
					<td height="32" align="right" class="Tahoma8">ID&nbsp;</td>
					<td height="32" class="Tahoma8"><input type="text" name="login_id" size="14" class="input" value="<%=strLoginSaveID%>"></td>
				</tr>
				<tr>
					<td height="32" align="right" class="Tahoma8">Password&nbsp;</td>
					<td height="32" class="Tahoma8"><input type="password" name="login_pwd" size="14" class="input" value="<%=strLoginSavePwd%>"></td>
				</tr>
				<tr>
					<td height="28" colspan="2" class="Tahoma8" align="right"><font color="#ED4E96"><%=btnLoginSaveCheck%></font>&nbsp;Save Login&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr align="center">
					<td height="23" colspan="2"><input type="image" name="formimage1" src="<%=skin_path%>i_login.gif" width="43" height="13" border="0">&nbsp;<%=Btn_Back_Start%><img src="<%=skin_path%>back.gif" width="42" height="13" border="0"><%=Btn_Back_End%></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
