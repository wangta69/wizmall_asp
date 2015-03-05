<%
Response.Buffer=true
'------------------------------------------------------------------------------
 'FILE NAME : backUrl.asp
 'DATE : 2006-09-01
 '이 페이지는 BackURL로 지정된 페이지로 오는 결과전문을 받고 수신응답을 하기위한 샘플페이지입니다.
'-------------------------------------------------------------------------------

' =============	Input 변수 =================================================================
' strModule	  :	Module Name
' strFunction :	Function Name
' strLogMsg	  :	Logging	할 정보
' ==========================================================================================

Sub	TraceLog(strLogMsg)

	Const ForReading = 1, ForWriting = 2, ForAppending = 8
	Dim	dtmCurrent,	iDay, iMonth, iYear
	Dim	strLogFile,	strRecord
	Dim	fs,	f

	'On	Error Resume Next
	'	If LOG_FLAG	<> "1" Then
	'		Exit Sub
	'	End	If

	'***************************************************************************
	' Log File 지정(해당업체에서 로그파일을 받을 경로 지정) 
	' ex) LOG_PATH = "C:\1\"(C드라이브 밑의 1디렉토리 밑에 생성)
	'***************************************************************************
	LOG_PATH = "C:\1\"

	'*************************************************************************
	' 현재 날짜를 생성
	'*************************************************************************
	dtmCurrent = now
	iDay = Day(dtmCurrent)
	If iDay	< 10 Then
		iDay = "0" & CStr(iDay)
	Else
		iDay = CStr(iDay)
	End	If

	iMonth = Month(dtmCurrent)
	If iMonth <	10 Then
		iMonth = "0" & CStr(iMonth)
	Else
		iMonth = CStr(iMonth)
	End	If
	iYear =	CStr(Year(dtmCurrent))

	strLogFile = LOG_PATH &	strModule &	iYear &	iMonth & iDay &	".txt"

	'*************************************************************************
	' Logging 할 Record	생성
	'*************************************************************************
	strRecord =	"["	& CStr(time()) & "]	"
	strRecord =	strRecord &	CStr(strFunction) &	Space(40 - Len(CStr(strFunction)))
	strRecord =	strRecord &	": " & CStr(strLogMsg) & " "

	'*************************************************************************
	' 화일에 Logging
	'*************************************************************************
	Set	fs = CreateObject("Scripting.FileSystemObject")

	Set	f =	fs.OpenTextFile(strLogFile,	ForAppending, True)
	f.WriteLine(strRecord)
	f.Close

	Err.Clear
End	Sub
%>
<%
	Dim	data
	Dim	ret
	Dim	paraData
	Dim	strLen
	Dim	writeData
	Dim	send

'On	Error GoTo ErrorHandler

	data = Trim(CStr(Request.QueryString("data")))

'	data = Server.URLDecode(data)

'*****************************************Header 전문*******************************************************
'0:길이,1:암호화구분,2:버전,3:Type,4:resend,5:요청일시,6:상점아이디,7:주문번호,8:주문자명,9:주민번호,10:이메일
'11:Product	Type,12:상품명,13:KeyIn	여부,14:유무선구분,15:헤더뒤 전문개수,16:휴대폰번호,17:예비
'************************************************************************************************************

'*****************************************신용카드 Data전문*************************************************
'18:승인구분,19:거래번호,20:오류구분,21:거래일자,22:거래시간,23:발급사코드,24:매입사코드,25:승인번호
'26:메시지1,27:메시지2,28:카드번호,29:유효기간,30:할부,31:금액,32:가맹점번호,33:인증여부,34:승인여부
'35:예비,36:인증구분,37:MPI인증장소,38:ISP또는 Visa3D인증정보
'************************************************************************************************************
'*****************************************가상계좌발급 Data전문*************************************************
'18:승인구분,19:거래번호,20:오류구분,21:거래일자,22:거래시간,23:은행,24:가상계좌,25:예금주
'26:메시지1,27:메시지2,28:예비
'************************************************************************************************************
'*****************************************월드패스카드 Data전문*************************************************
'18:승인구분,19:거래번호,20:오류구분,21:거래일자,22:거래시간,23:발급사코드,24:승인번호,25:잔액
'26:한도액,27:메시지1,28:메시지2,29:카드번호,30:금액,31:가맹점번호,32:예비
'************************************************************************************************************
'*****************************************계좌이체 Data전문*************************************************
'18:승인구분,19:거래번호,20:오류구분,21:거래일자,22:거래시간,23:계좌이체유형,24:통장인쇄메세지
'25:입금모계좌은행코드,26:입금모모계좌번호,27:출금은행코드,28:출금계좌번호,29:결제금액,30:은행응답코드
'31:메시지1,32:메시지2,33:예비
'************************************************************************************************************
'*****************************************휴대폰결제 Data전문*************************************************
'18:승인구분,19:거래번호,20:오류구분,21:거래일자,22:거래시간,23:금액,24:기관응답코드
'25:응답코드,26:응답메시지,27:서비스업체,28:기관코드,29:예비
'************************************************************************************************************
	paraData = Split(data,"`")

	strLen = Ubound(paraData,1)

'	For	I =	0 To strLen
'		writeData =	writeData &	paraData(I)
'	Next

	TraceLog data

	rVersion				=  paraData(1)	'  0:암호안함, 1:암호화(openssl), 2:암호화(seed)
	rType					=  paraData(2)	'  전문버전	: 311
	rmsg_sele				=  paraData(3)	'  전문구분
	rResend					=  paraData(4)	'  재전송구분
	rRequestDate			=  paraData(5)	'  요청일시
	rStoreId				=  paraData(6)	'  상점아이디
	rOrderNumber			=  paraData(7)	'  주문번호
	rUserName				=  paraData(8)	'  주문자명
	rIdNum					=  paraData(9)	'  주민번호
	rEmail					=  paraData(10)	'  이메일
	rGoodType				=  paraData(11)	'  제품구분 1 : 실물, 2 : 디지털
	rGoodName				=  paraData(12)	'  상품명
	rKeyInType				=  paraData(13)	'  keyin여부
	rLineType				=  paraData(14)	'  유무선구분
	rPhoneNo				=  paraData(15)	'  휴대폰번호
	rApprovalCount			=  paraData(16)	'  복합결제건수
	rHaedFiller				=  paraData(17)	'  예비

	ret	= "false"

	IF(mid(paraData(18),1,1)="1" or mid(paraData(18),1,1)="I") 	Then			'신용카드(ISP,Visa3D포함) paraData(18]=>승인구분	 paraData[18].substring(0,1).equals("1")
		IF strLen >= 38	Then
			rApprovalType		= paraData(18)
			rTransactionNo		= paraData(19)	 ' 거래번호
			rStatus				= paraData(20)	 ' 상태	O :	승인, X	: 거절
			rTradeDate			= paraData(21)	 ' 거래일자
			rTradeTime			= paraData(22)	 ' 거래시간
			rIssCode			= paraData(23)	 ' 발급사코드
			rAquCode			= paraData(24)	 ' 매입사코드
			rAuthNo				= paraData(25)	 ' 승인번호	or 거절시 오류코드
			rMessage1			= paraData(26)	 ' 메시지1
			rMessage2			= paraData(27)	 ' 메시지2
			rCardNo				= paraData(28)	 ' 카드번호
			rExpDate			= paraData(29)	 ' 유효기간
			rInstallment		= paraData(30)	 ' 할부
			rAmount				= paraData(31)	 ' 금액
			rMerchantNo			= paraData(32)	 ' 가맹점번호
			rAuthSendType		= paraData(33)	 ' 전송구분= new String(this.read(2))
			rApprovalSendType	= paraData(34)	 ' 전송구분(0 :	거절, 1	: 승인,	2: 원카드)
			rPoint1				= paraData(35)	 ' Point1
			rPoint2				= paraData(36)	 ' Point2
			rPoint3				= paraData(37)	 ' Point3
			rPoint4				= paraData(38)	 ' Point4
			rVanTransactionNo	= paraData(39)	 ' Van거래번호
			rFiller				= paraData(40)	 ' 예비
			rAuthType			= paraData(41)	 ' ISP : ISP거래, MP1, MP2 : MPI거래, SPACE	: 일반거래
			rMPIPositionType	= paraData(42)	 ' K : KSNET, R	: Remote, C	: 제3기관, SPACE : 일반거래
			rMPIReUseType		= paraData(43)	 ' Y : 재사용, N : 재사용아님
			rEncData			= paraData(44)	 ' MPI,	ISP	데이터

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"6"	Then
		IF strLen >= 28	Then
			rVAApprovalType	 = paraData(18)	  '
			rVATransactionNo = paraData(19)	  '	거래번호
			rVAStatus		 = paraData(20)	  '	상태
			rVATradeDate	 = paraData(21)	  '	거래일자
			rVATradeTime	 = paraData(22)	  '	거래시간
			rVABankCode		 = paraData(23)	  '	은행코드
			rVAVirAcctNo	 = paraData(24)	  '	가상계좌번호
			rVAName			 = paraData(25)	  '	예금주
			rVAMessage1		 = paraData(26)	  '	메시지1
			rVAMessage2		 = paraData(27)	  '	메시지2
			rVAFiller		 = paraData(28)	  '	예비

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"7"	Then '월드패스카드 paraData(18]=>승인구분
		IF strLen >= 32	Then
			rApprovalType	 = paraData(18)	  '
			rWPTransactionNo = paraData(19)	  '	거래번호
			rWPStatus		 = paraData(20)	  '	상태 O : 승인, X : 거절
			rWPTradeDate	 = paraData(21)	  '	거래일자
			rWPTradeTime	 = paraData(22)	  '	거래시간
			rWPIssCode		 = paraData(23)	  '	발급사코드
			rWPAuthNo		 = paraData(24)	  '	승인번호
			rWPBalanceAmount = paraData(25)	  '	잔액
			rWPLimitAmount	 = paraData(26)	  '	한도액
			rWPMessage1		 = paraData(27)	  '	메시지1
			rWPMessage2		 = paraData(28)	  '	메시지2
			rWPCardNo		 = paraData(29)	  '	카드번호
			rWPAmount		 = paraData(30)	  '	금액
			rWPMerchantNo	 = paraData(31)	  '	가맹점번호
			rWPFiller		 = paraData(32)	  '	예비

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"2"	Then
		IF strLen >= 33	Then
			rVAApprovalType	 = paraData(18)	  '
			rVATransactionNo = paraData(19)	  '	*거래번호
			rVAStatus		 = paraData(20)	  '	*상태 O : 승인, X : 거절
			rVATradeDate	 = paraData(21)	  '	*거래일자
			rVATradeTime	 = paraData(22)	  '	*거래시간
			rVAAcctType		 = paraData(23)	  '	계좌이체유형
			rVArVAPrintMsg	 = paraData(24)	  '	통장인쇄메세지
			rVAPBankCode	 = paraData(25)	  '	입금모계좌은행코드
			rVAPAcctNo		 = paraData(26)	  '	입금모모계좌번호
			rVABankCode		 = paraData(27)	  '	*출금은행코드
			rVAAcctNo		 = paraData(28)	  '	출금계좌번호
			rVAAmount		 = paraData(29)	  '	결제금액
			rVABankRespCode	 = paraData(30)	  '	은행응답코드
			rVAMessage1		 = paraData(31)	  '	*메시지1
			rVAMessage2		 = paraData(32)	  '	메시지2
			rVAFiller		 = paraData(33)	  '	예비

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"M"	Then
		IF strLen >= 29	Then
			rMApprovalType	 = paraData(18)	  '
			rMTransactionNo	 = paraData(19)	  '	거래번호    
			rMStatus		 = paraData(20)	  '	거래성공여부
			rMTradeDate 	 = paraData(21)	  '	거래일자    
			rMTradeTime 	 = paraData(22)	  '	거래시간    
			rMBalAmount 	 = paraData(23)	  '	잔액        
			rMTid 			 = paraData(24)	  '	기관응답코드
			rMRespCode		 = paraData(25)	  '	응답코드    
			rMRespMsg		 = paraData(26)	  '	응답메시지  
			rMBypassMsg		 = paraData(27)	  '	서비스업체
			rMCompCode		 = paraData(28)	  '	기관코드    
			rMFiller		 = paraData(29)	  '	예비        

			ret	= "true"

		End	IF
	End	IF
msg = "ret=" & ret
Response.Write(msg)
Response.AddHeader "Content-Length", Len(msg)
Response.Flush()
%>