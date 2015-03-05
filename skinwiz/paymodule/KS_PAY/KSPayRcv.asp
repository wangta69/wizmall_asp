<% 
Response.ContentType="text/HTML" 
Response.Charset="euc-kr" 
%>
<%
'------------------------------------------------------------------------------
' FILE NAME : KSPayRcv.asp
' DATE : 2006-09-01
' 이페이지는 kspay통합결재창으로부터 거래결과를 받아 가맹점결재페이지로 거래결과를 넘기는 역할을 합니다.
'------------------------------------------------------------------------------->

' 공통--------------------------------------------------------------------------------------
    reEncType			= request.form("reEncType")				'암호화구분
    reVersion			= request.form("reVersion")				'전문버전
    reType				= request.form("reType")				'전문구분
    reResend			= request.form("reResend")				'전송구분
    reRequestDate		= request.form("reRequestDate")			'요청일
    reStoreId			= request.form("reStoreId")				'상점아이디
    reOrderNumber		= request.form("reOrderNumber")			'주문번호
    reOrderName			= request.form("reOrderName")			'주문자명
    reAllRegid			= request.form("reAllRegid")			'주민번호
    reEmail				= request.form("reEmail")				'이메일
    reGoodType			= request.form("reGoodType")			'상품구분 1:실물, 2: 디지털
    reGoodName			= request.form("reGoodName")			'상품명
    reKeyInType			= request.form("reKeyInType")			'Keyin구분 K : Keyin
    reLineType			= request.form("reLineType")			'유무선구분 0: offline, 1: online(internet)
    reMobile			= request.form("reMobile")				'휴대폰번호
    reApprovalCount		= request.form("reApprovalCount")		'전문갯수
    reHeadFiller		= request.form("reHeadFiller")			'예비
	reApprovalType		= request.form("reApprovalType")		'승인구분

' 신용카드---------------------------------------------------------------------------------------
    reTransactionNo				= request.form("reTransactionNo")				'거래번호
    reStatus					= request.form("reStatus")						'상태
    reTradeDate					= request.form("reTradeDate")					'거래일자
    reTradeTime					= request.form("reTradeTime")					'거래시간
    reIssCode					= request.form("reIssCode")						'발급사코드
    reAquCode					= request.form("reAquCode")						'매입사코드
    reAuthNo					= request.form("reAuthNo")						'승인번호
    reMessage1					= request.form("reMessage1")					'메시지1
    reMessage2					= request.form("reMessage2")					'메시지2
    reCardNo					= request.form("reCardNo")						'카드번호14자리+XXXX
    reExpDate					= request.form("reExpDate")						'유효기간 YYMM
    reInstallment				= request.form("reInstallment")					'할부개월수
    reAmount					= request.form("reAmount")						'금액
    reMerchantNo				= request.form("reMerchantNo")					'가맹점번호
    reAuthSendType				= request.form("reAuthSendType")				'인증구분
    reApprovalSendType			= request.form("reApprovalSendType")			'승인구분
    rePoint1					= request.form("rePoint1")
    rePoint2					= request.form("rePoint2")
    rePoint3					= request.form("rePoint3")
    rePoint4					= request.form("rePoint4")
    reVanTransactionNo			= request.form("reVanTransactionNo")
    reFiller					= request.form("reFiller")
    reAuthType					= request.form("reAuthType")
    reMPIPositionType			= request.form("reMPIPositionType")
    reMPIReUseType				= request.form("reMPIReUseType")
    reInterest					= request.form("reInterest")					'이자구분 1: 일반, 2: 무이자

	rePApprovalType				= request.form("rePApprovalType")				'포인트승인구분
	rePTransactionNo			= request.form("rePTransactionNo")				'포인트거래번호
	rePStatus					= request.form("rePStatus")						'포인트승인상태
	rePTradeDate				= request.form("rePTradeDate")					'포인트거래일자
	rePTradeTime				= request.form("rePTradeTime")					'포인트거래시간
	rePIssCode					= request.form("rePIssCode")					'포인트발급사코드
	rePAuthNo					= request.form("rePAuthNo")						'포인트승인번호
	rePMessage1					= request.form("rePMessage1")					'메시지1
	rePMessage2					= request.form("rePMessage2")					'메시지2
	rePPoint1					= request.form("rePPoint1")						'거래포인트
	rePPoint2					= request.form("rePPoint2")						'가용포인트
	rePPoint3					= request.form("rePPoint3")						'누적포인트
	rePPoint4					= request.form("rePPoint4")						'가맹점포인트
	rePMerchantNo				= request.form("rePMerchantNo")					'가맹점번호
	rePNotice1					= request.form("rePNotice1")
	rePNotice2					= request.form("rePNotice2")
	rePNotice3					= request.form("rePNotice3")
	rePNotice4					= request.form("rePNotice4")
	rePFiller					= request.form("rePFiller")

' 가상계좌---------------------------------------------------------------------------------------
	reVATransactionNo			= request.form("reVATransactionNo")			'가상계좌거래번호
	reVAStatus					= request.form("reVAStatus")				'상태
	reVATradeDate				= request.form("reVATradeDate")				'거래일자
	reVATradeTime				= request.form("reVATradeTime")				'거래시간
	reVABankCode				= request.form("reVABankCode")				'은행코드
	reVAVirAcctNo				= request.form("reVAVirAcctNo")				'가상계좌번호
	reVAName					= request.form("reVAName")					'예금주명
	reVAMessage1				= request.form("reVAMessage1")				'메시지1
	reVAMessage2				= request.form("reVAMessage2")				'메시지2
	reVAFiller					= request.form("reVAFiller")				'예비

' 월드패스---------------------------------------------------------------------------------------
	reWPTransactionNo			= request.form("reWPTransactionNo")			'월드패스거래번호
	reWPStatus					= request.form("reWPStatus")				'상태
	reWPTradeDate				= request.form("reWPTradeDate")				'거래일자
	reWPTradeTime				= request.form("reWPTradeTime")				'거래시간
	reWPIssCode					= request.form("reWPIssCode")				'발급사코드
	reWPAuthNo					= request.form("reWPAuthNo")				'승인번호
	reWPBalanceAmount			= request.form("reWPBalanceAmount")			'잔액
	reWPLimitAmount				= request.form("reWPLimitAmount")			'한도액
	reWPMessage1				= request.form("reWPMessage1")				'메시지1
	reWPMessage2				= request.form("reWPMessage2")				'메시지2
	reWPCardNo					= request.form("reWPCardNo")				'카드번호
	reWPAmount					= request.form("reWPAmount")				'금액
	reWPMerchantNo				= request.form("reWPMerchantNo")			'가맹점번호
	reWPFiller					= request.form("reWPFiller")				'예비

' 휴대폰 ---------------------------------------------------------------------------------------
	reMTransactionNo			= request.form("reMTransactionNo")			'거래번호     
	reMStatus					= request.form("reMStatus")					'거래성공여부 
	reMTradeDate				= request.form("reMTradeDate")				'거래일자     
	reMTradeTime				= request.form("reMTradeTime")				'거래시간     
	reMBalAmount				= request.form("reMBalAmount")				'잔액         
	reMTid						= request.form("reMTid")					'기관응답코드 
	reMRespCode					= request.form("reMRespCode")				'응답코드     
	reMRespMsg					= request.form("reMRespMsg")				'응답메시지   
	reMBypassMsg				= request.form("reMBypassMsg")				'Echo 필드    
	reMCompCode					= request.form("reMCompCode")				'기관코드     
	reMFiller					= request.form("reMFiller")					'예비         

	'신용카드(1=MPI, I=ISP)
    if(mid(reApprovalType,1,1) = "1" or mid(reApprovalType,1,1) = "I") then			
        authyn		= request.form("reStatus")
        trno		= request.form("reTransactionNo")
        trddt		= request.form("reTradeDate")
        trdtm		= request.form("reTradeTime")
        amt			= request.form("reAmount")
        authno		= request.form("reAuthNo")
        msg1		= request.form("reMessage1")
        msg2		= request.form("reMessage2")
        ordno		= request.form("reOrderNumber")
        isscd		= request.form("reIssCode")
        aqucd		= request.form("reAquCode")
        temp_v		= request.form("reTemp_v")
        result		= request.form("reApprovalType")
    elseif(mid(reApprovalType,1,1) = "4") then					'포인트
        authyn		= request.form("rePStatus")
        trno		= request.form("rePTransactionNo")
        trddt		= request.form("rePTradeDate")
        trdtm		= request.form("rePTradeTime")
        amt			= request.form("reAmount")
        authno		= request.form("rePAuthNo")
        msg1		= request.form("rePMessage1")
        msg2		= request.form("rePMessage2")
        ordno		= request.form("reOrderNumber")
        isscd		= request.form("rePIssCode")
        aqucd		= ""
        temp_v		= request.form("reTemp_v")
        result		= request.form("reApprovalType")
    elseif(mid(reApprovalType,1,1) = "6") then					'가상계좌
        authyn		= request.form("reVAStatus")
        trno		= request.form("reVATransactionNo")
        trddt		= request.form("reVATradeDate")
        trdtm		= request.form("reVATradeTime")
        amt			= request.form("reAmount")
        authno		= request.form("reVABankCode")
        msg1		= request.form("reVAMessage1")
        msg2		= request.form("reVAMessage2")
        ordno		= request.form("reOrderNumber")
        isscd		= request.form("reVAVirAcctNo")
        aqucd		= ""
        temp_v		= request.form("reTemp_v")
        result		= request.form("reApprovalType")
	elseif(mid(reApprovalType,1,1) = "2") then              '계좌이체
        authyn		= request.form("reVAStatus")
        trno		= request.form("reVATransactionNo")
        trddt		= request.form("reVATradeDate")
        trdtm		= request.form("reVATradeTime")
        amt			= request.form("reAmount")
        authno		= request.form("reVABankCode")
        msg1		= request.form("reVAMessage1")
        msg2		= request.form("reVAMessage2")
        ordno		= request.form("reOrderNumber")
        isscd		= request.form("reVAVirAcctNo")
        aqucd		= ""
        temp_v		= request.form("reTemp_v")
        result		= request.form("reApprovalType")
    elseif(mid(reApprovalType,1,1) = "7") then					 '월드패스
        authyn		= request.form("reWPStatus")
        trno		= request.form("reWPTransactionNo")
        trddt		= request.form("reWPTradeDate")
        trdtm		= request.form("reWPTradeTime")
        amt			= request.form("reAmount")
        authno		= request.form("reWPAuthNo")
        msg1		= request.form("reWPMessage1")
        msg2		= request.form("reWPMessage2")
        ordno		= request.form("reOrderNumber")
        isscd		= ""
        aqucd		= ""
        temp_v		= request.form("reTemp_v")
        result		= request.form("reApprovalType")
    elseif(mid(reApprovalType,1,1) = "M") then					 '휴대폰
		authyn		= request.form("reMStatus")
		trno		= request.form("reMTransactionNo")
		trddt		= request.form("reMTradeDate")
		trdtm		= request.form("reMTradeTime")
		amt			= request.form("reMBalAmount")
		authno		= request.form("reMRespCode")	  
		msg1		= request.form("reMRespMsg")
		msg2		= request.form("reMobile")
		ordno		= request.form("reOrderNumber")
		isscd		= request.form("reMBypassMsg")
		aqucd  		= request.form("reGoodType")
		temp_v 		= request.form("reTemp_v")
		result		= request.form("reApprovalType")
	end if
%>
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript">
<!--
	/*init() - 함수설명 : 결재완료후 opener페이지(AuthFrm.asp)에 있는 paramSet(), goResult() 함수를 호출한다*/
    function init()
	{
        top.opener.paramSet("<%=authyn%>","<%=trno%>","<%=trddt%>","<%=trdtm%>","<%=authno%>","<%=ordno%>","<%=msg1%>","<%=msg2%>","<%=amt%>","<%=temp_v%>","<%=isscd%>","<%=aqucd%>","","<%=result%>");
        top.opener.goResult();
        window.close();
    }

    init();
-->
</script>
</head>
</html>