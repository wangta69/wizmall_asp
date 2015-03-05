<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../lib/class.cart.asp" -->
<%
Dim  sname,sid,sjumin1,sjumin2,semail,stel1,stel2,szip,saddress1,saddress2,rname,remail,rtel1,rtel2,rzip,raddress1,raddress2
Dim codevalue,paytype,paymoney,bankinfo,inputer,rdate,content
Dim exe_file

Dim strSQL,objRs
Dim db,util,cart
Set util = new utility	
Set db = new database
%>

<table width="100%" height="18" border="0" cellpadding="0" cellspacing="0">
  <tr bgcolor="#F6F6F6">
    <td width="15" height="22">&nbsp;</td>
    <td width="18" height="22" valign="middle"><img src="./skinwiz/cart/<%=CartSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
    <td height="22">Home 
      &gt; <strong>주문서 확인</strong></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="95%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td width="90" bgcolor="#EEEEEE">- <strong>주문서확인:</strong></td>
          <td bgcolor="#EEEEEE">선택하신 결제수단에 맞는 정보를 입력해 주세요<br>
            입력하신 정보는 철저히 보호되므로 안심하셔도 됩니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><table class="blank agn_l">
        <tr>
          <td><img src="./skinwiz/cart/<%=CartSkin%>/images/point_cart_01.gif" width="8" height="11">고객님께서 
            선택하신 상품내역입니다.</td>
        </tr>
        <tr>
          <td><%
session("carttype")		= "orderconfirm"
session("tmpcodevalue")	= codevalue
exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_view_execute.asp"
''Response.Write(exe_file)
SERVER.EXECUTE(exe_file)
%>
          </td>
        </tr>
        <%
Set db = new database
Dim totalmoney

'' 아래 두라인 추가 및 strSQL SESSION("CART_CODE") -> codevalue 로 변경
Dim codevalue : codevalue = Request("codevalue")
If codevalue = "" Then codevalue = SESSION("CART_CODE")

strSQL = "SELECT * FROM wizbuyer WHERE codevalue='" & codevalue & "'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
sname		= objRs("sname")
sid			= objRs("sid")
sjumin1		= objRs("sjumin1")
sjumin2		= objRs("sjumin2")
semail		= objRs("semail")
stel1		= objRs("stel1")
stel2		= objRs("stel2")
szip		= objRs("szip")
saddress1	= objRs("saddress1")
saddress2	= objRs("saddress2")
rname		= objRs("rname")
remail		= objRs("remail")
rtel1		= objRs("rtel1")
rtel2		= objRs("rtel2")
rzip		= objRs("rzip")
raddress1	= objRs("raddress1")
raddress2	= objRs("raddress2")
codevalue	= objRs("codevalue")
paytype		= objRs("paytype")
paymoney	= objRs("paymoney")
totalmoney	= objRs("totalmoney")
bankinfo	= objRs("bankinfo")
inputer		= objRs("inputer")
rdate		= objRs("rdate")
content		= objRs("content")
Set objRs = Nothing : db.Dispose : Set db	= Nothing
%>
        <tr>
          <td><img src="./skinwiz/cart/<%=CartSkin%>/images/title_payment01.gif" width="104" height="35">
            <table class="table_main w_default">
              <col width="140px" />
              <col width="*" />
              <tr>
                <th>총 주문금액</th>
                <td><strong> <%=FormatNumber(totalmoney,0)%> 원</strong></td>
              </tr>
              <tr>
                <th>총 
                  결제금액</th>
                <td><font color="703EAE"><strong> <%=FormatNumber(paymoney, 0)%> 원</strong></font></td>
              </tr>
              <tr>
                <th>입금은행</th>
                <td><%=bankinfo%> </td>
              </tr>
              <tr>
                <th>입금자 
                  성명</th>
                <td height="40"><%=inputer%><br />
                  <font color="#FF9900">* 입금자 성명과 실제 통장에 입금하신 성명이 일치해야 
                  입금이 확인됩니다.</font></td>
              </tr>
              <tr>
                <th>입금예정일</th>
                <td><%=rdate %> </td>
              </tr>
            </table>
            <img src="./skinwiz/cart/<%=CartSkin%>/images/title_orderinfo02.gif" width="114" height="35">
            <table class="table_main w_default">
              <col width="140px" />
              <col width="*" />
              <tr>
                <th>고객주문 
                  번호</th>
                <td><font color = "red"> <%=codevalue%> </font></td>
              </tr>
              <tr>
                <th>주문고객 
                  성명</th>
                <td><%=sname%></td>
              </tr>
              <tr>
                <th>전화번호</th>
                <td><%=stel1%></td>
              </tr>
              <tr>
                <th>휴대전화번호</th>
                <td><%=stel2%></td>
              </tr>
              <tr>
                <td>이메일</td>
                <td><%=semail%></td>
              </tr>
            </table>
            <img src="./skinwiz/cart/<%=CartSkin%>/images/title_orderinfo03.gif" width="96" height="35"><br>
            <table class="table_main w_default">
              <col width="140px" />
              <col width="*" />
              <tr>
                <th>받으시는 
                  분 성명</th>
                <td><%=rname%></td>
              </tr>
              <tr>
                <th>받으시는 
                  분 주소</th>
                <td>(<%=rzip%>) <%=raddress1%> <%=raddress2%></td>
              </tr>
              <tr>
                <th>받으실 
                  분 전화번호</th>
                <td><%=rtel1%></td>
              </tr>
              <tr>
                <th>받으실 
                  분 휴대전화</th>
                <td><%=rtel2%></td>
              </tr>
              <tr>
                <th>요청사항 
                  (50자 이내)</th>
                <td><%=content%></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td></td>
        </tr>
      </table>
      <div class="agn_c w_default">
      <!-- <img src="./skinwiz/cart/<%=CartSkin%>/images/but_re.gif" width="77" height="28" onClick="javascript:location.href='wizbag.asp?smode=step3';" style="cursor:pointer"> -->
      <img src="./skinwiz/cart/<%=CartSkin%>/images/but_ok2.gif" width="68" height="28" border="0" onclick="javascript:location.replace('wizbag.asp?smode=step5&codevalue=<%=codevalue%>&sname=<%=sname%>&semail=<%=semail%>')" style="cursor:pointer">
      
            </div>
            </td>
  </tr>

</table>
