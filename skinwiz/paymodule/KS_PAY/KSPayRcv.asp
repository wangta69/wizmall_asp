<% 
Response.ContentType="text/HTML" 
Response.Charset="euc-kr" 
%>
<%
'------------------------------------------------------------------------------
' FILE NAME : KSPayRcv.asp
' DATE : 2006-09-01
' ���������� kspay���հ���â���κ��� �ŷ������ �޾� ������������������ �ŷ������ �ѱ�� ������ �մϴ�.
'------------------------------------------------------------------------------->

' ����--------------------------------------------------------------------------------------
    reEncType			= request.form("reEncType")				'��ȣȭ����
    reVersion			= request.form("reVersion")				'��������
    reType				= request.form("reType")				'��������
    reResend			= request.form("reResend")				'���۱���
    reRequestDate		= request.form("reRequestDate")			'��û��
    reStoreId			= request.form("reStoreId")				'�������̵�
    reOrderNumber		= request.form("reOrderNumber")			'�ֹ���ȣ
    reOrderName			= request.form("reOrderName")			'�ֹ��ڸ�
    reAllRegid			= request.form("reAllRegid")			'�ֹι�ȣ
    reEmail				= request.form("reEmail")				'�̸���
    reGoodType			= request.form("reGoodType")			'��ǰ���� 1:�ǹ�, 2: ������
    reGoodName			= request.form("reGoodName")			'��ǰ��
    reKeyInType			= request.form("reKeyInType")			'Keyin���� K : Keyin
    reLineType			= request.form("reLineType")			'���������� 0: offline, 1: online(internet)
    reMobile			= request.form("reMobile")				'�޴�����ȣ
    reApprovalCount		= request.form("reApprovalCount")		'��������
    reHeadFiller		= request.form("reHeadFiller")			'����
	reApprovalType		= request.form("reApprovalType")		'���α���

' �ſ�ī��---------------------------------------------------------------------------------------
    reTransactionNo				= request.form("reTransactionNo")				'�ŷ���ȣ
    reStatus					= request.form("reStatus")						'����
    reTradeDate					= request.form("reTradeDate")					'�ŷ�����
    reTradeTime					= request.form("reTradeTime")					'�ŷ��ð�
    reIssCode					= request.form("reIssCode")						'�߱޻��ڵ�
    reAquCode					= request.form("reAquCode")						'���Ի��ڵ�
    reAuthNo					= request.form("reAuthNo")						'���ι�ȣ
    reMessage1					= request.form("reMessage1")					'�޽���1
    reMessage2					= request.form("reMessage2")					'�޽���2
    reCardNo					= request.form("reCardNo")						'ī���ȣ14�ڸ�+XXXX
    reExpDate					= request.form("reExpDate")						'��ȿ�Ⱓ YYMM
    reInstallment				= request.form("reInstallment")					'�Һΰ�����
    reAmount					= request.form("reAmount")						'�ݾ�
    reMerchantNo				= request.form("reMerchantNo")					'��������ȣ
    reAuthSendType				= request.form("reAuthSendType")				'��������
    reApprovalSendType			= request.form("reApprovalSendType")			'���α���
    rePoint1					= request.form("rePoint1")
    rePoint2					= request.form("rePoint2")
    rePoint3					= request.form("rePoint3")
    rePoint4					= request.form("rePoint4")
    reVanTransactionNo			= request.form("reVanTransactionNo")
    reFiller					= request.form("reFiller")
    reAuthType					= request.form("reAuthType")
    reMPIPositionType			= request.form("reMPIPositionType")
    reMPIReUseType				= request.form("reMPIReUseType")
    reInterest					= request.form("reInterest")					'���ڱ��� 1: �Ϲ�, 2: ������

	rePApprovalType				= request.form("rePApprovalType")				'����Ʈ���α���
	rePTransactionNo			= request.form("rePTransactionNo")				'����Ʈ�ŷ���ȣ
	rePStatus					= request.form("rePStatus")						'����Ʈ���λ���
	rePTradeDate				= request.form("rePTradeDate")					'����Ʈ�ŷ�����
	rePTradeTime				= request.form("rePTradeTime")					'����Ʈ�ŷ��ð�
	rePIssCode					= request.form("rePIssCode")					'����Ʈ�߱޻��ڵ�
	rePAuthNo					= request.form("rePAuthNo")						'����Ʈ���ι�ȣ
	rePMessage1					= request.form("rePMessage1")					'�޽���1
	rePMessage2					= request.form("rePMessage2")					'�޽���2
	rePPoint1					= request.form("rePPoint1")						'�ŷ�����Ʈ
	rePPoint2					= request.form("rePPoint2")						'��������Ʈ
	rePPoint3					= request.form("rePPoint3")						'��������Ʈ
	rePPoint4					= request.form("rePPoint4")						'����������Ʈ
	rePMerchantNo				= request.form("rePMerchantNo")					'��������ȣ
	rePNotice1					= request.form("rePNotice1")
	rePNotice2					= request.form("rePNotice2")
	rePNotice3					= request.form("rePNotice3")
	rePNotice4					= request.form("rePNotice4")
	rePFiller					= request.form("rePFiller")

' �������---------------------------------------------------------------------------------------
	reVATransactionNo			= request.form("reVATransactionNo")			'������°ŷ���ȣ
	reVAStatus					= request.form("reVAStatus")				'����
	reVATradeDate				= request.form("reVATradeDate")				'�ŷ�����
	reVATradeTime				= request.form("reVATradeTime")				'�ŷ��ð�
	reVABankCode				= request.form("reVABankCode")				'�����ڵ�
	reVAVirAcctNo				= request.form("reVAVirAcctNo")				'������¹�ȣ
	reVAName					= request.form("reVAName")					'�����ָ�
	reVAMessage1				= request.form("reVAMessage1")				'�޽���1
	reVAMessage2				= request.form("reVAMessage2")				'�޽���2
	reVAFiller					= request.form("reVAFiller")				'����

' �����н�---------------------------------------------------------------------------------------
	reWPTransactionNo			= request.form("reWPTransactionNo")			'�����н��ŷ���ȣ
	reWPStatus					= request.form("reWPStatus")				'����
	reWPTradeDate				= request.form("reWPTradeDate")				'�ŷ�����
	reWPTradeTime				= request.form("reWPTradeTime")				'�ŷ��ð�
	reWPIssCode					= request.form("reWPIssCode")				'�߱޻��ڵ�
	reWPAuthNo					= request.form("reWPAuthNo")				'���ι�ȣ
	reWPBalanceAmount			= request.form("reWPBalanceAmount")			'�ܾ�
	reWPLimitAmount				= request.form("reWPLimitAmount")			'�ѵ���
	reWPMessage1				= request.form("reWPMessage1")				'�޽���1
	reWPMessage2				= request.form("reWPMessage2")				'�޽���2
	reWPCardNo					= request.form("reWPCardNo")				'ī���ȣ
	reWPAmount					= request.form("reWPAmount")				'�ݾ�
	reWPMerchantNo				= request.form("reWPMerchantNo")			'��������ȣ
	reWPFiller					= request.form("reWPFiller")				'����

' �޴��� ---------------------------------------------------------------------------------------
	reMTransactionNo			= request.form("reMTransactionNo")			'�ŷ���ȣ     
	reMStatus					= request.form("reMStatus")					'�ŷ��������� 
	reMTradeDate				= request.form("reMTradeDate")				'�ŷ�����     
	reMTradeTime				= request.form("reMTradeTime")				'�ŷ��ð�     
	reMBalAmount				= request.form("reMBalAmount")				'�ܾ�         
	reMTid						= request.form("reMTid")					'��������ڵ� 
	reMRespCode					= request.form("reMRespCode")				'�����ڵ�     
	reMRespMsg					= request.form("reMRespMsg")				'����޽���   
	reMBypassMsg				= request.form("reMBypassMsg")				'Echo �ʵ�    
	reMCompCode					= request.form("reMCompCode")				'����ڵ�     
	reMFiller					= request.form("reMFiller")					'����         

	'�ſ�ī��(1=MPI, I=ISP)
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
    elseif(mid(reApprovalType,1,1) = "4") then					'����Ʈ
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
    elseif(mid(reApprovalType,1,1) = "6") then					'�������
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
	elseif(mid(reApprovalType,1,1) = "2") then              '������ü
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
    elseif(mid(reApprovalType,1,1) = "7") then					 '�����н�
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
    elseif(mid(reApprovalType,1,1) = "M") then					 '�޴���
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
	/*init() - �Լ����� : ����Ϸ��� opener������(AuthFrm.asp)�� �ִ� paramSet(), goResult() �Լ��� ȣ���Ѵ�*/
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