<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.cart.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim tablename,theme,menushow,keyword,whereis,page,setPageSize,setSubjectCut,setPageLink
Dim TotalCount, TotalPage
Dim cnt,ListNum,sname,sid,sjumin1,sjumin2,semail,stel1,stel2,szip,saddress1,saddress2,rname
Dim remail,rtel1,rtel2,rzip,raddress1,raddress2,paytype,paymoney,totalmoney,bankinfo,inputer
Dim codevalue,processing,content,rdate,wdate,DeliveryStatus
Dim pid, pname, model, getcomp, wongaprice, opstr, unit, price, qty

Dim strSQL,objRs
Dim db,util, cart
Set util	= new utility	
Set db		= new database
Set cart	= new wizcart

keyword		=  Request("keyword")
whereis		=  Request("whereis")
Dim ExcelFileName

response.buffer				= true

Response.Expires			= 0

Response.ContentType		= "application/vnd.ms-excel; name='My_Excel'"

Response.Charset			= " "

Response.CacheControl		= "public"

ExcelFileName				= "주문배송조회_[" & Date & "]"


Response.AddHeader "Content-Disposition","attachment;filename=" & ExcelFileName & ".xls"


whereis = "where b.uid <> 0 "
whereis = whereis & " and b.processing < 4"
'' // 전체 게시물 및 전체 페이지
%>
<style>
br{mso-data-placement:same-cell;}
</style>
      <table>
        <tr> 
          <th>주문번호</th>
          <th>주문일시</th>
          <th>상품코드</th>
          <th>품명</th>
          <th>모델명</th>
          <th>옵션</th>
          <th>규격</th>
          <th>공급사</th>
          <th>구매가</th>
          <th>판매가</th>
          <th>고객명</th>
          <th>연락처1</th>
          <th>연락처2</th>
          <th>주소</th>
          <th>수량</th>
          </tr>
        <%
		
strSQL	= "select  b.*, c.pid, c.qty, c.price, c.tprice, c.point, c.optionflag, m.pname, m.model, m.getcomp, m.wongaprice, m.price, m.unit from wizbuyer b " & _
			" left join wizcart c on c.oid = b.codevalue " & _
			" left join wizmall m on c.pid = m.pid " & _
			" " &  whereis &" ORDER BY b.uid desc"

'Response.Write(strSQL)
cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
cnt = cnt+1

ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - cnt + 1
sname 			= objRs("sname")
sid					= user_id
sjumin1 			= objRs("sjumin1")
sjumin2 			= objRs("sjumin2")
semail 			= objRs("semail")
stel1 				= objRs("stel1")
stel2 				= objRs("stel2")
szip 				= objRs("szip")
saddress1 		= objRs("saddress1")
saddress2 		= objRs("saddress2")
rname 			= objRs("rname")
remail 			= objRs("remail")
rtel1 				= objRs("rtel1")
rtel2 				= objRs("rtel2")
rzip 				= objRs("rzip")
raddress1 		= objRs("raddress1")
raddress2 		= objRs("raddress2")
paytype 			= objRs("paytype")
paymoney		= objRs("paymoney")
totalmoney	 	= objRs("totalmoney")
bankinfo 		= objRs("bankinfo")
inputer 			= objRs("inputer")
codevalue 		= objRs("codevalue")
processing		= objRs("processing")
content 			= objRs("content")
rdate 				= objRs("rdate")
wdate 			= objRs("wdate")



pid 			= objRs("pid")
pname 			= objRs("pname")
model 			= objRs("model")
getcomp 		= objRs("getcomp")
wongaprice 		= objRs("wongaprice")
unit	 		= objRs("unit")
price 			= objRs("price")
qty 			= objRs("qty")
opstr			= cart.getOptionview(objRs("optionflag"))
%>
        <tr> 
          <td><%=codevalue%></td>
          <td><%=FormatDateTime(wdate,2)%></td>
          <td><%=pid%></td>
          <td><%=pname%></td>
          <td><%=model%></td>
          <td><%=opstr%></td>
          <td><%=unit%></td>
          <td><%=getcomp%></td>
          <td><%=wongaprice%></td>
          <td><%=price%></td>
          <td><%=sname%></td>
          <td><%=rtel1%></td>
          <td><%=rtel2%></td>
          <td>(<%=rzip%>) <%=raddress1%> <%=raddress2%></td>
          <td><%=qty%></td>
          </tr>
        <%
objRs.movenext
wend
%>
      </table>
                 
<%
SET objRs =NOTHING
%>			