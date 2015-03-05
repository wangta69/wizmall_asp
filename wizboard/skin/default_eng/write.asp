<!-- #include file = "../../../lib/exe.board.asp" -->
<%
set util	= new utility
set board	= new boards
%>
<DIV id="board_write_form_trans_div" style="display:none"> <br>
  <br>
  <br>
  <br>
  <table cellpadding="3" cellspacing="1" bgcolor="#E7E3E7" align="center" width="308">
    <tr>
      <td width="300" bgcolor="white" height="100" align="center"><b>작성글을 저장중입니다.</b><br>
        <br>
        잠시만 기다려 주시기 바랍니다.</td>
    </tr>
  </table>
</DIV>

    <form name="board_write_form" id="board_write_form" method="post" enctype="MULTIPART/FORM-DATA" action="./wizboard/write_ok.asp?bid=<%=bid%>&gid=<%=gid%>";>
      <input type="hidden" name="move_layer" value="">
      <input type="hidden" name="smode" value="<%=smode%>">
      <input type="hidden" name="bid" value="<%=bid%>">
      <input type="hidden" name="gid" value="<%=gid%>">
      <input type="hidden" name="adminmode" value="<%=adminmode%>">
      <input type="hidden" name="uid" value="<%=uid%>">
      <input type="hidden" name="userid" value="<%=user_id%>">
      <input type="hidden" id="spamfree" name="spamfree" value=""> 
	  <input type="hidden" id="hidden_tmp_spamfree" value="<%=util.Linuxtime%>"> 
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">

      <tr>
        <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr  height="2" >
              <td height="2" colspan="7" bgcolor="#999999"></td>
            </tr>
            <tr>
              <td width="99" height="30" align="center">Subject</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">&nbsp;&nbsp;
                <input name="subject" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"  class="required" msg="Pls. Input Subject" value="<%=w_subject%>" size="50" maxlength="80">
                <%
if sethtmleditor = 1 then
 	Response.Write "<input type=hidden name='option_html' value='1'>"
				
else 
 IF (option_html = 1) OR (option_html = 2) THEN Html_Check = "CHECKED"
%>
                <input type=checkbox name="option_html" <%=Html_Check%> value="1">
                use HTML&nbsp;&nbsp;
<%
end if
IF option_secret = 1 THEN Secret_Check = "CHECKED"
%>
                <input type=checkbox name="option_secret" <%=Secret_Check%> value="1">
                Secret                      &nbsp;&nbsp;
                <%
if util.is_Admin = True then
	IF (notice = 1) THEN notice_Check = "CHECKED"
%>
                <input type=checkbox name="notice" <%=Html_Check%> value="1">
                Notice
                <%
end if
%>
              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <tr>
              <td width="99" height="30" align="center">Name</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">&nbsp;&nbsp;
              <input name="name" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"  class="required" msg="Pls, Input Name" value="<%=w_name%>" size="40" maxlength="40"></td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td width="99" align="center">Password</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">&nbsp;&nbsp;
              <input name="pass" type="password" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" class="required"  msg="Pls, Input password" value="<%=w_pass%>" size="15" maxlength="15"></td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <tr>
              <td width="99" height="30" align="center">Email</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">&nbsp;&nbsp;
                <input name="email" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" value="<%=w_email%>" size="60" maxlength="80">
              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <%
if setcategoryenable = 1 then
%>
            <tr>
              <td width="99" height="30" align="center"> Category </td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">&nbsp;&nbsp;
                <select name=category>
                  <%
if setcategoryenable = 1 Then
			Set db = new database
			strSQL = "select * from wiztable_category where bid='" & bid & "' and gid='" & gid & "'"
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			Dim SelectValue
			WHILE NOT(objRs.EOF)
				IF int(w_category) = int(objRs("intCategoryNum")) Then
					SelectValue = " selected "
				Else
					SelectValue = ""
				End if
				Response.Write "<option value=" & objRs("intCategoryNum") & SelectValue & ">" & objRs("CategoryName") & "</option>" & vbcrlf
			objRs.MOVENEXT
			WEND
end if
%>
                </select>
              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <%
end if
%>


            <tr>
              <td height="180" colspan="7" align="center"><textarea name="content" id="board_content" cols="95" rows="12" class="required" msg="Pls, Input contents" style=" width:98%; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"><%=w_content%></textarea></td>
<% if sethtmleditor = 1 then %>
<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "board_content",
	sSkinURI: "./js/Smart/SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});

function insertIMG(irid,fileame)
{
 
    var sHTML = "<img src='" + fileame + "' border='0'>";
    oEditors.getById[irid].exec("PASTE_HTML", [sHTML]);
 
}
</script>
<% end if %> 
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <% for i=1 to setfilenum %>
            <tr>
              <td width="99" height="30" align="center">Attached(<%=i%>)</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">&nbsp;&nbsp;
                <input name="attached" type="file" style="width:350px; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" id="attached" maxlength="80">
                <% if smode = "edit" then Response.Write "<input name='file_del' type='checkbox' value='1'>Delete File" %>              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <%
next
%>
            <tr>
              <td colspan="7" align="center">&nbsp;</td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td align="center"><table height="30" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="62"><a class="btn_save"><img src="<%=skin_path%>icon/save_btn.gif" border="0"></a></td>
              <td width="62"><a href="javascript:history.back(-1);"><img src="<%=skin_path%>icon/cancel_btn.gif" border="0"></a></td>
            </tr>
          </table></td>
      </tr>
    
  </table></form>
<%
SET objRs = NOTHING : Set db = Nothing : Set util = Nothing
%>