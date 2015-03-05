<!-- #include file = "../../../lib/exe.board.asp" -->
<%
set util	= new utility
set board	= new boards
%>
<style>
	#customWidget{display:inline-block; position:relative;}
	#colorSelector {
		position: relative;top: 4px;left: 4px;width: 28px;height: 28px;background: url(./js/jquery.plugins/colorpicker/images/select2.png) center; background-color:#000000;
	}
	#colorpickerHolder {
		top:32px; left:4px; width: 356px;height: 0;overflow: hidden;position: absolute; background-color:red;
	}
</style>
<script type="text/javascript">        
	$(document).ready(
		function()
		{
		var defaultColor = '<%=w_txtcolor%>';
		var setColor = defaultColor ? defaultColor:'000000';

		$("#colorSelector").css("backgroundColor", '#' + defaultColor);
		$('#colorpickerHolder').ColorPicker({
			flat: true,
			color: '#'+setColor,
			onChange: function (hsb, hex, rgb) { $("#txtcolor").val(hex); $('#colorSelector').css('backgroundColor', '#' + hex);},
			onSubmit: function(hsb, hex, rgb) {
			$('#colorSelector div').css('backgroundColor', '#' + hex);
		}
		}).bind('click', function(){
		});

		var widt = false;
		$('#colorSelector').bind('click', function() {
			$('#colorpickerHolder').stop().animate({height: widt ? 0 : 173}, 500);
			widt = !widt;
		});

	});
</script>

<script type="text/javascript" src="./js/jquery.plugins/jpicker-1.1.6/jpicker-1.1.6.min.js"></script>
<link type="text/css" rel="stylesheet" href="./js/jquery.plugins/jpicker-1.1.6/css/jPicker-1.1.6.min.css" />

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

<table width="100%" class="boardTbl_write">
	<col width="100px" />
	<col width="*" />
	<col width="100px" />
	<col width="*" />
            <tr>
              <th>제목</th>
              
              <td colspan="5" align="left">&nbsp;&nbsp;
                <input name="subject" type="text" class="required" msg="제목을 입력해 주세요" value="<%=w_subject%>" size="50" maxlength="80">

	      <input type="checkbox" value="1" name="txtbold"<% If w_txtbold = 1 then Response.Write " checked"%>> BOLD<!-- 텍스트 굵기 옵션 -->
		<input type="hidden" id="txtcolor" name="txtcolor" value="<%=w_txtcolor%>"></input><!-- color picker 옵션 -->
		<div id="customWidget">
			<div id="colorSelector"></div>
			<div id="colorpickerHolder"></div>
		</div>

                <%
if sethtmleditor = 1 then
 	Response.Write "<input type=hidden name='option_html' value='1'>"
				
else 
 IF (option_html = 1) OR (option_html = 2) THEN Html_Check = "CHECKED"
%>
                <input type=checkbox name="option_html" <%=Html_Check%> value="1">
                HTML사용&nbsp;&nbsp;
<%
end if
IF option_secret = 1 THEN Secret_Check = "CHECKED"
%>
                <input type=checkbox name="option_secret" <%=Secret_Check%> value="1">
                비밀글                      &nbsp;&nbsp;
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
            <tr>
              <th>글쓴이</th>
              
              <td align="left">&nbsp;&nbsp;
              <input name="name" type="text" class="required" msg="이름을 입력해 주세요" value="<%=w_name%>" size="40" maxlength="40"></td>
              
              <th>비밀번호</th>
              
              <td align="left">&nbsp;&nbsp;
              <input name="pass" type="password" class="required"  msg="비밀번호를 입력해 주세요" value="<%=w_pass%>" size="15" maxlength="15"></td>
            </tr>
            <tr>
              <th>이메일</th>
              
              <td colspan="5" align="left">&nbsp;&nbsp;
                <input name="email" type="text" value="<%=w_email%>" size="60" maxlength="80">
              </td>
            </tr>
            <%
if setcategoryenable = 1 then
%>
            <tr>
              <th> 카테고리 </th>
              
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
            <%
end if
%>


            <tr>
              <td height="180" colspan="4" align="center"><textarea name="content" id="board_content" rows="12" style="width:98%" class="required" msg="내용을 입력해 주세요" ><%=w_content%></textarea></td>
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
            <% for i=1 to setfilenum %>
            <tr>
              <th>첨부파일(<%=i%>)</th>
              
              <td colspan="5" align="left">&nbsp;&nbsp;
                <input name="attached" type="file" id="attached">
                <% if smode = "edit" then Response.Write "<input name='file_del' type='checkbox' value='1'>파일삭제" %>              </td>
            </tr>
            <%
next
%>

          </table></td>
      </tr>
      <tr>
        <td align="center"><table height="30" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="62"><a class="btn_save"><img src="<%=skin_path%>icon/save_btn.gif" border="0"></a></td>
              <td width="62"><a href="javascript:history.back(-1);"><img src="<%=skin_path%>icon/cancel_btn.gif" border="0"></a></td>
            </tr>
          </table>
</form>
<%
SET objRs = NOTHING : Set db = Nothing : Set util = Nothing
%>