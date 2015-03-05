<%
Response.Buffer=true
'------------------------------------------------------------------------------
 'FILE NAME : backUrl.asp
 'DATE : 2006-09-01
 '�� �������� BackURL�� ������ �������� ���� ��������� �ް� ���������� �ϱ����� �����������Դϴ�.
'-------------------------------------------------------------------------------

' =============	Input ���� =================================================================
' strModule	  :	Module Name
' strFunction :	Function Name
' strLogMsg	  :	Logging	�� ����
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
	' Log File ����(�ش��ü���� �α������� ���� ��� ����) 
	' ex) LOG_PATH = "C:\1\"(C����̺� ���� 1���丮 �ؿ� ����)
	'***************************************************************************
	LOG_PATH = "C:\1\"

	'*************************************************************************
	' ���� ��¥�� ����
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
	' Logging �� Record	����
	'*************************************************************************
	strRecord =	"["	& CStr(time()) & "]	"
	strRecord =	strRecord &	CStr(strFunction) &	Space(40 - Len(CStr(strFunction)))
	strRecord =	strRecord &	": " & CStr(strLogMsg) & " "

	'*************************************************************************
	' ȭ�Ͽ� Logging
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

'*****************************************Header ����*******************************************************
'0:����,1:��ȣȭ����,2:����,3:Type,4:resend,5:��û�Ͻ�,6:�������̵�,7:�ֹ���ȣ,8:�ֹ��ڸ�,9:�ֹι�ȣ,10:�̸���
'11:Product	Type,12:��ǰ��,13:KeyIn	����,14:����������,15:����� ��������,16:�޴�����ȣ,17:����
'************************************************************************************************************

'*****************************************�ſ�ī�� Data����*************************************************
'18:���α���,19:�ŷ���ȣ,20:��������,21:�ŷ�����,22:�ŷ��ð�,23:�߱޻��ڵ�,24:���Ի��ڵ�,25:���ι�ȣ
'26:�޽���1,27:�޽���2,28:ī���ȣ,29:��ȿ�Ⱓ,30:�Һ�,31:�ݾ�,32:��������ȣ,33:��������,34:���ο���
'35:����,36:��������,37:MPI�������,38:ISP�Ǵ� Visa3D��������
'************************************************************************************************************
'*****************************************������¹߱� Data����*************************************************
'18:���α���,19:�ŷ���ȣ,20:��������,21:�ŷ�����,22:�ŷ��ð�,23:����,24:�������,25:������
'26:�޽���1,27:�޽���2,28:����
'************************************************************************************************************
'*****************************************�����н�ī�� Data����*************************************************
'18:���α���,19:�ŷ���ȣ,20:��������,21:�ŷ�����,22:�ŷ��ð�,23:�߱޻��ڵ�,24:���ι�ȣ,25:�ܾ�
'26:�ѵ���,27:�޽���1,28:�޽���2,29:ī���ȣ,30:�ݾ�,31:��������ȣ,32:����
'************************************************************************************************************
'*****************************************������ü Data����*************************************************
'18:���α���,19:�ŷ���ȣ,20:��������,21:�ŷ�����,22:�ŷ��ð�,23:������ü����,24:�����μ�޼���
'25:�Աݸ���������ڵ�,26:�Աݸ����¹�ȣ,27:��������ڵ�,28:��ݰ��¹�ȣ,29:�����ݾ�,30:���������ڵ�
'31:�޽���1,32:�޽���2,33:����
'************************************************************************************************************
'*****************************************�޴������� Data����*************************************************
'18:���α���,19:�ŷ���ȣ,20:��������,21:�ŷ�����,22:�ŷ��ð�,23:�ݾ�,24:��������ڵ�
'25:�����ڵ�,26:����޽���,27:���񽺾�ü,28:����ڵ�,29:����
'************************************************************************************************************
	paraData = Split(data,"`")

	strLen = Ubound(paraData,1)

'	For	I =	0 To strLen
'		writeData =	writeData &	paraData(I)
'	Next

	TraceLog data

	rVersion				=  paraData(1)	'  0:��ȣ����, 1:��ȣȭ(openssl), 2:��ȣȭ(seed)
	rType					=  paraData(2)	'  ��������	: 311
	rmsg_sele				=  paraData(3)	'  ��������
	rResend					=  paraData(4)	'  �����۱���
	rRequestDate			=  paraData(5)	'  ��û�Ͻ�
	rStoreId				=  paraData(6)	'  �������̵�
	rOrderNumber			=  paraData(7)	'  �ֹ���ȣ
	rUserName				=  paraData(8)	'  �ֹ��ڸ�
	rIdNum					=  paraData(9)	'  �ֹι�ȣ
	rEmail					=  paraData(10)	'  �̸���
	rGoodType				=  paraData(11)	'  ��ǰ���� 1 : �ǹ�, 2 : ������
	rGoodName				=  paraData(12)	'  ��ǰ��
	rKeyInType				=  paraData(13)	'  keyin����
	rLineType				=  paraData(14)	'  ����������
	rPhoneNo				=  paraData(15)	'  �޴�����ȣ
	rApprovalCount			=  paraData(16)	'  ���հ����Ǽ�
	rHaedFiller				=  paraData(17)	'  ����

	ret	= "false"

	IF(mid(paraData(18),1,1)="1" or mid(paraData(18),1,1)="I") 	Then			'�ſ�ī��(ISP,Visa3D����) paraData(18]=>���α���	 paraData[18].substring(0,1).equals("1")
		IF strLen >= 38	Then
			rApprovalType		= paraData(18)
			rTransactionNo		= paraData(19)	 ' �ŷ���ȣ
			rStatus				= paraData(20)	 ' ����	O :	����, X	: ����
			rTradeDate			= paraData(21)	 ' �ŷ�����
			rTradeTime			= paraData(22)	 ' �ŷ��ð�
			rIssCode			= paraData(23)	 ' �߱޻��ڵ�
			rAquCode			= paraData(24)	 ' ���Ի��ڵ�
			rAuthNo				= paraData(25)	 ' ���ι�ȣ	or ������ �����ڵ�
			rMessage1			= paraData(26)	 ' �޽���1
			rMessage2			= paraData(27)	 ' �޽���2
			rCardNo				= paraData(28)	 ' ī���ȣ
			rExpDate			= paraData(29)	 ' ��ȿ�Ⱓ
			rInstallment		= paraData(30)	 ' �Һ�
			rAmount				= paraData(31)	 ' �ݾ�
			rMerchantNo			= paraData(32)	 ' ��������ȣ
			rAuthSendType		= paraData(33)	 ' ���۱���= new String(this.read(2))
			rApprovalSendType	= paraData(34)	 ' ���۱���(0 :	����, 1	: ����,	2: ��ī��)
			rPoint1				= paraData(35)	 ' Point1
			rPoint2				= paraData(36)	 ' Point2
			rPoint3				= paraData(37)	 ' Point3
			rPoint4				= paraData(38)	 ' Point4
			rVanTransactionNo	= paraData(39)	 ' Van�ŷ���ȣ
			rFiller				= paraData(40)	 ' ����
			rAuthType			= paraData(41)	 ' ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE	: �Ϲݰŷ�
			rMPIPositionType	= paraData(42)	 ' K : KSNET, R	: Remote, C	: ��3���, SPACE : �Ϲݰŷ�
			rMPIReUseType		= paraData(43)	 ' Y : ����, N : ����ƴ�
			rEncData			= paraData(44)	 ' MPI,	ISP	������

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"6"	Then
		IF strLen >= 28	Then
			rVAApprovalType	 = paraData(18)	  '
			rVATransactionNo = paraData(19)	  '	�ŷ���ȣ
			rVAStatus		 = paraData(20)	  '	����
			rVATradeDate	 = paraData(21)	  '	�ŷ�����
			rVATradeTime	 = paraData(22)	  '	�ŷ��ð�
			rVABankCode		 = paraData(23)	  '	�����ڵ�
			rVAVirAcctNo	 = paraData(24)	  '	������¹�ȣ
			rVAName			 = paraData(25)	  '	������
			rVAMessage1		 = paraData(26)	  '	�޽���1
			rVAMessage2		 = paraData(27)	  '	�޽���2
			rVAFiller		 = paraData(28)	  '	����

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"7"	Then '�����н�ī�� paraData(18]=>���α���
		IF strLen >= 32	Then
			rApprovalType	 = paraData(18)	  '
			rWPTransactionNo = paraData(19)	  '	�ŷ���ȣ
			rWPStatus		 = paraData(20)	  '	���� O : ����, X : ����
			rWPTradeDate	 = paraData(21)	  '	�ŷ�����
			rWPTradeTime	 = paraData(22)	  '	�ŷ��ð�
			rWPIssCode		 = paraData(23)	  '	�߱޻��ڵ�
			rWPAuthNo		 = paraData(24)	  '	���ι�ȣ
			rWPBalanceAmount = paraData(25)	  '	�ܾ�
			rWPLimitAmount	 = paraData(26)	  '	�ѵ���
			rWPMessage1		 = paraData(27)	  '	�޽���1
			rWPMessage2		 = paraData(28)	  '	�޽���2
			rWPCardNo		 = paraData(29)	  '	ī���ȣ
			rWPAmount		 = paraData(30)	  '	�ݾ�
			rWPMerchantNo	 = paraData(31)	  '	��������ȣ
			rWPFiller		 = paraData(32)	  '	����

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"2"	Then
		IF strLen >= 33	Then
			rVAApprovalType	 = paraData(18)	  '
			rVATransactionNo = paraData(19)	  '	*�ŷ���ȣ
			rVAStatus		 = paraData(20)	  '	*���� O : ����, X : ����
			rVATradeDate	 = paraData(21)	  '	*�ŷ�����
			rVATradeTime	 = paraData(22)	  '	*�ŷ��ð�
			rVAAcctType		 = paraData(23)	  '	������ü����
			rVArVAPrintMsg	 = paraData(24)	  '	�����μ�޼���
			rVAPBankCode	 = paraData(25)	  '	�Աݸ���������ڵ�
			rVAPAcctNo		 = paraData(26)	  '	�Աݸ����¹�ȣ
			rVABankCode		 = paraData(27)	  '	*��������ڵ�
			rVAAcctNo		 = paraData(28)	  '	��ݰ��¹�ȣ
			rVAAmount		 = paraData(29)	  '	�����ݾ�
			rVABankRespCode	 = paraData(30)	  '	���������ڵ�
			rVAMessage1		 = paraData(31)	  '	*�޽���1
			rVAMessage2		 = paraData(32)	  '	�޽���2
			rVAFiller		 = paraData(33)	  '	����

			ret	= "true"

		End	IF
	ElseIF mid (paraData(18),1,1) =	"M"	Then
		IF strLen >= 29	Then
			rMApprovalType	 = paraData(18)	  '
			rMTransactionNo	 = paraData(19)	  '	�ŷ���ȣ    
			rMStatus		 = paraData(20)	  '	�ŷ���������
			rMTradeDate 	 = paraData(21)	  '	�ŷ�����    
			rMTradeTime 	 = paraData(22)	  '	�ŷ��ð�    
			rMBalAmount 	 = paraData(23)	  '	�ܾ�        
			rMTid 			 = paraData(24)	  '	��������ڵ�
			rMRespCode		 = paraData(25)	  '	�����ڵ�    
			rMRespMsg		 = paraData(26)	  '	����޽���  
			rMBypassMsg		 = paraData(27)	  '	���񽺾�ü
			rMCompCode		 = paraData(28)	  '	����ڵ�    
			rMFiller		 = paraData(29)	  '	����        

			ret	= "true"

		End	IF
	End	IF
msg = "ret=" & ret
Response.Write(msg)
Response.AddHeader "Content-Length", Len(msg)
Response.Flush()
%>