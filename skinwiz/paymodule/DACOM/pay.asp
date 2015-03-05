<%
'///////////////////////////////////////////////////////////////////////////////////////////////////
'// *본 샘플 페이지는 신용카드 결제요청 샘플 입니다.
'//	
'// * hashdata 는 요청무결성을 검증하는 데이타로 요청시 필수 항목이며,
'//   mid+oid+amount+mertkey 를 조합한후 md5 방식으로 생성한 해쉬값 입니다.
'//
'//	*주의*   한글 데이타는 md5 암호화 를 하실수 없습니다.
'///////////////////////////////////////////////////////////////////////////////////////////////////
%>
<!-- #include file = "md5.asp" -->
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
'////////////////////////////////////////////////////////////////////////////////////////////////////
'//  mertkey 확인 방법 
'//  1. 상점관리자(서비스: http://pgweb.dacom.net  테스트: http://pgweb.dacom.net/tmert) 접속
'//  2. LG 데이콤에서 받은 테스트 아이디나 서비스 아이디로 로그인
'//  3. 계약정보 -> 상점정보관리 -> 결과전송정보 에서 확인이 가능 (승인결과전송여부를 반드시 웹전송 셋팅)
'////////////////////////////////////////////////////////////////////////////////////////////////////
mertkey		= CARD_PASS    ''데이콤에서 상점아이디별 발급
mertid		= CARD_ID		''상점아이디 (테스트용 아이디 / 서비스용 아이디 반드시 확인)
oid			= SESSION("CART_CODE")		''주문번호 (주의 : 한글사용불가)
amount		= objRs("paymoney")		''결제금액 (반드시 문자열로 넘겨주셔야 합니다.)
''note_url	= SET_URL&"skinwiz/paymodule/"&PG_PACK&"/note_url.asp"	''결과 DB처리 페이지 (http 또는 https 로 시작하는 전체 URL 지정 : 샘플참조)
''ret_url		= SET_URL&"skinwiz/paymodule/"&PG_PACK&"/ret_url.asp"     ''결과 화면처리 페이지 (http 또는 https 로 시작하는 전체 URL 지정 : 직접제작)

HTTP_HOST = Request("HTTP_HOST")
PATH_INFO = Request("PATH_INFO")
pathfile = Request("HTTP_HOST")&Request("PATH_INFO")
path = Replace(pathfile, "pay.asp", "")
note_url	= "http//"&path&"note_url.asp"
ret_url		= "http//"&path&"ret_url.asp"

buyer		= objRs("sname")

paytype		= objRs("paytype")
tcount		= objRs("tcount")
sjumin1		= objRs("sjumin1")
sjumin2		= objRs("sjumin2")
buyeremail	= objRs("semail")

'////////////////////////////// hashdata 생성 - 결제요청무결성검증 //////////////////////////////

hashdata = md5( mertid & oid & amount & mertkey )

'/////////////////////////////////////////////////////////////////////////////////////////////

SET objRs =NOTHING
if tcount > 1 then addstr = " 외"
CcProdDesc = pname&addstr

Select Case paytype
    Case "card"
        Smode = 3001
		actiontarget = "http://pg.dacom.net/card/cardAuthAppInfo.jsp"
    Case "hand"
        Smode = 6101
		actiontarget = "http://pg.dacom.net/wireless/wirelessAuthAppInfo1.jsp"
    Case "autobank"
        Smode = 2500
		actiontarget = "http://pg.dacom.net/transfer/transferSelectBank.jsp"
    Case "all"
        Smode = 3001
		actiontarget = ""			
End Select
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<title>데이콤 eCredit서비스 결제테스트</title>

<script language = 'javascript'>
<!--
function openWindow()
{
window.open("","Window","width=330, height=430, status=yes, scrollbars=no,resizable=yes, menubar=no");
document.mainForm.action="<%=actiontarget%>";
/*
========
신용카드
========
테스트용 결제창 URL				http://pg.dacom.net:7080/card/cardAuthAppInfo.jsp;
서비스용 결제창 URL				http://pg.dacom.net/card/cardAuthAppInfo.jsp;

========
계좌이체
========
테스트용 결제창 URL				http://pg.dacom.net:7080/transfer/transferSelectBank.jsp 
서비스용 결제창 URL				http://pg.dacom.net/transfer/transferSelectBank.jsp 

========
휴대폰
========
테스트용 결제창 URL				http://pg.dacom.net:7080/wireless/wirelessAuthAppInfo1.jsp
서비스용 결제창 URL				http://pg.dacom.net/wireless/wirelessAuthAppInfo1.jsp

========
무통장입금
========
테스트용 결제창 URL				http://pg.dacom.net:7080/cas/casRequestSA.jsp
서비스용 결제창 URL				http://pg.dacom.net/cas/casRequestSA.jsp 


Test ID로 테스트시 테스트용 URL로 테스트 하셔야 합니다.

*/
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
<input type="hidden" name="hashdata" value="<%= hashdata %>">			<!-- 결제요청 검증(무결성) 필드-->
<input type="hidden" name="mid" value="<%= mertid %>">					<!-- 상점ID -->
<input type="hidden" name="oid" value="<%= oid %>">						<!-- 주문번호 -->
<input type="hidden" name="amount" value="<%= amount %>">				<!-- 결제금액 -->
<input type="hidden" name="buyer" value="<%=buyer%>">						<!-- 구매자 -->
<input type="hidden" name="productinfo" value="<%=pname%>">					<!-- 상품명 -->

<input type="hidden" name="ret_url" value="<%= ret_url %>">				<!-- 팝업창 사용시 화면처리 URL (프레임 이용시 home_url 사용) -->
<input type="hidden" name="note_url" value="<%= note_url %>">			<!-- 결제결과 데이타처리URL(웹전송연동방식일때 : 필수) -->

<!-- 통계서비스를 위한 선택적인 hidden정보 -->

<input type="hidden" name="pid" value="<%=sjumin1%><%=sjumin2%>">
<input type="hidden" name="producttype" value="상품유형">
<input type="hidden" name="productcode" value="상품코드">
<input type="hidden" name="buyerid" value="구매자아이디">
<input type="hidden" name="buyeremail" value="<%=buyeremail%>">
<input type="hidden" name="deliveryinfo" value="배송처">
<input type="hidden" name="receiver" value="수취인">
<input type="hidden" name="receiverphone" value="수취인 전화번호">

<!--<input type="button" value="결제하기" onClick="javascript:openWindow()">-->
</form>
<script>
<!--
openWindow();
//-->
</script>
</body>

</html>

