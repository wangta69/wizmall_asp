<%@ codepage="949" language="VBScript" %>
<%
Dim storeid, ordername, ordernumber, amount, goodname, phoneno, currencytype, interesttype, paytype, sjumin1, sjumin2

storeid			= Request("storeid")		
ordername		= unescape(Request("ordername"))
email			= Request("email")
ordernumber		= Request("ordernumber")
amount			= Request("amount")
goodname		= unescape(Request("goodname"))
phoneno			= Request("phoneno")
currencytype	= Request("currencytype")
interesttype	= Request("interesttype")
sjumin1	= Request("sjumin1")
sjumin2	= Request("sjumin2")
paytype	= Request("paytype")

Dim s_paytype
	Select Case paytype
    Case "card"
        s_paytype = 100000
    Case "hand"
        s_paytype = 000001
    Case "autobank"
        s_paytype = 001000		
		
End Select

%>
<%'------------------------------------------------------------------------------
  'FILE NAME : AuthForm.asp
  'DATE : 2007-04-09
  '���������� kspay���հ���â���� �⺻�ŷ������� �Ѱ��ִ� ������ �ϴ� �����������Դϴ�.
'---------------------------------------------------------------------------------%>
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="javascript">
<!--
	/*goOpen() - �Լ����� : ���翡 �ʿ��� �⺻�ŷ��������� �����ϰ� kspay����â�� ���ϴ�.*/
	function goOpen() 
	{
		/*kspay����â�� �������� ���ڰ����� �����մϴ�.*/
        document.authFrmFrame.sndOrdernumber.value     = document.KSPayWeb.sndOrdernumber.value;
		document.authFrmFrame.sndGoodname.value        = document.KSPayWeb.sndGoodname.value;
		document.authFrmFrame.sndInstallmenttype.value = document.KSPayWeb.sndInstallmenttype.value;
		document.authFrmFrame.sndAmount.value          = document.KSPayWeb.sndAmount.value;
		document.authFrmFrame.sndOrdername.value       = document.KSPayWeb.sndOrdername.value;
		document.authFrmFrame.sndAllregid.value        = document.KSPayWeb.sndAllregid.value;
		document.authFrmFrame.sndEmail.value           = document.KSPayWeb.sndEmail.value;
		document.authFrmFrame.sndMobile.value          = document.KSPayWeb.sndMobile.value;
		document.authFrmFrame.sndInteresttype.value    = document.KSPayWeb.sndInteresttype.value;
		document.authFrmFrame.sndCurrencytype.value    = document.KSPayWeb.sndCurrencytype.value;
		document.authFrmFrame.sndWptype.value          = document.KSPayWeb.sndWptype.value;
		document.authFrmFrame.sndAdulttype.value       = document.KSPayWeb.sndAdulttype.value;
		
		document.authFrmFrame.sndReply.value           = getLocalUrl("KSPayRcv.asp") ;

		var height_ = 420;
		var width_ = 400;
		var left_ = screen.width;
		var top_ = screen.height;
		
		left_ = left_/2 - (width_/2);
		top_ = top_/2 - (height_/2);
		
		/*kspay����â�� ����ݴϴ�.*/
		src = window.open('about:blank','AuthFrmUp',
		        'height='+height_+',width='+width_+',status=yes,scrollbars=no,resizable=no,left='+left_+',top='+top_+'');
		document.authFrmFrame.target = 'AuthFrmUp';
		document.authFrmFrame.action ='https://kspay.ksnet.to/store/KSPayWebV1.3/KSPayWeb.jsp';
		document.authFrmFrame.submit();
    }

	function getLocalUrl(mypage) 
	{ 
		var myloc = location.href; 
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
	} 

	/*����ũ�� ����� ���� ���ǿ��θ� �����ϵ��� �մϴ�. */
	function openKEscrowAgree()
	{
		var height_ = 700;
		var width_ = 650;
		var left_ = screen.width;
		var top_ = screen.height;
		
		left_ = left_/2 - (width_/2);
		top_ = top_/2 - (height_/2);
		
		var escrow_url;
		var ptc;
		ptc=location.protocol.substr(0,4);
		/* ��� ���� â�� ȣ�� - KEscrowRcv.html(���� Ȯ���ڴ� ���氡��, ���� ���� ���� �Ұ���)*/
		if(ptc.toLowerCase()=="http")
		{
			escrow_url="http://kspay.ksnet.to/store/KSPayWebV1.3/vaccount/kscrow_agree.jsp?sndEscrowReply=" + getLocalUrl("KEscrowRcv.html");
		}
		else
		{
			escrow_url="https://kspay.ksnet.to/store/KSPayWebV1.3/vaccount/kscrow_agree.jsp?sndEscrowReply=" + getLocalUrl("KEscrowRcv.html");
		}		
		/*kspay����â�� ����ݴϴ�.*/
		src = window.open(escrow_url,'AuthFrmUp',
		        'height='+height_+',width='+width_+',status=yes,scrollbars=no,resizable=no,left='+left_+',top='+top_+'');
	}

	/* ����ũ�� ����� �ŷ��� ���� ���ý�  */
	function setPayMethod(p_type)
	{
		if (p_type=='E')
		{
			document.authFrmFrame.sndPaymethod.value = "010000";
			
			var amt = parseInt(document.KSPayWeb.sndAmount.value);
			if (isNaN(amt) || amt < 100000)
			{
				alert("10�����̻��� �����Ͻ� ��쿡 ����ũ�θ� ����Ͻ� �� �ֽ��ϴ�.");
				document.KSPayWeb.pay_type[0].checked = true;
				return false
			}
			
			openKEscrowAgree();
		}else
		if (p_type=='1')
		{
			document.authFrmFrame.sndPaymethod.value = "100000";
		}else
		if (p_type=='2')
		{
			document.authFrmFrame.sndPaymethod.value = "010000";
		}else
		if (p_type=='3')
		{
			document.authFrmFrame.sndPaymethod.value = "001000";
		}else
		if (p_type=='M')
		{
			document.authFrmFrame.sndPaymethod.value = "000001";
		}	
	}
	
	/*goResult() - �Լ����� : ����Ϸ��� ������� ������ ���������(result.asp)�� �����մϴ�.*/
	function goResult(){
		document.KSPayWeb.target = "";
		document.KSPayWeb.submit();
	}
	
	/*paramSet() - �Լ����� : ����Ϸ��� (KSPayRcv.asp�κ���)������� �޾� ������ ���������(result.asp)�� ���۵� form�� �����մϴ�.*/
	function paramSet(authyn,trno,trdt,trtm,authno,ordno,msg1,msg2,amt,temp_v,isscd,aqucd,remark,result){
		document.KSPayWeb.reAuthyn.value 	= authyn;
		document.KSPayWeb.reTrno.value 		= trno  ;
		document.KSPayWeb.reTrddt.value 	= trdt  ;
		document.KSPayWeb.reTrdtm.value 	= trtm  ;
		document.KSPayWeb.reAuthno.value 	= authno;
		document.KSPayWeb.reOrdno.value 	= ordno ;
		document.KSPayWeb.reMsg1.value 		= msg1  ;
		document.KSPayWeb.reMsg2.value 		= msg2  ;
		document.KSPayWeb.reAmt.value 		= amt   ;
		document.KSPayWeb.reTemp_v.value 	= temp_v;
		document.KSPayWeb.reIsscd.value 	= isscd ;
		document.KSPayWeb.reAqucd.value 	= aqucd ;
		document.KSPayWeb.reRemark.value 	= remark;
		document.KSPayWeb.reResult.value 	= result;
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
</style>
</head>
<body>
<!----------------------------------------------- <Part 1. KSPayWeb Form�� ���� ���� > ---------------------------------------->
<!--���� �Ϸ��� ������� �޾�ó���� ����������� �ּ�-->
<!--KSPAY�� �˾�����â���� ���簡 �̷������ ���ÿ� KSPayRcv.asp�� �����Ǹ鼭 �Ʒ��� value���� ä������ action��η� ���� �����մϴ�-->
<!--action�� ��δ� ����� ������ �Ѵ� ��밡���մϴ� -->
		<form name=KSPayWeb action = "./result.asp" method=post>
<!-- ����� ���� �Ķ����, value���� ä�������ʽÿ�. KSPayRcv.asp�� ����Ǹ鼭 ä���ִ� ���Դϴ�-->
			<input type=hidden name=reAuthyn value="">
			<input type=hidden name=reTrno   value="">
			<input type=hidden name=reTrddt  value="">
			<input type=hidden name=reTrdtm  value="">
			<input type=hidden name=reAuthno value="">
			<input type=hidden name=reOrdno  value="">
			<input type=hidden name=reMsg1   value="">
			<input type=hidden name=reMsg2   value="">
			<input type=hidden name=reAmt    value="">
			<input type=hidden name=reTemp_v value="">
			<input type=hidden name=reIsscd  value="">
			<input type=hidden name=reAqucd  value="">
			<input type=hidden name=reRemark value="">
			<input type=hidden name=reResult value="">
<!--��ü���� �߰��ϰ����ϴ� ������ �Ķ���͸� �Է��ϸ� �˴ϴ�.-->
<!--�� �Ķ���͵��� �����Ȱ�� ������(result.jsp)�� ���۵˴ϴ�.-->
			<input type=hidden name=a        value="a1">
			<input type=hidden name=b        value="b1">
			<input type=hidden name=c        value="c1">
			<input type=hidden name=d        value="d1">
<!--------------------------------------------------------------------------------------------------------------------------->
<table border=0 width=500>
	<tr>
	<td>
	<hr noshade size=1>
	<b>KSPay ���� ����</b>
	<hr noshade size=1>
	</td>
	</tr>
</table>
<br>
<table border=0 width=500>
<tr>
<td align=center>
<table width=400 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=center><font color="#FFFFFF">
������ �����Ͻ� �� ���ҹ�ư�� �����ֽʽÿ�
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=center>
<br>
<table>
<tr>
<!----------------------------------------------- < Part 2. ������ �������� �ʴ� �׸� > ------------------------------------>
<!--�̺κ��� ������ ���� �������� �⺻������ �����ؾ� �ϴ� �κ��Դϴ�.														-->
<!--�� �����Դ� �������� �ȵǴ� �׸��̴� �׽�Ʈ �� ���� hidden���� �������ֽñ� �ٶ��ϴ�.									-->
	<td colspan=2>������ �������� �ʾƾ� �ϴ� ������ �׸�</td>
</tr>
<tr>
<!-- ȭ����� ��ȭ�� ���� : 410 �Ǵ� WON -->
	<td>ȭ����� : </td>
	<td><input type=text name=sndCurrencytype size=30 maxlength=3 value="WON"></td>
</tr>
<tr>
<!--�ֹ���ȣ�� 30Byte(�ѱ� 15��) �Դϴ�. Ư������ ' " - ` �� ����ϽǼ� �����ϴ�. ����ǥ,�ֵ���ǥ,����,�������̼� -->
	<td>�ֹ���ȣ : </td>
	<td><input type=text name=sndOrdernumber size=30 maxlength=30 value="<%=ordernumber%>" readonly></td>
</tr>
<tr>
<!--�ֹε�Ϲ�ȣ�� �ʼ����� �ƴմϴ�.-->
	<td>�ֹι�ȣ : </td>
	<td><input type=text name=sndAllregid size=30 maxlength=30 value="<%=sjumin1%><%=sjumin12%>">	<font color=gray>"-"�� ���� �Է�</font>
</td>
</tr>
<tr>
	<td colspan=2><hr></td></tr>
<tr>
	<td colspan=2>�ſ�ī�� �⺻�׸�</td>
</tr>
<tr>
<!--�������� ������ �Һΰ������� �����մϴ�. ���⼭ �����Ͻ� ���� KSPAY�����˾�â���� ���� ��ũ�Ѽ����ϰ� �˴ϴ� -->
<!--�Ʒ��� ���ǰ�� ���� 0~12������ �Һΰŷ��� �����Ҽ��ְ� �˴ϴ�. -->
	<td>�Һΰ�����  : </td>
	<td><input type=text name=sndInstallmenttype size=30 maxlength=30 value="0:2:3:4:5:6:7:8:9:10:11:12"></td>
</tr>
<tr>
<!--������ ���а��� �߿��մϴ�. ������ �����ϰ� �Ǹ� �����ʿ��� ���ڸ� ���ž��մϴ�.-->
<!--������ �Һθ� �������� �ʴ� ��ü�� value='NONE" �� �Ѱ��ּž� �մϴ�. -->
<!--�� : ��� ������ ������ ���� value="ALL" / ������ �������� ���� value="NONE" -->
<!--�� : 3,4,5,6���� ������ ������ ���� value="3:4:5:6" -->
	<td>�����ڱ���  : </td>
	<td><input type=text name=sndInteresttype size=30 maxlength=30 value="NONE"></td>
</tr>
<tr>
	<td colspan=2><hr></td></tr>
<tr>
<!--�����н�ī�带 ����Ͻô� ������ �Ű澲�ø� �˴ϴ�. ������� �ʴ� ������ �ƹ����̳� �Ѱ��ֽø� �˴ϴ�. ����ø� �ȵ˴ϴ�.-->	
	<td colspan=2>�����н�ī�� �⺻�׸�</td>
</tr>
<tr>
	<TD>��/�ĺ�ī�屸�� :</TD>
	<TD>
			<input type=text    name=sndWptype value="1">
<!--
			<input type="radio" name="sndWptype" value="1" checked>����ī��
			<input type="radio" name="sndWptype" value="2">�ĺ�ī��
			<input type="radio" name="sndWptype" value="0">���ī��             
-->
	</TD>
</TR>
<TR>
	<TD>����Ȯ�ο��� :</TD>
	<TD>
		<input type="text" name="sndAdulttype" value="0">
<!--
		<input type="radio" name="sndAdulttype" value="1" checked>����Ȯ���ʿ�
		<input type="radio" name="sndAdulttype" value="0">����Ȯ�κ��ʿ�   
-->
	</TD>
</tr>
<tr>
	<td colspan=2><hr></td></tr>
<tr>
<!----------------------------------------------- <Part 3. ������ �����ִ� �׸� > ----------------------------------------------->
	<td colspan=2>������ �����ִ� �׸�</td>
</tr>
<tr>
<!--��ǰ���� 30Byte(�ѱ� 15��)�Դϴ�. Ư������ ' " - ` �� ����ϽǼ� �����ϴ�. ����ǥ,�ֵ���ǥ,����,�������̼� -->
	<td>��ǰ�� : </td>
	<td><input type=text name=sndGoodname size=30 maxlength=30 value="<%=goodname%>"></td>
</tr>
<tr>
	<td>���� : </td>
	<td><input type=text name=sndAmount size=30 maxlength=9 value="<%=amount%>" readonly></td>
</tr>
<tr>
	<td>���� : </td>
	<td><input type=text name=sndOrdername size=30 maxlength=20 value="<%=ordername%>"></td>
</tr>
<!--KSPAY���� ���������� ���Ϸ� �����ݴϴ�.(�ſ�ī��ŷ����� �ش�)-->
<tr>
	<td>���ڿ��� : </td>
	<td>
	<input type=text name=sndEmail size=30 maxlength=50 value="<%=email%>">
	</td>
</tr>	
<!--ī��翡 SMS ���񽺸� ����Ͻ� ���� ���ؼ� SMS ���ڸ޼����� ������ �帳�ϴ�.-->
<!--��ȭ��ȣ value ���� ���ڸ� �ְ� ���ֽñ� �ٶ��ϴ�. : '-' �� ���� �ȵ˴ϴ�.-->
<tr>
	<td>�̵���ȭ : </td>
	<td>
	<input type=text name=sndMobile size=30 maxlength=20 value="<%=phoneno%>">	
	<font color=gray>"-"�� ���� �Է�</font>
	</td>
</tr>
<TR>
	<TD conspan='2'>




<!--
<input type="hidden" name="pay_type" onClick="javascript:setPayMethod('1')" value="1">
		if (p_type=='E')
		{
			document.authFrmFrame.sndPaymethod.value = "010000";
			
			var amt = parseInt(document.KSPayWeb.sndAmount.value);
			if (isNaN(amt) || amt < 100000)
			{
				alert("10�����̻��� �����Ͻ� ��쿡 ����ũ�θ� ����Ͻ� �� �ֽ��ϴ�.");
				document.KSPayWeb.pay_type[0].checked = true;
				return false
			}
			
			openKEscrowAgree();
		}else
		if (p_type=='1')
		{
			document.authFrmFrame.sndPaymethod.value = "100000";
		}else
		if (p_type=='2')
		{
			document.authFrmFrame.sndPaymethod.value = "010000";
		}else
		if (p_type=='3')
		{
			document.authFrmFrame.sndPaymethod.value = "001000";
		}else
		if (p_type=='M')
		{
			document.authFrmFrame.sndPaymethod.value = "000001";
		}	
		
		
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('1')" value="1" checked>�ſ�ī��
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('2')" value="2" >�������Ա�
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('3')" value="3" >������ü
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('E')" value="E" >�������Ա�(����ũ��)
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('M')" value="M" >�޴�������
		-->
	</TD>
</tr>
<TR>
	<TD conspan='2'>
		10�����̻� ���ݰ����� �������Ա�(����ũ��)�� �����Ͻø� ��������� �ŷ��Ϸ�ñ��� KSNET���� �����ϰ� ������ �帳�ϴ�.
	</TD>
</tr>
<tr>
	<td colspan=2 align=center>
	<br>

	<input type="button" value=" �� �� " onClick="javascript:goOpen();">
	<br><br>
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
</td>
</tr>
</table>
<br>

<table border=0 width=500>
	<tr>
	<td>
	<font color=gray>
	���ڿ���� �̵���ȭ��ȣ�� �Է¹޴� ���� ������ ���ҳ����� �̸��� �Ǵ� SMS��
	�˷��帮�� �����̿��� �ݵ�� �����Ͽ� �ֽñ� �ٶ��ϴ�.
	</font>
	</td>
	</tr>
	
	<tr>
	<td><hr noshade size=1></td>
	</tr>
</table>
</form>

<!--dummy.asp�� ���Ȱ�� �����ϱ� ���� ���Դϴ�. �������� ������. -->
<IFRAME id=AuthFrame name=AuthFrame style="display:none" src="dummy.asp"></IFRAME>
<div style="display:none"> 
<!----------------------------------------------- <Part 4. authFrmFrame Form�� ���� ���� >----------------------------------------------->
<!-- �������� KSNET �����˾�â���� �����ϴ� �Ķ�����Դϴ�.-->
<form name=authFrmFrame target=AuthFrame method=post>

<!-- �ʱ� �ſ�ī�� �׽�Ʈ ID : 2999199999 / ����ũ�� �׽�Ʈ ID : 2999199998, �׽�Ʈ ���� �� KSPAY���� �߱޹��� ���� �������̵�� �ٲ��ֽʽÿ�.-->
<!-- �׽�Ʈ���̵�� �׽�Ʈ�Ͻ� �� ����ī��� �����ϼŵ� ������ û������ �ʽ��ϴ�. -->
	<input type=hidden name=sndStoreid         value="<%=storeid%>">

<!-- backUrl�� ������� �����ŵ� ������ �ɼǱ���Դϴ�.BackUrl���ϸ���� ��ΰ��� �־��ֽñ� �ٶ��ϴ�. 
�׸��� backurl���� �����͸� ���θ� DB�� ������Ʈ �۾��� �߰��� ���ּž� �մϴ�. -->
	<input type=hidden name=sndBackUrl         value=""> 

<!-- goOpen()���� ����ڰ� ������ URL�� �޾ƿͼ� sndReply�� ���� �����մϴ�.
sndReply�� KSPayRcv.asp(�������� �� ��������� ��â�� KSPayWeb Form�� �Ѱ��ִ� ������)�� �����θ� �־��ݴϴ�. -->
	<input type=hidden name=sndReply           value="">

<!--KSPAY �����˾�â���� ��밡���� ���������� �����մϴ�. �� ��������� ������ ����� �̷���� ���µ��־�� ��밡���մϴ�.-->
<!--�ſ�ī��/�������/������ü/�����н�ī��/����Ʈ/�޴�������-->
<!--�� : �ſ�ī��,�������,�����н�ī�� ���� value="110100' -->


	<input type=hidden name=sndPaymethod       value="<%=s_paytype%>"> <!-- ���� : �ſ�ī��, �������, ������ü, �����н�ī��, OK Cashbag, �޴��� -->
	<input type=hidden name=sndEscrow          value="0">	  <!--����ũ�����뿩��-- 0: �������, 1: ������ -->
 	<input type=hidden name="sndOrdernumber"	   value="">
	<input type=hidden name=sndGoodname        value="">
	<input type=hidden name=madeCompany	       value="">
	<input type=hidden name=madeCountry	       value="">
	<input type=hidden name=sndInstallmenttype value="">
	<input type=hidden name=sndAmount          value="">
	<input type=hidden name=sndOrdername       value="">
	<input type=hidden name=sndAllregid        value="">
	<input type=hidden name=sndEmail           value="">
	<input type=hidden name=sndMobile          value="">
	<input type=hidden name=sndInteresttype    value="">
	<input type=hidden name=sndCurrencytype    value="">
	<input type=hidden name=sndCashbag         value="0">     <!--OK CashBag-- 0: �̻��, 1: ��� -->
	<input type=hidden name=sndWptype          value="">
	<input type=hidden name=sndAdulttype       value="">
	<input type=hidden name=sndStoreName       value="���̿�������(��)">    <!--ȸ����� �ѱ۷� �־��ּ���(�ִ�20byte)-->
	<input type=hidden name=sndStoreNameEng    value="kspay_test_store">   <!--ȸ����� ����� �־��ּ���(�ִ�20byte)-->
	<input type=hidden name=sndStoreDomain     value="http://www.kspay_test.co.kr">   <!-- ȸ�� �������� http://�� �����ؼ� �־��ּ���-->
	<input type=hidden name=sndCertimethod	   value="IM">    <!-- I  : ISP����, M : MPI����, W : �ؿ����� -->
	<input type=hidden name=sndGoodType		   value="1">			<!--�ǹ�(1) / ������(2) -->

</form>
	<script language="javascript" type="text/javascript">
	<!--
		goOpen();
	//-->
	</script>
</div>
</body>
</html>
<!--�� �������� �ִ� ��� �Ķ���ʹ� ����ðų� �����Ͻø� ������ �̷������ �ʽ��ϴ�.-->