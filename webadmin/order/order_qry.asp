<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim codevalue,smode,processing,deliverer,invoiceno,sms_tel,sms_message	
Dim rzip, rzip1, rzip2, raddress1, raddress2

Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database



codevalue	= Request("codevalue")
smode		= Request("smode")
processing 	= Request("processing")
deliverer 	= Request("deliverer")
invoiceno 	= Request("invoiceno")
sms_tel 	= Request("sms_tel")
sms_message	= Request("sms_message")
rzip1		= Request("rzip1")
rzip2		= Request("rzip2") : rzip = rzip1 & "-" & rzip2
raddress1	= Request("raddress1")
raddress2	= Request("raddress2")


if smode = "processing_change" then 
	strSQL = "update wizbuyer set processing = "&processing&" where codevalue = "&codevalue
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Redirect("./order1_1.asp?codevalue="&codevalue)
elseif smode = "qde" then 
	strSQL = "delete wizbuyer where codevalue = "&codevalue
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	strSQL = "delete wizcart where oid = "&codevalue
	Call db.ExecSQL(strSQL, Nothing, DbConnect)	
	Response.Write("<script>opener.location.reload();self.close();</script>")
elseif smode = "delever_modify" then '' /* 택배사 및 택배번호 입력 */
	strSQL = "update wizbuyer SET deliverer = '"&deliverer&"', invoiceno = '"&invoiceno&"' WHERE codevalue="&codevalue
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Redirect("./order1_1.asp?codevalue="&codevalue)
elseif smode = "chg_address" then '' /* 주소변경 */
	strSQL = "update wizbuyer SET rzip = '"&rzip&"', raddress1 = '"&raddress1&"', raddress2 = '"&raddress2&"' WHERE codevalue="&codevalue
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Redirect("./order1_1.asp?codevalue="&codevalue)	
elseif smode = "trans_message" then ''sms발송
	if sms_tel <> "" and sms_message <> "" then ''/////////////////////////////// SMS 전송
		''// 사용되는 변수
		''// sms_tel : 수신자 번호
		''//sms_message =  : 발신내용
		''// sms_sender_tel : 발신자 번호
		''// sms_sender_name : 발신자명
		''// sms_sender_id : 발신자 아이디
		''//sms_sender_pwd : 발신자 패스워드	
		''	//include "./skin_sms/ANYSMS/smsindex.asp" //이곳에 수정된 모듈이 들어간다.
		''	include "./skin_sms/ICODE/smsindex.asp" //이곳에 수정된 모듈이 들어간다.
	end if
	Call util.js_alert("sms업체가 선정되지 않았습니다.","./order1_1.asp?codevalue="&codevalue)
end if

db.Dispose : Set db = Nothing : Set util = Nothing
%>
