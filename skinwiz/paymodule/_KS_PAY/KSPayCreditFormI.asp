<%
	'<!------------------------------------------------
	'파일명				: KSPayCreditFormI.asp
	'기능				: ISP인증승인용 카드정보입력용 페이지
	'작성일				: 2005-04-25
	'최종수정일			: 2005-04-25
	'최종수정자			: 박찬
	'------------------------------------------------->

	'신용카드승인종류 -  A-인증없는승인, N-인증승인, M-Visa3D인증승인, I-ISP인증승인
	certitype			= "I"
	authcode			= "I000"

	'기본거래정보
	storeid 			= request.form("storeid")				'상점아이디
	storepasswd			= ""									'상점승인(취소)용 패스워드 (추후사용)
	ordername 			= request.form("ordername")				'주문자명
	ordernumber			= request.form("ordernumber")			'주문번호
	amount				= request.form("amount")				'금액
	goodname			= request.form("goodname")				'상품명
	idnum				= "1111111111111"     					' 주민번호(정보등록용) 하이픈없이 등록
	email				= request.form("email")					'주문자이메일
	phoneno				= request.form("phoneno")				'주문자휴대폰번호
	currencytype		= request.form("currencytype")			'통화구분 : "WON" : 원화, "USD" : 미화
	interesttype		= request.form("interesttype")

	'ISP용 할부개월수지정
	KVP_QUOTA_INF    = "0:2:3:4:5:6:7:8:9:10:11:12"
	'ISP용 무이자 할부개월 지정(BC:0100 / 국민:0204 / 우리:0700)
	'//Ex ) String KVP_NOINT_INF 	= "0204-3:4:5:6, 0100-3:4:5:6, 0700-3:4:5:6" ;	- 각 카드사에 대해 3,4,5,6개월 할부건만 무이자처리
	'//Ex ) String KVP_NOINT_INF 	="ALL" - 모든개월수에 대하여 무이자처리함./ "NONE" - 모든개월수에 대하여 무이자처리하지않음.
	KVP_CURRENCY     = ""
	
	'interesttype으로 넘겨진 값으로 무이자처리
	if (interesttype = "ALL" or interesttype = "NONE") then
		KVP_NOINT_INF = interesttype
	elseif (interesttype = "") then
			KVP_NOINT_INF = "NONE"
	else 
			KVP_NOINT_INF = "0100-"+interesttype+", 0204-"+interesttype+", 0700-"+interesttype
	end if
%>
	
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="https://www.vpay.co.kr/KVPplugin_ssl.js"></script>
<script language="javascript">
<!--
	StartSmartUpdate();
   	function submit_isp(form) 
	{
		if (MakePayMessage(form) == true)
		{
			form.action= "KSPayCreditPostMNI.asp";
			form.submit();
			return true;
		}
		else 
		{
			alert("지불에 실패하였습니다.");
			return false;
		}
	}
-->
</script>
<style type="text/css">
	BODY{font-size:9pt; line-height:160%}
	TD{font-size:9pt; line-height:160%}
	A {color:blue;line-height:160%; background-color:#E0EFFE}
	INPUT{font-size:9pt;}
	SELECT{font-size:9pt;}
	.emp{background-color:#FDEAFE;}
	.white{background-color:#FFFFFF; color:black; border:1x solid white; font-size: 9pt;}
</style>
</head>

<body onload="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onFocus="" >
<form name=KSPayAuthForm method=post action="" onSubmit="">
<!--기본------------------------------------------------------------------>
<input type=hidden name="storeid"    			value="<%=storeid%>">
<input type=hidden name="storepasswd" 			value="<%=storepasswd%>">
<input type=hidden name="authty" 				value=<%=authcode%>>
<input type=hidden name="certitype" 			value=<%=certitype%>>

<!--일반신용카드---------------------------------------------------------->
<input type=hidden name="expdt"					value="">
<input type=hidden name="email"					value="<%=email%>">
<input type=hidden name="phoneno"				value="<%=phoneno%>">
<input type=hidden name="ordernumber"			value="<%=ordernumber%>">
<input type=hidden name="ordername"				value="<%=ordername%>">
<input type=hidden name="idnum"					value="<%=idnum%>">
<input type=hidden name="goodname"				value="<%=goodname%>">
<input type=hidden name="amount"				value="<%=amount%>">
<input type=hidden name="currencytype"			value="<%=currencytype%>">

<input type=hidden name="cardno"				value="">		<!--카드번호-->
<input type=hidden name="expyear"				value="">		<!--유효년-->
<input type=hidden name="expmon"				value="">		<!--유효월-->
<input type=hidden name="installment"			value="">		<!--할부-->
<input type=hidden name="lastidnum"				value="">		<!--주민번호-->
<input type=hidden name="passwd"				value="">		<!--비밀번호-->

<!--ISP------------------------------------------------------------>
<input type=hidden name=KVP_PGID 			value="A0029">	<!-- PG -->
<input type=hidden name=KVP_SESSIONKEY 		value="">  	    <!-- 세션키  --> 
<input type=hidden name=KVP_ENCDATA 		value="">     	<!-- 암호된데이터 -->
<input type=hidden name=KVP_CURRENCY	 	value="<%=currencytype%>"> 	<!-- 지불 화폐 단위 (WON/USD) : 한화 - WON, 미화 - USD-->
<input type=hidden name=KVP_NOINT 			value="">       <!-- 무이자구분(1:무이자,0:일반) -->
<input type=hidden name=KVP_QUOTA 			value="">       <!-- 할부 -->
<input type=hidden name=KVP_CARDCODE 		value="">    	<!-- 카드코드 -->
<input type=hidden name=KVP_CONAME 			value="">      	<!-- 카드명 -->
<input type=hidden name=KVP_RESERVED1 		value="">   	<!-- 예비1 -->
<input type=hidden name=KVP_RESERVED2 		value="">   	<!-- 예비2 -->
<input type=hidden name=KVP_RESERVED3 		value="">   	<!-- 예비3 -->
<input type=hidden name=KVP_IMGURL 			value="">	
<input type=hidden name=KVP_QUOTA_INF 		value="<%=KVP_QUOTA_INF%>">	<!--할부값-->
<input type=hidden name=KVP_GOODNAME 		value="<%=goodname%>">		<!--상품명-->
<input type=hidden name=KVP_PRICE 			value="<%=amount%>">		<!--금액-->
<input type=hidden name=KVP_NOINT_INF 		value="<%=KVP_NOINT_INF%>">	<!--일반, 무이자-->
<!--ISP------------------------------------------------------------>

<table border=0 width=0>
<tr>
<td align=center>
<table width=280 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드 승인&nbsp;
<%
	select case certitype
		case "A"	response.write("(인증없는승인)")
		case "N"	response.write("(인증승인)")
		case "I"	response.write("(I-ISP인증승인)")
		case else response.write("(I-ISP인증승인)")
	end select 
%>
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>상품명 :</td>
	<td><%=goodname%></td>
</tr>
<tr>
	<td>금액 :</td>
	<td><%=amount%></td>
</tr>
<tr>
	<td colspan=3><hr noshade size=1></td>
</tr>
<tr>
	<td colspan=2>
		<input type=button name=ISP onclick="return submit_isp(KSPayAuthForm)" value=" ISP결제 ">
	</td>
</tr>

</td>
</tr>
</table>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</table>
</form>
</body>
</html>