<!-- #include file = "../../../lib/exe.board.asp" -->
<%
set util	= new utility
set board	= new boards
%>
<div id="board_write_form_trans_div" style="display:none; width:308px; height:100px"> <br />
  <br />
  <br />
  <br />
  <table cellpadding="3" cellspacing="1" bgcolor="#E7E3E7" align="center" width="308">
    <tr>
      <td width="300" bgcolor="white" height="100" align="center"><b>작성글을 저장중입니다.</b><br>
        <br>
        잠시만 기다려 주시기 바랍니다.</td>
    </tr>
  </table>
</div>

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
      <input type="hidden" id="sethtmleditor" value="<%=sethtmleditor%>" /><!-- html editor 사용여부 -->
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">

      <tr>
        <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr  height="2" >
              <td height="2" colspan="7" bgcolor="#999999"></td>
            </tr>
            
            <tr>
              <td width="99" height="30" align="center">신청내용</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">
               <select name="sub_subject1" class="required" msg="신청내용을 입력해 주세요">
			<option value="">선택하세요</option>
			<option value="영어창의력캠프"<% IF w_sub_subject1 = "영어창의력캠프" THEN Response.Write(" selected") %>>영어창의력캠프</option>
			<option value="영재창의력프로그램""<% IF w_sub_subject1 = "영재창의력프로그램" THEN Response.Write(" selected") %>>영재창의력프로그램</option>
			<option value="해외창의력캠프""<% IF w_sub_subject1 = "해외창의력캠프" THEN Response.Write(" selected") %>>해외창의력캠프</option>
			<option value="국내창의력캠프""<% IF w_sub_subject1 = "국내창의력캠프" THEN Response.Write(" selected") %>>국내창의력캠프</option>
		</select>
              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>




            <tr>
              <td width="99" height="30" align="center">제목</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">
                <input name="subject" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"  class="required" msg="제목을 입력해 주세요" value="<%=w_subject%>" size="50" maxlength="80">
                <%
if sethtmleditor = 1 then
 	Response.Write "<input type=hidden name='option_html' value='1'>"
				
else 
 IF (option_html = 1) OR (option_html = 2) THEN Html_Check = "CHECKED"
%>
                <input type=checkbox name="option_html" <%=Html_Check%> value="1">
                HTML사용
<%
end if
IF option_secret = 1 THEN Secret_Check = "CHECKED"
%>
                <input type=checkbox name="option_secret" <%=Secret_Check%> value="1">
                비밀글                      
                <%
if util.is_Admin = True then
	IF (notice = 1) THEN notice_Check = "CHECKED"
%>
                <input type=checkbox name="notice" <%=Html_Check%> value="1">
                공지글
                <%
end if
%>
              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <tr>
              <td width="99" height="30" align="center">글쓴이</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">
              <input name="name" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"  class="required" msg="이름을 입력해 주세요" value="<%=w_name%>" size="35" maxlength="40"></td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td width="99" align="center">비밀번호</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">
              <input name="pass" type="password" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" class="required"  msg="비밀번호를 입력해 주세요" value="<%=w_pass%>" size="35" maxlength="15"></td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>


            <tr>
              <td width="99" height="30" align="center">휴대전화</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">
              <input name="sub_subject2" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"  class="required" msg="연락처를 입력해 주세요" value="<%=w_sub_subject2%>" size="35" maxlength="40"></td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td width="99" align="center">이메일</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">
               <input name="email" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" value="<%=w_email%>" size="35" maxlength="80"></td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
            </tr>


            <%
if setcategoryenable = 1 then
%>
            <tr>
              <td width="99" height="30" align="center"> 카테고리 </td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">
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
              <td height="180" colspan="7" align="center"><textarea name="content" id="board_content" rows="12" style="width:98%" class="required" msg="내용을 입력해 주세요" ><%=w_content%></textarea></td>
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
              <td width="99" height="30" align="center">첨부파일(<%=i%>)</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td colspan="5" align="left">
                <input name="attached" type="file" id="attached">
                <% if smode = "edit" then Response.Write "<input name='file_del' type='checkbox' value='1'>파일삭제" %>              </td>
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