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
  '이페이지는 kspay통합결재창으로 기본거래정보를 넘겨주는 역할을 하는 샘플페이지입니다.
'---------------------------------------------------------------------------------%>
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="javascript">
<!--
	/*goOpen() - 함수설명 : 결재에 필요한 기본거래정보들을 세팅하고 kspay통합창을 띄웁니다.*/
	function goOpen() 
	{
		/*kspay통합창에 전달해줄 인자값들을 세팅합니다.*/
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
		
		/*kspay통합창을 띄워줍니다.*/
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

	/*에스크로 약관에 대해 동의여부를 선택하도록 합니다. */
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
		/* 약관 동의 창을 호출 - KEscrowRcv.html(파일 확장자는 변경가능, 파일 명은 변경 불가능)*/
		if(ptc.toLowerCase()=="http")
		{
			escrow_url="http://kspay.ksnet.to/store/KSPayWebV1.3/vaccount/kscrow_agree.jsp?sndEscrowReply=" + getLocalUrl("KEscrowRcv.html");
		}
		else
		{
			escrow_url="https://kspay.ksnet.to/store/KSPayWebV1.3/vaccount/kscrow_agree.jsp?sndEscrowReply=" + getLocalUrl("KEscrowRcv.html");
		}		
		/*kspay통합창을 띄워줍니다.*/
		src = window.open(escrow_url,'AuthFrmUp',
		        'height='+height_+',width='+width_+',status=yes,scrollbars=no,resizable=no,left='+left_+',top='+top_+'');
	}

	/* 에스크로 적용된 거래에 대해 선택시  */
	function setPayMethod(p_type)
	{
		if (p_type=='E')
		{
			document.authFrmFrame.sndPaymethod.value = "010000";
			
			var amt = parseInt(document.KSPayWeb.sndAmount.value);
			if (isNaN(amt) || amt < 100000)
			{
				alert("10만원이상을 결제하실 경우에 에스크로를 사용하실 수 있습니다.");
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
	
	/*goResult() - 함수설명 : 결재완료후 결과값을 지정된 결과페이지(result.asp)로 전송합니다.*/
	function goResult(){
		document.KSPayWeb.target = "";
		document.KSPayWeb.submit();
	}
	
	/*paramSet() - 함수설명 : 결재완료후 (KSPayRcv.asp로부터)결과값을 받아 지정된 결과페이지(result.asp)로 전송될 form에 세팅합니다.*/
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
<!----------------------------------------------- <Part 1. KSPayWeb Form에 대한 설명 > ---------------------------------------->
<!--결제 완료후 결과값을 받아처리할 결과페이지의 주소-->
<!--KSPAY의 팝업결제창에서 결재가 이루어짐과 동시에 KSPayRcv.asp가 구동되면서 아래의 value값이 채워지고 action경로로 값을 전달합니다-->
<!--action의 경로는 상대경로 절대경로 둘다 사용가능합니다 -->
		<form name=KSPayWeb action = "./result.asp" method=post>
<!-- 결과값 수신 파라메터, value값을 채우지마십시오. KSPayRcv.asp가 실행되면서 채워주는 값입니다-->
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
<!--업체에서 추가하고자하는 임의의 파라미터를 입력하면 됩니다.-->
<!--이 파라메터들은 지정된결과 페이지(result.jsp)로 전송됩니다.-->
			<input type=hidden name=a        value="a1">
			<input type=hidden name=b        value="b1">
			<input type=hidden name=c        value="c1">
			<input type=hidden name=d        value="d1">
<!--------------------------------------------------------------------------------------------------------------------------->
<table border=0 width=500>
	<tr>
	<td>
	<hr noshade size=1>
	<b>KSPay 지불 샘플</b>
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
정보를 기입하신 후 지불버튼을 눌러주십시오
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
<!----------------------------------------------- < Part 2. 고객에게 보여지지 않는 항목 > ------------------------------------>
<!--이부분은 결제를 위해 상점에서 기본정보를 세팅해야 하는 부분입니다.														-->
<!--단 고객에게는 보여지면 안되는 항목이니 테스트 후 필히 hidden으로 변경해주시길 바랍니다.									-->
	<td colspan=2>고객에게 보여지지 않아야 하는 설정값 항목</td>
</tr>
<tr>
<!-- 화폐단위 원화로 설정 : 410 또는 WON -->
	<td>화폐단위 : </td>
	<td><input type=text name=sndCurrencytype size=30 maxlength=3 value="WON"></td>
</tr>
<tr>
<!--주문번호는 30Byte(한글 15자) 입니다. 특수문자 ' " - ` 는 사용하실수 없습니다. 따옴표,쌍따옴표,빼기,백쿼테이션 -->
	<td>주문번호 : </td>
	<td><input type=text name=sndOrdernumber size=30 maxlength=30 value="<%=ordernumber%>" readonly></td>
</tr>
<tr>
<!--주민등록번호는 필수값이 아닙니다.-->
	<td>주민번호 : </td>
	<td><input type=text name=sndAllregid size=30 maxlength=30 value="<%=sjumin1%><%=sjumin12%>">	<font color=gray>"-"는 빼고 입력</font>
</td>
</tr>
<tr>
	<td colspan=2><hr></td></tr>
<tr>
	<td colspan=2>신용카드 기본항목</td>
</tr>
<tr>
<!--상점에서 적용할 할부개월수를 세팅합니다. 여기서 세팅하신 값은 KSPAY결재팝업창에서 고객이 스크롤선택하게 됩니다 -->
<!--아래의 예의경우 고객은 0~12개월의 할부거래를 선택할수있게 됩니다. -->
	<td>할부개월수  : </td>
	<td><input type=text name=sndInstallmenttype size=30 maxlength=30 value="0:2:3:4:5:6:7:8:9:10:11:12"></td>
</tr>
<tr>
<!--무이자 구분값은 중요합니다. 무이자 선택하게 되면 상점쪽에서 이자를 내셔야합니다.-->
<!--무이자 할부를 적용하지 않는 업체는 value='NONE" 로 넘겨주셔야 합니다. -->
<!--예 : 모두 무이자 적용할 때는 value="ALL" / 무이자 미적용할 때는 value="NONE" -->
<!--예 : 3,4,5,6개월 무이자 적용할 때는 value="3:4:5:6" -->
	<td>무이자구분  : </td>
	<td><input type=text name=sndInteresttype size=30 maxlength=30 value="NONE"></td>
</tr>
<tr>
	<td colspan=2><hr></td></tr>
<tr>
<!--월드패스카드를 사용하시는 상점만 신경쓰시면 됩니다. 사용하지 않는 상점은 아무값이나 넘겨주시면 됩니다. 지우시면 안됩니다.-->	
	<td colspan=2>월드패스카드 기본항목</td>
</tr>
<tr>
	<TD>선/후불카드구분 :</TD>
	<TD>
			<input type=text    name=sndWptype value="1">
<!--
			<input type="radio" name="sndWptype" value="1" checked>선불카드
			<input type="radio" name="sndWptype" value="2">후불카드
			<input type="radio" name="sndWptype" value="0">모든카드             
-->
	</TD>
</TR>
<TR>
	<TD>성인확인여부 :</TD>
	<TD>
		<input type="text" name="sndAdulttype" value="0">
<!--
		<input type="radio" name="sndAdulttype" value="1" checked>성인확인필요
		<input type="radio" name="sndAdulttype" value="0">성인확인불필요   
-->
	</TD>
</tr>
<tr>
	<td colspan=2><hr></td></tr>
<tr>
<!----------------------------------------------- <Part 3. 고객에게 보여주는 항목 > ----------------------------------------------->
	<td colspan=2>고객에게 보여주는 항목</td>
</tr>
<tr>
<!--상품명은 30Byte(한글 15자)입니다. 특수문자 ' " - ` 는 사용하실수 없습니다. 따옴표,쌍따옴표,빼기,백쿼테이션 -->
	<td>상품명 : </td>
	<td><input type=text name=sndGoodname size=30 maxlength=30 value="<%=goodname%>"></td>
</tr>
<tr>
	<td>가격 : </td>
	<td><input type=text name=sndAmount size=30 maxlength=9 value="<%=amount%>" readonly></td>
</tr>
<tr>
	<td>성명 : </td>
	<td><input type=text name=sndOrdername size=30 maxlength=20 value="<%=ordername%>"></td>
</tr>
<!--KSPAY에서 결제정보를 메일로 보내줍니다.(신용카드거래에만 해당)-->
<tr>
	<td>전자우편 : </td>
	<td>
	<input type=text name=sndEmail size=30 maxlength=50 value="<%=email%>">
	</td>
</tr>	
<!--카드사에 SMS 서비스를 등록하신 고객에 한해서 SMS 문자메세지를 전송해 드립니다.-->
<!--전화번호 value 값에 숫자만 넣게 해주시길 바랍니다. : '-' 가 들어가면 안됩니다.-->
<tr>
	<td>이동전화 : </td>
	<td>
	<input type=text name=sndMobile size=30 maxlength=20 value="<%=phoneno%>">	
	<font color=gray>"-"는 빼고 입력</font>
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
				alert("10만원이상을 결제하실 경우에 에스크로를 사용하실 수 있습니다.");
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
		
		
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('1')" value="1" checked>신용카드
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('2')" value="2" >무통장입금
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('3')" value="3" >계좌이체
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('E')" value="E" >무통장입금(에스크로)
		<br>
		<input type="radio" name="pay_type" onClick="javascript:setPayMethod('M')" value="M" >휴대폰결제
		-->
	</TD>
</tr>
<TR>
	<TD conspan='2'>
		10만원이상 현금결제시 무통장입금(에스크로)를 선택하시면 결제대금을 거래완료시까지 KSNET에서 안전하게 보관해 드립니다.
	</TD>
</tr>
<tr>
	<td colspan=2 align=center>
	<br>

	<input type="button" value=" 지 불 " onClick="javascript:goOpen();">
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
	전자우편과 이동전화번호를 입력받는 것은 귀하의 지불내역을 이메일 또는 SMS로
	알려드리기 위함이오니 반드시 기입하여 주시기 바랍니다.
	</font>
	</td>
	</tr>
	
	<tr>
	<td><hr noshade size=1></td>
	</tr>
</table>
</form>

<!--dummy.asp는 보안경고를 방지하기 위한 것입니다. 수정하지 마세요. -->
<IFRAME id=AuthFrame name=AuthFrame style="display:none" src="dummy.asp"></IFRAME>
<div style="display:none"> 
<!----------------------------------------------- <Part 4. authFrmFrame Form에 대한 설명 >----------------------------------------------->
<!-- 상점에서 KSNET 결제팝업창으로 전송하는 파라메터입니다.-->
<form name=authFrmFrame target=AuthFrame method=post>

<!-- 초기 신용카드 테스트 ID : 2999199999 / 에스크로 테스트 ID : 2999199998, 테스트 종료 후 KSPAY에서 발급받은 실제 상점아이디로 바꿔주십시오.-->
<!-- 테스트아이디로 테스트하실 때 실제카드로 결제하셔도 고객에게 청구되지 않습니다. -->
	<input type=hidden name=sndStoreid         value="<%=storeid%>">

<!-- backUrl은 사용하지 않으셔도 무방한 옵션기능입니다.BackUrl파일명까지 경로값을 넣어주시길 바랍니다. 
그리고 backurl에서 데이터를 쇼핑몰 DB에 업데이트 작업을 추가로 해주셔야 합니다. -->
	<input type=hidden name=sndBackUrl         value=""> 

<!-- goOpen()에서 사용자가 접속한 URL을 받아와서 sndReply의 값에 세팅합니다.
sndReply는 KSPayRcv.asp(결제승인 후 결과값들을 본창의 KSPayWeb Form에 넘겨주는 페이지)의 절대경로를 넣어줍니다. -->
	<input type=hidden name=sndReply           value="">

<!--KSPAY 결제팝업창에서 사용가능한 결제수단을 세팅합니다. 각 결재수단은 각각의 계약이 이루어져 오픈되있어야 사용가능합니다.-->
<!--신용카드/가상계좌/계좌이체/월드패스카드/포인트/휴대폰결제-->
<!--예 : 신용카드,가상계좌,월드패스카드 선택 value="110100' -->


	<input type=hidden name=sndPaymethod       value="<%=s_paytype%>"> <!-- 순서 : 신용카드, 가상계좌, 계좌이체, 월드패스카드, OK Cashbag, 휴대폰 -->
	<input type=hidden name=sndEscrow          value="0">	  <!--에스크로적용여부-- 0: 적용안함, 1: 적용함 -->
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
	<input type=hidden name=sndCashbag         value="0">     <!--OK CashBag-- 0: 미사용, 1: 사용 -->
	<input type=hidden name=sndWptype          value="">
	<input type=hidden name=sndAdulttype       value="">
	<input type=hidden name=sndStoreName       value="케이에스페이(주)">    <!--회사명을 한글로 넣어주세요(최대20byte)-->
	<input type=hidden name=sndStoreNameEng    value="kspay_test_store">   <!--회사명을 영어로 넣어주세요(최대20byte)-->
	<input type=hidden name=sndStoreDomain     value="http://www.kspay_test.co.kr">   <!-- 회사 도메인을 http://를 포함해서 넣어주세요-->
	<input type=hidden name=sndCertimethod	   value="IM">    <!-- I  : ISP결제, M : MPI결제, W : 해외인증 -->
	<input type=hidden name=sndGoodType		   value="1">			<!--실물(1) / 디지털(2) -->

</form>
	<script language="javascript" type="text/javascript">
	<!--
		goOpen();
	//-->
	</script>
</div>
</body>
</html>
<!--이 페이지에 있는 모든 파라메터는 지우시거나 변경하시면 결제가 이루어지지 않습니다.-->