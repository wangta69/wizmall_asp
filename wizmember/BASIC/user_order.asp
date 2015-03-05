<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->
<%
if session("user_info") = "" then Response.Write("<script>alert('먼저 로그인해 주세요.');history.go(-1);</script>")

Dim strSQL,objRs
Dim db,util, mall
Set util	= new utility	
Set db		= new database
Set mall	= new malls

Dim keyword, where, page, setPageSize, setSubjectCut, setPageLink, whereis, TotalCount, TotalPage
keyword		=  Request("keyword")
where		=  Request("where")
page		=  Request("page")	: if page = "" then page = 1

setPageSize		= 10
setSubjectCut	= 20
setPageLink		= 10

whereis = " where b.sid = '" & user_id & "'"

	strSQL	= "SELECT COUNT(b.uid) FROM wizbuyer b "& whereis & " "
	objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
'' 전체 게시물 및 전체 페이지

	

	TotalCount = objRs(0)
	TotalPage = TotalCount / setPageSize
	IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
		TotalPage = int(TotalPage) + 1
	Else
		TotalPage = int(TotalPage)
	End if

'' 루프 기본 변수
	Dim LoopCount, intNotice, intIndexSize
	LoopCount = 0
	''read_uid = uid
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" valign="top"><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6">
          <td width="15" height="22">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="./wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22">Home &gt; <strong>주문조회</strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="center"><table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr>
          <td bgcolor="#EEEEEE">- 고객님께서 주문하신 내역입니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="center"><table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">&nbsp;</td>
        </tr>
        <tr>
          <td align="right">&nbsp;</td>
        </tr>
        <tr>
          <td align="right"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="company">
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%" class="agn_l">
                    <tr>
                      <td><img src="./wizmember/<%=MemberSkin%>/images/point_cart_01.gif" width="8" height="11"></td>
                      <td>회원가입후 현재까지 <strong><%=user_id%></strong> 의 주문내역 
                        입니다. </td>
                    </tr>
                    <tr>
                      <td><img src="./wizmember/<%=MemberSkin%>/images/point_cart_01.gif" width="8" height="11"></td>
                      <td> 주문번호를 클릭하면 자세한 사항을 보실 수 있습니다.</td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%" class="agn_l">
                    <tr>
                      <td height="3" colspan="7" bgcolor="#CCCCCC"></td>
                    </tr>
                    <tr>
                      <td width="46" height="27" bgcolor="#f3f3f3">&nbsp;</td>
                      <td height="27" align="center" bgcolor="#F2F2F2"><font color="#000000">주문번호</font></td>
                      <td height="27" align="center" bgcolor="#F2F2F2"><font color="#000000">상품명</font></td>
                      <td width="103" align="center" bgcolor="#F2F2F2"><font color="#000000">구매금액</font></td>
                      <td width="77" align="center" bgcolor="#F2F2F2"><font color="#000000"> 결제방식</font></td>
                      <td width="77" align="center" bgcolor="#F2F2F2"><font color="#000000"> 거래상태</font></td>
                      <td width="109" align="center" bgcolor="#F2F2F2"><font color="#000000"> 주문일시</font></td>
                    </tr>
                    <tr>
                      <td height="1" colspan="7" bgcolor="#cfcfcf"></td>
                    </tr>
                    <%
strSQL = "EXEC getOderList  """&page&""", """&setPageSize&""", ""b.codevalue, b.paytype, b.paymoney, b.totalmoney,b.processing,b.wdate"",""b.uid"", ""b.sid='" & user_id &"'"", ""b.uid desc"""
''Response.Write(strSQL)
Dim cnt, ListNum, paytype, paymoney, totalmoney, codevalue, processing, wdate, PName, totalpcount, orderproductname
Dim DeliveryStatus
Dim smode
Set objRs = db.ExecSQLReturnRs(strSQL, Nothing, DbConnect)
cnt = 0
while not objRs.eof
cnt = cnt+1
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - cnt + 1

paytype 		= objRs("paytype")
paymoney 		= objRs("paymoney")
totalmoney 		= objRs("totalmoney")
codevalue 		= objRs("codevalue")
processing 		= objRs("processing")
wdate 			= objRs("wdate")
pname 			= objRs("pname")
totalpcount		= objRs("totalcount")
''totalamount		= objRs("totalamount")
if totalpcount > 1 then
	orderproductname = pname&" 외"&(totalpcount - 1)
else 
	orderproductname = pname
end if
DeliveryStatus	= DeliveryStatusArr(processing)

%>
                    <tr>
                      <td width="46" height="27" bgcolor="#f3f3f3"><font color="#144179"><img src="./wizmember/<%=MemberSkin%>/images/point_list_01.gif" width="21" height="9"><%=ListNum%></font></td>
                      <td height="27" align="center"><strong><a href="wizmember.asp?smode=orderspec&codevalue=<%=codevalue%>"> <%=codevalue%> </a></strong></td>
                      <td height="27" align="center"><%=orderproductname%></td>
                      <td width="103" align="center"><%=FormatNumber(totalmoney, 0)%> 원</td>
                      <td width="77" align="center"><%=mall.getPayType(paytype)%></td>
                      <td width="77" align="center"><%=DeliveryStatus%></td>
                      <td width="109" align="center"><%=FormatDateTime(wdate,2)%></td>
                    </tr>
                    <tr>
                      <td height="1" colspan="7" bgcolor="#cfcfcf"></td>
                    </tr>
                    <%
objRs.movenext
wend
%>
                    <tr align="center">
                      <td height="27" colspan="7" bgcolor="#f3f3f3">&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="1" colspan="7" bgcolor="#cfcfcf"></td>
                    </tr>
                    <tr class="agn_c">
                      <td height="27" colspan="7">    <% 
Dim preimg : preimg = "wizmember/" & MemberSkin & "/img_order/pre.gif"
Dim nextimg : nextimg = "wizmember/" & MemberSkin & "/img_order//next.gif"	
Dim design
Dim linkurl : linkurl = "wizmember.asp.asp?smode="&smode
Call mall.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set mall = Nothing
	%></td>
                    </tr>
                    <tr>
                      <td height="1" colspan="7" bgcolor="#cfcfcf"></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td align="right">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
