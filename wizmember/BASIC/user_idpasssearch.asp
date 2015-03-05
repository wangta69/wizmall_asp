<!-- #include file="../../config/db_connect.asp" -->
<!-- #include file="../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%><%
Dim smode, qry, name, id, jumin1, jumin2, qry_result, mid
smode	= Request("smode")
qry		= Request("qry")
name		= Request("name")
id			= Request("id")
jumin1	= Request("jumin1")
jumin2	= Request("jumin2")
email		= Request("email")

if qry = "idsearch" then
	strSQL = "select m.mid, m.mpwd from wizmembers m, wizmembers_ind mi where mi.jumin1 = '" & jumin1 & "' and mi.jumin2 = '" & jumin2 & "' and mi.mid = m.mid"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if objRs.eof then
		qry_result  = "fail"
		qry_str		= "<font color='red'>정보를 찾을 수 없습니다. 다시 시도해 주세요</font>"
	else 
		qry_result	= "success"
		mid			= objRs("mid")
		mpwd		= objRs("mpwd")
	end if
elseif qry = "passsearch" then
	strSQL = "select m.mid, m.mpwd from wizmembers m, wizmembers_ind mi where mi.jumin1 = '" & jumin1 & "' and mi.jumin2 = '" & jumin2 & "' and mi.mid = m.mid"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if objRs.eof then
		qry_result  = "fail"
		qry_str		= "<font color='red'>정보를 찾을 수 없습니다. 다시 시도해 주세요</font>"
	else 
		qry_result	= "success"
		mid			= objRs("mid")
		mpwd		= objRs("mpwd")		
	end if
end if
%>
<script language="JavaScript">
<!--
function idcheckfnc(f){
	if(f.name.value == ""){
		alert('성함을 입력해 주세요')
		f.name.focus();
		return false;
	}else if(f.jumin1.value == ""){
		alert('주민번호를 입력해 주세요')
		f.jumin1.focus();
		return false;
	}else if(f.jumin2.value == ""){
		alert('주민번호를 입력해 주세요')
		f.jumin2.focus();
		return false;
	}else return true
}

function passcheckfnc(f){
	if(f.id.value == ""){
		alert('아이디를 입력해 주세요')
		f.id.focus();
		return false;
	}else if(f.name.value == ""){
		alert('성함을 입력해 주세요')
		f.name.focus();
		return false;
	}else if(f.jumin1.value == ""){
		alert('주민번호를 입력해 주세요')
		f.jumin1.focus();
		return false;
	}else if(f.jumin2.value == ""){
		alert('주민번호를 입력해 주세요')
		f.jumin2.focus();
		return false;
	}else return true
}


//-->
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22" class="company">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22" bgcolor="#F6F6F6" class="company">Home &gt; 아이디 및 비밀번호 
            찾기 </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr> 
          <td bgcolor="#EEEEEE">- 회원님!! <font color="#89BE38">아이디 또는 비밀번호</font>를 
            잊으셨나요? 입력하신 후 [확인]단추를 누르세요</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center">&nbsp;</td>
        </tr>
        <tr> 
          <td align="right">&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="26">&nbsp;</td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="14"><img src="wizmember/<%=MemberSkin%>/images/id1.gif" width="14" height="14"></td>
                <td background="wizmember/<%=MemberSkin%>/images/id2.gif"></td>
                <td width="14"><img src="wizmember/<%=MemberSkin%>/images/id3.gif" width="14" height="14"></td>
              </tr>
              <tr>
                <td background="wizmember/<%=MemberSkin%>/images/id4.gif">&nbsp;</td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="wizmember/<%=MemberSkin%>/images/id9.gif" height="90"></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="206"><img src="wizmember/<%=MemberSkin%>/images/id10.gif" width="206" height="114"></td>
                            <td>
<%
if qry = "idsearch" and qry_result = "fail" then
%>                         
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
						
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td colspan="7"><%=qry_str%></td>
                                          </tr>
                                    
                                  </table></td>
                                </tr>
                              </table>
<%
elseif qry = "idsearch" and qry_result = "success" then
%>                         
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
						
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td colspan="7">회원님의 아이디는 <b><%=mid%></b>입니다.</td>
                                          </tr>
                                    
                                  </table></td>
                                </tr>
                              </table>                              
<%
end if
%>
<%
if qry <> "idsearch" or qry_result <> "success" then
%> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <form action='wizmember.asp' method="post" onsubmit="return idcheckfnc(this)">
					<input type=hidden name="smode" value="<%=smode%>">
                      <input type=hidden name="qry" value="idsearch">
                      <input type=hidden name="outputmode" value="mail">							
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td width="87"><img src="wizmember/<%=MemberSkin%>/images/id11.gif" width="87" height="18"></td>
                                          <td width="132"><input type="text" name="name" id="name" style="border:1px solid #d9d9d9; width:130px; height:16px;">                                            </td>
                                          <td width="14">&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td width="8">&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                    <tr>
                                      <td height="8"></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                        </tr>
                                    <tr>
                                      <td><img src="wizmember/<%=MemberSkin%>/images/id12.gif" width="87" height="18"></td>
                                          <td><input type="text" name="jumin1" id="jumin1" style="border:1px solid #d9d9d9; width:130px; height:16px;"></td>
                                          <td align="center">-</td>
                                          <td width="132"><input type="password" name="jumin2" id="jumin2" style="border:1px solid #d9d9d9; width:130px; height:16px;"></td>
                                          <td>&nbsp;</td>
                                          <td width="60"><input type="image" src="wizmember/<%=MemberSkin%>/images/id13.gif" width="60" height="18"></td>
                                          <td>&nbsp;</td>
                                        </tr>
                                  </table></td>
                                </tr>
                                </form>
                              </table>
                              <% end if%></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
                <td background="wizmember/<%=MemberSkin%>/images/id5.gif">&nbsp;</td>
              </tr>
              <tr>
                <td><img src="wizmember/<%=MemberSkin%>/images/id6.gif" width="14" height="14"></td>
                <td background="wizmember/<%=MemberSkin%>/images/id7.gif"></td>
                <td><img src="wizmember/<%=MemberSkin%>/images/id8.gif" width="14" height="14"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="14"><img src="wizmember/<%=MemberSkin%>/images/id1.gif" width="14" height="14"></td>
                <td background="wizmember/<%=MemberSkin%>/images/id2.gif"></td>
                <td width="14"><img src="wizmember/<%=MemberSkin%>/images/id3.gif" width="14" height="14"></td>
              </tr>
              <tr>
                <td background="wizmember/<%=MemberSkin%>/images/id4.gif">&nbsp;</td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="wizmember/<%=MemberSkin%>/images/id14.gif" height="90"></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="206"><img src="wizmember/<%=MemberSkin%>/images/id16.gif" width="206" height="114"></td>
                            <td><%
if qry = "passsearch" and qry_result = "fail" then
%>                         
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
						
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td colspan="7"><%=qry_str%></td>
                                          </tr>
                                    
                                  </table></td>
                                </tr>
                              </table>
<%
elseif qry = "passsearch" and qry_result = "success" then
%>                         
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
						
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td colspan="7">회원님의 패스워드는 <b><%=mpwd%></b>입니다.</td>
                                          </tr>
                                    
                                  </table></td>
                                </tr>
                              </table>                              
<%
end if
%>
<%
if qry <> "passsearch" or qry_result <> "success" then
%> 
     
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <form action='wizmember.asp' method="post" onsubmit="return passcheckfnc(this)">
                                      <input type=hidden name="smode" value="<%=smode%>">
                                      <input type=hidden name="qry" value="passsearch">
                                      <input type=hidden name="outputmode" value="mail">	                                     
                                      <tr>
                                        <td><img src="wizmember/<%=MemberSkin%>/images/id15.gif" width="87" height="18"></td>
                                          <td><input type="text" name="id" id="textfield7" style="border:1px solid #d9d9d9; width:130px; height:16px;"></td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                      <tr>
                                        <td height="8"></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                        </tr>
                                      <tr>
                                        <td width="87"><img src="wizmember/<%=MemberSkin%>/images/id11.gif" width="87" height="18"></td>
                                          <td width="132"><input type="text" name="name" id="name" style="border:1px solid #d9d9d9; width:130px; height:16px;">                                            </td>
                                          <td width="14">&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td width="8">&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                      <tr>
                                        <td height="8"></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                          <td></td>
                                        </tr>
                                      <tr>
                                        <td><img src="wizmember/<%=MemberSkin%>/images/id12.gif" width="87" height="18"></td>
                                          <td><input type="text" name="jumin1" id="textfield5" style="border:1px solid #d9d9d9; width:130px; height:16px;"></td>
                                          <td align="center">-</td>
                                          <td width="132"><input type="password" name="jumin2" id="textfield6" style="border:1px solid #d9d9d9; width:130px; height:16px;"></td>
                                          <td>&nbsp;</td>
                                          <td width="60"><input type="image" src="wizmember/<%=MemberSkin%>/images/id13.gif" width="60" height="18"></td>
                                          <td>&nbsp;</td>
                                        </tr></form>
                                    </table></td>
                                </tr>
                                
                              </table> <% end if%></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
                <td background="wizmember/<%=MemberSkin%>/images/id5.gif">&nbsp;</td>
              </tr>
              <tr>
                <td><img src="wizmember/<%=MemberSkin%>/images/id6.gif" width="14" height="14"></td>
                <td background="wizmember/<%=MemberSkin%>/images/id7.gif"></td>
                <td><img src="wizmember/<%=MemberSkin%>/images/id8.gif" width="14" height="14"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="65">&nbsp;</td>
        </tr>
      </table></td>
        </tr>
        
      </table></td>
  </tr>
  <tr> 
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
</table>
