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

' Default(�����׸��� �ƴ�)-------------------------------------------------------
	EncType       = "2"			     		' 0: ��ȭ����, 1:openssl, 2: seed
	Version       = "0210"				    ' ��������
	VersionType   = "00"					' ����
	Resend        = "0"					    ' ���۱��� : 0 : ó��,  2: ������
	' ��û���� : yyyymmddhhmmss
	RequestDate   = SetData(Year(Now),    4, "9") & _  
	                SetData(Month(Now),   2, "9") & _
	                SetData(Day(Now),     2, "9") & _
	                SetData(Hour(Now),    2, "9") & _
	                SetData(Minute(Now),  2, "9") & _
	                SetData(Second(Now),  2, "9")
	KeyInType     = "K"					    ' KeyInType ���� : S : Swap, K: KeyInType
	LineType      = "1"			            ' lineType 0 : offline, 1:internet, 2:Mobile
	ApprovalCount = "1"				        ' ���ս��ΰ���
	GoodType      = "1"	                    ' ��ǰ���� 1 : �ǹ�, 2 : ������
	HeadFiller    = ""				        ' ����
'-------------------------------------------------------------------------------

' Header (�Է°� (*) �ʼ��׸�)--------------------------------------------------
	StoreId     = request.form("storeid")		' *�������̵�
	OrderNumber = ""							' �ֹ���ȣ
	UserName    = ""							' �ֹ��ڸ�
	IdNum       = ""							' �ֹι�ȣ or ����ڹ�ȣ
	Email       = ""							' email
	GoodName    = request.form("goodname")		' ��ǰ��
	PhoneNo     = request.form("phoneno")		' �޴�����ȣ
' Header end -------------------------------------------------------------------

' Data Default(�����׸��� �ƴ�)-------------------------------------------------
	ApprovalType	  = request.form("authty")	' ���α���
	TrNo   			  = request.form("trno")	' �ŷ���ȣ
' Data Default end -------------------------------------------------------------

' Server�� ���� ������ ������ ��ü����
	rApprovalType	   = "1011" 
	rTransactionNo      = ""				' �ŷ���ȣ
	rStatus             = "X"				' ���� O : ����, X : ����
	rTradeDate          = "" 				' �ŷ�����
	rTradeTime          = "" 				' �ŷ��ð�
	rIssCode            = "00" 				' �߱޻��ڵ�
	rAquCode			= "00" 				' ���Ի��ڵ�
	rAuthNo             = "9999" 			' ���ι�ȣ or ������ �����ڵ�
	rMessage1           = "��Ұ���" 		' �޽���1
	rMessage2           = "C�������õ�"	' �޽���2
	rCardNo             = "" 				' ī���ȣ
	rExpDate            = "" 				' ��ȿ�Ⱓ
	rInstallment        = "" 				' �Һ�
	rAmount             = "" 				' �ݾ�
	rMerchantNo         = "" 				' ��������ȣ
	rAuthSendType       = "N" 				' ���۱���
	rApprovalSendType   = "N" 				' ���۱���(0 : ����, 1 : ����, 2: ��ī��)
	rPoint1             = "000000000000"	' Point1
	rPoint2             = "000000000000"	' Point2
	rPoint3             = "000000000000"	' Point3
	rPoint4             = "000000000000"	' Point4
	rVanTransactionNo   = ""
	rFiller             = "" 				' ����
	rAuthType	 	    = "" 				' ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
	rMPIPositionType	= "" 				' K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
	rMPIReUseType	    = "" 				' Y : ����, N : ����ƴ�
	rEncData			= "" 				' MPI, ISP ������
' --------------------------------------------------------------------------------

	KSPayApprovalCancel "210.181.28.137", 21001
	
	HeadMessage EncType, Version, VersionType, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, _ 
				GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller

' ------------------------------------------------------------------------------
	CancelDataMessage ApprovalType, "0", TrNo, "", "", Filler

	if SendSocket("1") = true then
		rApprovalType		= ApprovalType	    
		rTransactionNo		= TransactionNo	  		' �ŷ���ȣ
		rStatus				= Status		  		' ���� O : ����, X : ����
		rTradeDate			= TradeDate		  		' �ŷ�����
		rTradeTime			= TradeTime		  		' �ŷ��ð�
		rIssCode			= IssCode		  		' �߱޻��ڵ�
		rAquCode			= AquCode		  		' ���Ի��ڵ�
		rAuthNo				= AuthNo		  		' ���ι�ȣ or ������ �����ڵ�
		rMessage1			= Message1		  		' �޽���1
		rMessage2			= Message2		  		' �޽���2
		rCardNo				= CardNo		  		' ī���ȣ
		rExpDate			= ExpDate		  		' ��ȿ�Ⱓ
		rInstallment		= Installment	  		' �Һ�
		rAmount				= Amount		  		' �ݾ�
		rMerchantNo			= MerchantNo	  		' ��������ȣ
		rAuthSendType		= AuthSendType	  		' ���۱���= new String(this.read(2))
		rApprovalSendType	= ApprovalSendType		' ���۱���(0 : ����, 1 : ����, 2: ��ī��)
		rPoint1				= Point1		  		' Point1
		rPoint2				= Point2		  		' Point2
		rPoint3				= Point3		  		' Point3
		rPoint4				= Point4		  		' Point4
		rVanTransactionNo   = VanTransactionNo      ' Van�ŷ���ȣ
		rFiller				= Filler		  		' ����
		rAuthType			= AuthType		  		' ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
		rMPIPositionType	= MPIPositionType 		' K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
		rMPIReUseType		= MPIReUseType			' Y : ����, N : ����ƴ�
		rEncData			= EncData		  		' MPI, ISP ������
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
								KSPay �ſ�ī�� ���
								</font></td>
							</tr>
							<tr bgcolor=#FFFFFF>
								<td valign=top>
									<table width=100% cellspacing=0 cellpadding=2 border=0>
										<tr>
											<td align=left>
												<table>	
													<tr><td>�ŷ���ȣ			</td><td><%=rTransactionNo%></td></tr>
													<tr><td>��������(O/X)		</td><td><%=rStatus%></td></tr>
													<tr><td>�ŷ� ����			</td><td><%=rTradeDate%></td></tr>
													<tr><td>�ŷ� �ð�			</td><td><%=rTradeTime%></td></tr>
													<tr><td>���� �޼���1        </td><td><%=rMessage1%></td></tr>
													<tr><td>���� �޼���2        </td><td><%=rMessage2%></td></tr>
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