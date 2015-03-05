<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim codevalue, smode, uid, exe_file

Dim sname,sid,semail,stel1,stel2,szip,saddress1,saddress2,rname,remail,rtel1,rtel2,rzip,rzip1,rzip2, bankinfo
Dim raddress1,raddress2,paytype,paymoney,totalmoney,processing,content,rdate,wdate
Dim deliverer,invoiceno, inputer, rtel, sms_msg
Dim i, selected
Dim strSQL,objRs
Dim db,util

''Set util = new utility	
Set db = new database

codevalue	= Request("codevalue")
smode		= Request("smode")
uid			= Request("uid")
%>
<html>
<head>
<title>위즈몰 관리자 모드 - [배송상세정보]</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="javascript" src="../../js/wizmall.js"></script>
<link rel="stylesheet" href="../../css/base.css" type="text/css">
<link rel="stylesheet" href="../../css/admin.css" type="text/css">

<script language="JavaScript">
<!--
function down_excel(id){
location.href = './order1_3.asp?DownForExel=yes&uid='+id;
}

function delete_confirm() {
	if (!confirm('\n\n삭제된 주문데이터는 복구가 불가능합니다.  \n\n정말로 삭제하시겠습니까?  \n\n'))return false;
	else {
	location.href="order_qry.asp?codevalue=<%=codevalue%>&smode=qde";
	}
	
}

function really() {
		if (confirm('\n\n이미 거래가 완료된 상태입니다.  \n\n거래가 완료된 상태에서 변경할 경우 \n\n회원에게 부여되었던 포인트 및 \n\n제품판매 정보가 거래완료이전 상태로 되돌려 집니다.\n\n정말로 변경하시겠습니까?  \n\n')) return true;
		return false;
}

function change_flag(flag){
	if(flag == "reorder"){ //재주문처리
	}else if(flag == "2"){
	}else if(flag == "reset"){ //초기상태로 변경
	}

}

function chnagefnc(flag){
	var f = document.orderspecfrm;
	
	if (flag == "processing_change"){
		f.smode.value = flag;
		f.action = "order_qry.asp";
		f.submit();
	}else if (flag == "delever_modify"){
		f.smode.value = flag;
		f.action = "order_qry.asp";
		f.submit();
	}else if (flag == "trans_message"){
		f.smode.value = flag;
		f.action = "order_qry.asp";
		f.submit();
	}else if (flag == "chg_address"){
		f.smode.value = flag;
		f.action = "order_qry.asp";
		f.submit();
	}
}

function OpenZipcode(){
wizwindow("../../util/zipcode/default/index.asp?form=orderspecfrm&zip1=rzip1&zip2=rzip2&firstaddress=raddress1&secondaddress=raddress2","ZipWin","width=380,height=310,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
}

//-->
</script>
</head>
                  
<body>

           
<div>배송상세정보 </div>
<%
'' 장바구니 시작
session("carttype") = "adminList"
session("tmpcodevalue") = codevalue
exe_file =  "../../skinwiz/cart/" & CartSkin & "/" & "cart_view_execute.asp"
SERVER.EXECUTE(exe_file)
''장바구니 끝

''주문자 정보 불러오기
strSQL		= "select * FROM wizBuyer WHERE codevalue ='" & codevalue & "'"
set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
uid			= objRs("uid")
sname		= objRs("sname")
sid			= objRs("sid")
semail		= objRs("semail")
stel1		= objRs("stel1")
stel2		= objRs("stel2")
szip		= objRs("szip")
saddress1	= objRs("saddress1")
saddress2	= objRs("saddress2")
rname		= objRs("rname")
bankinfo	= objRs("bankinfo")

remail		= objRs("remail")
rtel1		= objRs("rtel1")
rtel2		= objRs("rtel2")
rzip		= split(objRs("rzip"), "-") : rzip1 = rzip(0) : rzip2 = rzip(1)
raddress1	= objRs("raddress1")
raddress2	= objRs("raddress2")
paytype		= objRs("paytype")
paymoney	= objRs("paymoney")
totalmoney	= objRs("totalmoney")
codevalue	= objRs("codevalue")
processing	= objRs("processing")
content		= objRs("content")
rdate		= objRs("rdate")
wdate		= objRs("wdate")
deliverer	= objRs("deliverer")
invoiceno	= objRs("invoiceno")
%>
        <FORM ACTION='order_qry.asp' name="orderspecfrm" method=post>
        <INPUT type="hidden" NAME="codevalue" value='<%=codevalue%>'>
        <INPUT type="hidden" NAME="uid" value='<%=uid%>'>
		<input type="hidden" name="smode" value="processing_change">
      <table class="table_pop">
		<col width = "120px" />
		<col width = "200px" />
		<col width = "120px" />
		<col width = "*" />
        <tr> <th colspan="4">[ 주문자 정보 ]</th>
        </tr>
        <tr> <th>주문자명</th>
          <td><a HREF='mailto:<%=semail%>'> 
            <%=sname%> </A> ( <%=sid%> )</td>
          <th>입금자명</th>
          <td><%=inputer%>&nbsp;</td>
        </tr>
        <tr> <th>E-mail</th>
          <td><a href='mailto:<%=semail%>'> 
            <%=semail%> </a> </td>
          <th>전화번호</th>
          <td> <%=stel1%> </td>
        </tr>
        <tr> <th>휴대폰</th>
          <td>
            <%=stel2%> </td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> <th>주소</th>
          <td colspan="3"> (<%=szip%>)<%=saddress1%> <%=saddress2%> </td>
        </tr>

        <tr> <th colspan="4">[ 배송지 정보 ]</th>
        </tr>
        <tr> <th>받는사람</th>
          <td><a HREF='mailto:<%=semail%>'> 
            <%=rname%></A></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> <th>E-mail</th>
          <td><a href='mailto:<%=semail%>'> 
            <%=remail%> </a> </td>
          <th>전화번호</th>
          <td> <%=rtel%> </td>
        </tr>
        <tr> <th>휴대폰</th>
          <td> 
            <%=rtel2%> </td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> <th>우편번호</th>
          <td colspan="3"><table border="0" cellspacing="0" cellpadding="0">
              <tr> <td><input name="rzip1" id="rzip1" value="<%=rzip1%>" size=3>
            -
              <input name="rzip2" id="rzip2" value="<%=rzip2%>" size=3></td>
                <td>&nbsp;</td><td><img src="../img/util_icon8.gif" width="86" height="20" onClick='OpenZipcode()'></td><td>&nbsp;</td><td><button name="주소변경" onClick="chnagefnc('chg_address');" title="주소변경">주소변경</button></td>
              </tr>
            </table></td>
        </tr>
        <tr> <th>주소</th>
          <td colspan="3"> <input name="raddress1" value="<%=raddress1%>" size=50> </td>
        </tr>
        <tr> <th>상세주소</th>
          <td colspan="3"> <input name="raddress2" value="<%=raddress2%>" size=50></td>
        </tr>                
        <tr> <th>희망배송일</th>
          <td colspan="3"><%=rdate%></td>
        </tr>
        <tr> <th>배송안내글</th>
          <td colspan="3"> <%=content%> </td>
        </tr>


          <tr> <th colspan="4">[ 주문로그(LOG) ]</th>
          </tr>
          <tr> <th height="19">주문번호 </th>
            <td> 
              <%=codevalue%>
            </td>
            <th>주문일자</th>
            <td> 
              <%=wdate%>
            </td>
          </tr>
          <tr> <th>거래상태</th>
            <td colspan="3"> 
<% if processing = 6 then %>
              <table border="0">
                <INPUT type="hidden" NAME='processing' value='0'>
                <tr> <td> <select name='processing' DISABLED>
                      <option>반품처리상태</option>
                    </select> </td>
                  <td><input type="image" src="../img/je.gif" width="75" height="20"></td>
                </tr>
              </table>
<%
elseif processing = 4 then
%>
<table border="0">
                <tr> <td><INPUT type="hidden" NAME='processing' value='0'> <FONT COLOR=RED>배송 
                    완료됨</FONT></td>
                  <td><input type="image" src="../img/order_icon6.gif" width="66" height="20" onclick='return really();' value='주문접수상태로 변경'></td>
                </tr>
              </table>
<%
elseif processing < 4 then
%>

<table border="0">
                <tr> <td> <select name='processing' readonly>
<%
for i=0 to ubound(DeliveryStatusArr)
	if(i <> 5 and i <> 6) then
 				if i = processing then 
					selected = "selected"
				else selected = ""
				end if
				Response.Write "<option value='"&i&"' "&selected&">"&DeliveryStatusArr(i)&"</option>"
	end if
next
%>			

                    </select> </td>
                  <td><img src="../img/order_icon5.gif" width="66" height="20" onClick="chnagefnc('processing_change')"></td>
                </tr>
              </table>

<% end if %>
            </td>
          </tr>
      


          <tr> <th colspan="4">[ 택배사 및 송장번호]</th>
          </tr>
          <tr> <th>택배사</th>
            <td> 
              <input name="deliverer" value="<%=deliverer%>" size=13>
               </td>
            <th>송장번호</th>
            <td> 
              <input name="invoiceNo" value="<%=invoiceno%>" size=13>
              <img src="../img/3.gif" align="middle" width="75" height="20" onClick="chnagefnc('delever_modify')">
              </td>
          </tr>
        <tr> <td colspan="4"><a href="javascript:window.open('./order1_2.asp?what=sms', 'SMSMessageManagerWindow','width=470,height=407,statusbar=no,scrollbars=yes,toolbar=no')">[ SMS 발송 및 관리]</a>    <button name="" onClick="wizwindow('./order1_2.asp?what=sms', 'SMSMessageManagerWindow','width=470,height=500,statusbar=no,scrollbars=yes,toolbar=no')" title="메세지관리">메세지관리</button></td>
        </tr>
        <tr> <th>SMS발송</th>
          <td colspan="3"> <table width="400" border="0">
<%

strSQL = "select message from wizordermail where delivery_status = '" & processing & "' and flag='sms'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
sms_msg = "" : if not objRs.eof then sms_msg = objRs("message")
%>

                <tr> <th>전화번호</th>
                  <td> 
                    <input size=13 name="sms_tel" value="<%=stel2%>">
                    </td>
                  <td>&nbsp;</td>
                </tr>
                <tr> <th>메세지</th>
                  <td> <textarea name="sms_message"><%=sms_msg%></textarea></td>
                  <td><table border="0" cellpadding="0" cellspacing="0">
                      <tr> <td><img src="../img/3.gif" width="75" height="20" onClick="chnagefnc('trans_message')"></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
            </table></td>
        </tr>
        <tr> <th colspan="4">[ 결제방식 선택 ]</th>
        </tr>
        <%
''//------------------------------------------[결제방식]
if paytype = "card" then
%>
        <tr> <td>결제방식</td>
          <td colspan="3">신용카드 결제</td>
        </tr>
        <%
elseif paytype = "point" then
%>
        <tr> <td>결제방식</td>
          <td colspan="3">포인트 결제</td>
        </tr>
        <%
elseif paytype = "hand" then
%>
        <tr> <td>결제방식</td>
          <td colspan="3">핸드폰 결제</td>
        </tr>
<%
elseif paytype = "all" then
%>
        <tr> <td>결제방식</td>
          <td colspan="3">다중결제(온라인+신용카드+포인트)</td>
        </tr>
        <tr> <td>온라인입금</td>
          <td colspan="3"> 
            <%'=number_format(List[Ziro_Money])%>
            원</td>
        </tr>
        <tr> <td>입금계좌</td>
          <td colspan="3"> 
            <%=bankinfo%>
            &nbsp;</td>
        </tr>
        <tr> <td>입금예정일</td>
          <td colspan="3"><%=rdate%>&nbsp;</td>
        </tr>
        <tr> <td>신용카드</td>
          <td colspan="3"> 
            <%'=number_format(List[Card_Money])%>
            원</td>
        </tr>
        <tr> <td>포인트</td>
          <td colspan="3"> 
            <%'=number_format(List[point_Money])%>
            포인트</td>
        </tr>
        <%
else''온라인입금일경우
%>
        <tr> <td>결제방식</td>
          <td colspan="3">온라인입금</td>
        </tr>
        <tr> <td>입금계좌</td>
          <td colspan="3"> 
             <%=bankinfo%>
            &nbsp;</td>
        </tr>
        <tr> <td>입금예정일</td>
          <td colspan="3"> 
            <%=rdate%>
            &nbsp;</td>
        </tr>
        <%
end if
%>
        <tr> <td colspan="4" align="center"><table border="0" cellspacing="0" cellpadding="0">
              <tr> <!-- "\n\n거래가 완료된 상태에서 삭제가 불가능합니다. \n\n거래상태를 주문접수됨으로 변경후  \n\n삭제 처리하십시오.\n\n" -->
			  <!-- "\n\n거래가 완료된 상태에서 반품처리할 경우 \n\n거래상태를 주문접수됨으로 변경후  \n\n처리하십시오.\n\n" -->
                <% if processing = 4  then %>
                <td><button name="" onClick="alert('거래상태를 주문접수됨으로 변경후  \삭제 처리하십시오.'" title="주문삭제">주문삭제</button></td>
               <% else %>
                <td><button name="" onClick="delete_confirm()" title="주문삭제">주문삭제</button></td>
                <% end if %>
                <!--<td>&nbsp;</td>
                <%'if processing = 4  then%>
                <td><button name="" onClick="alert('거래상태를 주문접수됨으로 변경후  \삭제 처리하십시오.');" title="반송처리">반송처리</button></td>
                <%'else:%>
                <%'if(List[Co_Del] == 'checked') :%>
                <td><button name="" onClick="alert('이미 반품처리된 상태입니다.')" title="반송처리">반송처리</button></td>
                <%'else :%>
                <td><button name="" onClick="location.href='./order1_1.asp?uid=<%=uid%>&action=none'" title="반송처리">반송처리</button></td>
                <%'endif%>
                <%'endif%>
                <td>&nbsp;</td>-->
                <td><button name="" onClick="self.print();" title="프린트">프린트</button></td>
                <td>&nbsp;</td>
                <td><button name="" onClick="self.close();" title="창닫기">창닫기</button></td>
                <!--<td>&nbsp;</td>
                <td><button name="" onClick="down_excel('<%=uid%>');" title="엑셀출력">엑셀출력</button></td>-->
              </tr>
            </table></td>
        </tr>
      </table></form>

 
</body>
</html>
<%
db.Dispose : SET objRs = NOTHING : Set db = Nothing
%>
