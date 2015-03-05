<!-- #include file = "../../lib/cfg.common.asp" -->
<%
	Dim strHost, strPath
	strHost = "http://" & Request.ServerVariables("SERVER_NAME") & "/"
	strPath = Server.MapPath("../..") & "\"
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="../../css/base.css" type="text/css"> 
<title>▒▒ WizBoard For ASP Install Guide ▒▒</title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style2 {color: #FEAE03}
-->
</style>
<script language="javascript">
<!--
function check(){
	var f = document.InstallFrm
	if (f.Db_Odbc_Name.value == ""){
		alert("DB 이름을 입력해 주시기 바랍니다.");
		f.Db_Odbc_Name.focus();
		return false;
	}else if (f.Db_Odbc_User.value == ""){
		alert("DB 사용자 아이디를 입력해 주시기 바랍니다.");
		f.Db_Odbc_User.focus();
		return false;
	}else if (f.Db_Odbc_Pass.value == ""){
		alert("DB 패스워드를 입력해 주시기 바랍니다.");
		f.Db_Odbc_Pass.focus();
		return false;
	}else if (f.PATH_URL.value == ""){
		alert("홈페이지의 절대 경로를 입력해 주시기 바랍니다.");
		f.PATH_URL.focus();
		return false;
	}else if (f.SYSTEM_URL.value == ""){
		alert("홈페이지의 상대 경로를 입력해 주시기 바랍니다.");
		f.SYSTEM_URL.focus();
		return false;
	}else if (f.sql_ip.value == ""){
		alert("SQL 서버의 아이피 주소 또는 URL을 입력해 주시기 바랍니다.");
		f.sql_ip.focus();
		return false;
	}else return true
}
//-->
</script>
</head>
<body bgcolor="#17823A">
<table cellpadding="0" cellspacing="1" bgcolor="white" width="790" align="center">
  <form name="InstallFrm" method="post" action="install3.asp" onSubmit="return check();">
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
                  <td width="730"><font color="white">* 세팅전 <span class="style2">/config 폴더의 권한</span><font color="white">을 일반user 쓰기/수정 권한을 반드시 주셔야 합니다. <br />
  위즈몰 FOR ASP는 MS-SQL 2000/MS-SQL 2005 
                    서버 DB를 사용하는 프로그램입니다. 따라서 MS-SQL 2000/2005 서버가 설치되어 있어야 하며, 설치전에 
                    DB의 정보를 입력하셔야 합니다.사용하실 DB 서버에 대한 DB 이름, DB 사용자 아이디, 비밀번호를 
                    입력해 주시기 바랍니다. 위의 내용을 잘 모르시겠다면 설치전에 DB 서버 관리자에게 문의하시기 바랍니다.<font color="#FEAE03">위즈몰 
                    FOR ASP는OLE DB를 사용하므로 별다른 ODBC 셋팅이 필요 없습니다.</td>
                </tr>
                <tr> 
                  <td width="20"></td>
                  <td width="730"> <table cellpadding="0" cellspacing="0" width="730">
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">데이터 
                          베이스 이름 (DB Name)</span></td>
                        <td width="63%" height="26">&nbsp;
                          <input name="Db_Odbc_Name" type="text" id="Db_Odbc_Name" size="27"></td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">데이터 
                          베이스 사용자 아이디 (SQL User ID)</span></td>
                        <td width="63%" height="26">&nbsp;
                          <input name="Db_Odbc_User" type="text" id="Db_Odbc_User" size="27"></td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">데이터 
                          베이스 사용자 패스워드 (Password)</span></td>
                        <td width="63%" height="26">&nbsp;
                          <input name="Db_Odbc_Pass" type="text" id="Db_Odbc_Pass" size="27"></td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">위즈몰 
                          <font color="white">FOR ASP가 설치된 절대 경로</span></td>
                        <td width="63%" height="26">&nbsp;
                          <input type="text" name="PATH_URL" size="27" value="<%=strHost%>"> 
                          <font color="#FCF8E8">예) http://www.shop-wiz.com/</td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">위즈몰 
                          <font color="white">FOR ASP가 설치된 상대 경로</span></td>
                        <td width="63%" height="26">&nbsp;
                          <input type="text" name="SYSTEM_URL" size="27" value="<%=strPath%>">
                          <font color="#FCF8E8">예) c:\www\shopwiz\</td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">SQL 
                          서버 URL 또는 아이피</span></td>
                        <td width="63%" height="26">&nbsp;
                          <input name="sql_ip" type="text" value="localhost" size="27">
                          <font color="#FCF8E8">예) 211.111.222.333 or sql.shop-wiz.com or localhost </td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">schema</span></td>
                        <td width="63%" height="26"><font color="#FCF8E8">&nbsp;
                          <input name="owner" type="radio" value="1" checked>
                          DEFAULT
                          <input name="owner" type="radio" value="2">
                          SQL User ID와 동일</td>
                      </tr>                      
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">업로드 
                          컴포넌트 선택</span></td>
                        <td width="63%" height="26"><font color="#FCF8E8">&nbsp;
                          <input type="radio" name="upload_component" value="1">
                          ABC UPLOAD 
                          <input name="upload_component" type="radio" value="2" checked >
                          DEXT UPLOAD
                          <input name="upload_component" type="radio" value="3">
                          SITE GALAXY
                          </td>
                      </tr>
                      <tr> 
                        <td width="37%" height="26" align="right"><span class="style1">이미지 
                          컴포넌트 선택</span></td>
                        <td width="63%" height="26"><font color="#FCF8E8">&nbsp;
                          <input name="image_component" type="radio" value="1" checked>
                          없음 
                          <input name="image_component" type="radio" value="2">
                          DEXT UPLOAD</td>
                      </tr>					  
                      <!--<tr> 
                        <td width="37%" height="26" align="right"><span class="style1">메일 
                          컴포넌트 선택</span></td>
                        <td width="63%" height="26"><font color="#FCF8E8">&nbsp;
                          <input type="radio" name="mail_component" value="1" checked>
                          SMTP &nbsp;
                          <input type="radio" name="mail_component" value="2">
                          JMAIL</td>
                      </tr>-->
                    </table></td>
                </tr>
                <tr> 
                  <td width="20" height="29" align="center">&nbsp;</td>
                  <td width="730" height="29"><font color="white">위의 설정을 모두 하셨으면 
                    다음 버튼을 누르시고 계속 진행하시기 바랍니다.</td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td bgcolor="#005B1E" height="77" align="center">&nbsp; <input type="button" name="Button" value="이전" onClick="javascript:history.back(-1);">
              <input type="submit" name="" value="계속진행">
              <input type="button" name="" value="닫기" onClick="javascript:self.close();">
            </td>
          </tr>
        </table></td>
    </tr>
  </form>
</table>
</body>
</html>
