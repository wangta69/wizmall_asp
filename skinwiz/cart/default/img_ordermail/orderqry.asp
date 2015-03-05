<!-- #include file = "../../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../../config/db_connect.asp" -->
<!-- #include file = "../../../../config/skin_info.asp" -->
<!-- #include file = "../../../../config/admin_info.asp" -->
<!-- #include file = "../../../../lib/class.database.asp" -->
<!-- #include file = "../../../../lib/class.util.asp" -->
<%
Dim codevalue, main_title
Dim strSQL,objRs
Dim db, util
Set util = new utility	
Set db = new database

codevalue				= session("tmpcodevalue")
session("tmpcodevalue")	= ""
main_title				= "주문이 접수되었습니다."

		strSQL = "select b.* from wizbuyer b where b.codevalue = '"&codevalue&"'"
		''Response.Write(strSQL)
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		member_email	= objRs("semail")
		image_url		= PATH_URL&"/skinwiz/cart/"&CartSkin&"/img_ordermail"
		sname			= objRs("sname")
		rname			= objRs("rname")
		rtel1			= objRs("rtel1")
		rtel2			= objRs("rtel2")
		rzip			= objRs("rzip")
		raddress1		= objRs("raddress1")
		raddress2		= objRs("raddress2")
		raddress		= "("&rzip&")"&raddress1&" "&raddress2
		paytype			= objRs("paytype")
		wdate			= objRs("wdate")

		file = Request.ServerVariables("APPL_PHYSICAL_PATH") &"skinwiz\cart\"&CartSkin&"\img_ordermail\orderform.asp"
		Set fs = Server.CreateObject("Scripting.FileSystemObject")

 if not(fs.FileExists(file)) then '파일이 존재하지 않으면
        Set fs=nothing
 else

        dim readfs
        Set readfs = fs.OpenTextFile(file,1)

        Do while readfs.AtEndOfStream <> true
            mail_body = mail_body & readfs.readline
        Loop
                            
        readfs.close
        Set fs=nothing
                        
        mail_body=replace(mail_body, "{{image_url}}", image_url)
		mail_body=replace(mail_body, "{{order_id}}", codevalue)
		mail_body=replace(mail_body, "{{rname}}", rname)
		mail_body=replace(mail_body, "{{sname}}", sname)
		mail_body=replace(mail_body, "{{rtel}}", rtel1)
		mail_body=replace(mail_body, "{{raddress}}", raddress)
		mail_body=replace(mail_body, "{{paymethod}}", paytype)
		mail_body=replace(mail_body, "{{buydate}}", wdate)
		mail_body=replace(mail_body, "{{home_dir}}", PATH_URL)
		mail_body=replace(mail_body, "{{mall_name}}", mall_name)
		mail_body=replace(mail_body, "{{mall_company_no}}", mall_company_no)
		mail_body=replace(mail_body, "{{mall_address}}", mall_address)
		mail_body=replace(mail_body, "{{mall_company}}", mall_company)
		mail_body=replace(mail_body, "{{mall_ceo}}", mall_ceo)
		mail_body=replace(mail_body, "{{mall_tel}}", mall_tel)
		mail_body=replace(mail_body, "{{mall_fax}}", mall_fax)
 end if  
		message = mail_body
''ADMIN_EMAIL = "폰돌 <master@shop-wiz.com>"
	Call util.fnc_sendmail(member_email, ADMIN_EMAIL, main_title, message, "")

	Set util = Nothing : db.Dispose : Set objRs = Nothing : Set db = Nothing
%>

