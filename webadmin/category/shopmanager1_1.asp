<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

''/* 엑셀로 출력하기 */ 
DownForExel = Request("DownForExel")

if DownForExel ="yes" then
	response.buffer=true
	Response.Expires = 0
	Response.ContentType = "application/vnd.ms-excel; name='My_Excel'"
	Response.Charset = " "
	Response.CacheControl = "public"
	ExcelFileName = "쇼핑몰 카테고리_[" & Date & "]"
	
	Response.AddHeader "Content-Disposition","attachment;filename=" & ExcelFileName & ".xls"
end if
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 9">
</head>

<body>

  
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <!-- 대분류 리스트 Start -->
<%
strSQL = "select cat_no, cat_name, cat_price from wizCategory where cat_no < 100 order by cat_no asc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
	cat_no		= objRs("cat_no")
	cat_name	= objRs("cat_name")
	cat_price	= objRs("cat_price")
		Response.Write("<tr>")
		Response.Write("<TD valign='top'><font color='#000000'>"&cat_name&"("&cat_no&")</font></td>")
		Response.Write("<td valign='top'><table width='100%' border='0' cellspacing='0' cellpadding='0' class='s1'>")
		
		strSQL1 = "select cat_no, cat_name, cat_price from wizCategory where cat_no >= 100 and cat_no < 10000 and cat_no LIKE '%"&cat_no&"' order by cat_no asc"
		Set objRs1	= db.ExecSQLReturnRS(strSQL1, Nothing, DbConnect)
		WHILE NOT subobjRs.EOF
			cat_no1		= objRs1("cat_no")
			cat_name1	= objRs1("cat_name")
			cat_price1	= objRs1("cat_price")
			if cat_no1 <> 0 then
				Response.Write("<tr><td valign='top'>")
				Response.Write("<font color='#000000'>"&cat_name1&"("&cat_no1&")</font></td><td>")
				
				strSQL2 = "select cat_no, cat_name, cat_price from wizCategory where cat_no >= 100 and cat_no < 10000 and cat_no LIKE '%"&cat_no&"' order by cat_no asc"
				Set objRs2	= db.ExecSQLReturnRS(strSQL2, Nothing, DbConnect)
				WHILE NOT objRs2.EOF
					cat_no2		= objRs2("cat_no")
					cat_name2	= objRs2("cat_name")
					cat_price2	= objRs2("cat_price")			
					if cat_no2 <> 0 then
						Response.Write("<font color='#000000'>"&cat_name2&"("&cat_no2&")</font><br />")
					end if
				objRs2.MOVENEXT
				WEND
				Response.Write("</td></tr>")
			end if
		
		objRs1.MOVENEXT
		WEND
		Response.Write("</table></td>")		
		Response.Write("</tr><tr><td height='1' bgColor='cccccc' colspan='2'> </td></tr>")
		
objRs.MOVENEXT
WEND
%>
                      <!-- 대분류 리스트 End -->
                    </table>

</body>

</html>
