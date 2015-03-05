<!------------------------------------------------------------------------------
 FILE NAME : KSPayApprovalCancel.jsp
 AUTHOR : kspay@ksnet.co.kr
 DATE : 2006-08-01
 Version : V1.1
                                                         http://www.kspay.co.kr
                                                         http://www.ksnet.co.kr
                                  Copyright 2006 KSNET, Co. All rights reserved
------------------------------------------------------------------------------->
<%
	dim PGIPAddr
	dim PGPort

	dim HeadMsg
	dim DataMsg
	dim SendMsg
	dim ReceiveMsg
	dim SendURL
	dim SendURLMsg

	SendCount = 0
	ReceiveCount = 0
	
    MAXSIZE = 9

	' KSNET 전문 Haeder(공통으로 들어감)
	dim EncType 			' 0: 암화안함, 1:openssl, 2: seed
	dim Version 			' 전문버전
	dim VersionType 		' 구분
	dim Resend 			' 전송구분 : 0 : 처음,  2: 재전송
	dim RequestDate 		' 요청일자 : yyyymmddhhmmss
	dim StoreId 			' 상점아이디
	dim OrderNumber 		' 주문번호
	dim UserName 			' 주문자명
	dim IdNum 			' 주민번호 or 사업자번호
	dim Email 			' email
	dim GoodType 			' 제품구분 1 : 실물, 2 : 디지털
	dim GoodName 			' 제품명
	dim KeyInType 			' KeyInType 여부 : S : Swap, K: KeyInType
	dim LineType 			' lineType 0 : offline, 1:internet, 2:Mobile
	dim PhoneNo 			' 휴대폰번호
	dim ApprovalCount		' 복합결제건수
	
	dim HaedFiller			' 예비

 	' 신용카드승인결과 
	dim ApprovalType			' 승인구분
	dim TransactionNo			' 거래번호
	dim Status				' 상태 O : 승인 , X : 거절
	dim TradeDate				' 거래일자
	dim TradeTime				' 거래시간
	dim IssCode				' 발급사코드
	dim AquCode				' 매입사코드
	dim AuthNo				' 승인번호 or 거절시 오류코드
	dim Message1				' 메시지1
	dim Message2				' 메시지2
	dim CardNo				' 카드번호
	dim ExpDate				' 유효기간
	dim Installment				' 할부
	dim Amount				' 금액
	dim MerchantNo				' 가맹점번호
	dim AuthSendType			' 전송구분
	dim ApprovalSendType			' 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
	dim Point1				'
	dim Point2				'
	dim Point3				'
	dim Point4				'
	dim VanTransactionNo			' Van 거래번호
	dim Filler				' 예비
	dim AuthType				' ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	dim MPIPositionType			' K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	dim MPIReUseType			' Y : 재사용, N : 재사용아님
	dim EncData				' MPI, ISP 데이터
					
	' 가상계좌승인결과 
	dim VATransactionNo			'거래번호	           
	dim VAStatus				' 상태 O : 승인 , X : 거절 
	dim VATradeDate				' 거래일자                 
	dim VATradeTime				' 거래시간                 
	dim VABankCode				' 은행코드
	dim VAVirAcctNo				' 가상계좌번호
	dim VAName				' 예금주
	dim VACloseDate				' 마감일자
	dim VACloseTime				' 마감시간
	dim VARespCode				' 응답코드
	dim VAMessage1				' 메세지1
	dim VAMessage2				' 메세지2
	dim VAFiller				' 예비

	' 월드패스승인결과
	dim WPTransactionNo			'거래번호	
	dim WPStatus				' 상태 O : 승인 , X : 거절
	dim WPTradeDate	 			' 거래일자      
	dim WPTradeTime	 	        	' 거래시간      
	dim WPIssCode				'발급사코드
	dim WPAuthNo				'승인번호
	dim WPBalanceAmount			'잔액
	dim WPLimitAmount			'한도액
	dim WPMessage1				'메시지1
	dim WPMessage2				'메시지2
	dim WPCardNo				'카드번호
	dim WPAmount				'금액
	dim WPMerchantNo			'가맹점번호
	dim WPFiller		

 	' 포인트카드승인결과
	dim PTransactionNo			' 거래번호
	dim PStatus       			' 상태 O : 승인 , X : 거절
	dim PTradeDate    			' 거래일자
	dim PTradeTime    			' 거래시간
	dim PIssCode      			' 발급사코드
	dim PAuthNo       			' 승인번호 or 거절시 오류코드
	dim PMessage1     			' 메시지1
	dim PMessage2     			' 메시지2
	dim PPoint1	      			' 거래포인트
	dim PPoint2       			' 가용포인트
	dim PPoint3       			' 누적포인트
	dim PPoint4       			' 가맹점포인트
	dim PMerchantNo   			' 가맹점번호
	dim PNotice1      			' 
	dim PNotice2      			' 
	dim PNotice3      			' 
	dim PNotice4      			' 
	dim PFiller       			' 예비

	' 현금영수증승인결과
	dim HTransactionNo			' 거래번호  				   
	dim HStatus				' 오류구분 O:정상 X:거절     
	dim HCashTransactionNo			' 현금영수증 거래번호		   
	dim HIncomeType				' 0: 소득      1: 비소득   
	dim HTradeDate				' 거래 개시 일자             
	dim HTradeTime				' 거래 개시 시간             
	dim HMessage1				' 응답 message1            
	dim HMessage2				' 응답 message2            
	dim HCashMessage1			' 국세청 메시지 1          
	dim HCashMessage2			' 국세청 메시지 2          
	dim HFiller				' 예비                       


	' 카드 bin 체크 결과 - 추후 추가 

	' 휴대폰 인증 1차 2차 결과 - 추후 추가 

	' 상점정보 조회 - XMPI 결제 모듈 관련 추가  
	dim SITransactionNo			' 거래번호                                                            
	dim SIStatus          			' 성공:O, 실패: X                                                     
	dim SIRespCode        			' '0000' : 정상처리, '0001' : 미등록상점, '0009' : Timeout 및 기타오류
	dim SIAgenMembDealSele			' 자체대행구분 - '1' : 자체, '2' : 대행                               
	dim SIStartSele       			' 개시여부                                                            
	dim SIEntrNumb        			' 사업자번호                                                          
	dim SIShopName        			' 상점명                                                              
	dim SIMembNumbGene    			' 일반 가맹점번호                                                     
	dim SIMembNumbNoin    			' 무이자 가맹점번호                                                   
	dim SIAlloMontType    			' 할부유형                                                            
	dim SIFiller          			' 예비             
%>
<%
	function GetLength(sdata)
		dim i, j
		dim istrlen
		dim sresult
		
		sresult = ""
		j = 0
		
		for i = 1 To Len(sdata) '한글갯수구하기
			if Asc(Mid(sdata, i, 1)) < 0 then
				j = j + 1
			end if
		next
		
		GetLength = len( CStr( sdata ) ) + j
	end function
	
	function SetData(sdata, ilen, sflag)
		dim i, j
		dim istrlen
		dim sresult
		
		sresult = ""
		j = 0
		
		for i = 1 To Len(sdata) '한글갯수구하기
			if Asc(Mid(sdata, i, 1)) < 0 then
				j = j + 1
			end if
		next
		
		istrlen = len( CStr( sdata ) ) + j
		if sflag = "9" then
			for i=1 to ilen - istrlen
				 sresult = "0" & sresult
			next
			SetData = (sresult & sdata)
		else
			for i=1 to  ilen - istrlen
				 sresult = " " & sresult
			next
			SetData = (sdata & sresult)
		end if
	end function
	
	function SetParse(sdata, ipos, ilen, inextpos)
		dim stmp1, stmp2
		dim i, j, k
		j = 0
		k = 0
		stmp2 = ""
		
		stmp1 = Mid(sdata, ipos, ilen)
		for i = 1 To Len(stmp1) 
			if j < iLen then
				if Asc(Mid(stmp1, i, 1)) < 0 then
					j = j + 2
					k = k + 1
					stmp2 = stmp2 & Mid(stmp1, i, 1)
				else
					j = j + 1
					stmp2 = stmp2 & Mid(stmp1, i, 1)
				end if
			else
				inextpos = ipos + ilen - k
				SetParse = stmp2
				exit function
			end if
		next
		inextpos = ipos + ilen - k
		SetParse = stmp2
	end function

	function SetLogMsg(str)
		strBuf = "" 
		for i = 1 to len(str)
			if mid(str, i, 1) = " " then
				strBuf = strBuf + "_"
			else
				strBuf = strBuf + mid(str, i, 1)
			end if
		next
		SetLogMsg = strBuf
	end function
	
	function KSPayApprovalCancel(addr, port)
		PGIPAddr = addr
		PGPort   = port

		SendCount    = 0
		ReceiveCount = 0
		SendMsg      = ""
		
		KSPayApprovalCancel = true
	end function

	function HeadMessage (EncType, Version, VersionType, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, Filler)
	' EncType		: 0: 암화안함, 1:openssl, 2: seed           
	' Version		: 전문버전                                  
	' VersionType		: 구분                                      
	' Resend		: 전송구분 : 0 : 처음,  2: 재전송           
	' RequestDate		: 요청일자 : yyyymmddhhmmss                 
	' StoreId		: 상점아이디                                
	' OrderNumber		: 주문번호                                  
	' UserName		: 주문자명                                  
	' IdNum			: 주민번호 or 사업자번호                    
	' Email			: email                                     
	' GoodType		: 제품구분 0 : 실물, 1 : 디지털             
	' GoodName		: 제품명                                    
	' KeyInType		: KeyInType 여부 : S : Swap, K: KeyInType   
	' LineType		: lineType 0 : offline, 1:internet, 2:Mobile
	' PhoneNo		: 휴대폰번호                                
	' ApprovalCount		: 복합승인갯수                              
	' Filler 		: 예비                                      

		dim TmpHeadMsg
		
		IdNum_temp   = ""
		if(trim(IdNum) <> "") then
			for i = 1 to GetLength(IdNum)
				if (mid(IdNum,i,1) >= "0" and mid(IdNum,i,1) >= "0") then
					IdNum_temp = IdNum_temp + mid(IdNum,i,1)
				end if
			next
			
			IdNum = IdNum_temp
			if(len(IdNum) > 13) then
				IdNum = mid(IdNum,1,13)
			end if
		end if
    	
		PhoneNo_temp=""
		if(trim(PhoneNo) <> "") then
			for i = 1 to GetLength(PhoneNo)
				if (mid(PhoneNo,i,1) >= "0" and mid(PhoneNo,i,1) >= "0") then
					PhoneNo_temp = PhoneNo_temp + mid(PhoneNo,i,1)
				end if
			next
			PhoneNo = PhoneNo_temp
			
			if(GetLength(PhoneNo) < 10) then
				PhoneNo = ""
			elseif (mid(PhoneNo,1,3) = "010") or (mid(PhoneNo,1,3) = "011") or (mid(PhoneNo,1,3) = "017") or _
			      (mid(PhoneNo,1,3) = "016") or (mid(PhoneNo,1,3) = "018") or (mid(PhoneNo,1,3) = "019") then
		   		if(GetLength(PhoneNo) = 10) then
					PhoneNo = mid(PhoneNo,1,3) & "0" & mid(PhoneNo,4,7)
				elseif(GetLength(PhoneNo) > 11) then
					PhoneNo = mid(PhoneNo,1,11)
				end if
			end if
		end if
		
		EncType			= SetData(EncType,		 	 1, "X")
		Version			= SetData(Version,			 4, "X")
		VersionType		= SetData(VersionType,			 2, "X")
		Resend			= SetData(Resend,			 1, "X")
		RequestDate		= SetData(RequestDate,			14, "X")
		StoreId			= SetData(StoreId,			10, "X")
		OrderNumber		= SetData(OrderNumber,			50, "X")
		UserName		= SetData(UserName,			50, "X")
		IdNum			= SetData(IdNum,			13, "X")
		Email			= SetData(Email,			50, "X")
		GoodType		= SetData(GoodType,			 1, "X")
		GoodName		= SetData(GoodName,			50, "X")
		KeyInType		= SetData(KeyInType,			 1, "X")
		LineType		= SetData(LineType,		 	 1, "X")
		PhoneNo			= SetData("0"+PhoneNo,			12, "X")
		ApprovalCount		= SetData(ApprovalCount,		 1, "X")
		Filler 			= SetData(sFiller,			35, "X")

		TmpHeadMsg = 	EncType       	& _
						Version			& _
						VersionType		& _
						Resend		   	& _
						RequestDate		& _
						StoreId			& _
						OrderNumber		& _
						UserName		& _
						IdNum			& _
						Email			& _
						GoodType		& _
						GoodName		& _
						KeyInType		& _
						LineType		& _
						PhoneNo			& _
						ApprovalCount 		& _
						Filler

		HeadMsg  = TmpHeadMsg
		HeadMessage = true
	end function 
	
	// 신용카드승인요청 Body 1
	function CreditDataMessage(ApprovalType,InterestType,TrackII,Installment,Amount,Passwd,IdNum,CurrencyType,BatchUseType,CardSendType,VisaAuthYn,Domain,IpAddr,BusinessNumber,Filler, AuthType,MPIPositionType,MPIReUseType,EncData)
	' ApprovalType			: 승인구분                                                                                                                
	' InterestType     		: 일반/무이자구분 1:일반 2:무이자                                                                                         
	' TrackII			: 카드번호=유효기간  or 거래번호                                                                                          
	' Installment			: 할부  00일시불                                                                                                          
	' Amount			: 금액                                                                                                                    
	' Passwd			: 비밀번호 앞2자리                                                                                                        
	' IdNum				: 주민번호  뒤7자리, 사업자번호10                                                                                         
	' CurrencyType			: 통화구분 0:원화 1: 미화                                                                                                 
	' BatchUseType			: 거래번호배치사용구분  0:미사용 1:사용                                                                                   
	' CardSendType			: 카드정보전송 0:미정송 1:카드번호,유효기간,할부,금액,가맹점번호 2:카드번호앞14자리 + "XXXX",유효기간,할부,금액,가맹점번호
	' VisaAuthYn			: 비자인증유무 0:사용안함,7:SSL,9:비자인증                                                                                
	' Domain			: 도메인 자체가맹점(PG업체용)                                                                                             
	' IpAddr			: IP ADDRESS 자체가맹점(PG업체용)                                                                                         
	' BusinessNumber		: 사업자 번호 자체가맹점(PG업체용)                                                                                        
	' Filler			: 예비                                                                                                                    
	' AuthType			: ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래                                                                     
	' MPIPositionType		: K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래                                                                    
	' MPIReUseType   		: Y :  재사용, N : 재사용아님                                                                                             
	' EndData			: MPI, ISP 데이터                                                                                                         
	' CardCode			: KVP 통신만 필요함 추후 KSNET으로 통신시 필요없음

		dim TmpSendMsg
		
		ApprovalType		= SetData(ApprovalType,      4, "X")
		InterestType		= SetData(InterestType,      1, "X")
		TrackII			= SetData(TrackII,          40, "X")
		Installment		= SetData(Installment,       2, "9")
		Amount			= SetData(Amount,            9, "9")
		Passwd			= SetData(Passwd,	     2, "X")
		IdNum			= SetData(IdNum,            10, "X")
		CurrencyType		= SetData(CurrencyType,      1, "X")
		BatchUseType		= SetData(BatchUseType,      1, "X")
		CardSendType		= SetData(CardSendType,      1, "X")
		VisaAuthYn		= SetData(VisaAuthYn,        1, "X")
		Domain			= SetData(Domain,           40, "X")
		IpAddr			= SetData(IpAddr,           20, "X")
		BusinessNumber		= SetData(BusinessNumber,   10, "X")
		Filler			= SetData(Filler,          135, "X")
		AuthType		= SetData(AuthType,          1, "X")
		MPIPositionType		= SetData(MPIPositionType,   1, "X")
		MPIReUseType   		= SetData(MPIReUseType,      1, "X")   
		
		TmpSendMsg 	  = ApprovalType	& _
						InterestType		& _
						TrackII		 	& _
						Installment	 	& _
						Amount		 	& _
						Passwd		 	& _
						IdNum			& _
						CurrencyType		& _
						BatchUseType		& _
						CardSendType		& _
						VisaAuthYn	 	& _
						Domain		 	& _
						IpAddr		 	& _
						BusinessNumber		& _
						Filler		 	& _
						AuthType		& _
						MPIPositionType		& _
						MPIReUseType		& _
						EncData

		SendMsg = SendMsg & TmpSendMsg
		'response.write SetLogMsg(TmpSendMsg) 
		SendCount = SendCount + 1

		CreditDataMessage = true
	end function	

	// 가상계좌
	function VirtualAccountDataMessage(ApprovalType,BankCode,Amount,CloseDate,CloseTime,EscrowSele,VirFixSele,VirAcctNo,OrgTransactionNo,Filler)
	' ApprovalType     : 승인구분
	' BankCode         : 은행코드
	' Amount           : 금액		 
	' CloseDate        : 마감일
	' CloseTime        : 마감시간
	' EscrowSele       : 에스크로적용구분: 0:적용안함, 1:적용, 2:강제적용
	' VirFixSele       : 가상계좌번호지정구분
	' VirAcctNo        : 가상계좌번호
	' OrgTransactionNo : 원거래거래번호
	' Filler           : 예비	 	 

		TmpSendMsg = ""
		
		ApprovalType	= SetData(ApprovalType		,  4, "X")
		BankCode	= SetData(BankCode    		,  6, "X")
		Amount		= SetData(Amount      		,  9, "9")
		CloseDate	= SetData(CloseDate   		,  8, "X")
		CloseTime	= SetData(CloseTime   		,  6, "X")
		EscrowSele	= SetData(EscrowSele		,  1, "X")
		VirFixSele	= SetData(VirFixSele  		,  1, "X")
		VirAcctNo	= SetData(VirAcctNo   		, 15, "X")
		OrgTransactionNo= SetData(OrgTransactionNo	, 12, "X")
		Filler	        = SetData(Filler	  	, 52, "X")

		TmpSendMsg  	= ApprovalType        & _
						  BankCode            & _
						  Amount              & _
						  CloseDate           & _
						  CloseTime           & _
						  EscrowSele          & _
						  VirFixSele          & _
						  VirAcctNo           & _
						  OrgTransactionNo    & _
						  Filler       
                      
                      
                                            
		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(VirtualAccountDataMessage)
		SendCount = SendCount + 1           
		VirtualAccountDataMessage = true
	end function

	//월드패스카드 승인
	function WorldPassDataMessage(ApprovalType,TrackII,Passwd,Amount,WorldPassType,AdultType,CardSendType,Filler)	
	' ApprovalType,		: 승인구분                                                                                                                  
	' TrackII,		: 카드번호  or 거래번호                                                                                                 
	' Passwd,		: 비밀번호 앞2자리                                                                                                      
	' Amount,		: 금액                                                                                                                  
	' WorldPassType,	: 선후불카드구분                                                                                                        
	' AdultType,		: 성인확인구분                                                                                                          
	' CardSendType,		: 카드정보전송 0:미전송 1:카드번호,유효기간,할부,금액,가맹점번호 2:카드번호앞14자리 + "XXXX",유효기간,할부,금액,가맹점번호  
	' Filler)		: 기타                                                                                                                  

		ApprovalType	= SetData(ApprovalType,     4, "X")
		TrackII         = SetData((TrackII+"4912"),40, "X")
		Passwd		= SetData(Passwd,	    4, "X")
		Amount		= SetData(Amount,           9, "9")
	        WorldPassType	= SetData(WorldPassType,    1, "X")  
		AdultType	= SetData(AdultType,        1, "X")  
	        CardSendType	= SetData(CardSendType,     1, "X")  
		Filler	        = SetData(Filler,          40, "X")  

		TmpSendMsg = 	ApprovalType  &	_ 
						TrackII		  & _
						Passwd		  & _
						Amount		  & _
						WorldPassType	  & _
						AdultType	  & _
						CardSendType	  & _
						Filler

		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(TmpSendMsg)
		SendCount = SendCount + 1  

		WorldPassDataMessage = true
	end function

	' 포인트카드승인
	function PointDataMessage(ApprovalType,TrackII,Amount,Passwd,SaleType,Filler)		
	' ApprovalType,		: 승인구분                       
	' TrackII,		: 카드번호=유효기간  or 거래번호 
	' Amount,		: 금액                           
	' Passwd,		: 비밀번호 앞4자리               
	' SaleType,		: 판매구분                       
	' Filler)		: 기타                           

		ApprovalType	= SetData(ApprovalType,       4, "X")
		TrackII		= SetData((TrackII+"=4912"), 40, "X")
		Amount		= SetData(Amount,             9, "9")
		Passwd		= SetData(Passwd,             4, "X")
	        SaleType	= SetData(SaleType,           2, "X")
		Filler		= SetData(Filler,            40, "X")

		TmpSendMsg	 = 	ApprovalType & _
						TrackII		 & _
						Amount		 & _
						Passwd		 & _
						SaleType	 & _
						Filler

		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(TmpSendMsg)
		SendCount = SendCount + 1  

		PointDataMessage = true
		
	end function

	' 현금영수증승인
	function CashBillDataMessage(ApprovalType,TransactionNo,IssuSele,UserInfoSele,UserInfo,TranSele,CallCode,SupplyAmt,TaxAmt,SvcAmt,TotAmt,Filler)
	'	ApprovalType  : H000:일반발급, H200:계좌이체, H600:가상계좌
	'	TransactionNo : 입금완료된 계좌이체, 가상계좌 거래번호
	'	IssuSele      : 0:일반발급(PG원거래번호 중복체크), 1:단독발급(주문번호 중복체크 : PG원거래 없음), 2:강제발급(중복체크 안함)
	'	UserInfoSele  : 0:주민등록번호
	'	UserInfo      : 주민등록번호
	'	TranSele      : 0: 개인, 1: 사업자
	'	CallCode      : 통화코드  (0: 원화, 1: 미화)
	'	SupplyAmt     : 공급가액
	'	TaxAmt        : 세금
	'	SvcAmt        : 봉사료
	'	TotAmt        : 현금영수증 발급금액
	'	Filler 	      : 예비

		ApprovalType	= SetData(ApprovalType           ,      4, "X")
		TransactionNo	= SetData(TransactionNo          ,     12, "X")
		IssuSele	= SetData(IssuSele               ,      1, "X")
		UserInfoSele	= SetData(UserInfoSele           ,      1, "X")
		UserInfo	= SetData(UserInfo               ,     37, "X")
		TranSele	= SetData(TranSele               ,      1, "X")
		CallCode	= SetData(CallCode               ,      1, "X")
		SupplyAmt	= SetData(SupplyAmt              ,      9, "9")
		TaxAmt		= SetData(TaxAmt                 ,      9, "9")
		SvcAmt		= SetData(SvcAmt                 ,      9, "9")
		TotAmt		= SetData(TotAmt                 ,      9, "9")
		Filler		= SetData(Filler                 ,    147, "X")

		TmpSendMsg	= 	ApprovalType	& _
						TransactionNo		& _
						IssuSele		& _
						UserInfoSele		& _
						UserInfo		& _
						TranSele		& _
						CallCode		& _
						SupplyAmt		& _
						TaxAmt			& _
						SvcAmt			& _
						TotAmt			& _
						Filler

		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(TmpSendMsg)
		SendCount = SendCount + 1  

		CashBillDataMessage = true
		
	end function

	' 신용카드 취소 
	function CancelDataMessage(ApprovalType,CancelType,TransactionNo,TradeDate,OrderNumber,Filler)
 	' ApprovalType,	: 승인구분
	' CancelType,	: 취소처리구분 0:거래번호, 1:주문번호
	' TransactionNo,: 거래번호
	' TradeDate,	: 거래일자
	' OrderNumber,	: 주문번호
	' Filler)	: 기타
	
		ApprovalType   = SetData(ApprovalType,   4, "X")
		CancelType     = SetData(CancelType,     1, "X")
		TransactionNo  = SetData(TransactionNo, 12, "9")
		TradeDate      = SetData(TradeDate,	 8, "X")
		OrderNumber    = SetData(OrderNumber,   50, "X")
		Filler         = SetData(Filler,        75, "X")

		TmpSendMsg =	ApprovalType  & _
						CancelType    & _
						TransactionNo & _
						TradeDate     & _
						OrderNumber   & _
						Filler

		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(TmpSendMsg)
		SendCount = SendCount + 1  
		CancelDataMessage = true
	end function

	' 카드BIN 체크 
	function CardBinViewDataMessage(ApprovalType, TrackII, Filler)             
         ' 승인구분
         ' 카드번호
         ' 기타    
		ApprovalType	= SetData(ApprovalType,      4, "X")
		TrackII		= SetData(TrackII,          40, "X")
		Filler		= SetData(Filler,           56, "X")

		TmpSendMsg	= ApprovalType  & _
						TrackII       & _
						Filler

		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(TmpSendMsg)
		SendCount = SendCount + 1  
		CardBinViewDataMessage = true
	end function

	' 휴대폰 인증 1차, 2차 - 추후 추가 
	
	'상점상세정보 조회  - XMPI 관련 추가 
	function ShopInfoDetailDataMessage(ApprovalType, ShopId, BusiSele, CardCode, Filler)
	' 승인구분
	' 상점아이디
	' 업무구분
	' 카드코드
	' 기타 

		ApprovalType	= SetData(ApprovalType,     4, "X") 
		ShopId		= SetData(ShopId,          10, "X") 
	        BusiSele	= SetData(BusiSele,         1, "X") 
		CardCode	= SetData(CardCode,         6, "X") 
	        Filler	  	= SetData(Filler,          79, "X") 

		TmpSendMsg	= ApprovalType  & _
						ShopId       & _
						BusiSele     & _
						CardCode     & _
						Filler

		SendMsg = SendMsg & TmpSendMsg      
		'response.write SetLogMsg(TmpSendMsg)
		SendCount = SendCount + 1  
		ShopInfoDetailDataMessage = true
	end function

	function SendSocket(Flag)
		pDataLen = SetData((GetLength(HeadMsg & SendMsg)), 4, "9")
		'response.write "SendMessage=["&SetLogMsg((pDataLen & HeadMsg & SendMsg))&"]<br>"
		SendSocket = ProcessRequest(PGIPAddr, PGPort, Flag, (HeadMsg & SendMsg))
	end function

	function ProcessRequest(addr, port, ServiceType, SendMsg)
		ret = false

		' 컴포넌트 초기화 세팅 - 로그경로 및 타임아웃값 설정
		set objCom = nothing
		dim ErrorMsg
		

		set objCom = Server.CreateObject("KSNET_ATX0312.ComATX.1")
		objCom.KSNET_MsgSndRcv PGIPAddr, PGPort, "C:\ksnet\Socket\log\", SendMsg, 4, 10, ReceiveMsg, ErrorMsg	
		set objCom = nothing

		'response.write "ErrorMessage=["&SetLogMsg(ErrorMsg)&"]<br>"
		
		ret = ReceiveMessage()

		if ret = true then 
		end if
		
		ProcessRequest = ret
	end function
	
	function ReceiveMessage()
		TmpReceiveMsg = ""
		ipos = 0
	
		'response.write "ReceiveMsg=["&SetLogMsg(ReceiveMsg)&"]<br>"
	
		if ReceiveMsg = "" then
			ReceiveMessage = false
		else
			EncType       = SetParse(ReceiveMsg, 1,     1, ipos)   ' 0: 암화안함, 1:openssl, 2: seed
			Version       = SetParse(ReceiveMsg, ipos,  4, ipos)   ' 전문버전
			VersionType   = SetParse(ReceiveMsg, ipos,  2, ipos)   ' 구분
			Resend        = SetParse(ReceiveMsg, ipos,  1, ipos)   ' 전송구분 : 0 : 처음,  2: 재전송
			RequestDate   = SetParse(ReceiveMsg, ipos, 14, ipos)   ' 요청일자 : yyyymmddhhmmss
			StoreId       = SetParse(ReceiveMsg, ipos, 10, ipos)   ' 상점아이디
			OrderNumber   = SetParse(ReceiveMsg, ipos, 50, ipos)   ' 주문번호
			UserName      = SetParse(ReceiveMsg, ipos, 50, ipos)   ' 주문자명
			IdNum         = SetParse(ReceiveMsg, ipos, 13, ipos)   ' 주민번호 or 사업자번호
			Email         = SetParse(ReceiveMsg, ipos, 50, ipos)   ' email
			GoodType      = SetParse(ReceiveMsg, ipos,  1, ipos)   ' 제품구분 0 : 실물, 1 : 디지털
			GoodName      = SetParse(ReceiveMsg, ipos, 50, ipos)   ' 제품명
			KeyInType     = SetParse(ReceiveMsg, ipos,  1, ipos)   ' KeyInType 여부 : 1 : Swap, 2: KeyIn
			LineType      = SetParse(ReceiveMsg, ipos,  1, ipos)   ' lineType 0 : offline, 1:internet, 2:Mobile
			PhoneNo       = SetParse(ReceiveMsg, ipos, 12, ipos)   ' 휴대폰번호
			ApprovalCount = SetParse(ReceiveMsg, ipos,  1, ipos)   ' 승인갯수
			HaedFiller    = SetParse(ReceiveMsg, ipos, 35, ipos)   ' 예비
	
			TmpReceiveMsg = RecvLen       & _
							EncType       & _
							Version       & _
							VersionType   & _
							Resend        & _
							RequestDate   & _
							StoreId       & _
							OrderNumber   & _
							UserName      & _
							IdNum         & _
							Email         & _
							GoodType      & _
							GoodName      & _
							KeyInType     & _
							LineType      & _
							PhoneNo       & _
							ApprovalCount & _
							HaedFiller
	
			'response.write ("Header ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
			''Response.Write(VarType(ApprovalCount))
			Response.Write("ApprovalCount: " & ApprovalCount)
			if isnull(ApprovalCount) = false and trim(ApprovalCount) <> "" Then 
				ReceiveCount = CInt(ApprovalCount)
			End If
			ReceiveMessage = ReceiveDataMessage(ReceiveCount, ipos)
		end if

	end function

	function ReceiveDataMessage(iCnt, ipos)
		iCreidtCnt = 0
		iVirAcctCnt = 0
		iPhoneCnt = 0
		
		for i = 1 to iCnt
			ApprovalType         = SetParse(ReceiveMsg, ipos,  4, ipos)	// 승인구분	
			'response.write ("iCnt=["+SetLogMsg(ApprovalType)+"]<br>")
			'신용카드	
			if mid(ApprovalType,1,1) = "1" or mid(ApprovalType,1,1) = "I" then
				if mid(ApprovalType,2,1) = "5" then
					TransactionNo    = SetParse(ReceiveMsg, ipos, 12, ipos)	// 거래번호
					Status           = SetParse(ReceiveMsg, ipos,  1, ipos)	// 상태 O : 승인, X : 거절
					TradeDate        = SetParse(ReceiveMsg, ipos,  8, ipos)	// 거래일자
					TradeTime        = SetParse(ReceiveMsg, ipos,  6, ipos)	// 거래시간
					IssCode          = SetParse(ReceiveMsg, ipos,  6, ipos)	// 발급사코드
					Message1         = SetParse(ReceiveMsg, ipos, 16, ipos)	// 메시지1
					Message2         = SetParse(ReceiveMsg, ipos, 16, ipos)	// 메시지2

					TmpReceiveMsg = ApprovalType     & _
									TransactionNo    & _
									Status           & _
									TradeDate        & _
									TradeTime        & _
									IssCode          & _
									Message1         & _
									Message2         
					'response.write ("Credit Bin View ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
				else 				
					TransactionNo    = SetParse(ReceiveMsg, ipos, 12, ipos)	// 거래번호
					Status           = SetParse(ReceiveMsg, ipos,  1, ipos)	// 상태 O : 승인, X : 거절
					TradeDate        = SetParse(ReceiveMsg, ipos,  8, ipos)	// 거래일자
					TradeTime        = SetParse(ReceiveMsg, ipos,  6, ipos)	// 거래시간
					IssCode          = SetParse(ReceiveMsg, ipos,  6, ipos)	// 발급사코드
					AquCode		 = SetParse(ReceiveMsg, ipos,  6, ipos)	// 매입사코드
					AuthNo           = SetParse(ReceiveMsg, ipos, 12, ipos)	// 승인번호 or 거절시 오류코드
					Message1         = SetParse(ReceiveMsg, ipos, 16, ipos)	// 메시지1
					Message2         = SetParse(ReceiveMsg, ipos, 16, ipos)	// 메시지2
					CardNo           = SetParse(ReceiveMsg, ipos, 16, ipos)	// 카드번호
					ExpDate          = SetParse(ReceiveMsg, ipos,  4, ipos)	// 유효기간
					Installment      = SetParse(ReceiveMsg, ipos,  2, ipos)	// 할부
					Amount           = SetParse(ReceiveMsg, ipos,  9, ipos)	// 금액
					MerchantNo       = SetParse(ReceiveMsg, ipos, 15, ipos)	// 가맹점번호
					AuthSendType     = SetParse(ReceiveMsg, ipos,  1, ipos)	// 전송구분= new String(read(2));
					ApprovalSendType = SetParse(ReceiveMsg, ipos,  1, ipos)	// 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
					Point1           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point1
					Point2           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point2
					Point3           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point3
					Point4           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point4
					VanTransactionNo = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point4
					Filler           = SetParse(ReceiveMsg, ipos, 82, ipos)	// 예비
					AuthType	 = SetParse(ReceiveMsg, ipos,  1, ipos)	// I : ISP거래, M : MPI거래, SPACE : 일반거래
					MPIPositionType	 = SetParse(ReceiveMsg, ipos,  1, ipos)	// K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
					MPIReUseType	 = SetParse(ReceiveMsg, ipos,  1, ipos)	// Y : 재사용, N : 재사용아님
					EncLen		 = SetParse(ReceiveMsg, ipos,  5, ipos)
					if  EncLen	 = "" then
						EncData      = ""
					else 
						Response.Write(EncLen)
						EncData      = SetParse(ReceiveMsg, ipos,  CInt(EncLen), ipos)	// MPI, ISP 데이터
					end if
				
					TmpReceiveMsg	 = ApprovalType     & _
									TransactionNo    & _
									Status           & _
									TradeDate        & _
									TradeTime        & _
									IssCode          & _
									AquCode		 & _ 
									AuthNo           & _
									Message1         & _
									Message2         & _
									CardNo           & _
									ExpDate          & _
									Installment      & _
									Amount           & _
									MerchantNo       & _
									AuthSendType     & _
									ApprovalSendType & _
									Point1           & _
									Point2           & _
									Point3           & _
									Point4           & _
									VanTransactionNo & _
									Filler           & _
									AuthType	 & _
									MPIPositionType  & _
									MPIReUseType     & _
									EncData
					'response.write ("Credit ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
				end	if
			' 포인트카드
			elseif mid(ApprovalType,1,1) = "4" then
				PTransactionNo = SetParse(ReceiveMsg, ipos, 12, ipos)	' 거래번호                   
				PStatus        = SetParse(ReceiveMsg, ipos,  1, ipos)	' 상태 O : 승인 , X : 거절   
				PTradeDate     = SetParse(ReceiveMsg, ipos,  8, ipos)	' 거래일자                   
				PTradeTime     = SetParse(ReceiveMsg, ipos,  6, ipos)	' 거래시간                   
				PIssCode       = SetParse(ReceiveMsg, ipos,  6, ipos)	' 발급사코드                 
				PAuthNo        = SetParse(ReceiveMsg, ipos, 12, ipos)	' 승인번호 or 거절시 오류코드
				PMessage1      = SetParse(ReceiveMsg, ipos, 16, ipos)	' 메시지1                    
				PMessage2      = SetParse(ReceiveMsg, ipos, 16, ipos)	' 메시지2                    
				PPoint1	       = SetParse(ReceiveMsg, ipos,  9, ipos)	' 거래포인트                 
				PPoint2        = SetParse(ReceiveMsg, ipos,  9, ipos)	' 가용포인트                 
				PPoint3        = SetParse(ReceiveMsg, ipos,  9, ipos)	' 누적포인트                 
				PPoint4        = SetParse(ReceiveMsg, ipos,  9, ipos)	' 가맹점포인트               
				PMerchantNo    = SetParse(ReceiveMsg, ipos, 15, ipos)	' 가맹점번호                 
				PNotice1       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PNotice2       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PNotice3       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PNotice4       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PFiller        = SetParse(ReceiveMsg, ipos,  8, ipos)	' 예비                       

				TmpReceiveMsg =	ApprovalType   & _ 
								PTransactionNo & _ 
								PStatus        & _ 
								PTradeDate     & _ 
								PTradeTime     & _ 
								PIssCode       & _ 
								PAuthNo        & _ 
								PMessage1      & _ 
								PMessage2      & _ 
								PPoint1	       & _ 
								PPoint2        & _ 
								PPoint3        & _ 
								PPoint4        & _ 
								PMerchantNo    & _ 
								PNotice1       & _ 
								PNotice2       & _ 
								PNotice3       & _ 
								PNotice4       & _ 
								PFiller 

				'response.write ("Point ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
			' 가상계좌
			elseif mid(ApprovalType,1,1) = "6" then
				VATransactionNo	= SetParse(ReceiveMsg, ipos, 12, ipos)
				VAStatus	= SetParse(ReceiveMsg, ipos,  1, ipos)
				VATradeDate	= SetParse(ReceiveMsg, ipos,  8, ipos)
				VATradeTime	= SetParse(ReceiveMsg, ipos,  6, ipos)
				VABankCode	= SetParse(ReceiveMsg, ipos,  6, ipos)
				VAVirAcctNo	= SetParse(ReceiveMsg, ipos, 15, ipos)
				VAName		= SetParse(ReceiveMsg, ipos, 30, ipos)
				VACloseDate	= SetParse(ReceiveMsg, ipos, 8, ipos)
				VACloseTime	= SetParse(ReceiveMsg, ipos, 6, ipos)
				VARespCode	= SetParse(ReceiveMsg, ipos, 4, ipos)
				VAMessage1	= SetParse(ReceiveMsg, ipos, 16, ipos)
				VAMessage2	= SetParse(ReceiveMsg, ipos, 16, ipos)
				VAFiller	= SetParse(ReceiveMsg, ipos, 36, ipos)

				TmpReceiveMsg = ApprovalType    & _
								VATransactionNo		& _
								VAStatus	 	& _
								VATradeDate		& _
								VATradeTime		& _
								VABankCode	 	& _
								VAVirAcctNo		& _ 
								VAName		 	& _
								VACloseDate		& _
								VACloseTime		& _
								VARespCode		& _
								VAMessage1	 	& _
								VAMessage2	 	& _
								VAFiller

				'response.write ("Virtual ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
			' 월드패스
			elseif mid(ApprovalType,1,1) = "7" then
				WPTransactionNo = SetParse(ReceiveMsg, ipos, 12, ipos)
				WPStatus	= SetParse(ReceiveMsg, ipos,  1, ipos)
				WPTradeDate	= SetParse(ReceiveMsg, ipos,  8, ipos)
				WPTradeTime	= SetParse(ReceiveMsg, ipos,  6, ipos)
				WPIssCode	= SetParse(ReceiveMsg, ipos,  6, ipos)
				WPAuthNo	= SetParse(ReceiveMsg, ipos, 12, ipos)
				WPBalanceAmount	= SetParse(ReceiveMsg, ipos,  9, ipos)
				WPLimitAmount	= SetParse(ReceiveMsg, ipos,  9, ipos)
				WPMessage1	= SetParse(ReceiveMsg, ipos, 16, ipos)
				WPMessage2	= SetParse(ReceiveMsg, ipos, 16, ipos)
				WPCardNo	= SetParse(ReceiveMsg, ipos, 16, ipos)
				WPAmount	= SetParse(ReceiveMsg, ipos,  9, ipos)
				WPMerchantNo	= SetParse(ReceiveMsg, ipos, 15, ipos)
				WPFiller	= SetParse(ReceiveMsg, ipos, 11, ipos)

				TmpReceiveMsg = ApprovalType    & _
								WPTransactionNo & _
								WPStatus        & _
								WPTradeDate     & _
								WPTradeTime     & _
								WPIssCode       & _
								WPAuthNo        & _
								WPBalanceAmount & _
								WPLimitAmount   & _
								WPMessage1      & _
								WPMessage2      & _
								WPCardNo        & _
								WPAmount        & _
								WPMerchantNo    & _
								WPFiller

				'response.write ("WorldPass ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
			' 현금영수증
			elseif mid(ApprovalType,1,1) = "H" then
				HTransactionNo    = SetParse(ReceiveMsg, ipos,  12, ipos)
				HStatus           = SetParse(ReceiveMsg, ipos,   1, ipos)
				HCashTransactionNo= SetParse(ReceiveMsg, ipos,  12, ipos)
				HIncomeType       = SetParse(ReceiveMsg, ipos,   1, ipos)
				HTradeDate        = SetParse(ReceiveMsg, ipos,   8, ipos)
				HTradeTime        = SetParse(ReceiveMsg, ipos,   6, ipos)
				HMessage1         = SetParse(ReceiveMsg, ipos,  16, ipos)
				HMessage2         = SetParse(ReceiveMsg, ipos,  16, ipos)
				HCashMessage1     = SetParse(ReceiveMsg, ipos,  20, ipos)
				HCashMessage2     = SetParse(ReceiveMsg, ipos,  20, ipos)
				HFiller           = SetParse(ReceiveMsg, ipos, 150, ipos)

				TmpReceiveMsg = ApprovalType    	& _
								HTransactionNo    	& _
								HStatus           	& _
								HCashTransactionNo	& _
								HIncomeType		& _
								HTradeDate         	& _
								HTradeTime		& _ 
								HMessage1          	& _
								HMessage2          	& _
								HCashMessage1      	& _
								HCashMessage2      	& _
								HFiller            	
				'response.write ("CashBill ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
			' 상점세정보 조회결과
			elseif mid(ApprovalType,1,2) = "A7" then
				 SITransactionNo	= SetParse(ReceiveMsg, ipos,  12, ipos)  
				 SIStatus          	= SetParse(ReceiveMsg, ipos,   1, ipos)  
				 SIRespCode        	= SetParse(ReceiveMsg, ipos,   4, ipos)  
				 SIAgenMembDealSele	= SetParse(ReceiveMsg, ipos,   1, ipos)  
				 SIStartSele       	= SetParse(ReceiveMsg, ipos,   1, ipos)  
				 SIEntrNumb        	= SetParse(ReceiveMsg, ipos,  10, ipos)  
				 SIShopName        	= SetParse(ReceiveMsg, ipos,  30, ipos)  
				 SIMembNumbGene    	= SetParse(ReceiveMsg, ipos,  15, ipos)  
				 SIMembNumbNoin    	= SetParse(ReceiveMsg, ipos,  15, ipos)  
				 SIAlloMontType    	= SetParse(ReceiveMsg, ipos, 200, ipos)  
				 SIFiller          	= SetParse(ReceiveMsg, ipos, 207, ipos)  

				TmpReceiveMsg = ApprovalType    	& _
						SITransactionNo		& _
						SIStatus		& _
						SIRespCode		& _
						SIAgenMembDealSele	& _
						SIStartSele		& _
						SIEntrNumb		& _
						SIShopName		& _
						SIMembNumbGene		& _
						SIMembNumbNoin		& _	
						SIAlloMontType		& _
						SIFiller          
				'response.write ("ShopInfoDetail ReceiveMsg=["+SetLogMsg(TmpReceiveMsg)+"]<br>")
			end if
		next
		
		ReceiveDataMessage = true
	end function
%>
