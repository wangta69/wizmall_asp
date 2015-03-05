<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file="../../../config/admin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
strSQL		= "select m.pname from wizcart c left join wizmall m on c.pid=m.uid  where c.oid='"&SESSION("CART_CODE")&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
pname		= objRs("pname")
SET objRs	= NOTHING

strSQL = "select *, (select count(*) from wizcart where oid='"&SESSION("CART_CODE")&"') as tcount  from wizbuyer where codevalue='"&SESSION("CART_CODE")&"'"
''response.Write strSQL
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
''MxIssueNO		= SESSION("CART_CODE")
''Amount			= objRs("paymoney")

''CcNameOnCard	= objRs("sname")



''mertkey		= CARD_PASS    ''데이콤에서 상점아이디별 발급
storeid		= CARD_ID		''상점아이디 (테스트용 아이디 / 서비스용 아이디 반드시 확인)
ordernumber	= SESSION("CART_CODE")		''주문번호 (주의 : 한글사용불가)
amount		= objRs("paymoney")		''결제금액 (반드시 문자열로 넘겨주셔야 합니다.)
''note_url	= SET_URL&"skinwiz/paymodule/"&PG_PACK&"/note_url.asp"	''결과 DB처리 페이지 (http 또는 https 로 시작하는 전체 URL 지정 : 샘플참조)
''ret_url		= SET_URL&"skinwiz/paymodule/"&PG_PACK&"/ret_url.asp"     ''결과 화면처리 페이지 (http 또는 https 로 시작하는 전체 URL 지정 : 직접제작)

''HTTP_HOST = Request("HTTP_HOST")
''PATH_INFO = Request("PATH_INFO")
''pathfile = Request("HTTP_HOST")&Request("PATH_INFO")
''path = Replace(pathfile, "pay.asp", "")
''note_url	= "http//"&path&"note_url.asp"
''ret_url		= "http//"&path&"ret_url.asp"

ordername		= objRs("sname")
phoneno			= objRs("stel1")

paytype		= objRs("paytype")
tcount		= objRs("tcount")
sjumin1		= objRs("sjumin1")
sjumin2		= objRs("sjumin2")
email		= objRs("semail")


SET objRs =NOTHING
if tcount > 1 then addstr = " 외"
goodname = pname&addstr

Select Case paytype
    Case "card"
        Smode = 3001
		actiontarget = "./KSpayAuth.asp"
End Select
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>KS_PAY</title>

<script language = 'javascript'>
<!--
function openWindow()
{
window.open("","Window","width=330, height=430, status=yes, scrollbars=no,resizable=yes, menubar=no");
document.mainForm.action="<%=actiontarget%>";
document.mainForm.target = "Window";
document.mainForm.submit();
}
//-->
</script>

</head>
<body>
<h1>신용카드 결제창 Test</h1>
<!--  
        ******* 필독 *******
		 1. 각각의 결제 수단별로 요청정보에 차이가 있을 수 있으니 반드시 메뉴얼을 참고하셔서 결제연동을 하셔야 합니다. 
		 2. ret_url 페이지의 경우 고객이 결제를 확인하는 페이지 이므로 쇼핑몰에서 직접 제작하셔야 합니다.
-->
<form name="mainForm" method="POST" action="">
<!-- 결제를 위한 필수 hidden정보 -->
<input type="hidden" name="storeid" value="<%= storeid %>">					<!-- 상점아이디 테스트 : 2999199999-->
<input type="hidden" name="ordername" value="<%=escape(ordername) %>">					<!-- 주문자명 -->
<input type="hidden" name="email" value="<%= email %>">					<!-- 주문자이메일 -->
<input type="hidden" name="ordernumber" value="<%= ordernumber %>">					<!-- 주문번호 -->
<input type="hidden" name="amount" value="<%= amount %>">					<!-- 금액 -->
<input type="hidden" name="goodname" value="<%=escape(goodname) %>">					<!-- 상품명 -->
<input type="hidden" name="phoneno" value="<%= phoneno %>">					<!-- 주문자휴대폰 -->
<input type="hidden" name="currencytype" value="WON">					<!-- 통화구분(currencytype) : WON : WON-원화, USD : USD-미화 //-->
<input type="hidden" name="interesttype" value="NONE">					<!-- 무이자할부구분(interesttype):무이자 안함 "NONE"<br>3,6,9개월 무이자 "3:6:9"<br>전체월 무이자 "ALL" //-->
</form>
<script>
<!--
openWindow();
//-->
</script>
</body>

</html>

