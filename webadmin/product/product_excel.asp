<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim category, category1,category2,category3,pname,model,getcomp,porigin,compname,wongaprice,price1,price, smode
Dim deliveryfee,pdisplay,pnone,picture,picture1,picture2,picture3,description1,description2,description3
Dim whereis, s_category, keyword

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database



smode				= Request("smode")
s_category			= Request("s_category")
keyword				= Request("keyword")

if smode = "pnone" Then
	whereis = " where uid is not null and (pnone = 1 or pnone = 2)"
	
Else
	whereis = " where uid  = pid and pnone = 0"
End if
if s_category <> "" then 
		whereis = whereis & " and category like '%" & s_category &"'"
end if

if keyword <> "" then
	keyword = trim(keyword)
	whereis	= whereis & " and  ( pname LIKE '%" & keyword & "%' or description1 LIKE '%" & keyword & "%' OR model LIKE '%" & keyword & "%' )"
end if

''Response.Write(whereis)

Dim ExcelFileName
response.buffer				= true
Response.Expires			= 0
Response.ContentType		= "application/vnd.ms-excel; name='My_Excel'"
Response.Charset			= " "
Response.CacheControl		= "public"
ExcelFileName				= "상품리스트_[" & Date & "]"
Response.AddHeader "Content-Disposition","attachment;filename=" & ExcelFileName & ".xls"
%>
<style>
br{mso-data-placement:same-cell;}
</style>
      <table>
        <tr> 
          <th>대분류</th>
          <th>중분류</th>
          <th>소분류</th>
          <th>상품명</th>
          <th>모델명</th>
          <th>공급사</th>
          <th>원산지</th>
		  <th>제조사</th>
		  <th>구매가</th>
		  <th>시중가</th>
		  <th>판매가</th>
		  <th>택배비</th>
		  <th>상품노출</th>
		  <th>판매상태</th>
		  <th>이미지대</th>
		  <th>이미지중</th>
		  <th>이미지소</th>
		  <th>상세설명이미지</th>
		  <th>제품설명</th>
		  <th>간단한설명</th>
		  <th>배송정보</th>
        </tr>
        <%
		
strSQL = "select  * from wizmall "& whereis &" ORDER BY uid desc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof

category 			= objRs("category")
category1			= ""
category2			= ""
category3			= ""

if len(category) = 9 Then
	category1 = mid(category, 7, 3)
	category2 = mid(category, 4, 3)
	category3 = mid(category, 1, 3)
ElseIf len(category) = 6 Then
	category1 = mid(category, 4, 3)
	category2 = mid(category, 1, 3)
Else 
	category1 = mid(category, 1, 3)
End If

pname				= objRs("pname")
model				= objRs("model")
porigin				= objRs("porigin")
compname			= objRs("compname")
getcomp				= objRs("getcomp")

wongaprice			= objRs("wongaprice")
price1				= objRs("price1")
price				= objRs("price")
deliveryfee			= objRs("deliveryfee")
if objRs("pdisplay") = "0" THEN pdisplay = "Y" ELSE pdisplay="N" end if
pnone				= objRs("pnone")
if IsNull(objRs("picture")) = False Then
	picture				= split(objRs("picture"), "|")
	''Response.Write(objRs("picture"))
	if Ubound(picture) > 0 Then picture1			= picture(0)		
	if Ubound(picture) > 1 Then picture2			= picture(1)
	if Ubound(picture) >= 1 Then picture3			= picture(2)
End If
description1		= objRs("description1")


compname			= objRs("compname")

%>
        <tr> 
          <td><%=category1%></td>
          <td><%=category2%></td>
          <td><%=category3%></td>
          <td><%=pname%></td>
          <td><%=model%></td>
          <td><%=getcomp%></td>
          <td><%=porigin%></td>
		  <td><%=compname%></td>
		  <td><%=wongaprice%></td>
		  <td><%=price1%></td>
		  <td><%=price%></td>
		  <td><%=deliveryfee%></td>
		  <td><%=pdisplay%></td>
		  <td><%=pnone%></td>
		  <td><%=picture1%></td>
		  <td><%=picture2%></td>
		  <td><%=picture3%></td>
		  <td></td>
		  <td><%''=description1%></td>
		  <td><%=description2%></td>
		  <td><%=description3%></td>
        </tr>
        <%
objRs.movenext
wend
%>
      </table>
                 
<%
SET objRs =NOTHING
%>			