<%
Set util = new utility : Set db = new database : Set board = new boards
name	= user_name
id		= user_id
pass	= user_pwd
%>
<!-- 한줄쓰기 시작 -->

<script language="JavaScript">
<!--
function reple_check(f){
	if(f.name.value == ""){
		alert('성함을 넣어주세요');
		return false;	
	}else if(f.pass.value == ""){
		alert('패스워드를 넣어주세요');
		return false;	
	}else if(f.content.value == ""){
		alert('내용을 넣어주세요');
		return false;	
	}else{
		f.spamfree.value='<%=util.Linuxtime()%>';
		return true;
	}
}

function reple_del(bid, gid, uid, reple_uid){
window.open('<%=skin_path%>reple_del.asp?bid='+bid+'&gid='+gid+'&uid='+uid+'&reple_uid='+reple_uid+'&page=<%=page%>&adminmode=<%=adminmode%>&category=<%=category%>','RepleDelForm','width=300, height=150')

}
//-->
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr  height="1"> 
    <td height="1" colspan="6" align="center" bgcolor="#CCCCCC"></td>
  </tr>
<%
strSQL = "select * from wizboard_" & bid & "_" & gid & "_reply where b_uid=" & uid
''Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
content = util.ReplaceHtmlText(0, objRs("content"))
%>
 
  <tr> 
    <td width="30">&nbsp;</td>
    <td width="50"><%=objRs("name")%></td>
    <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
    <td ><%=content%></td>
    <td width="70" align="center" ><%=objRs("regdate")%> </td>
    <td width="20" align="center"><a href="javascript:;" onClick="reple_del('<%=bid%>', '<%=gid%>', '<%=uid%>', '<%=objRs("uid")%>')"><img src="<%=skin_path%>images/memo_del.gif" width="9" height="9" border="0"></a></td>
  </tr>
  <tr  height="1"> 
    <td height="1" colspan="6" align="center" bgcolor="#CCCCCC"></td>
  </tr>
<%
objRs.MOVENEXT
WEND
%>   
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
</table><form name="RepleWriteForm" method="post" onSubmit="return reple_check(this);" action="./wizboard/reple_ok.asp?bid=<%=bid%>&gid=<%=gid%>" enctype="multipart/form-data">
<input type="hidden" name="id" value="<%=user_id%>">
<input type="hidden" name="bid" value="<%=bid%>">
<input type="hidden" name="gid" value="<%=gid%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="spamfree" value="">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">


  <tr align="left"> 
      <td height="18" colspan="8">한줄글 쓰기</td>
  </tr>
  <tr  height="1"> 
    <td height="1" colspan="8" align="center" bgcolor="#CCCCCC"></td>
  </tr>
  <tr> 
    <td width="70" height="30">이름</td>
    <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
    <td align="left">&nbsp; <input name="name" type="text" style="width:100px; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" value="<%=name%>"></td>
    <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
    <td width="70">비밀번호</td>
    <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
    <td align="left">&nbsp; <input name="pass" type="password"  value="<%=pass%>" style="width:100px; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"></td>
    <td>&nbsp;</td>
  </tr>
  <tr  height="1"> 
    <td height="1" colspan="8" align="center" bgcolor="#CCCCCC"></td>
  </tr>
  <tr> 
    <td>내용</td>
    <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
    <td colspan="5" align="left">&nbsp; <textarea name="content"  rows="3"  style=" width:98%; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;color: #333333;"></textarea></td>
    <td align="center"><input type="submit" name="Submit" value="작성" style="width=60px; height=35px; cursor:pointer"></td>
  </tr>
  <tr> 
    <td height="5"></td>
    <td colspan="8"></td>
  </tr>
  <tr  height="1"> 
    <td height="1" colspan="9" align="center" bgcolor="#CCCCCC"></td>
  </tr>
</table></form>
<!-- 한줄 쓰기 끝 -->
