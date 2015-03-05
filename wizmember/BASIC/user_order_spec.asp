<% Option Explicit %>
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
'' 제작자 : 폰돌                     
'' URL : http://www.shop-wiz.com      
'' Email : master@shop-wiz.com       
'' Copyright (C) 2008  shop-wiz.com 

Dim codevalue
Dim uid,sname,sid,sjumin1,sjumin2,semail,stel1,stel2,szip,saddress1,saddress2,rname,remail
Dim rtel1,rtel2,rzip,raddress1,raddress2,paytype,paymoney,totalmoney,pointmoney,bankinfo,inputer
Dim processing,deliverer,invoiceno,content,rdate,wdate,pay_date,paytype_str
Dim exe_file	
Dim strSQL,objRs
Dim db,util
Set util = new utility	: Set db = new database

codevalue	= Request("codevalue")

if codevalue = "" then
	Call util.js_alert("잘못된 접근입니다.","")
else
	strSQL = "SELECT * FROM wizbuyer WHERE codevalue='"&codevalue&"'"
	Set objRs = db.ExecSQLReturnRs(strSQL, Nothing, DbConnect)
end if
 
if objRs.eof then Call util.js_alert("\n\n주문번호 : " & codevalue & "에 대한 데이터가 존재하지 않습니다.   \n\n관리자에게 문의하십시오.\n\n","")


uid			= objRs("uid")
sname		= objRs("sname")
sid			= objRs("sid")
if sid = "" then sid = "비회원"
''sjumin1		= objRs("sjumin1")
''sjumin2		= objRs("sjumin2")
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
paytype		= objRs("paytype")
paymoney	= objRs("paymoney")
totalmoney	= objRs("totalmoney")
pointmoney	= totalmoney - paymoney
bankinfo	= objRs("bankinfo")
inputer		= objRs("inputer")
''codevalue	= objRs("codevalue")
processing	= objRs("processing")
deliverer	= objRs("deliverer")
invoiceno	= objRs("invoiceno")
content		= objRs("content")
rdate		= objRs("rdate")
wdate		= objRs("wdate")
pay_date	= objRs("pay_date")

Select Case paytype
    Case "online"
        paytype_str = "무통장입금"
    Case "card"
        paytype_str = "카드결재"
    Case "hand"
        paytype_str = "핸드폰결재"
    Case "autobank"
        paytype_str = "자동이체"
    Case "point"
        paytype_str = "포인트결재"
    Case "all"
        paytype_str = "다중결재"								
End Select 
db.Dispose : Set objRs = Nothing : Set db = Nothing : Set util = Nothing
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="./wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22">Home &gt; <strong>주문 조회</strong></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="40">&nbsp;</td>
  </tr>
  <tr> 
    <td align="center">
<table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr> 
          <td bgcolor="#EEEEEE">- 고객님께서 주문하신 상품의 상세 내역입니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align="center">
<table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="right"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
              <tr> 
                <td><img src="./wizmember/<%=MemberSkin%>/images/point_cart_01.gif" width="8" height="11">고객님께서 
                  선택하신 상품내역입니다.</td>
              </tr>
              <tr> 
                <td>
                
<%
session("carttype") = "orderspec"
session("tmpcodevalue") = codevalue
exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_view_execute.asp"
SERVER.EXECUTE(exe_file)
%></td>
              </tr>
              <tr> 
                <td><img src="./wizmember/<%=MemberSkin%>/images/title_orderinfo02.gif" width="114" height="35"></td>
              </tr>
              <tr> 
                <td align="left"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <tr bgcolor="#CCCCCC"> 
                      <td height="3" colspan="3"></td>
                    </tr>

                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>보내는
                        분</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=sname%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>					
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>보내는
                        분 E-mail</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=semail%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>보내는
                        분 전화번호</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=stel1%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>보내는
                        분 휴대폰번호</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=stel2%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>수령인</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=rname%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>수령인주소</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left">(<%=rzip%>) <%=raddress1%> <%=raddress2%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>수령인
                        전화번호</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=rtel1%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>수령인
                        휴대폰번호</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=rtel2%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>					
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>배송안내글</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><FONT COLOR=BROWN><%=content%></FONT></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td><img src="./wizmember/<%=MemberSkin%>/images/title_ing.gif" width="83" height="35"></td>
              </tr>
              <tr> 
                <td align="left"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <tr> 
                      <td height="3" colspan="3" bgcolor="#CCCCCC"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>주문번호</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><font color="#FF6600"><strong><%=codevalue%></strong></font></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>주문일자</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=wdate%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>거래상태</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"> 
<%=DeliveryStatusArr(processing)%>                      </td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>택배사</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"> 
				  
<%=deliverer%>                      </td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>송장번호</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"> 
<%=invoiceno%>                      </td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>										
                  </table></td>
              </tr>
              <tr> 
                <td align="left"><img src="./wizmember/<%=MemberSkin%>/images/title_payment01.gif"><br> 
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <tr> 
                      <td height="3" colspan="3" bgcolor="#CCCCCC"></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>결제방식</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><strong>
					<%=paytype_str%></strong></td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>실입금액</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><B><%=FormatNumber(paymoney, 0)%>원</B></td>
                    </tr>					
<%
if paytype = "all" then ''다중결제일경우
%>					

                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>입금계좌</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"> 
                        <%=bankinfo%>                      </td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>입금인</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=inputer%></td>
                    </tr>

                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>포인트</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><B><%=FormatNumber(pointmoney, 0)%>원</B></td>
                    </tr>
<%
elseif paytype = "online" then ''무통장입금일경우
%>

                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>임금계좌</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"> 
                        <%=bankinfo%>                      </td>
                    </tr>
                    <tr> 
                      <td width="142" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"></font>입금인</td>
                      <td width="12" height="27"><img src="./wizmember/<%=MemberSkin%>/images/img_a.gif" width="12" height="27"></td>
                      <td height="27" align="left"><%=inputer%></td>
                    </tr>					
<%
end if
%>
                    <tr> 
                      <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td align="center"> 
            <table width="564" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="36" align="center" valign="bottom"><table width="200" height="42" border="0" cellpadding="0" cellspacing="0">
                    <tr align="center"> 
                      <!-- <td><A HREF='#' onclick='jvascript:self.close()'><img src="./wizmember/<%=MemberSkin%>/images/but_close.gif" width="88" height="28" border="0"></a></td> -->
                      <td><A HREF='#' onclick='jvascript:self.print()'><img src="./wizmember/<%=MemberSkin%>/images/but_print.gif" width="88" height="28" border="0"></a></td>
                    </tr>
                  </table>
                  <br> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
</table>
<br>
