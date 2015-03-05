<!-- #include file = "../../../lib/exe.board.asp" -->
<%
set util	= new utility
set board	= new boards
%>
<DIV id=write_view style="display:none"> <br>
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
<DIV id=write_form style="display:block"> 
          <form name="WRITE_FORM" method="post" onsubmit="return WRITE_FUNC();" enctype="MULTIPART/FORM-DATA" action="./wizboard/write_ok.asp?bid=<%=bid%>&gid=<%=gid%>";>
            <input type="hidden" name="move_layer" value="">
            <input type="hidden" name="smode" value="<%=smode%>">
            <input type="hidden" name="bid" value="<%=bid%>">
            <input type="hidden" name="gid" value="<%=gid%>">
			<input type="hidden" name="adminmode" value="<%=adminmode%>">
            <input type="hidden" name="uid" value="<%=uid%>">
			<input type="hidden" name="userid" value="<%=user_id%>">
			<input type=hidden name="option_html" value="1">
			<input type="hidden" name="spamfree" value="">
<table width="580" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="35" align="right" valign="bottom" style="padding-bottom:2px" class="paging">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
        </tr>
        <tr>
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">분류</td>
<%
IF option_secret = 1 THEN 
	Secret_Check1 = "CHECKED"
ELSE
	Secret_Check2 = "CHECKED"
END IF
%>		  
          <td align="left" bgcolor="#F7F7F7" style="padding-left:5"><input type="radio" value="0" checked name="option_secret" <%=Secret_Check2%> />          
            일반
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" value="1" name="option_secret" <%=Secret_Check1%>>
            비밀 <input type=checkbox name="notice" <%=Html_Check%> value="1">
            공지글</td>
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
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">이름</td>
          <td align="left" bgcolor="#F9F9F9" style="padding-left:5"><input name="name" type="text" id="name" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 18px; width:50%" value="<%=w_name%>" >          </td>
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
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">이메일</td>
          <td align="left" bgcolor="#F9F9F9" style="padding-left:5"><input name="email" type="text" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 18px; width:50%" value="<%=w_email%>">          </td>
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
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">글제목</td>
          <td align="left" bgcolor="#F9F9F9" style="padding-left:5"><input name="subject" type="text" id="subject" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 18px; width:99%" value="<%=w_subject%>">          </td>
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
          <td width="100" align="center" bgcolor="#EFEFEF" class="ft1">내 용</td>
          <td bgcolor="#F9F9F9" style="padding-left:5; padding-top:3; padding-bottom:3"><table border=0 cellpadding=0 cellspacing=0 width="100%">
              <tr>
                <td align="left"><!--<textarea name="content" cols="95" rows="12" checkenable msg="내용을 입력해 주세요" style=" width:98%; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"><%=w_content%></textarea>-->
                      <!-- GmEditor begin-->
                      <!-- #include file = "../../../js/gmEditor/func_editor.asp" -->
<%
' 이미지 업로드 사용 (1은 사용안함)
upload_image = ""
' 미디어 업로드 사용 (1은 사용안함)
upload_media = ""

editor_Url = "./js/gmEditor"
Response.Write "<script language='javascript'>" & vbcrlf
Response.Write "<!--" & vbcrlf
Response.Write "var _editor_url = '.';" & vbcrlf
Response.Write "var _contentValue = 'CONTENTS';" & vbcrlf
Response.Write "var _contentName = 'WRITE_FORM';" & vbcrlf
Response.Write "var _i_uploaded = '"&upload_image&"';" & vbcrlf
Response.Write "var _m_uploaded = '"&upload_media&"';" & vbcrlf
Response.Write "//Edit_Modify(_contentName,_contentValue)" & vbcrlf
Response.Write "//-->" & vbcrlf
Response.Write "</script>" & vbcrlf
response.Write myEditor(1,editor_Url,"WRITE_FORM","content","500","250")
%>

                    <!-- GmEditor end-->                  </td>
              </tr>
            </table>
            <!-- ActiveX Write End !!-->
          </td>
        </tr>
        <tr>
          <td height="1" colspan="2" bgcolor="#DDDDDD"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
<% for i=1 to setfilenum %>   
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">첨부파일(<%=i%>)</td>
          <td align="left" bgcolor="#F9F9F9" style="padding-left:5"><input name="attached" type="file" style="width:350px; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" id="attached" maxlength="80">
                     <% if smode = "edit" then Response.Write "<input name='file_del' type='checkbox' value='1'>파일삭제" %>          </td>
        </tr>
        <tr>
          <td height="1" colspan="2" bgcolor="#DDDDDD"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
<%
next
%>	  
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">비밀번호</td>
          <td align="left" bgcolor="#F9F9F9" style="padding-left:5"><input name="pass" type="password" id="pass" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 18px; width:25%" value="<%=pass%>">
            <span class="text-small"> 글 수정/삭제시 필요합니다</span></td>
        </tr>
        <tr>
          <td height="1" colspan="2" bgcolor="#DDDDDD"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
</table>
<table width="580" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="img/blank.gif" width="1" height="7"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td height="60"><input type="image" src="<%=skin_path%>icon/save_btn.gif" border="0"></td>
          <td align="right"><a href="javascript:document.fom.reset();"></a></td>
          <td width="75" align="right"><a href="javascript:history.back(-1);"><img src="<%=skin_path%>icon/cancel_btn.gif" border="0"></a></td>
        </tr>
      </table></td>
  </tr>
</table></form>
</div>
<%
SET objRs = NOTHING : Set db = Nothing : Set util = Nothing
%>
