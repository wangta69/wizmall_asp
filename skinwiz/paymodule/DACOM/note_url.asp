<%
'
' 이 페이지는 링크창 + 웹전송 방식의 note_url 샘플입니다.
'
'============================================================================================================
' 주의1 : 이 페이지를 ret_url에 지정하시면 안됩니다. ret_url과 note_url로 돌려드리는 결과값은 차이가 있습니다.
'            본 페이지는 반드시 note_url 에만 지정하셔야 합니다. (* ret_url 은 메뉴얼을 참고로 별도 제작하셔야 합니다)
'
' 주의2 : note_url 페이지의 경우 hashdata 검증이 필수 입니다. 따라서 상점관리자에서 확인된 mertkey값을 아래 
'           샘플내용에 꼭 지정해 주셔야 합니다.
'
' 주의3 : note_url은 LG데이콤 결제서버가 호출하는 페이지로 OK 출력이외의 메시지가 수신될 경우 결과전송에 문제가
'           발생하게 됩니다. html 태그나 자바스크립트 코드를 사용하는 경우 동작을 보장할 수 없습니다.
'
' 주의4 : 정상적으로 data를 처리한 경우에도 LG데이콤에서 OK 응답을 받지 못한 경우는 결제결과가 중복해서 나갈 수 
'           있으므로 관련한 처리도 고려되어야 합니다
'
' 주의5 : 결제에 대한 결과 처리는 각각의 경우에 따라 write_success(),write_failure(),write_hasherr()에서 관련 루틴을
'           추가 하시면 됩니다.
'============================================================================================================
'
' [ note_url 페이지가 문제가 있는 경우 ]
'
' 상점관리자 페이지-> 결제내역조회 -> 전체거래내역조회 -> 전송실패내역조회 에서 note_url이 LG데이콤으로 응답한 
' 내용을 확인 하실수 있습니다.
' 
' - 서비스 상점관리자 URL : http://pgweb.dacom.net
' - 테스트 상점관리자 URL : http://pgweb.dacom.net/tmert
'


	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1
%>

<!-- #include file = "md5.asp" -->
<!-- #include file="write.asp" -->
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
<%
	Dim msgtype       	' 거래종류에 따른 데이콤이 정의한 코드
	Dim respcode		' 응답코드: 0000(성공) 그외 실패
	Dim respmsg			' 응답메세지
	Dim transaction   	' 데이콤이 부여한 거래번호
	Dim merchantid     	' 상점아이디 
	Dim oid   			' 주문번호
	Dim amount      	' 거래금액
	Dim currencycode   	' 통화코드(410:원화, 840:달러)
	Dim paytype       	' 결제수단코드
	Dim paydate       	' 거래일시(승인일시/이체일시)
	Dim buyer       	' 구매자명
	Dim productinfo   	' 상품정보
	Dim buyerssn   		' 구매자주민등록번호
	Dim buyerid   		' 구매자ID
	Dim buyeraddress 	' 구매자주소
	Dim buyerphone 		' 구매자전화번호
	Dim buyeremail 		' 구매자이메일주소
	Dim receiver      	' 수취인명
	Dim receiverphone 	' 수취인전화번호
	Dim deliveryinfo 	' 배송정보
	Dim producttype   	' 상품유형
	Dim productcode   	' 상품코드
	Dim financecode   	' 결제기관코드(카드종류/은행코드)
	Dim financename   	' 결제기관이름(카드이름/은행이름)
	Dim hashdata		' 해쉬값
	Dim hashdata2		' 해쉬값2

	Dim authnumber    	' 승인번호(신용카드)
	Dim cardnumber    	' 카드번호(신용카드)
	Dim cardexp    		' 유효기간(신용카드)
	Dim cardperiod    	' 할부개월수(신용카드)	
	Dim nointerestflag  ' 무이자할부여부(신용카드) - '1'이면 무이자할부 '0'이면 일반할부
	Dim transamount		' 환율적용금액(신용카드)
	Dim exchangerate	' 환율(신용카드)

	Dim pid    			' 예금주/휴대폰소지자/입금자 주민등록번호(계좌이체/휴대폰/무통장입금) 
	Dim accountowner	' 계좌소유주이름(계좌이체) 
	Dim accountnumber	' 계좌번호(계좌이체, 무통장입금) 

	Dim telno			' 휴대폰전화번호(휴대폰)

    Dim payer           ' 입금인(무통장입금)
    Dim cflag           ' 무통장입금 플래그(무통장입금) - 'R':계좌할당, 'I':입금, 'C':입금취소
    Dim tamount         ' 입금총액(무통장입금)
    Dim camount         ' 현입금액(무통장입금)
    Dim bankdate        ' 입금또는취소일시
	Dim seqno			' 입금순서(무통장입금)

	Dim receiptnumber	' 현금영수증 승인번호

	Dim mertkey			' 데이콤에서 부여하는 상점키
	Dim resp, noti(46)


	' 데이콤에서 받은 value
	respcode 		= trim(request("respcode"))
	respmsg 		= trim(request("respmsg"))
	hashdata 		= trim(request("hashdata"))
	transaction 	= trim(request("transaction"))
	merchantid 		= trim(request("mid"))
	oid 			= trim(request("oid"))
	amount 			= trim(request("amount"))
	currencycode 	= trim(request("currency"))
	paytype 		= trim(request("paytype"))
	msgtype 		= trim(request("msgtype"))
	paydate 		= trim(request("paydate"))
	buyer 			= trim(request("buyer"))
	productinfo 	= trim(request("productinfo"))
	buyerssn 		= trim(request("buyerssn"))
	buyerid 		= trim(request("buyerid"))
	buyeraddress 	= trim(request("buyeraddress"))
	buyerphone 		= trim(request("buyerphone"))
	buyeremail 		= trim(request("buyeremail"))
	receiver 		= trim(request("receiver"))
	receiverphone 	= trim(request("receiverphone"))
	deliveryinfo 	= trim(request("deliveryinfo"))
	producttype 	= trim(request("producttype"))
	productcode 	= trim(request("productcode"))
	financecode 	= trim(request("financecode"))
	financename 	= trim(request("financename"))
	authnumber 		= trim(request("authnumber"))
	cardnumber 		= trim(request("cardnumber"))
	cardexp 		= trim(request("cardexp"))
	cardperiod 		= trim(request("cardperiod"))
	nointerestflag 	= trim(request("nointerestflag"))
	transamount 	= trim(request("transamount"))
	exchangerate 	= trim(request("exchangerate"))
	pid 			= trim(request("pid"))
	accountnumber 	= trim(request("accountnumber"))
	accountowner 	= trim(request("accountowner"))
	telno			= trim(request("telno"))
	payer			= trim(request("payer"))
	cflag			= trim(request("cflag"))
	tamount			= trim(request("tamount"))
	camount			= trim(request("camount"))
	bankdate		= trim(request("bankdate"))
	seqno			= trim(request("seqno"))
	receiptnumber	= trim(request("receiptnumber"))
	receiptkind		= trim(request("receiptkind"))
	receiptself		= trim(request("receiptself"))
	useescrow		= trim(request("useescrow"))
	hashdata2		= trim(request("hashdata2"))

	''mertkey 		= "" '//데이콤에서 발급
	mertkey 		= CARD_PASS '//데이콤에서 발급
	hashdata3 		= md5(transaction & merchantid & oid & paydate & respcode & amount & mertkey)

	noti(0) = msgtype
	noti(1) = respcode
	noti(2) = respmsg
	noti(3) = transaction
	noti(4) = merchantid
	noti(5) = oid
	noti(6) = amount
	noti(7) = currencycode
	noti(8) = paytype
	noti(9) = paydate
	noti(10) = buyer
	noti(11) = productinfo
	noti(12) = buyerssn
	noti(13) = buyerid
	noti(14) = buyeraddress
	noti(15) = buyerphone
	noti(16) = buyeremail
	noti(17) = receiver
	noti(18) = receiverphone
	noti(19) = deliveryinfo
	noti(20) = producttype
	noti(21) = productcode
	noti(22) = financecode
	noti(23) = financename
	noti(24) = hashdata
	noti(25) = authnumber
	noti(26) = cardnumber
	noti(27) = cardexp
	noti(28) = cardperiod
	noti(29) = nointerestflag
	noti(30) = transamount
	noti(31) = exchangerate
	noti(32) = pid
	noti(33) = accountnumber
	noti(34) = accountowner
	noti(35) = telno
	noti(36) = payer
	noti(37) = cflag
	noti(38) = tamount
	noti(39) = camount
	noti(40) = bankdate
	noti(41) = seqno
	noti(42) = receiptnumber
	noti(43) = receiptkind
	noti(44) = receiptself
	noti(45) = useescrow
	noti(46) = hashdata2

	if (hashdata3 = hashdata2) then
	    if (respcode = "0000") then
	        resp = write_success(noti)
	    else 
	        resp = write_failure(noti)
	    end if
	else
	    write_hasherr(noti)
	end if

	if resp then
	    Response.Write("OK")
	else
	    Response.Write("FAIL")
	end if
%>
