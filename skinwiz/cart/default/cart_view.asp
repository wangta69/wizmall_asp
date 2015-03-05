<%
Set util = new utility : Set db	= new database : Set cart = new wizcart

Dim carttype, tmpcodevalue''타 위치에서 현재 cart view만 사용하고자 할경우
Dim TotalUnit,MESSAGE_TACKBAE 
Dim totalmoney,loopcnt,summoney
Dim picture,p_picture,p_picture_2,category,uid,cuid,price,pname,qty,optionflag,opstr,ordermoney,tprice, each_tackbae_money, deliveryfee
carttype				= session("carttype")
tmpcodevalue			= session("tmpcodevalue")
session("carttype")		= ""
session("tmpcodevalue") = ""
''carttype: orderspec:주문배송조회에서 넘어옮

''Dim CART_CODE : CART_CODE	= SESSION("CART_CODE")
Dim CART_CODE''cart_query.asp와 중복(나중에 어떻게 처리할지 생각해보자)
IF SESSION("CART_CODE") = "" THEN
	CART_CODE				= util.Linuxtime()
	SESSION("CART_CODE")    = CART_CODE ''장바구니고유코드
ELSE
	CART_CODE = SESSION("CART_CODE")
END If



if tmpcodevalue <> "" then 
	CART_CODE = tmpcodevalue
ElseIf session("user_id") <> "" Then
	''예전에 담아 두었던 상품중 결제단까지 가지 않은 것들을 불러온다.(이부분은 추후 관리자단에서 옵션처리)
	sqlstr = "update wizcart set oid = '" & CART_CODE &"' where user_id='" & session("user_id" )& "' and ostatus = 0"
	dbcon.execute(sqlstr)
End If





%>
<!-- 장바구니 보기 -->
<SCRIPT LANGUAGE=javascript>
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
</SCRIPT>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
<% 
if carttype = "orderspec" or carttype = "orderconfirm" then ''주문배송조회, 주문확인(step4)에서 넘어옮

%>

	<table width='100%' border=0 align="center" cellpadding=0 cellspacing=0 style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
      <tr align="center" bgcolor="#E08B18" height=23>
        <td height="3" colspan="4"></td>
      </tr>
      <tr align=CENTER height=23>
        <td height="29" bgcolor="#FCF7F3">상품명</td>
        <td height="29" bgcolor="#FCF7F3">가격</td>
        <td height="29" bgcolor="#FCF7F3">수량</td>
        <td height="29" bgcolor="#FCF7F3">소계금액</td>
        </tr>
      <%
Call cart.cart_view_pre(CART_CODE)
loopcnt		= 0
WHILE NOT objRs.EOF
	Call cart.cart_view(objRs)
		
%>
      <form name='view_form<%=i%>'action='./skinwiz/cart/cart_query.asp'>
        <input type=HIDDEN name='smode' value='update_qty' />
        <input type=HIDDEN name='cuid' value='<%=cuid%>' />
        <tr align=CENTER>
          <td align=LEFT><table width=100%  style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
            <tr>
              <td width=50><a href='./wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>'><img src='./config/wizstock/<%=p_picture_2%>' width='50' height='50' border=0 /></a></td>
              <td><a href='./wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>'><font color=BLUE><u>
                <%=pname%><%=opstr%>
              </u></font></a> </td>
            </tr>
          </table></td>
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
loopcnt=loopcnt+1
objRs.MOVENEXT
WEND
if loopcnt = 0 then
%>
        <tr align=CENTER>
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
<%
else
%>
	<table width='100%' border=0 align="center" cellpadding=0 cellspacing=0 style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
      <tr align=CENTER bgcolor="#E08B18" height=23>
        <td height="3" colspan="6"></td>
      </tr>
      <tr align=CENTER height=23>
        <td height="29" bgcolor="#FCF7F3">상품명</td>
        <td height="29" bgcolor="#FCF7F3">가격</td>
        <td height="29" bgcolor="#FCF7F3">수량</td>
        <td height="29" bgcolor="#FCF7F3">소계금액</td>
        <td height="29" bgcolor="#FCF7F3">수정</td>
        <td height="29" bgcolor="#FCF7F3">삭제</td>
      </tr>
      <%
Call cart.cart_view_pre(CART_CODE)
loopcnt		= 0
WHILE NOT objRs.EOF
	Call cart.cart_view(objRs)
		
%>
      <form name='view_form<%=loopcnt%>'action='./skinwiz/cart/cart_query.asp'>
        <input type=HIDDEN name='smode' value='update_qty' />
        <input type=HIDDEN name='cuid' value='<%=cuid%>' />
        <tr align=CENTER>
          <td align=LEFT><table width=100%  style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
            <tr>
              <td width=50><a href='./wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>'><img src='./config/wizstock/<%=p_picture_2%>' width='50' height='50' border=0 /></a></td>
              <td><a href='./wizmart.asp?code=<%=category%>&smode=view&no=<%=uid%>'><font color=BLUE><u>
                <%=pname%><%=opstr%>
              </u></font></a> </td>
            </tr>
          </table></td>
          <td><%=FormatNumber(price, 0)%>
            원
                <input type=HIDDEN name='goodsprice' value='<%=price%>' /></td>
          <td><table cellpadding=0 cellspacing=0 border=0  style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
            <tr>
              <td rowspan=2><input type=TEXT size=4 name='buynum' maxlength=5 value='<%=qty%>' onkeypress="is_number()" />              </td>
              <td><a href='javascript:num_plus(document.view_form<%=loopcnt%>);'><img src='./skinwiz/cart/<%=CartSkin%>/images/num_plus.gif' border=0 /></a></td>
              <td rowspan=2>&nbsp;&nbsp;EA</td>
            </tr>
            <tr>
              <td><a href='javascript:num_minus(document.view_form<%=loopcnt%>);'><img src='./skinwiz/cart/<%=CartSkin%>/images/num_minus.gif' border=0 /></a></td>
            </tr>
          </table></td>
          <td><font color='#E37509'><b>
            <%=FormatNumber(summoney, 0)%>
            원</b></font><br />          </td>
          <td><input name="IMAGE" type=IMAGE src='./skinwiz/cart/<%=CartSkin%>/images/but_mo.gif' align="middle" />          </td>
          <td><a href='./skinwiz/cart/cart_query.asp?smode=qde&cuid=<%=cuid%>'><img src='./skinwiz/cart/<%=CartSkin%>/images/but_cancle.gif' border=0 align="middle" /></a></td>
        </tr>
        <tr>
          <td colspan=6 height=5></td>
        </tr>
        <tr>
          <td colspan=6 background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=2></td>
        </tr>
      </form>
      <%
loopcnt=loopcnt+1
objRs.MOVENEXT
WEND
if loopcnt = 0 then
%>
        <tr align=CENTER>
          <td height="25" colspan="6" align=center>현재 장바구니에 담긴 상품이 없습니다.</td>
        </tr>
        <tr>
          <td colspan=6 height=5></td>
        </tr>
        <tr>
          <td colspan=6 background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=2></td>
        </tr>
<%
end if
%>
    </table>
	<%
	end if
	%>
        <br />
<%
MESSAGE_TACKBAE = cart.deliverfee_proc()
%>
        <table width='100%' border=0 align="center" cellpadding=0 cellspacing=0>
          <tr>
            <td background='./skinwiz/cart/<%=CartSkin%>/image/cart_line.gif' height=1></td>
          </tr>
          <tr>
            <td height=25 align=CENTER bgcolor=#E9E7DF class="castb"><table width="100%" border="0" cellpadding="0" cellspacing="5" bgcolor="#F3F3F3" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                <tr>
                  <td width="60%"><%=MESSAGE_TACKBAE%></td>
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
