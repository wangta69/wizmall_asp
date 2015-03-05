<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util,board
Set util	= new utility	
Set board	= new boards
owner	= REQUEST("owner")
'' 2003 사용시  '../../config/db_connect.asp' Include 파일은 부모 디렉터리를 표시하기 위해 '..'를 사용할 수 없습니다.  라는 메시지가 뜰경우
'' 인터넷정보서비스(IIS)관리 ->웹사이트->작업중인계정->속성->홈디렉토리->구성->옵션->부모경로 사용에 책크바랍니다.
''
	Dim STR, I
	If owner = "2" Then	Db_Owner = "[" & Db_Odbc_User & "]." Else Db_Owner = ""
	If owner = "2" Then	sp_owner = Db_Odbc_User Else sp_owner = "dbo"
	
%>
<!-- #include file = "install4_make_proc.asp" -->
<!-- #include file = "install4_make_table.asp" -->
<!-- #include file = "install4_make_mall_table.asp" -->
<!-- #include file = "make_config_file.asp" -->
<%
	Set db		= new database
	Dim strAdminID, strAdminPwd, strAdminName, strAdminMail, strAdminHome
	Dim ADMIN_NAME, ADMIN_EMAIL
	strAdminID   = REQUEST("strAdminID")
	strAdminPwd  = REQUEST("strAdminPwd")
	strAdminName = REQUEST("strAdminName")
	strAdminMail = REQUEST("strAdminMail")
	strAdminHome = REQUEST("strAdminHome")

	strSQL = "INSERT INTO [wiztable_main] ([BID], [GID], [AdminID], [AdminPwd], [AdminName], [AdminMail], [AdminHome], [datesigndate]) VALUES ('" & BID & "','" & GID & "','" & strAdminID & "','" & strAdminPwd & "','" & strAdminName & "','" & strAdminMail & "','" & strAdminHome & "',getdate()) "
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	ADMIN_NAME	= strAdminName
	ADMIN_EMAIL	= strAdminMail



Dim FILEPATH
FILEPATH = PATH_SYSTEM & "config\admin_info.asp"

str = "<%"
str = str & chr(13)&chr(10)
str = str & "'' 이 파일은 위즈몰 기본 환경 설정 파일입니다."
str = str & chr(13)&chr(10)
str = str &"Dim ADMIN_NAME, ADMIN_EMAIL, SET_URL, SET_TITLE"
str = str & chr(13)&chr(10)
str = str &"	ADMIN_NAME     = " & CHR(34) & strAdminName & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	ADMIN_EMAIL     = " & CHR(34) & strAdminMail & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	SET_URL     = " & CHR(34) & strAdminHome & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	SET_TITLE     = " & CHR(34) & "위즈몰쇼핑몰 For ASP" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	''----------------------------------------------------"
str = str & chr(13)&chr(10)
str = str &"Dim mall_name, mall_company, mall_ceo, mall_charge, mall_tel, mall_fax, mall_email, mall_company_no, mall_reg_no, mall_address"
str = str & chr(13)&chr(10)
str = str &"	mall_name    	 = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_company     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_ceo     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_charge     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_tel     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_fax     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_email     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_company_no     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_reg_no     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_address     = " & CHR(34) & "" & CHR(34)
str = str & chr(13)&chr(10)
str = str & CHR(37 ) & ">"

	''Call util.makeFile_adminInfo()
	Call util.makeFile_adminInfo(str, FILEPATH)
	
	SET objRs = Nothing : db.Dispose : db = Nothing : util = Nothing
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel=StyleSheet HREF=style.css type=text/css title=style>
<title>▒▒ WizBoard For ASP Install Guide ▒▒</title>
</head>
<body bgcolor="#17823A">
<table cellpadding="0" cellspacing="1" bgcolor="white" width="790" align="center">
  <form name="InstallFrm" method="post" onSubmit="return check();">
    <tr> 
      <td width="788" height="1" bgcolor="#BBBBBB"></td>
    </tr>
    <tr> 
      <td width="788"> <table cellpadding="0" cellspacing="0" width="788">
          <tr> 
            <td height="116" bgcolor="#005B1E">&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
          <tr> 
            <td height="89" bgcolor="#17823A">&nbsp;</td>
          </tr>
          <tr> 
            <td bgcolor="#17823A" height="264"> <table align="center" cellpadding="0" cellspacing="0" width="750">
                <tr> 
                  <td width="20" height="32"></td>
                  <td width="730" height="32"><font color="white">위즈몰 FOR ASP 에 대한 
                    모든 설치 과정이 이루어 졌습니다.</td>
                </tr>
                <tr> 
                  <td width="20" height="50"></td>
                  <td width="730" height="50"><font color="white">위즈몰를 개인적인 용도로 
                    사용하실 경우 카피라이트 수정, 소스 수정이 불가능합니다. 위 사항을 위반할 경우 저작권 법에 따라 처벌을 
                    받을 수 있으므로 주의 하시기 바랍니다.</td>
                </tr>
                <tr> 
                  <td width="20" height="50"></td>
                  <td width="730" height="50"><font color="white">그럼 개인적으로 사용하시는
                      분은 위 사항을 잘 지키시면서 유용하게 사용하시고 상업적으로 사용하실 분들은 숍위즈 (<a href="http://www.shop-wiz.com" target="_blank"><font color="#FEAE00">http://www.shop-wiz.com</a><font color="white">)
                       홈페이지에서 유료 버전을 참고 하시기 바랍니다.</td>
                </tr>
                <tr> 
                  <td width="20" height="40"></td>
                  <td width="730" height="40"><font color="#FEAE00">※ 보안을 위해 INSTALL 
                    폴더(http://설치된 홈페이지/webadmin/install)는 삭제하시거나 다른곳으로 이동해 주시기 바랍니다.</td>
                </tr>
                <tr> 
                  <td width="20" height="40"></td>
                  <td width="730" height="40"><font color="#FEAE00">※ 위즈몰 관리자 
                    모드 URL : http://설치된 홈페이지/admin/</td>
                </tr>
                <tr> 
                  <td width="20" height="39"></td>
                  <td width="730" height="39"><font color="white">관리자 모드로 바로 이동을 
                    하시려면 아래 관리자 모드 이동 버튼을 클릭하시기 바랍니다.</td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td bgcolor="#005B1E" height="77" align="center">&nbsp;&nbsp; 
              <input type="button" name="Button" value="다음" onClick="location.replace('<%=PATH_URL%>webadmin/')">
              <input type="button" name="Submit2" value="마침" onClick="javascript:self.close();"></td>
          </tr>
        </table></td>
    </tr>
  </form>
</table>

</body>
</html>
