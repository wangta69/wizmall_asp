<!-- #include file=KSPayApprovalCancel.inc -->
<%
	'승인타입	 : A-인증없는승인, N-인증승인, M-Visa3D인증승인, I-ISP인증승인 
	certitype			= request.form("certitype")	

'Header부 Data --------------------------------------------------
	EncType			= "2" 					'0: 암화안함, 1:ssl, 2: seed
	Version			= "0603"				' 전문버전
	VType			= "00"					' 구분
	Resend			= "0"					' 전송구분 : 0 : 처음,  2: 재전송

	RequestDate		=	SetData(Year(Now),    4, "9") & _  
						SetData(Month(Now),   2, "9") & _
		                SetData(Day(Now),     2, "9") & _
		                SetData(Hour(Now),    2, "9") & _
			            SetData(Minute(Now),  2, "9") & _
		                SetData(Second(Now),  2, "9")
	
	KeyInType		= "K" 					'KeyInType 여부 : S : Swap, K: KeyInType
	LineType		= "1"					'lineType 0 : offline, 1:internet, 2:Mobile
	ApprovalCount	= "1"					'복합승인갯수
	GoodType		= "0" 					'제품구분 0 : 실물, 1 : 디지털
	HeadFiller		= ""					'예비

	StoreId			= request.form("storeid") 			'*상점아이디
	OrderNumber		= request.form("ordernumber") 		'*주문번호
	UserName		= request.form("ordername") 		'*주문자명
	IdNum			= request.form("idnum") 			'주민번호 or 사업자번호
	Email			= request.form("email") 			'*email
	GoodName		= request.form("goodname") 			'*제품명
	PhoneNo			= request.form("phoneno") 			'*휴대폰번호
'Header end -------------------------------------------------------------------

'Data Default-------------------------------------------------
	ApprovalType		= request.form("authty") 									'승인구분
	InterestType		= request.form("interest") 									'일반/무이자구분 1:일반 2:무이자
	TrackII				= request.form("cardno")&"="&request.form("expdt")       	' 카드번호=유효기간  or 거래번호
	Installment			= request.form("installment") 								'할부  00일시불
	Amount				= request.form("amount") 									'금액
	Passwd				= request.form("passwd") 									'비밀번호 앞2자리
	LastIdNum			= request.form("lastidnum") 								'주민번호  뒤7자리, 사업자번호10
	CurrencyType		= request.form("currencytype") 								'통화구분 0:원화 1: 미화

	BatchUseType		= "0" 				'거래번호배치사용구분  0:미사용 1:사용
	CardSendType		= "0" 				'카드정보전송유무 
	'0:미전송 1:카드번호,유효기간,할부,금액,가맹점번호 2:카드번호앞14자리 + "XXXX",유효기간,할부,금액,가맹점번호
	VisaAuthYn			= "7" 				'비자인증유무 0:사용안함,7:SSL,9:비자인증
	Domain				= "" 				'도메인 자체가맹점(PG업체용)
	IpAddr				= Request.ServerVariables("REMOTE_ADDR")			'IP ADDRESS 자체가맹점(PG업체용)
	BusinessNumber		= "" 												'사업자 번호 자체가맹점(PG업체용)
	Filler				= "" 												'예비
	AuthType			= "" 												'ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	MPIPositionType		= "" 												'K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	MPIReUseType		= "" 	      										'Y : 재사용, N : 재사용아님
	EncData				= "" 												'MPI, ISP 데이터
	
	cavv				= request.form("cavv") 		'MPI용
	xid					= request.form("xid") 		'MPI용
	eci					= request.form("eci")	 	'MPI용

	KVP_PGID			= "" 
	KVP_CARDCODE		= "" 
	KVP_SESSIONKEY		= "" 
	KVP_ENCDATA			= "" 

	'ISP일경우
	if certitype = "I" then
		TrackII			= "" 
		InterestType	= request.form("KVP_NOINT")		'무이자구분
		Installment		= request.form("KVP_QUOTA")		'할부:00일시불
		KVP_PGID		= request.form("KVP_PGID")
		KVP_CARDCODE	= request.form("KVP_CARDCODE")
		KVP_SESSIONKEY	= request.form("KVP_SESSIONKEY")
		KVP_ENCDATA		= request.form("KVP_ENCDATA")
	end if
'Data Default end -------------------------------------------------------------

'Server로 부터 응답이 없을시 자체응답
	rApprovalType		= "1001"  
	rTransactionNo		= "" 							'거래번호
	rStatus				= "X" 							'상태 O : 승인, X : 거절
	rTradeDate			= "" 							'거래일자
	rTradeTime			= "" 							'거래시간
	rIssCode			= "00" 							'발급사코드
	rAquCode			= "00" 							'매입사코드
	rAuthNo				= "9999" 						'승인번호 or 거절시 오류코드
	rMessage1			= "승인거절" 					'메시지1
	rMessage2			= "C잠시후재시도" 				'메시지2
	rCardNo				= "" 							'카드번호
	rExpDate			= "" 							'유효기간
	rInstallment		= "" 							'할부
	rAmount				= "" 							'금액
	rMerchantNo			= "" 							'가맹점번호
	rAuthSendType		= "N" 							'전송구분
	rApprovalSendType	= "N" 							'전송구분(0 : 거절, 1 : 승인, 2: 원카드)
	rPoint1				= "000000000000" 				'Point1
	rPoint2				= "000000000000"				'Point2
	rPoint3				= "000000000000"				'Point3
	rPoint4				= "000000000000" 				'Point4
	rVanTransactionNo	= "" 
	rFiller				= "" 							'예비
	rAuthType	 		= "" 							'ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	rMPIPositionType	= "" 							'K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	rMPIReUseType		= "" 							'Y : 재사용, N : 재사용아님
	rEncData			= "" 							'MPI, ISP 데이터
'--------------------------------------------------------------------------------
	
	'일반승인인경우
	if certitype = "A" or certitype = "N" then
		AuthType				= ""
		MPIPositionType			= ""
		MPIReUseType			= ""
		EncData					= ""
	end if
	'Visa3d인증승인인경우
	if certitype = "M" then
		AuthType				= "M"
		MPIPositionType			= "K"
		MPIReUseType			= "N"
		cavv					= SetData(cavv, 40, "X")
		xid						= SetData(xid,  40, "X")
		eci						= SetData(eci,   2, "X")
		EncData					= SetData(GetLength(cavv&xid&eci), 5, "9")&cavv&xid+eci
	end if
	'ISP인증승인인경우
	if certitype = "I" then
		AuthType				= "I"
		MPIPositionType			= "K"
		MPIReUseType			= "N"

		KVP_SESSIONKEY = server.URLEncode(KVP_SESSIONKEY)
		KVP_ENCDATA    = server.URLEncode(KVP_ENCDATA)
		KVP_SESSIONKEY = SetData(GetLength(KVP_SESSIONKEY), 4, "9") & KVP_SESSIONKEY
		KVP_ENCDATA    = SetData(GetLength(KVP_ENCDATA),    4, "9") & KVP_ENCDATA
		KVP_CARDCODE   = SetData((SetData(GetLength(KVP_CARDCODE), 2, "9") & KVP_CARDCODE), 22, "X")
		EncData        = SetData(GetLength(KVP_PGID+KVP_SESSIONKEY+KVP_ENCDATA), 5, "9") & KVP_PGID+KVP_SESSIONKEY & KVP_ENCDATA & KVP_CARDCODE
	end if
	
	if certitype = "I" then 
		if InterestType = "0" then InterestType = "1" else InterestType = "2" end if
	end if

	if CurrencyType = "WON" or CurrencyType = "410" or CurrencyType = "" then CurrencyType = "0" end if 
	if CurrencyType = "USD" or CurrencyType = "840" then CurrencyType = "1" else CurrencyType = "0" end if

	'dll 초기화
	KSPayApprovalCancel "210.181.28.137", 21001

	'Header부 전문조립
	HeadMessage EncType, Version, VType, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, _ 
				GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller

	'Data부 전문조립
	CreditDataMessage ApprovalType, InterestType, TrackII, Installment, Amount, Passwd, LastIdNum, CurrencyType, BatchUseType, CardSendType, VisaAuthYn, _
		Domain, IpAddr, BusinessNumber, Filler, AuthType, MPIPositionType, MPIReUseType, EncData

	'KSPAY로 요청전문송신후 수신데이터 파싱
	if SendSocket("1") = true then
		rApprovalType			= ApprovalType		'승인구분코드(서비스종류를 구분할수 있습니다. 첨부된전문내역서상의 승인코드부 참조)
		rTransactionNo		= TransactionNo	  		' 거래번호
		rStatus				= Status		  		' 상태 O : 승인, X : 거절
		rTradeDate			= TradeDate		  		' 거래일자
		rTradeTime			= TradeTime		  		' 거래시간
		rIssCode			= IssCode		  		' 발급사코드
		rAquCode			= AquCode		  		' 매입사코드
		rAuthNo				= AuthNo		  		' 승인번호 or 거절시 오류코드
		rMessage1			= Message1		  		' 메시지1
		rMessage2			= Message2		  		' 메시지2
		rCardNo				= CardNo		  		' 카드번호
		rExpDate			= ExpDate		  		' 유효기간
		rInstallment		= Installment	  		' 할부
		rAmount				= Amount		  		' 금액
		rMerchantNo			= MerchantNo	  		' 가맹점번호
		rAuthSendType		= AuthSendType	  		' 전송구분= new String(this.read(2))
		rApprovalSendType	= ApprovalSendType		' 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
	end if
%>

<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
<script language="javascript">
<!--

document.onkeypress = processKey;
document.onkeydown  = processKey;

function processKey() {
        if(( event.ctrlKey == true && ( event.keyCode == 78 || event.keyCode == 82 ) ) ||
		( event.keyCode >= 112 && event.keyCode <= 123 ))
 	{
                event.keyCode = 0;
                event.cancelBubble = true;
                event.returnValue = false;
        }
        if(event.keyCode == 8 && typeof(event.srcElement.value) == "undefined") {
                event.keyCode = 0;
                event.cancelBubble = true;
                event.returnValue = false;
        }
}

-->
</script>
</head>

<body onLoad="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<%
if rStatus = "O" then 
	''SESSION("CART_CODE")
	strSQL = "update wizbuyer set processing = '2', pay_date=getdate() where codevalue='" & OrderNumber & "'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	 Response.Write "<script>"
	 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step4&codevalue='"& OrderNumber &"')"
	 Response.Write"</script>"
else
		 Response.Write "<script>"
		 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step1')"
		 Response.Write "</script>"
end if
%>
<table border=0 width=0>
<tr>
<td align=center>
<table width=320 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드 결과&nbsp;
<%
	select case certitype
		case "A"	response.write("(인증없는승인)") 
		case "N"	response.write("(인증승인)") 
		case "M"	response.write("(M-Visa3D인증승인)") 
		case "I"		response.write("(I-ISP인증승인)") 
		case else  response.write("(???)") 
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
	<td>거래종류 :</td>
	<td><%=rApprovalType%></td>
</tr>
<tr>
	<td>거래번호 :</td>
	<td><%=rTransactionNo%></td>
</tr>
<tr>
	<td>거래성공여부 :</td>
	<td><%=rStatus%></td>
</tr>
<tr>
	<td>거래시간 :</td>
	<td><%=rTradeDate%>&nbsp;<%=rTradeTime%></td>
</tr>
<tr>
	<td>발급사코드 :</td>
	<td><%=rIssCode%></td>
</tr>
<tr>
	<td>매입사코드 :</td>
	<td><%=rAquCode%></td>
</tr>
<tr>
	<td>승인번호 :</td>
	<td><%=rAuthNo%></td>
</tr>
<tr>
	<td>메시지1 :</td>
	<td><%=rMessage1%></td>
</tr>
<tr>
	<td>메시지2 :</td>
	<td><%=rMessage2%></td>
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
</body>
</html>