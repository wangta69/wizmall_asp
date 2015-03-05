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
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <form name="WRITE_FORM" method="post" onsubmit="return WRITE_FUNC(this);" enctype="MULTIPART/FORM-DATA" action="./wizboard/write_ok.asp?bid=<%=bid%>&gid=<%=gid%>";>
      <input type="hidden" name="move_layer" value="">
      <input type="hidden" name="smode" value="<%=smode%>">
      <input type="hidden" name="bid" value="<%=bid%>">
      <input type="hidden" name="gid" value="<%=gid%>">
      <input type="hidden" name="adminmode" value="<%=adminmode%>">
      <input type="hidden" name="uid" value="<%=uid%>">
      <input type="hidden" name="userid" value="<%=user_id%>">
      <input type="hidden" name="spamfree" value="">
      <tr>
        <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr  height="2" >
              <td height="2" colspan="3" bgcolor="#999999"></td>
            </tr>
            <tr>
              <td width="99" height="30" align="center">제목</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">&nbsp;&nbsp;
              <input name="subject" type="text" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" checkenable  msg="제목을 입력해 주세요" value="<%=subject%>" size="50" maxlength="80"></td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="3" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <tr>
              <td width="99" height="30" align="center">비밀번호</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">&nbsp;&nbsp;
              <input name="pass" type="password" style="border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" id="pass"  msg="비밀번호를 입력해 주세요" value="<%=pass%>" size="15" maxlength="15" /></td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="3" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <%
if setcategoryenable = 1 then
%>
            <tr>
              <td width="99" height="30" align="center"> 카테고리</td>
              <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
              <td align="left">&nbsp;&nbsp;
                <select name=category>
                  <%
if setcategoryenable = 1 then
			strSQL = "select * from wiztable_category where bid='" & bid & "' and gid='" & gid & "'"
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			Dim SelectValue
			WHILE NOT(objRs.EOF)
				IF int(category) = int(objRs("intCategoryNum")) Then
					SelectValue = " selected "
				Else
					SelectValue = ""
				End if
				Response.Write "<option value=" & objRs("intCategoryNum") & SelectValue & ">" & objRs("CategoryName") & "</option>" & vbcrlf
			objRs.MOVENEXT
			WEND
end if
%>
                </select>              </td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="3" align="center" bgcolor="#CCCCCC"></td>
            </tr>
            <%
end if
%>
            <tr>
              <td height="180" colspan="3" align="center"><textarea name="content" cols="95" rows="12" checkenable msg="내용을 입력해 주세요" style=" width:98%; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;"><%=content%></textarea></td>
            </tr>
            <tr  height="1">
              <td height="1" colspan="3" align="center" bgcolor="#CCCCCC"></td>
            </tr>
<% for i=1 to setfilenum %> 				  
                  <tr> 
                    <td width="99" height="30" align="center">첨부파일(<%=i%>)</td>
                    <td width="1" align="center" valign="middle" bgcolor="f0f0f0"><img src="<%=skin_path%>images/dotline.gif" width="1" height="25"></td>
                    <td colspan="5" align="left">&nbsp;&nbsp; <input name="attached" type="file" style="width:350px; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" id="attached" maxlength="80">
                     <% if smode = "edit" then Response.Write "<input name='file_del' type='checkbox' value='1'>파일삭제" %>                    </td>
            </tr>
                  <tr  height="1"> 
                    <td height="1" colspan="7" align="center" bgcolor="#CCCCCC"></td>
                  </tr>
<%
next
%>
            <tr>
              <td colspan="3" align="center">&nbsp;</td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td align="center"><table height="30" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="62"><input type="image" src="<%=skin_path%>icon/save_btn.gif" border="0"></td>
              <td width="62"><a href="javascript:history.back(-1);"><img src="<%=skin_path%>icon/cancel_btn.gif" border="0"></a></td>
            </tr>
          </table></td>
      </tr>
    </form>
  </table>
</div>
<%
SET objRs = NOTHING : Set db = Nothing : Set util = Nothing
%>
