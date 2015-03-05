<%
name	= user_name
id		= user_id
pass	= user_pwd
%>
<!-- 한줄쓰기 시작 -->

<script language="JavaScript">
<!--
function reple_check(){
	var f = document.RepleWriteForm;
	if(f.name.value == ""){
		alert('성함을 넣어주세요');
		return false;	
	}else if(f.pass.value == ""){
		alert('패스워드를 넣어주세요');
		return false;	
	}else if(f.content.value == ""){
		alert('내용을 넣어주세요');
		return false;	
	}
}

function reple_del(bid, gid, uid, reple_uid){
window.open('<%=skin_path%>reple_del.asp?bid='+bid+'&gid='+gid+'&uid='+uid+'&reple_uid='+reple_uid,'RepleDelForm','width=300, height=150')

}
//-->
</script>
<%
strSQL = "select * from wizboard_" & bid & "_" & gid & "_reply where b_uid=" & uid
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
content = util.ReplaceHtmlText(0, objRs("content"))
%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td bgcolor="#efefef" height="1"></td>
          </tr>
          <tr>
            <td valign="top" style="padding-left:15; padding-right:15; padding-top:12"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="25" bgcolor="#efefef" style="padding-left:5"><span class="text"><%=objRs("name")%> </span>&nbsp;&nbsp;<span class="text-smalltahoma">[date
                      : <%=objRs("regdate")%>]</span></td>
                  <td width="60" align="right" bgcolor="#efefef"><!--<img src="images/co_edit.gif" width="51" height="15" onclick='co_editit("co_edit","2");' style="cursor:pointer;">--></td>
                  <td width="58" align="center" bgcolor="#efefef"><a href="javascript:;" onClick="reple_del('<%=bid%>', '<%=gid%>', '<%=uid%>', '<%=objRs("uid")%>')"><img src="<%=skin_path%>images/co_delete.gif" width="51" height="15" border="0" style="cursor:pointer;" ></a></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td valign="top" class="text" style="padding-left:20; padding-right:15; padding-top:5; padding-bottom:15"> <%=content%></td>
          </tr>
        </table>
<%
objRs.MOVENEXT
WEND
%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="RepleWriteForm" method="post" onSubmit="return reple_check();" action="./wizboard/reple_ok.asp">
<input type="hidden" name="id" value="<%=user_id%>">
<input type="hidden" name="bid" value="<%=bid%>">
<input type="hidden" name="gid" value="<%=gid%>">
<input type="hidden" name="uid" value="<%=uid%>">  	  
        <!--===============코멘트 쓰기 폼 시작=================================================================-->

          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              
				<tr>
                  <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
                </tr>
                <tr>
                  <td width="100" height="26" align="center" bgcolor="#efefef" class="text-smalltahoma"><strong>comment</strong></td>
                  <td bgcolor="#f7f7f7" style="padding-left:5; padding-bottom:3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="40" class="ft1"><font color="#B4B4B4">이름</font>: </td>
                        <td width="90" class="text-small"><input name="name" type="text" id="name" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 16px; width:80px" value="<%=name%>">
                        </td>
                        <td width="70" class="ft1"><font color="#B4B4B4">비밀번호</font> : </td>
                        <td width="230"><input name="pass" type="password" id="pass" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 16px; width:80px" value="<%=pass%>">
                          <font class="e1" size="2" color="#333333"></font> </td>
                        <td width="100" align="right" class="text-small"><input type="image" src="<%=skin_path%>images/co_submit.gif" width="51" height="15" border="0"  style="cursor:pointer;"> </td>
                      </tr>
                    </table>
                    <textarea name="content" id="content" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 70px; width:99%"></textarea></td>
                </tr>
                <tr>
                  <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
                </tr>
              </table></td>
          </tr></form>
      </table>
