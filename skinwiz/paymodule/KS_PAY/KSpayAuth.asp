<%@ codepage="949" language="VBScript" %>
<%
Dim storeid, ordername, ordernumber, amount, goodname, phoneno, currencytype, interesttype

storeid			= Request("storeid")		
ordername		= unescape(Request("ordername"))
email			= Request("email")
ordernumber		= Request("ordernumber")
amount			= Request("amount")
goodname		= unescape(Request("goodname"))
phoneno			= Request("phoneno")
currencytype	= Request("currencytype")
interesttype	= Request("interesttype")

%>
<html>
<head>
<title>KSPayAuth</title>
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
/*ISP�ΰ�� �����ڱ����� ������ KSpayCreditFormI.jsp ���� �����ϰԵ˴ϴ�.*/
function interest_lock(arg)
{
	if(arg == 'I')	 
	{
		interest_opt.style.visibility = "hidden" ;
		interest_opt_t.style.visibility = "hidden" ;
	}
	else 
	{
		interest_opt.style.visibility = "visible" ;
		interest_opt_t.style.visibility = "visible" ;
	}
}

/*�� ������ĺ� ī������ �Է��������� �̵�*/
function _submit(frm)
{
	for(var i=0 ; i<frm.certitype.length ; i++)
	{
		if(frm.certitype[i].checked == true)
		{
			if(frm.certitype[i].value == "I")
			{
				frm.action = "KSPayCreditFormI.asp"
				frm.submit() ;
				return true ;
			}
			else
			{
				frm.action = "KSpayCreditFormMN.asp"
				frm.submit() ;
				return true ;		
			}
		}
	}

}
-->
</script>
</head>

<body onLoad="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<form name="KSpayAuth" method="post">
<input type="hidden" name="storeid" value="<%=storeid%>" maxlength="10"><!--����ID(storeid) : //-->
<INPUT TYPE="hidden" NAME="currencytype" value="<%=currencytype%>" checked><!-- ��ȭ����(currencytype) : WON : WON-��ȭ, USD : USD-��ȭ //-->
<input type="hidden" name="interesttype" value="<%=interesttype%>" maxlength="25"><!-- �������Һα���(interesttype):������ ���� "NONE"<br>3,6,9���� ������ "3:6:9"<br>��ü�� ������ "ALL" //-->

<table width=320 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay �ſ�ī��ŷ��� �⺻�ŷ�����
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>�ŷ�����(certitype) :</td>
	<td>
	<INPUT TYPE="radio" NAME="certitype" value="M" checked>M-Visa3D��������<br> �Ｚ/����/����/����/��Ƽ/�ϳ�/�ѹ�/�Ե�/��ȯ/����/����/����<br>
	<INPUT TYPE="radio" NAME="certitype" value="I">I-ISP��������<br> ��/����/�츮(����ȭ)/��������<br>
	<INPUT TYPE="radio" NAME="certitype" value="N">N-�Ϲ���������<br> ����(������)<br>
	<INPUT TYPE="radio" NAME="certitype" value="A">A-�������½���<br> �ؿ�ī��<br>
	</td>
</tr>



<tr>
	<td>�ֹ��ڸ� :</td>
	<td><%=ordername%><input type="hidden" name="ordername" value="<%=ordername%>" maxlength="25"></td>
</tr>
<tr>
	<td>�ֹ���ȣ :</td>
	<td><%=ordernumber%><input type="hidden" name="ordernumber" value="<%=ordernumber%>" maxlength="50"></td>
</tr>
<tr>
	<td>�ݾ� :</td>
	<td><%=amount%><input type="hidden" name="amount" value="<%=amount%>" maxlength="9"></td>
</tr>
<tr>
	<td>��ǰ�� :</td>
	<td><%=goodname%><input type="hidden" name="goodname" value="<%=goodname%>" maxlength="25"></td>
</tr>
<tr>
	<td>�ֹ���E-mail<br><font size="2">(���θ��Ϲ߼ۿ�)</font> :</td>
	<td><input type="text" name="email" value="<%=email%>" maxlength="25"></td>
</tr>
<tr>
	<td>�ֹ����޴��� : </td>
	<td><input type="text" name="phoneno" value="<%=phoneno%>" maxlength="25"></td>
</tr>

		

<div>
<tr><td colspan=2 align=center><HR></td></tr>
<tr>
<td colspan=2 align=center>
	<input type="button" name="gotoFrm" size=40 value="������û" onClick="_submit(this.form);">
</td>
</tr>

</table></tr></table></td></tr></table></td></tr>
</table>
</form>
</body>
</html>