<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%><%
Dim qry_result, mid
smode	= Request("smode")
query	= Request("query")
name	= Request("name")
id		= Request("id")
jumin1	= Request("jumin1")
jumin2	= Request("jumin2")

if query = "idsearch" then
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
elseif query = "passsearch" then
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<title>
<!--#include virtual="/inc/title.htm"-->
</title>
<style type="text/css">
body {
	background:#666666;
	margin:0;
	padding:10px;
}
</style>
<script language="javascript">
<!--
	resizeTo(496,570);
//-->
</script>
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
</head>
<body>
<table width="466" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td><table width="466" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="./images_pop/id9.gif" width="419" height="90"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="23"></td>
                    </tr>
                    <tr>
                      <td height="47" align="left" style="padding-left:45px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                        <%
if query = "idsearch" and qry_result = "fail" then
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
elseif query = "idsearch" and qry_result = "success" then
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
if query <> "idsearch" or qry_result <> "success" then
%>
                        <table border="0" cellspacing="0" cellpadding="0">
                          <form action='./pop_idpasssearch.asp' method="post" onsubmit="return idcheckfnc(this)">
                            <input type=hidden name="smode" value="<%=smode%>">
                            <input type=hidden name="query" value="idsearch">
                            <input type=hidden name="outputmode" value="mail">
                            <tr>
                              <td><img src="./images_pop/id11.gif" width="87" height="18"></td>
                              <td><input type="text" name="name" id="name" style="border:1px solid #d9d9d9; width:80px; height:16px;">
                              </td>
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
                              <td><img src="./images_pop/id12.gif" width="87" height="18"></td>
                              <td><input type="text" name="jumin1" id="jumin1" style="border:1px solid #d9d9d9; width:80px; height:16px;"></td>
                              <td align="center">-</td>
                              <td><input type="text" name="jumin2" id="jumin2" style="border:1px solid #d9d9d9; width:80px; height:16px;"></td>
                              <td>&nbsp;</td>
                              <td><input type="image" src="./images_pop/id13.gif" width="60" height="18" border="0"></td>
                              <td>&nbsp;</td>
                            </tr>
                          </form>
                        </table>
                        <% end if%>
                      </td>
                    </tr>
                    <tr>
                      <td height="36">&nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#666666" height="10"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="./images_pop/id14.gif" width="466" height="90"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="23"></td>
                    </tr>
                    <tr>
                      <td height="47" align="left" style="padding-left:45px;"><%
if query = "passsearch" and qry_result = "fail" then
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
elseif query = "passsearch" and qry_result = "success" then
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
if query <> "passsearch" or qry_result <> "success" then
%>
                        <table border="0" cellspacing="0" cellpadding="0">
                          <form action='./pop_idpasssearch.asp' method="post" onsubmit="return passcheckfnc(this)">
                            <input type=hidden name="smode" value="<%=smode%>">
                            <input type=hidden name="query" value="passsearch">
                            <input type=hidden name="outputmode" value="mail">
                            <tr>
                              <td><img src="./images_pop/id15.gif" width="87" height="18"></td>
                              <td><input type="text" name="id" id="textfield7" style="border:1px solid #d9d9d9; width:80px; height:16px;"></td>
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
                              <td><img src="./images_pop/id11.gif" width="87" height="18"></td>
                              <td><input type="text" name="name" id="name" style="border:1px solid #d9d9d9; width:80px; height:16px;">
                              </td>
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
                              <td><img src="./images_pop/id12.gif" width="87" height="18"></td>
                              <td><input type="text" name="jumin1" id="textfield5" style="border:1px solid #d9d9d9; width:80px; height:16px;"></td>
                              <td align="center">-</td>
                              <td><input type="text" name="jumin2" id="textfield6" style="border:1px solid #d9d9d9; width:80px; height:16px;"></td>
                              <td>&nbsp;</td>
                              <td><input type="image" src="./images_pop/id13.gif" width="60" height="18" border="0"></td>
                              <td>&nbsp;</td>
                            </tr>
                          </form>
                        </table>
                        <% end if%>
                      </td>
                    </tr>
                    <tr>
                      <td height="35">&nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="right" bgcolor="#666666"><a href="javascript:self.close()"><img src="./images_pop/close.gif" width="76" height="20" border="0"></a></td>
  </tr>
</table>
</body>
</html>
