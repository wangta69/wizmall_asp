<%
	'<!------------------------------------------------
	'���ϸ�				: KSPayCreditFormI.asp
	'���				: ISP�������ο� ī�������Է¿� ������
	'�ۼ���				: 2005-04-25
	'����������			: 2005-04-25
	'����������			: ����
	'------------------------------------------------->

	'�ſ�ī��������� -  A-�������½���, N-��������, M-Visa3D��������, I-ISP��������
	certitype			= "I"
	authcode			= "I000"

	'�⺻�ŷ�����
	storeid 			= request.form("storeid")				'�������̵�
	storepasswd			= ""									'��������(���)�� �н����� (���Ļ��)
	ordername 			= request.form("ordername")				'�ֹ��ڸ�
	ordernumber			= request.form("ordernumber")			'�ֹ���ȣ
	amount				= request.form("amount")				'�ݾ�
	goodname			= request.form("goodname")				'��ǰ��
	idnum				= "1111111111111"     					' �ֹι�ȣ(������Ͽ�) �����¾��� ���
	email				= request.form("email")					'�ֹ����̸���
	phoneno				= request.form("phoneno")				'�ֹ����޴�����ȣ
	currencytype		= request.form("currencytype")			'��ȭ���� : "WON" : ��ȭ, "USD" : ��ȭ
	interesttype		= request.form("interesttype")

	'ISP�� �Һΰ���������
	KVP_QUOTA_INF    = "0:2:3:4:5:6:7:8:9:10:11:12"
	'ISP�� ������ �Һΰ��� ����(BC:0100 / ����:0204 / �츮:0700)
	'//Ex ) String KVP_NOINT_INF 	= "0204-3:4:5:6, 0100-3:4:5:6, 0700-3:4:5:6" ;	- �� ī��翡 ���� 3,4,5,6���� �ҺΰǸ� ������ó��
	'//Ex ) String KVP_NOINT_INF 	="ALL" - ��簳������ ���Ͽ� ������ó����./ "NONE" - ��簳������ ���Ͽ� ������ó����������.
	KVP_CURRENCY     = ""
	
	'interesttype���� �Ѱ��� ������ ������ó��
	if (interesttype = "ALL" or interesttype = "NONE") then
		KVP_NOINT_INF = interesttype
	elseif (interesttype = "") then
			KVP_NOINT_INF = "NONE"
	else 
			KVP_NOINT_INF = "0100-"+interesttype+", 0204-"+interesttype+", 0700-"+interesttype
	end if
%>
	
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="https://www.vpay.co.kr/KVPplugin_ssl.js"></script>
<script language="javascript">
<!--
	StartSmartUpdate();
   	function submit_isp(form) 
	{
		if (MakePayMessage(form) == true)
		{
			form.action= "KSPayCreditPostMNI.asp";
			form.submit();
			return true;
		}
		else 
		{
			alert("���ҿ� �����Ͽ����ϴ�.");
			return false;
		}
	}
-->
</script>
<style type="text/css">
	BODY{font-size:9pt; line-height:160%}
	TD{font-size:9pt; line-height:160%}
	A {color:blue;line-height:160%; background-color:#E0EFFE}
	INPUT{font-size:9pt;}
	SELECT{font-size:9pt;}
	.emp{background-color:#FDEAFE;}
	.white{background-color:#FFFFFF; color:black; border:1x solid white; font-size: 9pt;}
</style>
</head>

<body onload="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onFocus="" >
<form name=KSPayAuthForm method=post action="" onSubmit="">
<!--�⺻------------------------------------------------------------------>
<input type=hidden name="storeid"    			value="<%=storeid%>">
<input type=hidden name="storepasswd" 			value="<%=storepasswd%>">
<input type=hidden name="authty" 				value=<%=authcode%>>
<input type=hidden name="certitype" 			value=<%=certitype%>>

<!--�Ϲݽſ�ī��---------------------------------------------------------->
<input type=hidden name="expdt"					value="">
<input type=hidden name="email"					value="<%=email%>">
<input type=hidden name="phoneno"				value="<%=phoneno%>">
<input type=hidden name="ordernumber"			value="<%=ordernumber%>">
<input type=hidden name="ordername"				value="<%=ordername%>">
<input type=hidden name="idnum"					value="<%=idnum%>">
<input type=hidden name="goodname"				value="<%=goodname%>">
<input type=hidden name="amount"				value="<%=amount%>">
<input type=hidden name="currencytype"			value="<%=currencytype%>">

<input type=hidden name="cardno"				value="">		<!--ī���ȣ-->
<input type=hidden name="expyear"				value="">		<!--��ȿ��-->
<input type=hidden name="expmon"				value="">		<!--��ȿ��-->
<input type=hidden name="installment"			value="">		<!--�Һ�-->
<input type=hidden name="lastidnum"				value="">		<!--�ֹι�ȣ-->
<input type=hidden name="passwd"				value="">		<!--��й�ȣ-->

<!--ISP------------------------------------------------------------>
<input type=hidden name=KVP_PGID 			value="A0029">	<!-- PG -->
<input type=hidden name=KVP_SESSIONKEY 		value="">  	    <!-- ����Ű  --> 
<input type=hidden name=KVP_ENCDATA 		value="">     	<!-- ��ȣ�ȵ����� -->
<input type=hidden name=KVP_CURRENCY	 	value="<%=currencytype%>"> 	<!-- ���� ȭ�� ���� (WON/USD) : ��ȭ - WON, ��ȭ - USD-->
<input type=hidden name=KVP_NOINT 			value="">       <!-- �����ڱ���(1:������,0:�Ϲ�) -->
<input type=hidden name=KVP_QUOTA 			value="">       <!-- �Һ� -->
<input type=hidden name=KVP_CARDCODE 		value="">    	<!-- ī���ڵ� -->
<input type=hidden name=KVP_CONAME 			value="">      	<!-- ī��� -->
<input type=hidden name=KVP_RESERVED1 		value="">   	<!-- ����1 -->
<input type=hidden name=KVP_RESERVED2 		value="">   	<!-- ����2 -->
<input type=hidden name=KVP_RESERVED3 		value="">   	<!-- ����3 -->
<input type=hidden name=KVP_IMGURL 			value="">	
<input type=hidden name=KVP_QUOTA_INF 		value="<%=KVP_QUOTA_INF%>">	<!--�Һΰ�-->
<input type=hidden name=KVP_GOODNAME 		value="<%=goodname%>">		<!--��ǰ��-->
<input type=hidden name=KVP_PRICE 			value="<%=amount%>">		<!--�ݾ�-->
<input type=hidden name=KVP_NOINT_INF 		value="<%=KVP_NOINT_INF%>">	<!--�Ϲ�, ������-->
<!--ISP------------------------------------------------------------>

<table border=0 width=0>
<tr>
<td align=center>
<table width=280 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay �ſ�ī�� ����&nbsp;
<%
	select case certitype
		case "A"	response.write("(�������½���)")
		case "N"	response.write("(��������)")
		case "I"	response.write("(I-ISP��������)")
		case else response.write("(I-ISP��������)")
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
	<td>��ǰ�� :</td>
	<td><%=goodname%></td>
</tr>
<tr>
	<td>�ݾ� :</td>
	<td><%=amount%></td>
</tr>
<tr>
	<td colspan=3><hr noshade size=1></td>
</tr>
<tr>
	<td colspan=2>
		<input type=button name=ISP onclick="return submit_isp(KSPayAuthForm)" value=" ISP���� ">
	</td>
</tr>

</td>
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
</form>
</body>
</html>