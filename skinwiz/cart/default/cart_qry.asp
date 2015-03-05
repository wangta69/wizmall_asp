<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../lib/class.cart.asp" -->
<%
Dim qry, processing
Dim sname,sid,sjumin1,sjumin2,semail,stel1_1,stel1_2,stel1_3,stel2_1,stel2_2,stel2_3,szip1,szip2,saddress1,saddress2
Dim rname,remail,rtel1_1,rtel1_2,rtel1_3,rtel2_1,rtel2_2,rtel2_3,rzip1,rzip2,raddress1,raddress2,paytype,paymoney
Dim totalmoney,bankinfo,inputer,codevalue,content,inputy,inputm,inputd,inputh,rdate,stel1,stel2,rtel1,rtel2,szip,rzip
Dim strSQL,objRs
Dim db,util,cart
Set util	= new utility : Set db		= new database : Set cart		= new wizcart

sname 			= trim(Request.Form("sname"))
sid				= user_id
sjumin1 		= trim(Request.Form("sjumin1"))
sjumin2 		= trim(Request.Form("sjumin2"))
semail 			= trim(Request.Form("semail"))
stel1_1 		= trim(Request.Form("stel1_1"))
stel1_2 		= trim(Request.Form("stel1_2"))
stel1_3 		= trim(Request.Form("stel1_3"))
stel1 			= trim(Request.Form("stel1"))	: If stel1 = "" then stel1 = stel1_1&"-"&stel1_2&"-"&stel1_3
stel2_1 		= trim(Request.Form("stel2_1"))
stel2_2 		= trim(Request.Form("stel2_2"))
stel2_3 		= trim(Request.Form("stel2_3"))
stel2 			= trim(Request.Form("stel2"))	: If stel2 = "" then stel2 = stel2_1&"-"&stel2_2&"-"&stel2_3
szip1 			= trim(Request.Form("szip1"))
szip2 			= trim(Request.Form("szip2"))
szip 			= trim(Request.Form("szip"))	: if szip	= "" then szip = szip1&"-"&szip2
saddress1 		= trim(Request.Form("saddress1"))
saddress2 		= trim(Request.Form("saddress2"))
rname 			= trim(Request.Form("rname"))
remail 			= trim(Request.Form("remail"))
rtel1_1 		= trim(Request.Form("rtel1_1"))
rtel1_2 		= trim(Request.Form("rtel1_2"))
rtel1_3 		= trim(Request.Form("rtel1_3"))
rtel1 			= trim(Request.Form("rtel1"))	: if rtel1 = "" then rtel1 = rtel1_1&"-"&rtel1_2&"-"&rtel1_3
rtel2_1 		= trim(Request.Form("rtel2_1"))
rtel2_2 		= trim(Request.Form("rtel2_2"))
rtel2_3 		= trim(Request.Form("rtel2_3"))
rtel2 			= trim(Request.Form("rtel2"))	: if rtel2 = "" then rtel2 = rtel2_1&"-"&rtel2_2&"-"&rtel2_3
rzip1 			= trim(Request.Form("rzip1"))
rzip2 			= trim(Request.Form("rzip2"))
rzip 			= trim(Request.Form("rzip"))	: if rzip	= "" then rzip = rzip1&"-"&rzip2
raddress1 		= trim(Request.Form("raddress1"))
raddress2 		= trim(Request.Form("raddress2"))
paytype 		= trim(Request.Form("paytype")) : if paytype = "" then paytype = "online"
paymoney 		= trim(Request.Form("paymoney"))
totalmoney 		= trim(Request.Form("totalmoney"))
bankinfo 		= trim(Request.Form("bankinfo"))
inputer 		= trim(Request.Form("inputer"))
codevalue 		= trim(Request.Form("codevalue"))
content 		= trim(Request.Form("content"))
inputy			= trim(Request.Form("inputy"))
inputm			= trim(Request.Form("inputm"))
inputd			= trim(Request.Form("inputd"))
inputh			= trim(Request.Form("inputh"))
rdate 			= inputy & "/" & inputm & "/" & inputd & "/" & inputh


If SESSION("CART_CODE") = "" Then Call util.js_alert("오랫동안 사용이 없었어 장바구니가 초기화 되었습니다.", "")

''현재 장바구니가 존재하는지 아닌지에 따라 입력/수정 모드로 전환한다.
strSQL = "select count(*) from wizbuyer where codevalue = '"&SESSION("CART_CODE")&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

if objRs(0) = 0 then qry = "qin" else  qry = "qup"

Set objRs = Nothing


Call cart.update_cart_status(10,SESSION("CART_CODE") )

if qry = "qin" then
	strSQL = "INSERT INTO wizbuyer ( "  
	strSQL = strSQL & "sname,sid,sjumin1,sjumin2,semail,stel1,stel2,szip,saddress1,saddress2,rname,remail,rtel1,rtel2,rzip,raddress1,raddress2,"
	strSQL = strSQL & "paytype,paymoney,totalmoney,bankinfo,inputer,codevalue,processing,content,rdate,wdate"
	strSQL = strSQL & ") VALUES ( " 
	strSQL = strSQL & "'"& sname &"','"& sid &"','"&sjumin1&"','"&sjumin2&"','"&semail&"','"&stel1&"','"&stel2&"','"&szip&"','"&saddress1&"',"
	strSQL = strSQL & "'"&saddress2&"','"&rname&"','"&remail&"','"&rtel1&"','"&rtel2&"','"&rzip&"','"&raddress1&"','"&raddress2&"',"
	strSQL = strSQL & "'"&paytype&"','"&paymoney&"','"&totalmoney&"','"&bankinfo&"','"&inputer&"','"&SESSION("CART_CODE")&"','"&processing&"',"
	strSQL = strSQL & "'"&content&"', '"& rdate &"',getdate() "
	strSQL = strSQL & ") "
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
  
elseif qry = "qup" then
	strSQL = "update wizbuyer set "  
	strSQL = strSQL & " sname='"&sname&"',sid='"&sid&"',sjumin1='"&sjumin1&"',sjumin2='"&sjumin2&"',semail='"&semail&"',stel1='"&stel1&"',"
	strSQL = strSQL & " stel2='"&stel2&"',szip='"&szip&"',saddress1='"&saddress1&"',saddress2='"&saddress2&"',rname='"&rname&"',"
	strSQL = strSQL & " remail='"&remail&"',rtel1='"&rtel1&"',rtel2='"&rtel2&"',rzip='"&rzip&"',raddress1='"&raddress1&"',raddress2='"&raddress2&"',"
	strSQL = strSQL & " paytype='"&paytype&"',paymoney='"&paymoney&"',totalmoney='"&totalmoney&"',bankinfo='"&bankinfo&"',inputer='"&inputer&"',"
	strSQL = strSQL & " processing='"&processing&"',content='"&content&"',rdate='"&rdate&"'"
	strSQL = strSQL & " where codevalue='"&SESSION("CART_CODE")&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
end If
db.Dispose : Set db	= Nothing : Set util = Nothing : Set cart = Nothing
%>
<iframe id="PayIFrame"  src="" style="display:none" width="700" height="500"> </iframe>
<%
if paytype = "online" then  
  Response.Redirect ("./wizbag.asp?smode=step4&codevalue="&SESSION("CART_CODE"))
  Response.End()
else
	Response.Write "<script>PayIFrame.location='./skinwiz/paymodule/"&PG_PACK&"/pay.asp?codevalue="&SESSION("CART_CODE")&"&paytype="&paytype&"'</script>"
end if
%>

<table width="100%" height="18" border="0" cellpadding="0" cellspacing="0">
  <tr bgcolor="#F6F6F6">
    <td width="15" height="22" class="company">&nbsp;</td>
    <td width="18" height="22" valign="middle"><img src="./skinwiz/cart/<%=CartSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
    <td height="22" class="company">Home &gt; 결제진행중</td>
  </tr>
</table>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="96%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="60">&nbsp;</td>
        </tr>
        <tr height="8">
          <td align="center">
            <img src="./skinwiz/cart/<%=CartSkin%>/images/pay_img.gif" width="591" height="311" border="0" usemap="#PayProcessing">
            <map name="PayProcessing">
              <area shape="rect" coords="127,212,242,235" href="javascript:location.reload();">
              <area shape="rect" coords="254,212,414,235" href="/wizbag.asp?smode=step2">
            </map></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><table width="564" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="36" align="center" valign="bottom"><br>
          </td>
        </tr>
      </table></td>
  </tr>
</table>
