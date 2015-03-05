<!-- #include file=KSPayApprovalCancel.inc -->
<%
'<!------------------------------------------------------------------------------
' FILE NAME : KSPayCancelForm.asp
' AUTHOR : kspay@ksnet.co.kr
' DATE : 2003/11/29
'                                                         http://www.kspay.co.kr
'                                                         http://www.ksnet.co.kr
'                                  Copyright 2003 KSNET, Co. All rights reserved
'------------------------------------------------------------------------------->

' Default(수정항목이 아님)-------------------------------------------------------
	EncType       = "2"			     		' 0: 암화안함, 1:openssl, 2: seed
	Version       = "0210"				    ' 전문버전
	VersionType   = "00"					' 구분
	Resend        = "0"					    ' 전송구분 : 0 : 처음,  2: 재전송
	' 요청일자 : yyyymmddhhmmss
	RequestDate   = SetData(Year(Now),    4, "9") & _  
	                SetData(Month(Now),   2, "9") & _
	                SetData(Day(Now),     2, "9") & _
	                SetData(Hour(Now),    2, "9") & _
	                SetData(Minute(Now),  2, "9") & _
	                SetData(Second(Now),  2, "9")
	KeyInType     = "K"					    ' KeyInType 여부 : S : Swap, K: KeyInType
	LineType      = "1"			            ' lineType 0 : offline, 1:internet, 2:Mobile
	ApprovalCount = "1"				        ' 복합승인갯수
	GoodType      = "1"	                    ' 제품구분 1 : 실물, 2 : 디지털
	HeadFiller    = ""				        ' 예비
'-------------------------------------------------------------------------------

' Header (입력값 (*) 필수항목)--------------------------------------------------
	StoreId     = request.form("storeid")		' *상점아이디
	OrderNumber = ""							' 주문번호
	UserName    = ""							' 주문자명
	IdNum       = ""							' 주민번호 or 사업자번호
	Email       = ""							' email
	GoodName    = request.form("goodname")		' 제품명
	PhoneNo     = request.form("phoneno")		' 휴대폰번호
' Header end -------------------------------------------------------------------

' Data Default(수정항목이 아님)-------------------------------------------------
	ApprovalType	  = request.form("authty")	' 승인구분
	TrNo   			  = request.form("trno")	' 거래번호
' Data Default end -------------------------------------------------------------

' Server로 부터 응답이 없을시 자체응답
	rApprovalType	   = "1011" 
	rTransactionNo      = ""				' 거래번호
	rStatus             = "X"				' 상태 O : 승인, X : 거절
	rTradeDate          = "" 				' 거래일자
	rTradeTime          = "" 				' 거래시간
	rIssCode            = "00" 				' 발급사코드
	rAquCode			= "00" 				' 매입사코드
	rAuthNo             = "9999" 			' 승인번호 or 거절시 오류코드
	rMessage1           = "취소거절" 		' 메시지1
	rMessage2           = "C잠시후재시도"	' 메시지2
	rCardNo             = "" 				' 카드번호
	rExpDate            = "" 				' 유효기간
	rInstallment        = "" 				' 할부
	rAmount             = "" 				' 금액
	rMerchantNo         = "" 				' 가맹점번호
	rAuthSendType       = "N" 				' 전송구분
	rApprovalSendType   = "N" 				' 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
	rPoint1             = "000000000000"	' Point1
	rPoint2             = "000000000000"	' Point2
	rPoint3             = "000000000000"	' Point3
	rPoint4             = "000000000000"	' Point4
	rVanTransactionNo   = ""
	rFiller             = "" 				' 예비
	rAuthType	 	    = "" 				' ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	rMPIPositionType	= "" 				' K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	rMPIReUseType	    = "" 				' Y : 재사용, N : 재사용아님
	rEncData			= "" 				' MPI, ISP 데이터
' --------------------------------------------------------------------------------

	KSPayApprovalCancel "210.181.28.137", 21001
	
	HeadMessage EncType, Version, VersionType, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, _ 
				GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller

' ------------------------------------------------------------------------------
	CancelDataMessage ApprovalType, "0", TrNo, "", "", Filler

	if SendSocket("1") = true then
		rApprovalType		= ApprovalType	    
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
		rPoint1				= Point1		  		' Point1
		rPoint2				= Point2		  		' Point2
		rPoint3				= Point3		  		' Point3
		rPoint4				= Point4		  		' Point4
		rVanTransactionNo   = VanTransactionNo      ' Van거래번호
		rFiller				= Filler		  		' 예비
		rAuthType			= AuthType		  		' ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
		rMPIPositionType	= MPIPositionType 		' K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
		rMPIReUseType		= MPIReUseType			' Y : 재사용, N : 재사용아님
		rEncData			= EncData		  		' MPI, ISP 데이터
	end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<title>KSPay</title>
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
</head>

<body>
<table border=0 width=0>
	<tr>
		<td align=center>
			<table width=350 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
				<tr>
					<td width=50%>
						<table width=100% cellspacing=1 cellpadding=2 border=0>
							<tr bgcolor=#4F9AFF height=25>
								<td align=left><font color="#FFFFFF">
								KSPay 신용카드 취소
								</font></td>
							</tr>
							<tr bgcolor=#FFFFFF>
								<td valign=top>
									<table width=100% cellspacing=0 cellpadding=2 border=0>
										<tr>
											<td align=left>
												<table>	
													<tr><td>거래번호			</td><td><%=rTransactionNo%></td></tr>
													<tr><td>오류구분(O/X)		</td><td><%=rStatus%></td></tr>
													<tr><td>거래 일자			</td><td><%=rTradeDate%></td></tr>
													<tr><td>거래 시간			</td><td><%=rTradeTime%></td></tr>
													<tr><td>응답 메세지1        </td><td><%=rMessage1%></td></tr>
													<tr><td>응답 메세지2        </td><td><%=rMessage2%></td></tr>
												</table>
											<td>
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
</body>
</html>