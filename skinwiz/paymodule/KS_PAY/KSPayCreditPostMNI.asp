<!-- #include file=KSPayApprovalCancel.inc -->
<%
	'����Ÿ��	 : A-�������½���, N-��������, M-Visa3D��������, I-ISP�������� 
	certitype			= request.form("certitype")	

'Header�� Data --------------------------------------------------
	EncType			= "2" 					'0: ��ȭ����, 1:ssl, 2: seed
	Version			= "0603"				' ��������
	VType			= "00"					' ����
	Resend			= "0"					' ���۱��� : 0 : ó��,  2: ������

	RequestDate		=	SetData(Year(Now),    4, "9") & _  
						SetData(Month(Now),   2, "9") & _
		                SetData(Day(Now),     2, "9") & _
		                SetData(Hour(Now),    2, "9") & _
			            SetData(Minute(Now),  2, "9") & _
		                SetData(Second(Now),  2, "9")
	
	KeyInType		= "K" 					'KeyInType ���� : S : Swap, K: KeyInType
	LineType		= "1"					'lineType 0 : offline, 1:internet, 2:Mobile
	ApprovalCount	= "1"					'���ս��ΰ���
	GoodType		= "0" 					'��ǰ���� 0 : �ǹ�, 1 : ������
	HeadFiller		= ""					'����

	StoreId			= request.form("storeid") 			'*�������̵�
	OrderNumber		= request.form("ordernumber") 		'*�ֹ���ȣ
	UserName		= request.form("ordername") 		'*�ֹ��ڸ�
	IdNum			= request.form("idnum") 			'�ֹι�ȣ or ����ڹ�ȣ
	Email			= request.form("email") 			'*email
	GoodName		= request.form("goodname") 			'*��ǰ��
	PhoneNo			= request.form("phoneno") 			'*�޴�����ȣ
'Header end -------------------------------------------------------------------

'Data Default-------------------------------------------------
	ApprovalType		= request.form("authty") 									'���α���
	InterestType		= request.form("interest") 									'�Ϲ�/�����ڱ��� 1:�Ϲ� 2:������
	TrackII				= request.form("cardno")&"="&request.form("expdt")       	' ī���ȣ=��ȿ�Ⱓ  or �ŷ���ȣ
	Installment			= request.form("installment") 								'�Һ�  00�Ͻú�
	Amount				= request.form("amount") 									'�ݾ�
	Passwd				= request.form("passwd") 									'��й�ȣ ��2�ڸ�
	LastIdNum			= request.form("lastidnum") 								'�ֹι�ȣ  ��7�ڸ�, ����ڹ�ȣ10
	CurrencyType		= request.form("currencytype") 								'��ȭ���� 0:��ȭ 1: ��ȭ

	BatchUseType		= "0" 				'�ŷ���ȣ��ġ��뱸��  0:�̻�� 1:���
	CardSendType		= "0" 				'ī�������������� 
	'0:������ 1:ī���ȣ,��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ 2:ī���ȣ��14�ڸ� + "XXXX",��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ
	VisaAuthYn			= "7" 				'������������ 0:������,7:SSL,9:��������
	Domain				= "" 				'������ ��ü������(PG��ü��)
	IpAddr				= Request.ServerVariables("REMOTE_ADDR")			'IP ADDRESS ��ü������(PG��ü��)
	BusinessNumber		= "" 												'����� ��ȣ ��ü������(PG��ü��)
	Filler				= "" 												'����
	AuthType			= "" 												'ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
	MPIPositionType		= "" 												'K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
	MPIReUseType		= "" 	      										'Y : ����, N : ����ƴ�
	EncData				= "" 												'MPI, ISP ������
	
	cavv				= request.form("cavv") 		'MPI��
	xid					= request.form("xid") 		'MPI��
	eci					= request.form("eci")	 	'MPI��

	KVP_PGID			= "" 
	KVP_CARDCODE		= "" 
	KVP_SESSIONKEY		= "" 
	KVP_ENCDATA			= "" 

	'ISP�ϰ��
	if certitype = "I" then
		TrackII			= "" 
		InterestType	= request.form("KVP_NOINT")		'�����ڱ���
		Installment		= request.form("KVP_QUOTA")		'�Һ�:00�Ͻú�
		KVP_PGID		= request.form("KVP_PGID")
		KVP_CARDCODE	= request.form("KVP_CARDCODE")
		KVP_SESSIONKEY	= request.form("KVP_SESSIONKEY")
		KVP_ENCDATA		= request.form("KVP_ENCDATA")
	end if
'Data Default end -------------------------------------------------------------

'Server�� ���� ������ ������ ��ü����
	rApprovalType		= "1001"  
	rTransactionNo		= "" 							'�ŷ���ȣ
	rStatus				= "X" 							'���� O : ����, X : ����
	rTradeDate			= "" 							'�ŷ�����
	rTradeTime			= "" 							'�ŷ��ð�
	rIssCode			= "00" 							'�߱޻��ڵ�
	rAquCode			= "00" 							'���Ի��ڵ�
	rAuthNo				= "9999" 						'���ι�ȣ or ������ �����ڵ�
	rMessage1			= "���ΰ���" 					'�޽���1
	rMessage2			= "C�������õ�" 				'�޽���2
	rCardNo				= "" 							'ī���ȣ
	rExpDate			= "" 							'��ȿ�Ⱓ
	rInstallment		= "" 							'�Һ�
	rAmount				= "" 							'�ݾ�
	rMerchantNo			= "" 							'��������ȣ
	rAuthSendType		= "N" 							'���۱���
	rApprovalSendType	= "N" 							'���۱���(0 : ����, 1 : ����, 2: ��ī��)
	rPoint1				= "000000000000" 				'Point1
	rPoint2				= "000000000000"				'Point2
	rPoint3				= "000000000000"				'Point3
	rPoint4				= "000000000000" 				'Point4
	rVanTransactionNo	= "" 
	rFiller				= "" 							'����
	rAuthType	 		= "" 							'ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
	rMPIPositionType	= "" 							'K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
	rMPIReUseType		= "" 							'Y : ����, N : ����ƴ�
	rEncData			= "" 							'MPI, ISP ������
'--------------------------------------------------------------------------------
	
	'�Ϲݽ����ΰ��
	if certitype = "A" or certitype = "N" then
		AuthType				= ""
		MPIPositionType			= ""
		MPIReUseType			= ""
		EncData					= ""
	end if
	'Visa3d���������ΰ��
	if certitype = "M" then
		AuthType				= "M"
		MPIPositionType			= "K"
		MPIReUseType			= "N"
		cavv					= SetData(cavv, 40, "X")
		xid						= SetData(xid,  40, "X")
		eci						= SetData(eci,   2, "X")
		EncData					= SetData(GetLength(cavv&xid&eci), 5, "9")&cavv&xid+eci
	end if
	'ISP���������ΰ��
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

	'dll �ʱ�ȭ
	KSPayApprovalCancel "210.181.28.137", 21001

	'Header�� ��������
	HeadMessage EncType, Version, VType, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, _ 
				GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller

	'Data�� ��������
	CreditDataMessage ApprovalType, InterestType, TrackII, Installment, Amount, Passwd, LastIdNum, CurrencyType, BatchUseType, CardSendType, VisaAuthYn, _
		Domain, IpAddr, BusinessNumber, Filler, AuthType, MPIPositionType, MPIReUseType, EncData

	'KSPAY�� ��û�����۽��� ���ŵ����� �Ľ�
	if SendSocket("1") = true then
		rApprovalType			= ApprovalType		'���α����ڵ�(���������� �����Ҽ� �ֽ��ϴ�. ÷�ε��������������� �����ڵ�� ����)
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
KSPay �ſ�ī�� ���&nbsp;
<%
	select case certitype
		case "A"	response.write("(�������½���)") 
		case "N"	response.write("(��������)") 
		case "M"	response.write("(M-Visa3D��������)") 
		case "I"		response.write("(I-ISP��������)") 
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
	<td>�ŷ����� :</td>
	<td><%=rApprovalType%></td>
</tr>
<tr>
	<td>�ŷ���ȣ :</td>
	<td><%=rTransactionNo%></td>
</tr>
<tr>
	<td>�ŷ��������� :</td>
	<td><%=rStatus%></td>
</tr>
<tr>
	<td>�ŷ��ð� :</td>
	<td><%=rTradeDate%>&nbsp;<%=rTradeTime%></td>
</tr>
<tr>
	<td>�߱޻��ڵ� :</td>
	<td><%=rIssCode%></td>
</tr>
<tr>
	<td>���Ի��ڵ� :</td>
	<td><%=rAquCode%></td>
</tr>
<tr>
	<td>���ι�ȣ :</td>
	<td><%=rAuthNo%></td>
</tr>
<tr>
	<td>�޽���1 :</td>
	<td><%=rMessage1%></td>
</tr>
<tr>
	<td>�޽���2 :</td>
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