<%
	'<!------------------------------------------------
	'���ϸ�				: KSPayCreditFormN.asp
	'���				: ����/��������/MPI�������ο� ī�������Է¿� ������
	'�ۼ���				: 2007-07-04
	'������				: ������
	'------------------------------------------------->

	'VISA3D �������� ��ġ 
	ILK_HOST			 = "https://kspay.ksnet.to/totmpi/veri_host.jsp" 

	'�ſ�ī��������� -  A-�������½���, N-��������, M-Visa3D��������
	certitype			= request.form("certitype")
	authcode			= ""

	'�⺻�ŷ�����
	storeid				= request.form("storeid")				'�������̵�
	storepasswd			= ""									'��������(���)�� �н����� (���Ļ��)
	ordername			= request.form("ordername")				'�ֹ��ڸ�
	ordernumber			= request.form("ordernumber")			'�ֹ���ȣ
	amount				= request.form("amount")				'�ݾ�
	goodname			= request.form("goodname")				'��ǰ��
	idnum				= "1111111111111"						'�ֹι�ȣ(������Ͽ�) �����¾��� ���
	email				= request.form("email")					'�ֹ����̸���
	phoneno				= request.form("phoneno")				'�ֹ����޴�����ȣ
	currencytype		= request.form("currencytype")			'��ȭ���� : "WON" : ��ȭ, "USD" : ��ȭ
	interesttype		= request.form("interesttype")

	select case certitype
		case "A"	authcode = "1000"
		case "N"	authcode = "1300"
		case "M"	authcode = "1000"
		case else	authcode = "1300"
	end select 
%>
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<META HTTP-EQUIV="Pragma" CONTENT="No-cache">

<script language="javascript">
<!--
// ���߽����� ���ɼ��� ���̱� ���� ��� �̺�Ʈ�� ���´�.
document.onmousedown=right;
document.onmousemove=right;

document.onkeypress = processKey;	
document.onkeydown  = processKey;

function processKey() { 
	if((event.ctrlKey == true && (event.keyCode == 8 || event.keyCode == 78 || event.keyCode == 82)) 
		|| ((typeof(event.srcElement.type) == "undefined" || typeof(event.srcElement.name) == "undefined" || event.srcElement.type != "text" || event.srcElement.name != "sndEmail") && event.keyCode >= 112 && event.keyCode <= 123)) {
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

function right(e) {
	if(navigator.appName=='Netscape'&&(e.which==3||e.which==2)){
		alert('���콺 ������ ��ư�� ����Ҽ� �����ϴ�.');
		return;
	}else if(navigator.appName=='Microsoft Internet Explorer'&&(event.button==2||event.button==3)) {
		alert('���콺 ������ ��ư�� ����Ҽ� �����ϴ�.');
		return;
	}
}
-->
</script>

<script language="javascript">
<!--
	/*** Visa3D������ ��ũ��Ʈ ***/

	//��ȿ�Ⱓ�����ϱ�
	function getValue(ym)
	{
		var i = 0;
		var form = document.KSPayAuthForm;

		if( ym == "year" ) {
			while( !form.expyear[i].selected ) i++;
			return form.expyear[i].value;
		} 
		else if( ym == "month" ) {
			while( !form.expmon[i].selected ) i++;
			return form.expmon[i].value;
		}
	}
	
	function getReturnUrl()
	{
		var myloc = location.href;
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/return.asp';	
	}

	// vbv���� ó��- MPI
	function submitV3d()
	{
		var frm = document.Visa3d;
		var realform = document.KSPayAuthForm;

		frm.dummy.value="https://kspay.ksnet.to/totmpi/dummy.jsp";

		SetInstallment(realform);

		//Visa3D������ ��ȿ�Ⱓ�� expiry�� �����Ѵ�(YYMM ���·� �����Ͽ��� �Ѵ�.).
		//frm.expiry.value = getValue("year").substring(2) + getValue("month");
		frm.expiry.value = "4912"; //Vias3D�� ���� "4912"�� ����
		realform.expdt.value = "4912"; //Vias3D�� ���� "4912"�� ����

		var sIndex = realform.selectcard.value;

		// ī��� ���� ���� üũ
		if (sIndex == 0) {
			alert('�����Ͻ� ī��縦 �����Ͻñ� �ٶ��ϴ�.');
			realform.selectcard.focus();
			return;
		}

		frm.instType.value = realform.interest.value;	

		frm.cardcode.value = realform.selectcard.value ;
		frm.pan.value = "" ;

		frm.returnUrl.value = getReturnUrl();
		frm.action = '<%=ILK_HOST%>';
		frm.submit();
	}

	/* ���� ������������ �Ѱ��ִ� form�� xid, eci, cavv, cardno�� �����Ѵ� */
	function paramSet(xid, eci, cavv, cardno)
	{
		var frm = document.KSPayAuthForm;
		frm.xid.value = xid;
		frm.eci.value = eci;
		frm.cavv.value = cavv;
		frm.cardno.value = cardno;
	}

	/* realSubmit�� ������ ���ΰ� �ƴѰ��� �Ǵ��ϴ� �Լ�. �� �Լ��� ȣ���� ���� �������� �ƴ� return.jsp�� �ϰ� �Ǹ�, 
	�������� �޾Ƶξ��� ������ �Ķ���͵�� ���󼭺�����࿩�θ� �޾� ������������ �ǳѰ��ش�. */
	function proceed(arg)
	{
		var frm = document.KSPayAuthForm;
		var xid = frm.xid.value;
		var eci = frm.eci.value;
		var cavv = frm.cavv.value;
		var cardno = frm.cardno.value;

		if((arg == "TRUE"||arg == "true"||arg == true) && check_param(xid, eci, cavv, cardno))
		{
			submitAuth() ;
		}
		else
		{
			alert("Visa3D��������") ;
		}
	}

	function check_param(xid, eci, cavv, cardno)
	{
	
		var ck_mpi = get_cookie("xid_eci_cavv_cardno");
	
		if (ck_mpi == xid + eci + cavv + cardno)
		{
			return false;
		}

		set_cookie("xid_eci_cavv_cardno", xid + eci + cavv + cardno);

		ck_mpi = get_cookie("xid_eci_cavv_cardno");

		return true;
	}

	function get_cookie(strName)
	{
		var strSearch = strName + "=";
		if ( document.cookie.length > 0 )
		{
			iOffset = document.cookie.indexOf( strSearch );
			if ( iOffset != -1 ) 
			{
				iOffset += strSearch.length;
				iEnd = document.cookie.indexOf( ";", iOffset );
				if ( iEnd == -1 )
					iEnd = document.cookie.length;

				return unescape(document.cookie.substring( iOffset, iEnd ));
			}
		}

		return "";
	}

	function set_cookie(strName, strValue) 
	{ 
	
		var strCookie = strName + "=" + escape(strValue);
		document.cookie = strCookie;
	}       

	/*** Visa3D������ ��ũ��Ʈ �� ***/
	
	function submitAuth()
	{
		var frm = document.KSPayAuthForm;
		
		SetInstallment(frm);	

		if (frm.expdt.value != "4912") // Visa3D������ �ƴѰ�츸 ��� , Visa3D�� ���� ������ "4912"�� ����
		{
			frm.expdt.value	= getValue("year").substring(2) + getValue("month");
		}
		frm.action			= "./KSPayCreditPostMNI.asp";
		frm.submit();
	}

	function SetInstallment(form)
	{
	
        	var sInstallment = form.installment.value;
        	var sInteresttype = form.interesttype.value.split(":");
        	
        	sInstallment = (sInstallment != null && sInstallment.length == 2) ? sInstallment.substring(0,2) : "00";
        	
        	if((sInstallment != "00" && sInstallment != "01" && sInstallment != "60" && sInstallment !="61")&& form.amount.value < 50000) {
                	alert("50,000�� �̻� �Һ� �����մϴ�.");
                	form.installment.value = form.installment.options[0].value;
                	form.interestname.value = "";
                	return;
        	}
        	
            if(sInteresttype[0] == "ALL")
        	{
        		if (sInstallment != "00")
        			form.interestname.value = "�������Һ�";
        		else 
        			form.interestname.value = "";
        		
        		form.interest.value = 2;
        		return;
        	}
       	    else if (sInteresttype[0] == "NONE" || sInteresttype[0] == "" || sInteresttype[0].substring(0,1) == " ")
        	{
        		if (sInstallment != "00")
        			form.interestname.value = "�Ϲ��Һ�";
        		else 
        			form.interestname.value = "";
        			
        		form.interest.value = 1;	
        		return;
        	}
        	        
        	for (i=0; i < sInteresttype.length; i++)
        	{
        		if (sInteresttype[i].length == 1) 
        			sInteresttype[i] = "0"+sInteresttype[i];
        		else if (sInteresttype[i].length > 2) 
        			sInteresttype[i] = sInteresttype[i].substring(0,2);
        			
        		        		
        		if (sInteresttype[i] == sInstallment)
        		{
        			if (sInstallment != "00")
        				form.interestname.value = "�������Һ�";
        			else 
        				form.interestname.value = "";
        			
        			form.interest.value = 2;
        			break;
        			
        		}
        		else
        		{
        			if (sInstallment != "00")
        				form.interestname.value = "�Ϲ��Һ�";
        			else 
        				form.interestname.value = "";
        				
        			form.interest.value = 1;
        		}
        	}
	}
-->
</script>
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onFocus="" >

<form name=KSPayAuthForm method=post>
<!--�⺻-------------------------------------------------------------->
<input type=hidden name="storeid"    			value="<%=storeid%>">
<input type=hidden name="storepasswd" 			value="<%=storepasswd%>">
<input type=hidden name="authty" 				value=<%=authcode%>>
<input type=hidden name="certitype" 			value=<%=certitype%>>

<!--�Ϲݽſ�ī��------------------------------------------------------>
<input type=hidden name="expdt"					value="">
<input type=hidden name="email"					value="<%=email%>">
<input type=hidden name="phoneno"				value="<%=phoneno%>">
<input type=hidden name="interest"				value="">
<input type=hidden name="interesttype"			value="<%=interesttype%>">
<input type=hidden name="ordernumber"			value="<%=ordernumber%>">
<input type=hidden name="ordername"				value="<%=ordername%>">
<input type=hidden name="idnum"					value="<%=idnum%>">
<input type=hidden name="goodname"				value="<%=goodname%>">
<input type=hidden name="amount"				value="<%=amount%>">
<input type=hidden name="currencytype"			value="<%=currencytype%>">

<%if certitype = "M" then%>
<input type=hidden name="cardno"	value="">
<%end if%>
<!--Visa3d---------------------------------------------------------------->
<input type="hidden" name="xid"		value="">
<input type="hidden" name="eci"		value="">
<input type="hidden" name="cavv"	value="">
<!--Visa3d---------------------------------------------------------------->


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
		case "M"	response.write("(M-Visa3D��������)") 
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

<!-- Visa3d ���������̸� Visa3d ���� ��ũ��Ʈ�� ����Ѵ� -->
<%if certitype = "M" then%>
<tr>
	<td>�ſ�ī������ :</td>
	<td>
		<select name="selectcard">
			<option value="0" selected>ī�带 �����ϼ���</option>
			<option value="1">��ȯī��</option>
			<option value="2">�Ｚī��</option>
			<option value="4">����ī��</option>
			<option value="5">�Ե�ī��</option>
			<option value="6">����ī��</option>
			<option value="7">��Ƽ(�ѹ�)ī��</option>
			<option value="8">����ī��</option>			
			<option value="9">����ī��</option>
			<option value="10">����ī��</option>
			<option value="11">�ϳ�ī��</option>
			<option value="12">����ī��</option>
			<option value="13">����ī��</option>
			<option value="14">����ī��</option>
		</select>
	</td>
</tr>
<%end if%>

<!--Visa3D�� �ƴҶ� ��ȿ�Ⱓ�� ����.-->
<%if certitype = "N" or certitype = "A" then%>
<tr>
	<td>�ſ�ī�� :</td>
	<td>
		<input type=text name=cardno size=20 maxlength=16 value="">
	</td>
</tr>
<tr>
	<td>��ȿ�Ⱓ :</td>
	<td>
		<select name="expyear">
<%
Dim dyear
dyear = CInt(Year(Date)) 
		   
for i=dyear to ( dyear + 15 )
	Response.Write "<option value= " & i & ">" & i & "</option>" 
Next
%>
		</select>��/
		<select name="expmon">
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12" selected>12</option>
		</select>��
	</td>
</tr>

<%end if%>

<tr>
	<td>�Һ� :</td>
	<td>
		<select name="installment" onchange="return SetInstallment(this.form);">
			<option value="00" selected>�Ͻú�</option>
			<option value="02">02����</option>
			<option value="03">03����</option>
			<option value="04">04����</option>
			<option value="05">05����</option>
			<option value="06">06����</option>
			<option value="07">07����</option>
			<option value="08">08����</option>
			<option value="09">09����</option>
			<option value="10">10����</option>
			<option value="11">11����</option>
			<option value="12">12����</option>
		</select>
		&nbsp;
		    <input type=text name=interestname size="10" readonly value="" style="border:0px" >
	</td>
</tr>

<!-- Visa3d ���������̸� Visa3d ���� ��ũ��Ʈ�� ����Ѵ� -->
<%if certitype = "M" then%>
	<input type=hidden name=lastidnum value="">
	<input type=hidden name=passwd value="">
<tr>
	<td colspan=2 align=center>
			<input type=button onclick="javascript:submitV3d()" value="Visa3d ��������">
	</td>
</tr>
<%end if%>
<!-- �Ϲ���������-->
<%if certitype = "N" then%>
<tr>
	<td>�ֹι�ȣ :</td>
	<td>
		XXXXXX - <input type=text name=lastidnum size=10 maxlength=7 value="">
	</td>
</tr>
<tr>
	<td>��й�ȣ :</td>
	<td><input type=password name=passwd size=4 maxlength=2 value="">XX</td>
</tr>
<tr>
	<td colspan=2 align=center>
		<input type=button onclick="javascript:submitAuth()" value="�Ϲ���������">
	</td>
</tr>
<%end if%>
<!-- �������½���-->
<%if certitype = "A" then%>
	<input type=hidden name=lastidnum value="">
	<input type=hidden name=passwd value="">
<tr>
	<td colspan=2 align=center>
		<input type=button onclick="javascript:submitAuth()" value="�������½���">
	</td>
</tr>
<%end if%>

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
<!------------------------------------ ILK Modification --------------------------------------------->
<!-----------------------------------------------------------------------------------------------
	�߿�!!!
	IFrame�� src�� ������ �ƹ��͵� ���� dummy.jsp�� �ִ� ���� https �� SSL�� ������ �̷������ ���
	���� ������ �ε�� ���Ȱ��� �޽����� �ߴ� ���� �����ϱ� �����̴�.
	�� �κ� ������ "���ȵ��� �ʴ� �׸� ǥ���Ͻðڽ��ϱ�?" ��� �޽����� �߹Ƿ� ����.
------------------------------------------------------------------------------------------------->

<!--Visa3d������ ���� ���ڵ�-->
<IFRAME id=ILKFRAME name=ILKFRAME style="display:none" src="https://kspay.ksnet.to/totmpi/dummy.jsp"></IFRAME>
<%
    if currencytype = "WON" or currencytype = null or currencytype = "" then currencytype = "410" end if		'��ȭ
    if currencytype = "USD" then currencytype = "840" end if									'��ȭ
%>
<div style="display:none"> 
<FORM name=Visa3d action="<%=ILK_HOST%>"  target="ILKFRAME" method=post>
   <INPUT type="hidden"		name=pan				value=""		size="19" maxlength="19">
   <INPUT type="hidden"		name=expiry				value=""		size="6"  maxlength="6">
   <INPUT type="hidden"		name=purchase_amount	value="<%=amount%>"	size="20" maxlength="20">
   <INPUT type="hidden"		name=amount				value="<%=amount%>"	size="20" maxlength="20">
   <INPUT type="hidden"		name=description		value="none"		size="80" maxlength="80">
   <INPUT type="hidden"		name=currency			value="<%=currencytype%>"	size="3"  maxlength="3"	>
   <INPUT type="hidden"		name=recur_frequency	value=""		size="4"  maxlength="4"	>
   <INPUT type="hidden"		name=recur_expiry		value=""		size="8"  maxlength="8"	>
   <INPUT type="hidden"		name=installments		value=""		size="4"  maxlength="4"	>   
   <INPUT type="hidden"		name=device_category	value="0"		size="20" maxlength="20">
   <INPUT type="hidden"		name="name"				value="test store"	size="20">	<!--ȸ����� ����� �־��ּ���(�ִ�20byte)-->
   <INPUT type="hidden"		name="url"				value="http://www.store.com"	size="20">	<!-- ȸ�� �������� http://�� �����ؼ� �־��ּ���-->
   <INPUT type="hidden"		name="country"			value="410"		size="20">
   <INPUT type="password"	name="dummy"			value="">
   <INPUT type="hidden"		name="returnUrl"		value="">						<!--Visa3d������ ����������� ������-->
   <input type="hidden"		name=cardcode			value="">
   <input type="hidden"		name="merInfo"			value="<%=storeid%>">
   <input type="hidden"		name="bizNo"			value="1208197322">
   <input type="hidden"		name="instType"			value="">
</FORM>
</div>
<!------------------------------------ ILK Modification end ----------------------------------------->
</body>
</html>