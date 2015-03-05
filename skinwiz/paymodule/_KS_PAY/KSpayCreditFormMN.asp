<%
	'<!------------------------------------------------
	'파일명				: KSPayCreditFormN.asp
	'기능				: 승인/인증승인/MPI인증승인용 카드정보입력용 페이지
	'작성일				: 2007-07-04
	'수정자				: 문선영
	'------------------------------------------------->

	'VISA3D 인증서버 위치 
	ILK_HOST			 = "https://kspay.ksnet.to/totmpi/veri_host.jsp" 

	'신용카드승인종류 -  A-인증없는승인, N-인증승인, M-Visa3D인증승인
	certitype			= request.form("certitype")
	authcode			= ""

	'기본거래정보
	storeid				= request.form("storeid")				'상점아이디
	storepasswd			= ""									'상점승인(취소)용 패스워드 (추후사용)
	ordername			= request.form("ordername")				'주문자명
	ordernumber			= request.form("ordernumber")			'주문번호
	amount				= request.form("amount")				'금액
	goodname			= request.form("goodname")				'상품명
	idnum				= "1111111111111"						'주민번호(정보등록용) 하이픈없이 등록
	email				= request.form("email")					'주문자이메일
	phoneno				= request.form("phoneno")				'주문자휴대폰번호
	currencytype		= request.form("currencytype")			'통화구분 : "WON" : 원화, "USD" : 미화
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
// 이중승인의 가능성을 줄이기 위해 몇가지 이벤트를 막는다.
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
		alert('마우스 오른쪽 버튼을 사용할수 없습니다.');
		return;
	}else if(navigator.appName=='Microsoft Internet Explorer'&&(event.button==2||event.button==3)) {
		alert('마우스 오른쪽 버튼을 사용할수 없습니다.');
		return;
	}
}
-->
</script>

<script language="javascript">
<!--
	/*** Visa3D인증용 스크립트 ***/

	//유효기간추출하기
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

	// vbv결제 처리- MPI
	function submitV3d()
	{
		var frm = document.Visa3d;
		var realform = document.KSPayAuthForm;

		frm.dummy.value="https://kspay.ksnet.to/totmpi/dummy.jsp";

		SetInstallment(realform);

		//Visa3D인증용 유효기간을 expiry에 세팅한다(YYMM 형태로 세팅하여야 한다.).
		//frm.expiry.value = getValue("year").substring(2) + getValue("month");
		frm.expiry.value = "4912"; //Vias3D의 경우는 "4912"로 세팅
		realform.expdt.value = "4912"; //Vias3D의 경우는 "4912"로 세팅

		var sIndex = realform.selectcard.value;

		// 카드사 선택 여부 체크
		if (sIndex == 0) {
			alert('결제하실 카드사를 선택하시기 바랍니다.');
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

	/* 실제 승인페이지로 넘겨주는 form에 xid, eci, cavv, cardno를 세팅한다 */
	function paramSet(xid, eci, cavv, cardno)
	{
		var frm = document.KSPayAuthForm;
		frm.xid.value = xid;
		frm.eci.value = eci;
		frm.cavv.value = cavv;
		frm.cardno.value = cardno;
	}

	/* realSubmit을 진행할 것인가 아닌가를 판단하는 함수. 이 함수의 호출은 승인 페이지가 아닌 return.jsp로 하게 되며, 
	페이지가 받아두었던 인증값 파라메터들과 리얼서브밋진행여부를 받아 승인페이지로 되넘겨준다. */
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
			alert("Visa3D인증실패") ;
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

	/*** Visa3D인증용 스크립트 끝 ***/
	
	function submitAuth()
	{
		var frm = document.KSPayAuthForm;
		
		SetInstallment(frm);	

		if (frm.expdt.value != "4912") // Visa3D결제가 아닌경우만 사용 , Visa3D의 경우는 위에서 "4912"로 세팅
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
                	alert("50,000원 이상만 할부 가능합니다.");
                	form.installment.value = form.installment.options[0].value;
                	form.interestname.value = "";
                	return;
        	}
        	
            if(sInteresttype[0] == "ALL")
        	{
        		if (sInstallment != "00")
        			form.interestname.value = "무이자할부";
        		else 
        			form.interestname.value = "";
        		
        		form.interest.value = 2;
        		return;
        	}
       	    else if (sInteresttype[0] == "NONE" || sInteresttype[0] == "" || sInteresttype[0].substring(0,1) == " ")
        	{
        		if (sInstallment != "00")
        			form.interestname.value = "일반할부";
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
        				form.interestname.value = "무이자할부";
        			else 
        				form.interestname.value = "";
        			
        			form.interest.value = 2;
        			break;
        			
        		}
        		else
        		{
        			if (sInstallment != "00")
        				form.interestname.value = "일반할부";
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
<!--기본-------------------------------------------------------------->
<input type=hidden name="storeid"    			value="<%=storeid%>">
<input type=hidden name="storepasswd" 			value="<%=storepasswd%>">
<input type=hidden name="authty" 				value=<%=authcode%>>
<input type=hidden name="certitype" 			value=<%=certitype%>>

<!--일반신용카드------------------------------------------------------>
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
KSPay 신용카드 승인&nbsp;
<%
	select case certitype
		case "A"	response.write("(인증없는승인)") 
		case "N"	response.write("(인증승인)") 
		case "M"	response.write("(M-Visa3D인증승인)") 
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
	<td>상품명 :</td>
	<td><%=goodname%></td>
</tr>
<tr>
	<td>금액 :</td>
	<td><%=amount%></td>
</tr>
<tr>
	<td colspan=3><hr noshade size=1></td>
</tr>

<!-- Visa3d 인증승인이면 Visa3d 인증 스크립트를 사용한다 -->
<%if certitype = "M" then%>
<tr>
	<td>신용카드종류 :</td>
	<td>
		<select name="selectcard">
			<option value="0" selected>카드를 선택하세요</option>
			<option value="1">외환카드</option>
			<option value="2">삼성카드</option>
			<option value="4">현대카드</option>
			<option value="5">롯데카드</option>
			<option value="6">신한카드</option>
			<option value="7">씨티(한미)카드</option>
			<option value="8">수협카드</option>			
			<option value="9">광주카드</option>
			<option value="10">전북카드</option>
			<option value="11">하나카드</option>
			<option value="12">산은카드</option>
			<option value="13">제주카드</option>
			<option value="14">농협카드</option>
		</select>
	</td>
</tr>
<%end if%>

<!--Visa3D가 아닐때 유효기간을 세팅.-->
<%if certitype = "N" or certitype = "A" then%>
<tr>
	<td>신용카드 :</td>
	<td>
		<input type=text name=cardno size=20 maxlength=16 value="">
	</td>
</tr>
<tr>
	<td>유효기간 :</td>
	<td>
		<select name="expyear">
<%
Dim dyear
dyear = CInt(Year(Date)) 
		   
for i=dyear to ( dyear + 15 )
	Response.Write "<option value= " & i & ">" & i & "</option>" 
Next
%>
		</select>년/
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
		</select>월
	</td>
</tr>

<%end if%>

<tr>
	<td>할부 :</td>
	<td>
		<select name="installment" onchange="return SetInstallment(this.form);">
			<option value="00" selected>일시불</option>
			<option value="02">02개월</option>
			<option value="03">03개월</option>
			<option value="04">04개월</option>
			<option value="05">05개월</option>
			<option value="06">06개월</option>
			<option value="07">07개월</option>
			<option value="08">08개월</option>
			<option value="09">09개월</option>
			<option value="10">10개월</option>
			<option value="11">11개월</option>
			<option value="12">12개월</option>
		</select>
		&nbsp;
		    <input type=text name=interestname size="10" readonly value="" style="border:0px" >
	</td>
</tr>

<!-- Visa3d 인증승인이면 Visa3d 인증 스크립트를 사용한다 -->
<%if certitype = "M" then%>
	<input type=hidden name=lastidnum value="">
	<input type=hidden name=passwd value="">
<tr>
	<td colspan=2 align=center>
			<input type=button onclick="javascript:submitV3d()" value="Visa3d 인증승인">
	</td>
</tr>
<%end if%>
<!-- 일반인증승인-->
<%if certitype = "N" then%>
<tr>
	<td>주민번호 :</td>
	<td>
		XXXXXX - <input type=text name=lastidnum size=10 maxlength=7 value="">
	</td>
</tr>
<tr>
	<td>비밀번호 :</td>
	<td><input type=password name=passwd size=4 maxlength=2 value="">XX</td>
</tr>
<tr>
	<td colspan=2 align=center>
		<input type=button onclick="javascript:submitAuth()" value="일반인증승인">
	</td>
</tr>
<%end if%>
<!-- 인증없는승인-->
<%if certitype = "A" then%>
	<input type=hidden name=lastidnum value="">
	<input type=hidden name=passwd value="">
<tr>
	<td colspan=2 align=center>
		<input type=button onclick="javascript:submitAuth()" value="인증없는승인">
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
	중요!!!
	IFrame의 src를 내용이 아무것도 없는 dummy.jsp로 주는 것은 https 즉 SSL로 결제가 이루어지는 경우
	현재 페이지 로드시 보안관련 메시지가 뜨는 것을 방지하기 위함이다.
	이 부분 삭제시 "보안되지 않는 항목도 표시하시겠습니까?" 라는 메시지가 뜨므로 주의.
------------------------------------------------------------------------------------------------->

<!--Visa3d인증에 사용될 인자들-->
<IFRAME id=ILKFRAME name=ILKFRAME style="display:none" src="https://kspay.ksnet.to/totmpi/dummy.jsp"></IFRAME>
<%
    if currencytype = "WON" or currencytype = null or currencytype = "" then currencytype = "410" end if		'미화
    if currencytype = "USD" then currencytype = "840" end if									'원화
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
   <INPUT type="hidden"		name="name"				value="test store"	size="20">	<!--회사명을 영어로 넣어주세요(최대20byte)-->
   <INPUT type="hidden"		name="url"				value="http://www.store.com"	size="20">	<!-- 회사 도메인을 http://를 포함해서 넣어주세요-->
   <INPUT type="hidden"		name="country"			value="410"		size="20">
   <INPUT type="password"	name="dummy"			value="">
   <INPUT type="hidden"		name="returnUrl"		value="">						<!--Visa3d인증후 결과값을받을 페이지-->
   <input type="hidden"		name=cardcode			value="">
   <input type="hidden"		name="merInfo"			value="<%=storeid%>">
   <input type="hidden"		name="bizNo"			value="1208197322">
   <input type="hidden"		name="instType"			value="">
</FORM>
</div>
<!------------------------------------ ILK Modification end ----------------------------------------->
</body>
</html>