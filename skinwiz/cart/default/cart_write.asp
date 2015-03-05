<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../config/bank_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../lib/class.cart.asp" -->
<%
Dim code, smode
Dim sname,sid,sjumin1,sjumin2,semail,stel1,stel2,szip,saddress1,saddress2,rname,remail
Dim rtel1,rtel2,rzip,raddress1,raddress2,paytype,paymoney	,bankinfo,inputer
Dim codevalue,processing,content,pay_date,stel1_1,stel1_2,stel1_3,stel2_1,stel2_2
Dim stel2_3,szip1,szip2,rtel1_1,rtel1_2 ,rtel1_3,rtel2_1,rtel2_2,rtel2_3,rzip1,rzip2
''Dim loopcnt,totalmoney, uid, -- cart_view와 중복되는 변수 제외 
Dim strSQL,objRs, result
Dim db,util,cart
Dim UserPoint : If IsNumeric(UserPoint) = False Then CInt(UserPoint)
Dim RCompany, selectdate
'', selectdate, intselectdate, SelectYear, SelectMonth, SelectDay, StartYear, EndYear, DisplayYear
Set util = new utility	: Set db = new database : Set cart = new wizcart
uid		= Request("uid")
code	= Request("code")


if CARD_ENABLE_MONEY = "" then CARD_ENABLE_MONEY=0

IF SESSION("CART_CODE") <> "" THEN ''현재 주문자 정보가 있는지 책크
	strSQL = "select count(*) from wizbuyer where codevalue = '"&SESSION("CART_CODE")&"'" 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	result = objRs(0)
END IF


if result = 1 then ''저장된 정보를 불러온다 
	strSQL = "select * from wizbuyer where codevalue = '"&SESSION("CART_CODE")&"'" 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	sname		= objRs("sname")
	sid			= objRs("sid")
	sjumin1		= objRs("sjumin1")
	sjumin2		= objRs("sjumin2")
	semail		= objRs("semail")
	stel1		= split(objRs("stel1"), "-")
	stel2		= split(objRs("stel2"), "-")
	szip		= split(objRs("szip"), "-")
	saddress1	= objRs("saddress1")
	saddress2	= objRs("saddress2")
	rname		= objRs("rname")
	remail		= objRs("remail")
	rtel1		= split(objRs("rtel1"), "-")
	rtel2		= split(objRs("rtel2"), "-")
	rzip		= split(objRs("rzip"), "-")
	raddress1	= objRs("raddress1")
	raddress2	= objRs("raddress2")
	paytype		= objRs("paytype")
	paymoney	= objRs("paymoney")
	totalmoney	= objRs("totalmoney")
	bankinfo	= objRs("bankinfo")
	inputer		= objRs("inputer")
	codevalue	= objRs("codevalue")
	processing	= objRs("processing")
	content		= objRs("content")
	pay_date	= objRs("pay_date")	
	for loopcnt=0 to ubound(stel1)
		if loopcnt=0 then stel1_1 = stel1(loopcnt)
		if loopcnt=1 then stel1_2 = stel1(loopcnt)
		if loopcnt=2 then stel1_3 = stel1(loopcnt)
	next
	for loopcnt=0 to ubound(stel2)
		if loopcnt=0 then stel2_1 = stel1(loopcnt)
		if loopcnt=1 then stel2_2 = stel1(loopcnt)
		if loopcnt=2 then stel2_3 = stel1(loopcnt)
	next	
	for loopcnt=0 to ubound(szip)
		if loopcnt=0 then szip1 = szip(loopcnt)
		if loopcnt=1 then szip2 = szip(loopcnt)
	next
	for loopcnt=0 to ubound(rtel1)
		if loopcnt=0 then rtel1_1 = rtel1(loopcnt)
		if loopcnt=1 then rtel1_2 = rtel1(loopcnt)
		if loopcnt=2 then rtel1_3 = rtel1(loopcnt)
	next
	for loopcnt=0 to ubound(rtel2)
		if loopcnt=0 then rtel2_1 = rtel1(loopcnt)
		if loopcnt=1 then rtel2_2 = rtel1(loopcnt)
		if loopcnt=2 then rtel2_3 = rtel1(loopcnt)
	next	
	for loopcnt=0 to ubound(rzip)
		if loopcnt=0 then rzip1 = rzip(loopcnt)
		if loopcnt=1 then rzip2 = rzip(loopcnt)
	next		
elseif user_id <> "" and user_id <> "admin" then''회원정보를 불러온다.
	strSQL = "select m.*, i.* from wizmembers m, wizmembers_ind i where m.mid = '" & user_id & "' and m.mid = i.mid"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	sname		= objRs("mname")
	semail		= objRs("email")
	stel1		= split(objRs("tel1"), "-")
	stel2		= split(objRs("tel2"), "-")
	saddress1	= objRs("address1")
	saddress2	= objRs("address2")
	szip		= split(objRs("zip1"), "-")
	''birthdate	= split(objRs("birthdate"), "/")
	for loopcnt=0 to ubound(stel1)
		if loopcnt=0 then stel1_1 = stel1(loopcnt)
		if loopcnt=1 then stel1_2 = stel1(loopcnt)
		if loopcnt=2 then stel1_3 = stel1(loopcnt)
	next
	for loopcnt=0 to ubound(stel2)
		if loopcnt=0 then stel2_1 = stel1(loopcnt)
		if loopcnt=1 then stel2_2 = stel1(loopcnt)
		if loopcnt=2 then stel2_3 = stel1(loopcnt)
	next	
	for loopcnt=0 to ubound(szip)
		if loopcnt=0 then szip1 = szip(loopcnt)
		if loopcnt=1 then szip2 = szip(loopcnt)
	next	
end if
%>
<script language="JavaScript">
<!--
$(function(){
	$(".paytype").click(function(){
		//var f = eval("document."+v.form.name);
		totalpay = RemoveComma($("#total_check").val());
		
		var paytypevalue = $('.paytype:checked').val()
		
		switch(paytypevalue){
			case "online":
				$("#onlinepaytype1").show()	;
				$("#onlinepaytype2").show()	;
				$("#onlinepaytype3").show()	;
				$("#autobanktype1").hide();
			break;
			case "card":
				if(totalpay < <%=CARD_ENABLE_MONEY%> ){
					window.alert('신용카드구매는 구매액이 <%=FormatNumber(CARD_ENABLE_MONEY)%>원 이상만 가능합니다.');
					v.checked = false;
					return;
				}
				$("#onlinepaytype1").hide()	;
				$("#onlinepaytype2").hide()	;
				$("#onlinepaytype3").hide()	;
				$("#autobanktype1").hide();
			break;
			case "hand":
				if(totalpay < <%=CARD_ENABLE_MONEY%> ){
					window.alert('핸드폰 구매액이 <%=FormatNumber(CARD_ENABLE_MONEY)%>원 이상만 가능합니다.');
					v.checked = false;
					return;
				}
				$("#onlinepaytype1").hide()	;
				$("#onlinepaytype2").hide()	;
				$("#onlinepaytype3").hide()	;
				$("#autobanktype1").hide();
			break;
			case "autobank":
				$("#onlinepaytype1").hide()	;
				$("#onlinepaytype2").show()	;
				$("#onlinepaytype3").hide()	;
				$("#autobanktype1").show();
			break;
		}
	});
});


function OrderCheckField(f){
	if(autoCheckForm(f)){
		return true;
	}else{
		return false;
	}
}

function OpenZipcode(flag){
	if(flag == 1){
	window.open("./util/zipcode/<%=ZipCodeSkin%>/index.asp?form=FrmUserInfo&zip1=szip1&zip2=szip2&firstaddress=saddress1&secondaddress=saddress2","ZipWin","width=367,height=300,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
	}else if(flag == 2){
	window.open("./util/zipcode/<%=ZipCodeSkin%>/index.asp?form=FrmUserInfo&zip1=rzip1&zip2=rzip2&firstaddress=raddress1&secondaddress=raddress2","ZipWin","width=367,height=300,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
	}
}

function copyvalue(){
	var f = document.FrmUserInfo;
	if(f.same_yn[0].checked == true){
		f.rname.value = f.sname.value;
		f.rtel1_1.value = f.stel1_1.value;
		f.rtel1_2.value = f.stel1_2.value;
		f.rtel1_3.value = f.stel1_3.value;
		f.rtel2_1.value = f.stel2_1.value;
		f.rtel2_2.value = f.stel2_2.value;
		f.rtel2_3.value = f.stel2_3.value;		
		f.rzip1.value = f.szip1.value;
		f.rzip2.value = f.szip2.value;
		f.raddress1.value = f.saddress1.value;
		f.raddress2.value = f.saddress2.value;
	}else if(f.same_yn[1].checked == true){
		f.rname.value = "";
		f.rtel1_1.value = "";
		f.rtel1_2.value = "";
		f.rtel1_3.value = "";
		f.rtel2_1.value = "";
		f.rtel2_2.value = "";
		f.rtel2_3.value = "";			
		f.rzip1.value = "";
		f.rzip2.value = "";
		f.raddress1.value = "";
		f.raddress2.value = "";

	}
}


//-->
</script>

<table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
  <tr bgcolor="#F6F6F6">
    <td width="15" height="22" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">&nbsp;</td>
    <td width="18" height="22" valign="middle"><img src="./skinwiz/cart/<%=CartSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
    <td height="22" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">Home &gt; <strong>주문서
      작성</strong></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
  <tr>
    <td><table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr>
          <td width="90" bgcolor="#EEEEEE">- <strong>주문서작성:</strong></td>
          <td bgcolor="#EEEEEE">고객님의 배송지 정보와 결제방법을 입력해 주세요<br>
            회원이실 경우, 입력이 더욱 편리하고 더 많은 혜택을 누리실 수 있습니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;<img src="./skinwiz/cart/<%=CartSkin%>/images/point_cart_01.gif" width="8" height="11">고객님께서
      선택하신 상품내역입니다.</td>
  </tr>
  <tr>
    <td><!-- #include file = "./cart_view.asp" -->
      <Script language=javascript>
<!--
function paycalculate() {
var f = document.FrmUserInfo;
	num1 = filterNum(f.pointamount.value);
	num2 = filterNum(f.totalmoney.value);
	//num3 = filterNum(f.pgamount.value);
	//num4 = filterNum(f.olineamount.value);
	if (!TypeCheck(f.pointamount.value, NUM+COMMA)) {
			alert('숫자와 콤마만 입력가능합니다.');
			f.pointamount.value = '0';
			f.pointamount.focus();
			return true;
	}
	if (num1 > <%=CInt(UserPoint)%>) {
			alert('고객님께서 사용가능한 <%=UserPoint%>포인트 이내에서만 구매가능합니다.');
			//f.pointamount.value = commaSplit(num2 - num3 - num4);
			f.pointamount.focus();
			return true;
	}
	if (num1 > <%=totalmoney%>) {
			alert('포인트 결제금액이 제품 구매액보다 많게 입력되었습니다');
			//f.pointamount.value = commaSplit(num2 - num3 - num4);
			f.pointamount.focus();
			return true;
	}
	f.pointamount.value = commaSplit(f.pointamount.value);
	f.total_check.value = commaSplit(num2 - num1) ;
}
//-->
</script>
    </td>
  </tr>
  <!---------------------------------------------------------------------------------->
  <tr>
    <td></td>
  </tr>
  <tr>
    <td align="right"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="15" class="title"><%
Set util = new utility
%>
            <form name="FrmUserInfo" method="post" OnSubmit="return OrderCheckField(this);" action="wizbag.asp">
              <input type="hidden" name="smode" value="execute">
              <input type="hidden" name="pqty" value="1">
              <input type="hidden" name="uid" value="<%=uid%>">
              <input type="hidden" name="totalmoney" value="<%=totalmoney%>">
              <input type="hidden" name="paymoney" value="<%=totalmoney%>">
              <input type="hidden" name="code" value="<%=code%>">
              <table class="blank agn_l">
                <!-- copy from here -->
                <tr>
                  <td><font color='red'>&quot;*&quot; 표시가 있는 항목은 모두 입력하셔야 합니다.</font>
                <tr>
                  <td><img src="./skinwiz/cart/<%=CartSkin%>/images/title_orderinfo02.gif" width="114" height="35"></td>
                </tr>
                <tr>
                  <td><table class="table_main w_default">
                      <col width="140px" />
                      <col width="*" />
                      <tr>
                        <th>주문고객
                          성명</th>
                        <td><input name="sname" type="text" id="sname" value="<%=sname%>" size="20" maxlength="30" checkenable msg="고객 성명을 입력해 주세요"></td>
                      </tr>
                      <tr>
                        <th>회사명/부서</th>
                        <td><input name="RCompany" type="text" value="<%=RCompany%>" size="20" maxlength="30" >
                          <font color="#FF9900">* 기업고객일경우 회사명과 부서를 남겨주세요</font></td>
                      </tr>
                      <tr>
                        <th>전화번호</th>
                        <td><input name="stel1_1" type="text" id="stel1_1" class="w50" value="<%=stel1_1%>" maxlength="5" checkenable msg="전화번호를 입력해 주세요">
                          -
                          <input name="stel1_2" type="text" id="stel1_2" class="w50" value="<%=stel1_2%>" maxlength="5" checkenable msg="전화번호를 입력해 주세요">
                          -
                          <input name="stel1_3" type="text" id="stel1_3" class="w50" value="<%=stel1_3%>" maxlength="5" checkenable msg="전화번호를 입력해 주세요"></td>
                      </tr>
                      <tr>
                        <th>휴대전화번호</th>
                        <td><input name="stel2_1" type="text" id="stel2_1" class="w50" value="<%=stel2_1%>" maxlength="5" >
                          -
                          <input name="stel2_2" type="text" id="stel2_2" class="w50" value="<%=stel2_2%>" maxlength="5">
                          -
                          <input name="stel2_3" type="text" id="stel2_3" class="w50" value="<%=stel2_3%>" maxlength="5"></td>
                      </tr>
                      <tr>
                        <th rowspan="3">주소</th>
                        <td><input name="szip1" type="text" id="szip1" class="w30" value="<%=szip1%>" maxlength="5" >
                          -
                          <input name="szip2" type="text" id="szip2" class="w30" value="<%=szip2%>" maxlength="5">
                          <a href="javascript:OpenZipcode('1')"><img src="./skinwiz/cart/<%=CartSkin%>/images//but_post.gif" width="91" height="18" align="absmiddle" border="0"></a></td>
                      </tr>
                      <tr>
                        <td><INPUT NAME="saddress1" TYPE="text" id="saddress1" VALUE="<%=saddress1%>">
                          동까지의 주소</td>
                      </tr>
                      <tr>
                        <td><input name="saddress2" type="text" id="saddress2" value="<%=saddress2%>">
                          동이하의 주소 </td>
                      </tr>
                      <tr>
                        <th>이메일</th>
                        <td><input name="semail" type="text" id="semail" value="<%=semail%>" size="35" maxlength="30" checkenable msg="고객 이메일을 입력해 주세요" option="regMail"></td>
                      </tr>
                    </table>
                    <br />
                    <img src="./skinwiz/cart/<%=CartSkin%>/images/title_orderinfo03.gif" width="96" height="35"><br>
                    <table class="table_main w_default">
                      <col width="140px" />
                      <col width="*" />
                      <tr>
                        <td colspan="2">위와
                          동일 주소 선택 :
                          <input type="radio" name="same_yn" value="1" onClick="copyvalue()" class="input_radio2">
                          예
                          <input type="radio" CHECKED name="same_yn" value="0" onClick="copyvalue()" class="input_radio2">
                          아니요</td>
                      </tr>
                      <tr>
                        <th width="127">받으시는
                          분 성명</th>
                        <td width="454"><input name="rname" type="text" id="rname" value="<%=rname%>" size="20" maxlength="30"></td>
                      </tr>
                      <tr>
                        <th>받으시는
                          분 주소</th>
                        <td><input name="rzip1" type="text" id="rzip1" value="<%=rzip1%>" class="w30" maxlength="3" READONLY checkenable msg="수령지 우편번호를 입력해 주세요">
                          -
                          <input name="rzip2" type="text" id="rzip2" class="w30" value="<%=rzip2%>" maxlength="3" READONLY checkenable msg="수령지 우편번호를 입력해 주세요">
                          <a href="javascript:OpenZipcode('2')"><img src="./skinwiz/cart/<%=CartSkin%>/images//but_post.gif" width="91" height="18" align="absmiddle" border="0"></a></td>
                      </tr>
                      <tr>
                        <th> </th>
                        <td><input name="raddress1" type=text id="raddress1" value="<%=raddress1%>" size=50 READONLY checkenable msg="수령지 주소를 입력해 주세요">
                          <br>
                          <input name="raddress2" type=text id="raddress2" value="<%=raddress2%>" size=30 checkenable msg="수령지 상세주소를 입력해 주세요">
                          상세주소</td>
                      </tr>
                      <tr>
                        <th>받으실
                          분 전화번호</th>
                        <td><input name="rtel1_1" type="text" id="rtel1_1" value="<%=rtel1_1%>" class="w50" maxlength="5" checkenable msg="받으실분 전화번호를 입력해 주세요">
                          -
                          <input name="rtel1_2" type="text" id="rtel1_2" value="<%=rtel1_2%>" class="w50" maxlength="5" checkenable msg="받으실분 전화번호를 입력해 주세요">
                          -
                          <input name="rtel1_3" type="text" id="rtel1_3" value="<%=rtel1_3%>" class="w50" maxlength="5" checkenable msg="받으실분 전화번호를 입력해 주세요"></td>
                      </tr>
                      <tr>
                        <th>받으실
                          분 휴대전화</th>
                        <td><input name="rtel2_1" type="text" id="rtel2_1" class="w50" value="<%=rtel2_1%>" maxlength="5">
                          -
                          <input name="rtel2_2" type="text" id="rtel2_2" class="w50" value="<%=rtel2_2%>" maxlength="5">
                          -
                          <input name="rtel2_3" type="text" id="rtel2_3" class="w50" value="<%=rtel2_3%>" maxlength="5"></td>
                      </tr>
                      <tr>
                        <th>요청사항
                          (50자 이내)</th>
                        <td class="agn_l"><textarea name="content" rows="3"id="content" style="width:100%"><%=content%></textarea>
                        </td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td><table class="table_main w_default">
                      <col width="140px" />
                      <col width="*" />
                      <col width="140px" />
                      <col width="200px" />
                      <tr>
                        <th>물품금액</th>
                        <td colspan="3" ><%=FormatNumber(totalmoney, 0)%>원</td>
                      </tr>
                      <!--<tr>
            <td>배송비</td>
            <td colspan="3" > </td>
          </tr>-->
                      <!--<tr>
          <td>할인금액</td>
          <td colspan="3">&nbsp;</td>
          </tr>-->
                      <% if POINT_ENABLE = "checked" then %>
                      <!-- 포인트 결재 시작 -->
                      <tr>
                        <th>포인트사용금액</th>
                        <td><input value='0' type=TEXT name='pointamount' size=10 onkeyup='paycalculate();' style="font: 9pt 굴림; border:1 solid #cccccc; text-align:right" /></td>
                        <th>현재가용포인트</th>
                        <td><!--<%''=UserPoint - HoldPoint%>/-->
                          <%=FormatNumber(UserPoint,0)%>원</td>
                      </tr>
                      <!-- 포인트 결재 끝 -->
                      <% end if %>
                      <tr>
                        <th>최종결제 금액 </th>
                        <td colspan="3" ><input type=TEXT name='total_check' id="total_check" size=10 readonly value='<%=totalmoney%>' />
                          원</td>
                      </tr>
                      <tr>
                        <th>결제방식</th>
                        <td colspan="3"><!-- 무통장 입금 시작 ----------->
                          <input name="paytype" class="paytype" type="radio" value="online" checked="checked" checkenable msg="결제방법을 선택해주세요" />
                          <strong>무통장 입금 </strong>
                          <!-- 무통장 입금 끝 -------------->
                          <%
if CARD_ENABLE = "checked" then
%>
                          <!-- 신용카드 시작 --------------->
                          <input name="paytype" class="paytype" type="radio" value="card" />
                          <strong>신용카드</strong>
                          <!-- 신용카드 끝 ----------------->
                          <%
end if
%>
                          <%
if PHONE_ENABLE = "checked" then
%>
                          <!-- 핸드폰 결재 시작 --------------->
                          <input name="paytype" class="paytype" type="radio" value="hand" />
                          <strong>핸드폰 결제</strong>
                          <!-- 핸드폰 결재 끝 ----------------->
                          <%
end if
%>
                          <%
if AUTOBANKING_ENABLE = "checked" then
%>
                          <!-- 실시간 계좌이체 시작 --------------->
                          <input name="paytype" class="paytype" type="radio" value="autobank" />
                          <strong>실시간 계좌 이체</strong>
                          <!-- 실시간 계좌이체 끝 ----------------->
                          <%
end if
%></td>
                      </tr>
                      <!--<tr>
            <td>주문금액</td>
            <td class="pink" ><%''number_format(totalmoney);%>원</td>
          </tr>
          <tr>
            <td>결제금액</td>
            <td ><%''number_format(totalmoney);%>원</td>
          </tr>-->
                      <tr id="onlinepaytype1">
                        <th>입금은행</th>
                        <td colspan="3"><select name='BankInfo' size='1'>
                            <%
for loopcnt=1 to Ubound(ZIRO_LIST)
	if ZIRO_LIST(loopcnt) <> "" Then Response.Write "<option vlaue='"&ZIRO_LIST(loopcnt)&"'>"&ZIRO_LIST(loopcnt)&"</option>"&chr(13)&chr(10)
next				  
					  
%>
                          </select>
                        </td>
                      </tr>
                      <tr id="onlinepaytype2">
                        <th>입금자명</th>
                        <td colspan="3"><input name="inputer" type="text" id="inputer" value="<%=Inputer%>" />
                        </td>
                      </tr>
                      <tr id="onlinepaytype3">
                        <th>입금예정일</th>
                        <td colspan="3"><select name="inputy">
                            <%			  
Response.Write util.getSelectdate("year",selectdate)	
%>
                          </select>
                          <select name="inputm">
                            <%	
Response.Write util.getSelectdate("month",selectdate)
%>
                          </select>
                          <select name="inputd">
                            <%	
Response.Write util.getSelectdate("day",selectdate)
%>
                          </select>
                        </td>
                      </tr>
                      <tr id="autobanktype1" style="display:none">
                        <th>주민번호</th>
                        <td colspan="3"><input name="sjumin1" type="text" id="sjumin1" value="<%=sjumin1%>" size="6" maxlength="6" />
                          -
                          <input name="sjumin2" type="text" id="sjumin2" value="<%=sjumin2%>" size="7" maxlength="7" /></td>
                      </tr>
                    </table></td>
                </tr>
              </table>
              <br />
              <div class="agn_c"> <img src="./skinwiz/cart/<%=CartSkin%>/images/but_re.gif" width="77" height="28" onClick="javascript:history.go(-1);" style="cursor:pointer">
                <input name="image" type="image" src="./skinwiz/cart/<%=CartSkin%>/images/but_momey.gif" width="81" height="28" border="0">
              </div>
            </form></td>
        </tr>
        <tr>
          <td align="right"><table width="564" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="36" valign="bottom"><br>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
''db.DisPose : Set objRs = Nothing : Set db = Nothing : 
Set util = Nothing
%>
