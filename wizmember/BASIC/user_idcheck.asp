<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim db,strSQL,objRs
''Dim util
''Set util = new utility	
Set db = new database
Dim flag, id
id = trim(Request("id"))
if id <> "" then
	strSQL = "select mid from wizmembers where mid = '" & id & "'" 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if objRs.eof then
		flag = 1
	else
		flag = 2
	end if
end if
db.Dispose : Set db = Nothing : Set objRs = Nothing
%>
<html>
<head>
<title>아이디 중복확인</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<style>
body,table,tr,td,input,form{
font-family:돋움; font-size:9pt; color:#666666; line-height:120%;
}

body { scrollbar-3dlight-color:#FFFFFF;
       scrollbar-arrow-color:#939393;
       scrollbar-track-color:#F4F4F4;
       scrollbar-darkshadow-color:#FFFFFF;
       scrollbar-face-color:#EDEDED;
       scrollbar-highlight-color:#FAFAFA;
       scrollbar-shadow-color:#BDBDBD	
 }
</style>
<script language="JavaScript">
<!--
function id_check(){
 var f = document.idcheckForm
 	if(f.id.value == ""){
		alert('아이디를 입력해 주세요');
		f.id.focus();
		return false;
	}else{
	return true;
	}
}

function setting(id) {
opener.document.FrmUserInfo.id.value = id;
self.close();
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="350" border="0" cellspacing="0" cellpadding="0" class="maintxt">
  <tr> 
    <td><img src="img_idcheck/t04.gif" width="350" height="40"></td>
  </tr>
  <tr> 
    <td> <table width="350" border="0" cellspacing="0" cellpadding="5" class="stage_txt">
        <tr> 
          <td height="1" width="100" bgcolor="#DFDFDF"></td>
        </tr>
        <tr> 
<% 
if flag = 1 then
%>		
          <td height="24" class="maintxt"><img src="img_idcheck/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle">사용가능 
            메시지</td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="80" class="maintxt"></td>
        </tr>
        <tr> 
          <td height="50" class="maintxt"><img src="img_idcheck/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle"><b><%=id%></b> 
            사용할 수 있습니다. 등록할까요?</td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="80" class="maintxt"></td>
        </tr>
<%
elseif flag = 2 then
%>		
        <tr> 
          <td height="24" class="maintxt"><img src="img_idcheck/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle">중복 
            확인 메시지</td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="80" class="maintxt"></td>
        </tr>
        <tr> 
          <td height="50" class="maintxt"><img src="img_idcheck/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle"><b><%=id%></b> 
            는<span class="text">사용할 수 없는 ID입니다. 다른 ID를 입력하세요.</span></td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="80" class="maintxt"></td>
        </tr>
<%
end if
%>		
        <tr> 
          <td height="24" class="maintxt"><img src="img_idcheck/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle">아이디 
            입력 메시지</td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="80" class="maintxt"></td>
        </tr>
        <tr> 
          <td height="24" class="maintxt"><span class="text"><img src="img_idcheck/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle">아이디는 
            <b>4자 이상 12자 이내</b>로 만들어 주세요</span></td>
        </tr>
<form name="idcheckForm" action="user_idcheck.asp" method="post" onSubmit="return id_check()">		
        <tr> 
          <td height="24" class="txt"> <div align="center"> 
              <input class=maintxt style="BORDER-RIGHT: rgb(214,214,214) 1px solid; BORDER-TOP: rgb(214,214,214) 1px solid; BORDER-LEFT: rgb(214,214,214) 1px solid; BORDER-BOTTOM: rgb(214,214,214) 1px solid" 
                  maxlength=214 size=15 name="id" value="<%=id%>">
             <input type="image" src="img_idcheck/bt_search.gif" width="48" height="18" align="absmiddle" vspace="0" hspace="5" border="0"> 
            </div></td>
        </tr>
</form>		
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="80"></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="50" height="5" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td></td>
  </tr>
</table>
<table width="350" height="40" border="0" cellpadding="0" cellspacing="0" background="img_idcheck/t05.gif">
  <tr> 
    <td class="maintxt"><div align="right"><a href="javascript:;"onFocus='this.blur()' onClick="setting('<%=id%>')"><img src="img_idcheck/icon_ok.gif" width="55" height="25" border="0"></a></div></td>
    <td width="20" class="maintxt">&nbsp;</td>
    <td class="maintxt"><a href="javascript:self.close();"onFocus='this.blur()'><img src="img_idcheck/icon_cancel.gif" width="55" height="25" border="0"></a></td>
  </tr>
</table>
</body>
</html>
