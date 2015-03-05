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

	' KSNET ���� Haeder(�������� ��)
	dim EncType 			' 0: ��ȭ����, 1:openssl, 2: seed
	dim Version 			' ��������
	dim VersionType 		' ����
	dim Resend 			' ���۱��� : 0 : ó��,  2: ������
	dim RequestDate 		' ��û���� : yyyymmddhhmmss
	dim StoreId 			' �������̵�
	dim OrderNumber 		' �ֹ���ȣ
	dim UserName 			' �ֹ��ڸ�
	dim IdNum 			' �ֹι�ȣ or ����ڹ�ȣ
	dim Email 			' email
	dim GoodType 			' ��ǰ���� 1 : �ǹ�, 2 : ������
	dim GoodName 			' ��ǰ��
	dim KeyInType 			' KeyInType ���� : S : Swap, K: KeyInType
	dim LineType 			' lineType 0 : offline, 1:internet, 2:Mobile
	dim PhoneNo 			' �޴�����ȣ
	dim ApprovalCount		' ���հ����Ǽ�
	
	dim HaedFiller			' ����

 	' �ſ�ī����ΰ�� 
	dim ApprovalType			' ���α���
	dim TransactionNo			' �ŷ���ȣ
	dim Status				' ���� O : ���� , X : ����
	dim TradeDate				' �ŷ�����
	dim TradeTime				' �ŷ��ð�
	dim IssCode				' �߱޻��ڵ�
	dim AquCode				' ���Ի��ڵ�
	dim AuthNo				' ���ι�ȣ or ������ �����ڵ�
	dim Message1				' �޽���1
	dim Message2				' �޽���2
	dim CardNo				' ī���ȣ
	dim ExpDate				' ��ȿ�Ⱓ
	dim Installment				' �Һ�
	dim Amount				' �ݾ�
	dim MerchantNo				' ��������ȣ
	dim AuthSendType			' ���۱���
	dim ApprovalSendType			' ���۱���(0 : ����, 1 : ����, 2: ��ī��)
	dim Point1				'
	dim Point2				'
	dim Point3				'
	dim Point4				'
	dim VanTransactionNo			' Van �ŷ���ȣ
	dim Filler				' ����
	dim AuthType				' ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
	dim MPIPositionType			' K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
	dim MPIReUseType			' Y : ����, N : ����ƴ�
	dim EncData				' MPI, ISP ������
					
	' ������½��ΰ�� 
	dim VATransactionNo			'�ŷ���ȣ	           
	dim VAStatus				' ���� O : ���� , X : ���� 
	dim VATradeDate				' �ŷ�����                 
	dim VATradeTime				' �ŷ��ð�                 
	dim VABankCode				' �����ڵ�
	dim VAVirAcctNo				' ������¹�ȣ
	dim VAName				' ������
	dim VACloseDate				' ��������
	dim VACloseTime				' �����ð�
	dim VARespCode				' �����ڵ�
	dim VAMessage1				' �޼���1
	dim VAMessage2				' �޼���2
	dim VAFiller				' ����

	' �����н����ΰ��
	dim WPTransactionNo			'�ŷ���ȣ	
	dim WPStatus				' ���� O : ���� , X : ����
	dim WPTradeDate	 			' �ŷ�����      
	dim WPTradeTime	 	        	' �ŷ��ð�      
	dim WPIssCode				'�߱޻��ڵ�
	dim WPAuthNo				'���ι�ȣ
	dim WPBalanceAmount			'�ܾ�
	dim WPLimitAmount			'�ѵ���
	dim WPMessage1				'�޽���1
	dim WPMessage2				'�޽���2
	dim WPCardNo				'ī���ȣ
	dim WPAmount				'�ݾ�
	dim WPMerchantNo			'��������ȣ
	dim WPFiller		

 	' ����Ʈī����ΰ��
	dim PTransactionNo			' �ŷ���ȣ
	dim PStatus       			' ���� O : ���� , X : ����
	dim PTradeDate    			' �ŷ�����
	dim PTradeTime    			' �ŷ��ð�
	dim PIssCode      			' �߱޻��ڵ�
	dim PAuthNo       			' ���ι�ȣ or ������ �����ڵ�
	dim PMessage1     			' �޽���1
	dim PMessage2     			' �޽���2
	dim PPoint1	      			' �ŷ�����Ʈ
	dim PPoint2       			' ��������Ʈ
	dim PPoint3       			' ��������Ʈ
	dim PPoint4       			' ����������Ʈ
	dim PMerchantNo   			' ��������ȣ
	dim PNotice1      			' 
	dim PNotice2      			' 
	dim PNotice3      			' 
	dim PNotice4      			' 
	dim PFiller       			' ����

	' ���ݿ��������ΰ��
	dim HTransactionNo			' �ŷ���ȣ  				   
	dim HStatus				' �������� O:���� X:����     
	dim HCashTransactionNo			' ���ݿ����� �ŷ���ȣ		   
	dim HIncomeType				' 0: �ҵ�      1: ��ҵ�   
	dim HTradeDate				' �ŷ� ���� ����             
	dim HTradeTime				' �ŷ� ���� �ð�             
	dim HMessage1				' ���� message1            
	dim HMessage2				' ���� message2            
	dim HCashMessage1			' ����û �޽��� 1          
	dim HCashMessage2			' ����û �޽��� 2          
	dim HFiller				' ����                       


	' ī�� bin üũ ��� - ���� �߰� 

	' �޴��� ���� 1�� 2�� ��� - ���� �߰� 

	' �������� ��ȸ - XMPI ���� ��� ���� �߰�  
	dim SITransactionNo			' �ŷ���ȣ                                                            
	dim SIStatus          			' ����:O, ����: X                                                     
	dim SIRespCode        			' '0000' : ����ó��, '0001' : �̵�ϻ���, '0009' : Timeout �� ��Ÿ����
	dim SIAgenMembDealSele			' ��ü���౸�� - '1' : ��ü, '2' : ����                               
	dim SIStartSele       			' ���ÿ���                                                            
	dim SIEntrNumb        			' ����ڹ�ȣ                                                          
	dim SIShopName        			' ������                                                              
	dim SIMembNumbGene    			' �Ϲ� ��������ȣ                                                     
	dim SIMembNumbNoin    			' ������ ��������ȣ                                                   
	dim SIAlloMontType    			' �Һ�����                                                            
	dim SIFiller          			' ����             
%>
<%
	function GetLength(sdata)
		dim i, j
		dim istrlen
		dim sresult
		
		sresult = ""
		j = 0
		
		for i = 1 To Len(sdata) '�ѱ۰������ϱ�
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
		
		for i = 1 To Len(sdata) '�ѱ۰������ϱ�
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
	' EncType		: 0: ��ȭ����, 1:openssl, 2: seed           
	' Version		: ��������                                  
	' VersionType		: ����                                      
	' Resend		: ���۱��� : 0 : ó��,  2: ������           
	' RequestDate		: ��û���� : yyyymmddhhmmss                 
	' StoreId		: �������̵�                                
	' OrderNumber		: �ֹ���ȣ                                  
	' UserName		: �ֹ��ڸ�                                  
	' IdNum			: �ֹι�ȣ or ����ڹ�ȣ                    
	' Email			: email                                     
	' GoodType		: ��ǰ���� 0 : �ǹ�, 1 : ������             
	' GoodName		: ��ǰ��                                    
	' KeyInType		: KeyInType ���� : S : Swap, K: KeyInType   
	' LineType		: lineType 0 : offline, 1:internet, 2:Mobile
	' PhoneNo		: �޴�����ȣ                                
	' ApprovalCount		: ���ս��ΰ���                              
	' Filler 		: ����                                      

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
	
	// �ſ�ī����ο�û Body 1
	function CreditDataMessage(ApprovalType,InterestType,TrackII,Installment,Amount,Passwd,IdNum,CurrencyType,BatchUseType,CardSendType,VisaAuthYn,Domain,IpAddr,BusinessNumber,Filler, AuthType,MPIPositionType,MPIReUseType,EncData)
	' ApprovalType			: ���α���                                                                                                                
	' InterestType     		: �Ϲ�/�����ڱ��� 1:�Ϲ� 2:������                                                                                         
	' TrackII			: ī���ȣ=��ȿ�Ⱓ  or �ŷ���ȣ                                                                                          
	' Installment			: �Һ�  00�Ͻú�                                                                                                          
	' Amount			: �ݾ�                                                                                                                    
	' Passwd			: ��й�ȣ ��2�ڸ�                                                                                                        
	' IdNum				: �ֹι�ȣ  ��7�ڸ�, ����ڹ�ȣ10                                                                                         
	' CurrencyType			: ��ȭ���� 0:��ȭ 1: ��ȭ                                                                                                 
	' BatchUseType			: �ŷ���ȣ��ġ��뱸��  0:�̻�� 1:���                                                                                   
	' CardSendType			: ī���������� 0:������ 1:ī���ȣ,��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ 2:ī���ȣ��14�ڸ� + "XXXX",��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ
	' VisaAuthYn			: ������������ 0:������,7:SSL,9:��������                                                                                
	' Domain			: ������ ��ü������(PG��ü��)                                                                                             
	' IpAddr			: IP ADDRESS ��ü������(PG��ü��)                                                                                         
	' BusinessNumber		: ����� ��ȣ ��ü������(PG��ü��)                                                                                        
	' Filler			: ����                                                                                                                    
	' AuthType			: ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�                                                                     
	' MPIPositionType		: K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�                                                                    
	' MPIReUseType   		: Y :  ����, N : ����ƴ�                                                                                             
	' EndData			: MPI, ISP ������                                                                                                         
	' CardCode			: KVP ��Ÿ� �ʿ��� ���� KSNET���� ��Ž� �ʿ����

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

	// �������
	function VirtualAccountDataMessage(ApprovalType,BankCode,Amount,CloseDate,CloseTime,EscrowSele,VirFixSele,VirAcctNo,OrgTransactionNo,Filler)
	' ApprovalType     : ���α���
	' BankCode         : �����ڵ�
	' Amount           : �ݾ�		 
	' CloseDate        : ������
	' CloseTime        : �����ð�
	' EscrowSele       : ����ũ�����뱸��: 0:�������, 1:����, 2:��������
	' VirFixSele       : ������¹�ȣ��������
	' VirAcctNo        : ������¹�ȣ
	' OrgTransactionNo : ���ŷ��ŷ���ȣ
	' Filler           : ����	 	 

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

	//�����н�ī�� ����
	function WorldPassDataMessage(ApprovalType,TrackII,Passwd,Amount,WorldPassType,AdultType,CardSendType,Filler)	
	' ApprovalType,		: ���α���                                                                                                                  
	' TrackII,		: ī���ȣ  or �ŷ���ȣ                                                                                                 
	' Passwd,		: ��й�ȣ ��2�ڸ�                                                                                                      
	' Amount,		: �ݾ�                                                                                                                  
	' WorldPassType,	: ���ĺ�ī�屸��                                                                                                        
	' AdultType,		: ����Ȯ�α���                                                                                                          
	' CardSendType,		: ī���������� 0:������ 1:ī���ȣ,��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ 2:ī���ȣ��14�ڸ� + "XXXX",��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ  
	' Filler)		: ��Ÿ                                                                                                                  

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

	' ����Ʈī�����
	function PointDataMessage(ApprovalType,TrackII,Amount,Passwd,SaleType,Filler)		
	' ApprovalType,		: ���α���                       
	' TrackII,		: ī���ȣ=��ȿ�Ⱓ  or �ŷ���ȣ 
	' Amount,		: �ݾ�                           
	' Passwd,		: ��й�ȣ ��4�ڸ�               
	' SaleType,		: �Ǹű���                       
	' Filler)		: ��Ÿ                           

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

	' ���ݿ���������
	function CashBillDataMessage(ApprovalType,TransactionNo,IssuSele,UserInfoSele,UserInfo,TranSele,CallCode,SupplyAmt,TaxAmt,SvcAmt,TotAmt,Filler)
	'	ApprovalType  : H000:�Ϲݹ߱�, H200:������ü, H600:�������
	'	TransactionNo : �ԱݿϷ�� ������ü, ������� �ŷ���ȣ
	'	IssuSele      : 0:�Ϲݹ߱�(PG���ŷ���ȣ �ߺ�üũ), 1:�ܵ��߱�(�ֹ���ȣ �ߺ�üũ : PG���ŷ� ����), 2:�����߱�(�ߺ�üũ ����)
	'	UserInfoSele  : 0:�ֹε�Ϲ�ȣ
	'	UserInfo      : �ֹε�Ϲ�ȣ
	'	TranSele      : 0: ����, 1: �����
	'	CallCode      : ��ȭ�ڵ�  (0: ��ȭ, 1: ��ȭ)
	'	SupplyAmt     : ���ް���
	'	TaxAmt        : ����
	'	SvcAmt        : �����
	'	TotAmt        : ���ݿ����� �߱ޱݾ�
	'	Filler 	      : ����

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

	' �ſ�ī�� ��� 
	function CancelDataMessage(ApprovalType,CancelType,TransactionNo,TradeDate,OrderNumber,Filler)
 	' ApprovalType,	: ���α���
	' CancelType,	: ���ó������ 0:�ŷ���ȣ, 1:�ֹ���ȣ
	' TransactionNo,: �ŷ���ȣ
	' TradeDate,	: �ŷ�����
	' OrderNumber,	: �ֹ���ȣ
	' Filler)	: ��Ÿ
	
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

	' ī��BIN üũ 
	function CardBinViewDataMessage(ApprovalType, TrackII, Filler)             
         ' ���α���
         ' ī���ȣ
         ' ��Ÿ    
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

	' �޴��� ���� 1��, 2�� - ���� �߰� 
	
	'���������� ��ȸ  - XMPI ���� �߰� 
	function ShopInfoDetailDataMessage(ApprovalType, ShopId, BusiSele, CardCode, Filler)
	' ���α���
	' �������̵�
	' ��������
	' ī���ڵ�
	' ��Ÿ 

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

		' ������Ʈ �ʱ�ȭ ���� - �αװ�� �� Ÿ�Ӿƿ��� ����
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
			EncType       = SetParse(ReceiveMsg, 1,     1, ipos)   ' 0: ��ȭ����, 1:openssl, 2: seed
			Version       = SetParse(ReceiveMsg, ipos,  4, ipos)   ' ��������
			VersionType   = SetParse(ReceiveMsg, ipos,  2, ipos)   ' ����
			Resend        = SetParse(ReceiveMsg, ipos,  1, ipos)   ' ���۱��� : 0 : ó��,  2: ������
			RequestDate   = SetParse(ReceiveMsg, ipos, 14, ipos)   ' ��û���� : yyyymmddhhmmss
			StoreId       = SetParse(ReceiveMsg, ipos, 10, ipos)   ' �������̵�
			OrderNumber   = SetParse(ReceiveMsg, ipos, 50, ipos)   ' �ֹ���ȣ
			UserName      = SetParse(ReceiveMsg, ipos, 50, ipos)   ' �ֹ��ڸ�
			IdNum         = SetParse(ReceiveMsg, ipos, 13, ipos)   ' �ֹι�ȣ or ����ڹ�ȣ
			Email         = SetParse(ReceiveMsg, ipos, 50, ipos)   ' email
			GoodType      = SetParse(ReceiveMsg, ipos,  1, ipos)   ' ��ǰ���� 0 : �ǹ�, 1 : ������
			GoodName      = SetParse(ReceiveMsg, ipos, 50, ipos)   ' ��ǰ��
			KeyInType     = SetParse(ReceiveMsg, ipos,  1, ipos)   ' KeyInType ���� : 1 : Swap, 2: KeyIn
			LineType      = SetParse(ReceiveMsg, ipos,  1, ipos)   ' lineType 0 : offline, 1:internet, 2:Mobile
			PhoneNo       = SetParse(ReceiveMsg, ipos, 12, ipos)   ' �޴�����ȣ
			ApprovalCount = SetParse(ReceiveMsg, ipos,  1, ipos)   ' ���ΰ���
			HaedFiller    = SetParse(ReceiveMsg, ipos, 35, ipos)   ' ����
	
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
			ApprovalType         = SetParse(ReceiveMsg, ipos,  4, ipos)	// ���α���	
			'response.write ("iCnt=["+SetLogMsg(ApprovalType)+"]<br>")
			'�ſ�ī��	
			if mid(ApprovalType,1,1) = "1" or mid(ApprovalType,1,1) = "I" then
				if mid(ApprovalType,2,1) = "5" then
					TransactionNo    = SetParse(ReceiveMsg, ipos, 12, ipos)	// �ŷ���ȣ
					Status           = SetParse(ReceiveMsg, ipos,  1, ipos)	// ���� O : ����, X : ����
					TradeDate        = SetParse(ReceiveMsg, ipos,  8, ipos)	// �ŷ�����
					TradeTime        = SetParse(ReceiveMsg, ipos,  6, ipos)	// �ŷ��ð�
					IssCode          = SetParse(ReceiveMsg, ipos,  6, ipos)	// �߱޻��ڵ�
					Message1         = SetParse(ReceiveMsg, ipos, 16, ipos)	// �޽���1
					Message2         = SetParse(ReceiveMsg, ipos, 16, ipos)	// �޽���2

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
					TransactionNo    = SetParse(ReceiveMsg, ipos, 12, ipos)	// �ŷ���ȣ
					Status           = SetParse(ReceiveMsg, ipos,  1, ipos)	// ���� O : ����, X : ����
					TradeDate        = SetParse(ReceiveMsg, ipos,  8, ipos)	// �ŷ�����
					TradeTime        = SetParse(ReceiveMsg, ipos,  6, ipos)	// �ŷ��ð�
					IssCode          = SetParse(ReceiveMsg, ipos,  6, ipos)	// �߱޻��ڵ�
					AquCode		 = SetParse(ReceiveMsg, ipos,  6, ipos)	// ���Ի��ڵ�
					AuthNo           = SetParse(ReceiveMsg, ipos, 12, ipos)	// ���ι�ȣ or ������ �����ڵ�
					Message1         = SetParse(ReceiveMsg, ipos, 16, ipos)	// �޽���1
					Message2         = SetParse(ReceiveMsg, ipos, 16, ipos)	// �޽���2
					CardNo           = SetParse(ReceiveMsg, ipos, 16, ipos)	// ī���ȣ
					ExpDate          = SetParse(ReceiveMsg, ipos,  4, ipos)	// ��ȿ�Ⱓ
					Installment      = SetParse(ReceiveMsg, ipos,  2, ipos)	// �Һ�
					Amount           = SetParse(ReceiveMsg, ipos,  9, ipos)	// �ݾ�
					MerchantNo       = SetParse(ReceiveMsg, ipos, 15, ipos)	// ��������ȣ
					AuthSendType     = SetParse(ReceiveMsg, ipos,  1, ipos)	// ���۱���= new String(read(2));
					ApprovalSendType = SetParse(ReceiveMsg, ipos,  1, ipos)	// ���۱���(0 : ����, 1 : ����, 2: ��ī��)
					Point1           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point1
					Point2           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point2
					Point3           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point3
					Point4           = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point4
					VanTransactionNo = SetParse(ReceiveMsg, ipos, 12, ipos)	// Point4
					Filler           = SetParse(ReceiveMsg, ipos, 82, ipos)	// ����
					AuthType	 = SetParse(ReceiveMsg, ipos,  1, ipos)	// I : ISP�ŷ�, M : MPI�ŷ�, SPACE : �Ϲݰŷ�
					MPIPositionType	 = SetParse(ReceiveMsg, ipos,  1, ipos)	// K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
					MPIReUseType	 = SetParse(ReceiveMsg, ipos,  1, ipos)	// Y : ����, N : ����ƴ�
					EncLen		 = SetParse(ReceiveMsg, ipos,  5, ipos)
					if  EncLen	 = "" then
						EncData      = ""
					else 
						Response.Write(EncLen)
						EncData      = SetParse(ReceiveMsg, ipos,  CInt(EncLen), ipos)	// MPI, ISP ������
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
			' ����Ʈī��
			elseif mid(ApprovalType,1,1) = "4" then
				PTransactionNo = SetParse(ReceiveMsg, ipos, 12, ipos)	' �ŷ���ȣ                   
				PStatus        = SetParse(ReceiveMsg, ipos,  1, ipos)	' ���� O : ���� , X : ����   
				PTradeDate     = SetParse(ReceiveMsg, ipos,  8, ipos)	' �ŷ�����                   
				PTradeTime     = SetParse(ReceiveMsg, ipos,  6, ipos)	' �ŷ��ð�                   
				PIssCode       = SetParse(ReceiveMsg, ipos,  6, ipos)	' �߱޻��ڵ�                 
				PAuthNo        = SetParse(ReceiveMsg, ipos, 12, ipos)	' ���ι�ȣ or ������ �����ڵ�
				PMessage1      = SetParse(ReceiveMsg, ipos, 16, ipos)	' �޽���1                    
				PMessage2      = SetParse(ReceiveMsg, ipos, 16, ipos)	' �޽���2                    
				PPoint1	       = SetParse(ReceiveMsg, ipos,  9, ipos)	' �ŷ�����Ʈ                 
				PPoint2        = SetParse(ReceiveMsg, ipos,  9, ipos)	' ��������Ʈ                 
				PPoint3        = SetParse(ReceiveMsg, ipos,  9, ipos)	' ��������Ʈ                 
				PPoint4        = SetParse(ReceiveMsg, ipos,  9, ipos)	' ����������Ʈ               
				PMerchantNo    = SetParse(ReceiveMsg, ipos, 15, ipos)	' ��������ȣ                 
				PNotice1       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PNotice2       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PNotice3       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PNotice4       = SetParse(ReceiveMsg, ipos, 40, ipos)	'                            
				PFiller        = SetParse(ReceiveMsg, ipos,  8, ipos)	' ����                       

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
			' �������
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
			' �����н�
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
			' ���ݿ�����
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
			' ���������� ��ȸ���
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