<%
'------------------------------------------------------------------------------
' FILE NAME : result.asp
' DATE : 2004-11-10
' 이페이지는 거래결과를 받아 사용자에게 보여주거나, DB처리등 사후처리를 하기위한 샘플페이지입니다.
'------------------------------------------------------------------------------->

authyn = request.form("reAuthyn")
trno   = request.form("reTrno")
trddt  = request.form("reTrddt")
trdtm  = request.form("reTrdtm")
amt    = request.form("reAmt")
authno = request.form("reAuthno")
msg1   = request.form("reMsg1")
msg2   = request.form("reMsg2")
ordno  = request.form("reOrdno")
isscd  = request.form("reIsscd")
aqucd  = request.form("reAqucd")
result = request.form("reResult")

'업체에서 추가하신 인자값을 받는 부분입니다
a = request.form("a") 
b = request.form("b") 
c = request.form("c") 
d = request.form("d")
'업체에서 추가하신 인자값을 받는 부분입니다
%>
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<html>
<head> 
	<title>입력값</title>
	<link rel="stylesheet" href="form.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body bgcolor=#ffffff onLoad="">
<%
if authyn = "O" then 
	''SESSION("CART_CODE")
	strSQL = "update wizbuyer set processing = '2', pay_date=getdate() where codevalue='" & ordno & "'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	 Response.Write "<script>"
	 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step4&codevalue="& ordno &"')"
	 Response.Write"</script>"
else
		 Response.Write "<script>"
		 //Response.Write "parent.location.replace('../../../wizbag.asp?smode=step1')"
		 Response.Write "self.close())"
		 Response.Write "</script>"
end if
%>
<CENTER><B><font size=4 color="blue">성공페이지 내역.</font></B></CENTER>
<br>
<TABLE  width="800" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="center" colspan=4>
			<br>
			이페이지는 <font color = "red">승인성공시</font>에 업체측으로 리턴되는 결과 값들을 나타내고 있읍니다. 
			<br>
			아래와 같은 리턴 항목들중에서 귀사에서 필요하신 부분만 받으셔서 사용하시면 됩니다.
			<br>
			<br>
		</td>
	</tr>
<TR>
	<TD><B>항목명</B></TD>
	<TD><B>변수명</B></TD>
	<TD><B>결과값</B></TD>
	<TD><B>비고</B></TD>
</TR>
<TR>
	<TD>승인구분</TD>
	<TD>authyn</TD>
	<TD><%if authyn = "O" then response.write "승인" else response.write "거절" end if%></TD>
	<TD>승인요청에 대하여 승인이 허락되던지 <br>거절되던지 리턴값의 항목은 같읍니다.</TD>
</TR>
<TR>
	<TD>거래번호</TD>
	<TD>trno</TD>
	<TD><%=trno%></TD>
	<TD>거래번호는 중요합니다. <br>결재정보중 유니크키로 사용하는값으로 사후 승인취소등의 처리시 꼭 필요합니다.</TD>
</TR>
<TR>
	<TD>거래일자</TD>
	<TD>trddt</TD>
	<TD><%=trddt%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>거래시간</TD>
	<TD>trdtm</TD>
	<TD><%=trdtm%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>카드사 승인번호/은행 코드번호</TD>
	<TD>authno</TD>
	<TD><%=authno%></TD>
	<TD>승인번호는 카드사에서 발급하는 것으로 유니크하지 않을수도 있음에 주의하십시요.</TD>
</TR>
<TR>
	<TD>발급사코드/가상계좌번호/계좌이체번호/휴대폰결제기관</TD>
	<TD>isscd</TD>
	<TD><%=isscd%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>매입사코드/실물-디지털구분</TD>
	<TD>aqucd</TD>
	<TD><%=aqucd%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>주문번호</TD>
	<TD>ordno</TD>
	<TD><%=ordno%></TD>
	<TD>주문번호는 업체측에서 넘겨주신 값을 그대로 리턴해드립니다.</TD>
</TR>
<TR>
	<TD>금액</TD>
	<TD>amt</TD>
	<TD><%=amt%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>메세지1</TD>
	<TD>msg1</TD>
	<TD><%=msg1%></TD>
	<TD>메세지는 카드사에서 보내는 것을 그대로 리턴해 드리는것으로<br> KSNET에서 생성된 내용은 아닙니다.</TD>
</TR>
<TR>
	<TD>메세지2</TD>
	<TD>msg2</TD>
	<TD><%=msg2%></TD>
	<TD>승인성공시 이부분엔 OK와 승인번호가 표시됩니다.</TD>
</TR>
<TR>
    <TD>결제수단</TD>
    <TD>result</TD>
    <TD><%=result%></TD>
    <TD>결제수단이 표시됩니다.</TD>
</TR>
<TR>
	<TD>사용자추가 인자값</TD>
	<TD>&nbsp;</TD>
	<TD>
	a = <%=a%><br>
	b = <%=b%><br>
	c = <%=c%><br>
	d = <%=d%><br>
	</TD>
	<TD>&nbsp;</TD>
</TR>

	<tr>
		<td align="center" colspan=4>
			<br>
			<br>
			<br>
		</td>
	</tr>
</TABLE>
</body>
</html>