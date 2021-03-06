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
/*ISP인경우 무이자구분은 별도로 KSpayCreditFormI.jsp 에서 세팅하게됩니다.*/
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

/*각 인증방식별 카드정보 입력페이지로 이동*/
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
<input type="hidden" name="storeid" value="<%=storeid%>" maxlength="10"><!--상점ID(storeid) : //-->
<INPUT TYPE="hidden" NAME="currencytype" value="<%=currencytype%>" checked><!-- 통화구분(currencytype) : WON : WON-원화, USD : USD-미화 //-->
<input type="hidden" name="interesttype" value="<%=interesttype%>" maxlength="25"><!-- 무이자할부구분(interesttype):무이자 안함 "NONE"<br>3,6,9개월 무이자 "3:6:9"<br>전체월 무이자 "ALL" //-->

<table width=320 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드거래용 기본거래정보
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>거래종류(certitype) :</td>
	<td>
	<INPUT TYPE="radio" NAME="certitype" value="M" checked>M-Visa3D인증승인<br> 삼성/신한/현대/신한/씨티/하나/한미/롯데/외환/수협/광주/전북<br>
	<INPUT TYPE="radio" NAME="certitype" value="I">I-ISP인증승인<br> 비씨/국민/우리(구평화)/저축은행<br>
	<INPUT TYPE="radio" NAME="certitype" value="N">N-일반인증승인<br> 농협(구축협)<br>
	<INPUT TYPE="radio" NAME="certitype" value="A">A-인증없는승인<br> 해외카드<br>
	</td>
</tr>



<tr>
	<td>주문자명 :</td>
	<td><%=ordername%><input type="hidden" name="ordername" value="<%=ordername%>" maxlength="25"></td>
</tr>
<tr>
	<td>주문번호 :</td>
	<td><%=ordernumber%><input type="hidden" name="ordernumber" value="<%=ordernumber%>" maxlength="50"></td>
</tr>
<tr>
	<td>금액 :</td>
	<td><%=amount%><input type="hidden" name="amount" value="<%=amount%>" maxlength="9"></td>
</tr>
<tr>
	<td>상품명 :</td>
	<td><%=goodname%><input type="hidden" name="goodname" value="<%=goodname%>" maxlength="25"></td>
</tr>
<tr>
	<td>주문자E-mail<br><font size="2">(승인메일발송용)</font> :</td>
	<td><input type="text" name="email" value="<%=email%>" maxlength="25"></td>
</tr>
<tr>
	<td>주문자휴대폰 : </td>
	<td><input type="text" name="phoneno" value="<%=phoneno%>" maxlength="25"></td>
</tr>

		

<div>
<tr><td colspan=2 align=center><HR></td></tr>
<tr>
<td colspan=2 align=center>
	<input type="button" name="gotoFrm" size=40 value="결제요청" onClick="_submit(this.form);">
</td>
</tr>

</table></tr></table></td></tr></table></td></tr>
</table>
</form>
</body>
</html>