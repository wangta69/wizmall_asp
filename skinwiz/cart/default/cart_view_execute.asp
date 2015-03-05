<% Option Explicit %>
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../config/bank_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../lib/class.cart.asp" -->
<%
Dim strSQL,objRs
Dim db,util,cart
Set util = new utility	
Set db = new database
Set cart	= new wizcart
Dim carttype, tmpcodevalue''타 위치에서 현재 cart view만 사용하고자 할경우
Dim TotalUnit,Loopcnt,summoney,totalmoney,picture,category,uid,cuid,price,pname,qty,option1,option2,opstr,ordermoney
Dim p_picture,p_picture_2,optionflag,tprice, each_tackbae_money, deliveryfee
Dim MESSAGE_TACKBAE



carttype		= session("carttype")
tmpcodevalue	= session("tmpcodevalue")
session("carttype") = ""
session("tmpcodevalue") = ""
''carttype: orderspec:주문배송조회에서 넘어옮, adminList : 관리자단 주문 상세조회

Dim CART_CODE
CART_CODE	= SESSION("CART_CODE")

if tmpcodevalue <> "" then CART_CODE = tmpcodevalue
if IsNumeric(TACKBAE_CUTLINE) = False then TACKBAE_CUTLINE = Cint(TACKBAE_CUTLINE)
if IsNumeric(TACKBAE_MONEY) = False then TACKBAE_MONEY = Cint(TACKBAE_MONEY)

%>
<!-- 장바구니 보기 -->
<script language="javascript">
<!--
	function num_plus(num){
			gnum = parseInt(num.buynum.value);
			num.buynum.value = gnum + 1;
			return;
	}

	function num_minus(num){
			gnum = parseInt(num.buynum.value);
			if( gnum > 1 ){
					num.buynum.value = gnum - 1;
			}
			return;
	}

	function really(){
		if (confirm('\n\n정말로 장바구니를 모두 비우시겠습니까?\n\n')) return true;
		return false;
	}

	function is_number(){
			 if ((event.keyCode<48)||(event.keyCode>57)){
					  alert("\n\n수량은 숫자만 입력하셔야 합니다.\n\n");
					  event.returnValue=false;
			 }
	}
//-->
</script>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>

	<table width='100%' border=0 align="center" cellpadding=0 cellspacing=0 >
      <tr align="center" bgcolor="#E08B18" height=23>
        <td height="3" colspan="4"></td>
      </tr>
      <tr align="center" height=23>
        <td height="29" bgcolor="#FCF7F3">상품명</td>
        <td height="29" bgcolor="#FCF7F3">가격</td>
        <td height="29" bgcolor="#FCF7F3">수량</td>
        <td height="29" bgcolor="#FCF7F3">소계금액</td>
        </tr>
      <%
Call cart.cart_view_pre(CART_CODE)
Loopcnt = 0
WHILE NOT objRs.EOF
	Call cart.cart_view(objRs)	
%>
      <form name='view_form<%=Loopcnt%>' action='./skinwiz/cart/cart_query.asp'>
        <input type=HIDDEN name='smode' value='update_qty' />
        <input type=HIDDEN name='cuid' value='<%=cuid%>' />
        <tr align="center">
          <td align=LEFT>
<%
if carttype = "adminList" then''관리자단에서 볼경우 링크만 변경된다.
%>         
          <table width=100%  >
            <tr>
              <td width=50><a href='../../wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>' target="_blank"><img src='../../config/wizstock/<%=p_picture_2%>' width='50' height='50' border=0 /></a></td>
              <td><a href='../../wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>' target="_blank"><font color=BLUE><u>
                <%=pname%>
              </u></font></a><%=opstr%></td>
            </tr>
          </table>
<%
else
%>
<table width=100%  >
            <tr>
              <td width=50><a href='./wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>'><img src='./config/wizstock/<%=p_picture_2%>' width='50' height='50' border=0 /></a></td>
              <td><a href='./wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>'><font color=BLUE><u>
                <%=pname%>
              </u></font></a><%=opstr%></td>
            </tr>
          </table>
<%
end if
%>                  
          </td>
          <td><%=FormatNumber(price, 0)%>
            원
                <input type=HIDDEN name='goodsprice' value='<%=price%>' /></td>
          <td><%=qty%></td>
          <td><font color='#E37509'><b>
            <%=FormatNumber(summoney, 0)%>
            원</b></font><br />          </td>
          </tr>
        <tr>
          <td colspan=4 height=5></td>
        </tr>
        <tr>
          <td colspan=4 background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=2></td>
        </tr>
      </form>
      <%
Loopcnt	= Loopcnt+1
objRs.MOVENEXT
WEND
if Loopcnt = 0 then
%>
        <tr align="center">
          <td height="25" colspan="4" align=center>현재 장바구니에 담긴 상품이 없습니다.</td>
        </tr>
        <tr>
          <td colspan=4 height=5></td>
        </tr>
        <tr>
          <td colspan=4 background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=2></td>
        </tr>
<%
end if
%>
    </table>

<br />
<%
MESSAGE_TACKBAE = cart.deliverfee_proc()
%>
        <table width='100%' border=0 align="center" cellpadding=0 cellspacing=0>
          <tr>
            <td background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=1></td>
          </tr>
          <tr>
            <td height=25 align="center" bgcolor=#E9E7DF class="castb"><table width="100%" border="0" cellpadding="0" cellspacing="5" bgcolor="#F3F3F3" >
                <tr>
                  <td width="60%">&nbsp;</td>
                  <td width="40%" align="center">주문상품 총액: <%=FormatNumber(totalmoney, 0)%> 원</td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=1></td>
          </tr>
        </table>
      <%
}
%> 
        <!-- 장바구니 보기 끝 --></td>
  </tr>
</table>
<%
db.DisPose : Set objRs = Nothing : Set db = Nothing : Set util = Nothing : Set cart = Nothing
%>
