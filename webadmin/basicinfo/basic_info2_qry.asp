<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility : Set db = new database

Dim qry, menushow, theme, admin_pwd, admin_id, ADMIN_NAME, ADMIN_EMAIL, SET_URL, SET_TITLE
Dim mall_name, mall_company, mall_ceo, mall_charge, mall_tel, mall_fax, mall_email, mall_company_no, mall_reg_no, mall_address	

qry			= Request("qry")
menushow	= Request("menushow")
theme		= Request("theme")
admin_id	= Request("admin_id")
admin_pwd	= Request("admin_pwd")
ADMIN_NAME	= Request("ADMIN_NAME")
ADMIN_EMAIL	= Request("ADMIN_EMAIL")
SET_URL		= Request("SET_URL")
SET_TITLE		= Request("SET_TITLE")


mall_name		= Request("mall_name")
mall_company	= Request("mall_company")
mall_ceo		= Request("mall_ceo")
mall_charge		= Request("mall_charge")
mall_tel		= Request("mall_tel")
mall_fax		= Request("mall_fax")
mall_email		= Request("mall_email")
mall_company_no	= Request("mall_company_no")
mall_reg_no		= Request("mall_reg_no")
mall_address	= Request("mall_address")

if qry = "qup" then
	strSQL = "update wiztable_main set AdminID = '" & admin_id & "', AdminPwd = '" & admin_pwd & "'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	''util.makeFile_adminInfo()''utf8에서 문제가 발생하여 아래처럼 처리



Dim FILEPATH, str
FILEPATH = PATH_SYSTEM & "config\admin_info.asp"

str = "<%"
str = str & chr(13)&chr(10)
str = str & "'' 이 파일은 위즈몰 기본 환경 설정 파일입니다."
str = str & chr(13)&chr(10)
str = str &"Dim ADMIN_NAME, ADMIN_EMAIL, SET_URL, SET_TITLE"
str = str & chr(13)&chr(10)
str = str &"	ADMIN_NAME     = " & CHR(34) & ADMIN_NAME & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	ADMIN_EMAIL     = " & CHR(34) & ADMIN_EMAIL & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	SET_URL     = " & CHR(34) & SET_URL & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	SET_TITLE     = " & CHR(34) & SET_TITLE & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	''----------------------------------------------------"
str = str & chr(13)&chr(10)
str = str &"Dim mall_name, mall_company, mall_ceo, mall_charge, mall_tel, mall_fax, mall_email, mall_company_no, mall_reg_no, mall_address"
str = str & chr(13)&chr(10)
str = str &"	mall_name    	 = " & CHR(34) & mall_name & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_company     = " & CHR(34) & mall_company & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_ceo     = " & CHR(34) & mall_ceo & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_charge     = " & CHR(34) & mall_charge & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_tel     = " & CHR(34) & mall_tel & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_fax     = " & CHR(34) & mall_fax & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_email     = " & CHR(34) & mall_email & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_company_no     = " & CHR(34) & mall_company_no & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_reg_no     = " & CHR(34) & mall_reg_no & CHR(34)
str = str & chr(13)&chr(10)
str = str &"	mall_address     = " & CHR(34) & mall_address & CHR(34)
str = str & chr(13)&chr(10)
str = str & CHR(37 ) & ">"


Call util.makeFile_adminInfo(str, FILEPATH)

	Set util = Nothing : db.Dispose : Set db = Nothing
	Response.Redirect("./main.asp?menushow="&menushow&"&theme=basicinfo/basic_info2")


end if	
	
%>
