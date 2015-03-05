<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
Dim whereis, orderArr, orderby, TotalCount, cnt, setImgWidth, VIEW_LINK, stockouticon, tmpcnt
Dim Loopcnt
Set db		= new database
Set mall	= new malls
whereis = "where m1.category like '%"&code&"' and m1.pdisplay <> 1"

if searchmode = "innersearch" and stext <> "" then
	whereis = whereis & " and (m2.pname like '%"&stext&"%' or m2.brand like '%"&stext&"%' or m2.description1 like '%"&stext&"%')"
end If

if order <> "" then
	orderArr	= split(order, "/")
	orderby		= " order by " & orderArr(0) & " " & orderArr(1) 
else 
	if DefaultOrder <> "" then
		orderArr	= split(DefaultOrder, "/")
		orderby		= " order by " & orderArr(0) & " " & orderArr(1) 
	else
		orderby		= " order by m1.uid desc"
	end if
end if

strSQL		= "SELECT COUNT(m1.uid) FROM wizmall m1 left join wizmall m2 on m1.pid = m2.uid " & whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount	= objRs(0)
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <form name="orderForm" method="post" action="wizmart.asp">
    <input type="hidden" name="code" value="<%=code%>">
    <tr>
      <td> 총<%=TotalCount%>개의 상품이 있습니다.</td>
      <td align="right"><select name="order" onchange="submit();">
          <option value="">정렬방식선택</option>
          <option value="m2.uid/desc" <% if order = "m2.uid/desc" then Response.Write("selected") %>>상품등록순</option>
          <option value="m2.price/asc" <% if order = "m2.price/asc" then Response.Write("selected") %>>저가격순</option>
          <option value="m2.price/desc" <% if order = "m2.price/desc" then Response.Write("selected") %>>고가격순</option>
        </select>
      </td>
    </tr>
  </form>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="center">
    <%
	
strSQL = "select TOP " & ListNo & " m1.uid, m1.category, m2.pname, m2.picture, m2.option3, m2.pnone, m2.stock, m2.stockouttype, m2.pinput, m2.poutput, m2.model, m2.Price, m2.Price1 from wizMall m1 left join wizMall m2 on m1.pid = m2.uid " & whereis & " and m1.uid not in (SELECT TOP " & ((page - 1) * ListNo) & " m1.uid from wizMall m1 left join wizMall m2 on m1.pid = m2.uid " & whereis & orderby & ") " & orderby 

cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
setImgWidth = 120
while not objRs.eof
    PictureArr = split(objRs("Picture"), "|")
	if ubound(PictureArr) > 0 then Picture0 = PictureArr(0) end if
	if ubound(PictureArr) > 0 then Picture1 = PictureArr(1) end if
	if ubound(PictureArr) > 1 then Picture2 = PictureArr(2) end if

	option3			= objRs("option3")
	uid				= objRs("uid")
	pnone			= objRs("pnone")
	pname			= objRs("pname")
	stock			= objRs("stock")
	price			= objRs("price")
	price1			= objRs("price1")
	model			= objRs("model")
	category		= objRs("category")
	stockouttype	= objRs("stockouttype")
	pinput			= objRs("pinput")
	poutput			= objRs("poutput")
	dpIcon			= mall.getOptionICon(option3,IconSkin,DisplayOptionIconArr)''option_arg, iconskin, OptionIcon
	//Response.Write(option3&","&IconSkin&","&DisplayOptionIconArr)
	stockstate		= mall.stockStatus(uid, pnone, stock, stockouttype, pinput, poutput)	
	//Response.Write(uid&","&pnone&","&stock&","&stockouttype&","&pinput&","&poutput)
	if stockstate = false  then 
		VIEW_LINK = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
		stockouticon = "<img src='./skinwiz/common_icon/"&iconskin&"/icon_soldout.gif'>"
		
	else 
		VIEW_LINK = "'./wizmart.asp?smode=view&code=" & Category & "&no=" & uid & "'"
		stockouticon = ""
	end if
%>
    <td height="190" valign="top"><table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="80" align="center"><table border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
              <tr>
                <td width="80" align="center"><table width="120" height="120" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%" bordercolor="#bababa">
                    <tr>
                      <td align="center" bgcolor="#FFFFFF"><A HREF=<%=VIEW_LINK%>> <%=mall.getGoodsImg(Picture2, setImgWidth) %></A> </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td align="center" class="company"><A HREF=<%=VIEW_LINK%>> <%=pname%></a>
                  <% 
						if Model <> "" then  
							Response.Write("<br>" & Model)
						end if
						%>
                  <br>
                  <font color="#006699"><strong> <%=FormatNumber(Price, 0)%> 원</strong></font></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <%
cnt = cnt + 1
if cnt mod 4 = 0 then Response.Write "</tr><tr align='center'><td background='img/main/bg_w.gif' height='1' colspan='4'></td></tr><tr align='center'>"
objRs.movenext
wend
tmpcnt = cnt mod 4
if tmpcnt <> 0 then
	for Loopcnt = tmpcnt to 3
		Response.Write("<td width='176'></td>")
	next
end if
%>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    <% 
Dim preimg : preimg = "skinwiz/shop/" & ShopSkin & "/images/pre.gif"
Dim nextimg : nextimg = "skinwiz/shop/" & ShopSkin & "/images/next.gif"	
Dim design
Dim linkurl : linkurl = "wizmart.asp?code="&code&"&order="&order
Call mall.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set mall = Nothing
	%>
</td>
  </tr>
</table>
<%
db.Dispose : Set db		= Nothing : Set util	= Nothing : Set mall = Nothing
%>
