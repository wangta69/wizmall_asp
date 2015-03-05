<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database

	Dim Db_Odbc_Name, Db_Odbc_User, Db_Odbc_Pass, PATH_URL, SYSTEM_URL, sql_ip, upload_component
	Dim s_name, s_mail, strHost, confname1, FSO

	Db_Odbc_Name		= REQUEST("Db_Odbc_Name")
	Db_Odbc_User		= REQUEST("Db_Odbc_User")
	Db_Odbc_Pass		= REQUEST("Db_Odbc_Pass")
	PATH_URL			= REQUEST("PATH_URL")
	SYSTEM_URL			= REQUEST("SYSTEM_URL")
	sql_ip				= REQUEST("sql_ip")
	upload_component	= REQUEST("upload_component")
	image_component		= REQUEST("image_component")

	owner				= REQUEST("owner")
	
	IF MID  (PATH_URL,1,7) <> "http://" THEN PATH_URL = "http://" & PATH_URL
	IF RIGHT(PATH_URL,1)   <> "/"       THEN PATH_URL = PATH_URL & "/"
	IF RIGHT(SYSTEM_URL,1)   <> "\"       THEN SYSTEM_URL = SYSTEM_URL & "\"

	
	s_name  = "위즈몰" : s_mail  = "master@shop-wiz.com" : strHost = "http://" & REQUEST.ServerVariables("SERVER_NAME")
	confname1 = SYSTEM_URL & "config\db_connect.asp"

	SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
	IF FSO.fileExists(confname1) THEN FSO.DeleteFile(confname1)

	SET FILE = FSO.createTextFile(confname1, ForWriting)
	FILE.WRITELINE("<%")
	FILE.WRITELINE("	' 이 파일은 위즈몰 환경 설정 파일입니다.")
	FILE.WRITELINE("	' 이 파일은 임의대로 수정이 가능하나 DB의 연결이 잘못될 수 있습니다. ")
	FILE.WRITELINE("")
	FILE.WRITELINE("Dim PATH_URL, PATH_SYSTEM")
	FILE.WRITELINE("Dim Db_Odbc_Name, Db_Odbc_User, Db_Odbc_Pass, sql_ip")
	FILE.WRITELINE("Dim upload_component, image_component, owner")
	FILE.WRITELINE("Dim DbConnect")
	FILE.WRITELINE("")
	FILE.WRITELINE("	PATH_URL        = " & CHR(34) & PATH_URL & CHR(34))
	FILE.WRITELINE("	PATH_SYSTEM        = " & CHR(34) & SYSTEM_URL & CHR(34))
	FILE.WRITELINE("")
	FILE.WRITELINE("	Db_Odbc_Name     = " & CHR(34) & Db_Odbc_Name & CHR(34))
	FILE.WRITELINE("	Db_Odbc_User     = " & CHR(34) & Db_Odbc_User & CHR(34))
	FILE.WRITELINE("	Db_Odbc_Pass     = " & CHR(34) & Db_Odbc_Pass & CHR(34))
	FILE.WRITELINE("	sql_ip = " & CHR(34) & sql_ip & CHR(34))
	FILE.WRITELINE("	owner = " & CHR(34) & owner & CHR(34))
	FILE.WRITELINE("")
	FILE.WRITELINE("'' 1 : ABC, 2 : DEXT, 3 : SITEGALAY")
	FILE.WRITELINE("	upload_component = " & CHR(34) & upload_component & CHR(34))
	FILE.WRITELINE("")
	FILE.WRITELINE("")
	FILE.WRITELINE("'' 1 : 없음, 2 : DEXT")
	FILE.WRITELINE("	image_component = " & CHR(34) & image_component & CHR(34))
	FILE.WRITELINE("")	
	FILE.WRITELINE("	'' DB 에 연결을 부분")
	FILE.WRITELINE("	DbConnect = " & CHR(34) & "Provider=SQLOLEDB;Data Source = " & CHR(34) & "&sql_ip&" & CHR(34) & ";Initial Catalog=" & CHR(34) & "&Db_Odbc_Name&" & CHR(34) & ";User ID=" & CHR(34) & "&Db_Odbc_User&" & CHR(34) & ";Password=" & CHR(34) & "&Db_Odbc_Pass&" & CHR(34) & ";" & CHR(34))
	FILE.WRITELINE("")
	FILE.WRITELINE("  '' 하위는 클라스에서 처리 , 필요시 오픈 하여 사용")
	FILE.WRITELINE("	''SET DbCon = Server.CreateObject(" & CHR(34) & "ADODB.Connection" & CHR(34) & ")")
	FILE.WRITELINE("	''DbCon.Open DbConnect")
	FILE.WRITELINE(CHR(37 ) & ">")
	FILE.CLOSE
'Response.End()
	On Error Resume Next
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel=StyleSheet HREF=style.css type=text/css title=style>
<title>▒▒ WizBoard For ASP Install Guide ▒▒</title>
<script language="javascript">
<!--
function check(f){
	if (f.strAdminID.value == "" || f.strAdminID.value.length < 4){
		alert("전체 관리자 아이디가 입력되지 않았거나 4자 이하로 입력하셨습니다.");
		f.strAdminID.focus();
		return false;
	}else if (f.strAdminPwd.value == "" || f.strAdminPwd.value.length < 4){
		alert("패스워드가 입력되지 않았거나 4자 이하로 입력하셨습니다.");
		f.strAdminPwd.focus();
		return false;
	}else if (f.strAdminPwd.value != f.strAdminPwd2.value){
		alert("입력한 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
		f.strAdminPwd2.focus();
		return false;
	}else if (f.strAdminName.value == ""){
		alert("전체 관리자 이름을 입력해 주시기 바랍니다.");
		f.strAdminName.focus();
		return false;
	}else if (f.strAdminName.value == ""){
		alert("전체 관리자 메일주소를 입력해 주시기 바랍니다.");
		f.strAdminName.focus();
		return false;
	}
}

function check_email(str){
emailStr = str.value
if(emailStr != "") {
	var emailPat=/^(.+)@(.+)/
	var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]"
	var validChars="\[^\\s" + specialChars + "\]"
	var firstChars=validChars
	var quotedUser="(\"[^\"]*\")"
	var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]/
	var atom="(" + firstChars + validChars + "*" + ")"
	var word="(" + atom + "|" + quotedUser + ")"
	var userPat=new RegExp("^" + word + "(\\." + word + ")*")
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*")
	var matchArray=emailStr.match(emailPat)
	if (matchArray==null) {
		alert("E-mail 주소를 정확히 입력해 주시기 바랍니다.");
		str.focus();
		return false;
		}
	}
}

function onlyEng(objtext1) {
	var inText = objtext1.value;
	var ret;
	for (var i = 0; i<= inText.length; i++) {
		ret = inText.charCodeAt(i);
		if (ret > 127) {
			alert("영문자와 숫자만 입력 가능합니다.");
			objtext1.focus();
			break;
			return false;
		}
	}
}
//-->
</script>
</head>
<body bgcolor="#17823A">

<table cellpadding="0" cellspacing="1" bgcolor="white" width="790" align="center">
  <form name="InstallFrm" method="post" action="install4.asp" onSubmit="return check(this);">
  <input type="hidden" name="owner" value="<%=owner%>">
    <tr> 
      <td width="788" height="1" bgcolor="#BBBBBB"></td>
    </tr>
    <tr> 
      <td width="788"> <table cellpadding="0" cellspacing="0" width="788">
          <tr> 
            <td height="116" bgcolor="#005B1E">&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
          <tr> 
            <td height="19" bgcolor="#17823A"></td>
          </tr>
          <tr> 
            <td height="14" bgcolor="#17823A" align="center">&nbsp;</td>
          </tr>
          <tr> 
            <td height="8" bgcolor="#17823A"></td>
          </tr>
          <tr> 
            <td bgcolor="#17823A" height="307"> <table align="center" cellpadding="0" cellspacing="0" width="750">
                <tr> 
                  <td width="20" valign="top" align="center">&nbsp;</td>
                  <td width="730"><font color="white">위즈몰 FOR ASP 관리자 정보를 입력하셔야 
                    합니다.<br />
                    위즈몰 FOR ASP 관리는 전체 관리자를 일반 회원 테이블에서 관리하지 않고 전체 관리자 테이블에서 
                    따로 관리를 합니다.<br />
                    전체 관리자 정보는 정확하게 입력해 주시고, 입력한 내용을 숙지하고 계셔야 합니다.<br />
                    전체 관리자 정보는 위즈몰 관리자 모드에서 변경하실 수 있습니다.</td>
                </tr>
                <tr> 
                  <td width="20"></td>
                  <td width="730"> <table cellpadding="0" cellspacing="0" width="730">
                      <tr> 
                        <td height="26"><font color="#FFFFFF">관리자 
                          아이디 (Administrator ID)</td>
                        <td height="26">&nbsp;
                          <input name="strAdminID" type="text" id="strAdminID" OnBlur="onlyEng(this);" size="30"> 
                          <input type="hidden" name="PATH_URL" value="<%=PATH_URL%>">
                          <input type="hidden" name="SYSTEM_URL" value="<%=SYSTEM_URL%>"></td>
                      </tr>
                      <tr> 
                        <td height="26"><font color="#FFFFFF">관리자 
                          패스워드 (Administrator Password)</td>
                        <td height="26">&nbsp;
                          <input name="strAdminPwd" type="password" id="strAdminPwd" size="30"></td>
                      </tr>
                      <tr> 
                        <td height="26"><font color="#FFFFFF">관리자 
                          패스워드 확인 (Administrator Password)</td>
                        <td height="26">&nbsp;
                          <input name="strAdminPwd2" type="password" id="strAdminPwd2" size="30"></td>
                      </tr>
                      <tr> 
                        <td height="26"><font color="#FFFFFF">관리자 
                          이름 (Administrator Name)</td>
                        <td height="26">&nbsp;
                          <input name="strAdminName" type="text" id="strAdminName" size="30"></td>
                      </tr>
                      <tr> 
                        <td height="26"><font color="#FFFFFF">관리자 
                          메일 주소 (Administrator E-Mail Address)</td>
                        <td height="26">&nbsp;
                          <input name="strAdminMail" type="text" id="strAdminMail" OnBlur="check_email(this);" size="30"></td>
                      </tr>
                      <tr> 
                        <td height="26"><font color="#FFFFFF">관리자 
                          홈페이지 주소 (Administrator Homepage Address)</td>
                        <td height="26">&nbsp;
                          <input name="strAdminHome" type="text" id="strAdminHome" value="http://" size="30"></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td width="20" height="29" align="center">&nbsp;</td>
                  <td width="730" height="29"><font color="white">위의 관리자 정보를 모두 
                    입력하셨다면 다음 버튼을 누르시고 계속 진행하시기 바랍니다.</td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td bgcolor="#005B1E" height="77" align="center">&nbsp; 
              <input type="button" name="Button" value="이전" onClick="javascript:history.back(-1);">
              <input type="submit" name="Submit2" value="다음으로">
              <input type="button" name="Submit3" value="닫기" onClick="javascript:self.close();">
              &nbsp; &nbsp;&nbsp;</td>
          </tr>
        </table></td>
    </tr>
  </form>
</table>
</body>
</html>
