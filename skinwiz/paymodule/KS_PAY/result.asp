<%
'------------------------------------------------------------------------------
' FILE NAME : result.asp
' DATE : 2004-11-10
' ���������� �ŷ������ �޾� ����ڿ��� �����ְų�, DBó���� ����ó���� �ϱ����� �����������Դϴ�.
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

'��ü���� �߰��Ͻ� ���ڰ��� �޴� �κ��Դϴ�
a = request.form("a") 
b = request.form("b") 
c = request.form("c") 
d = request.form("d")
'��ü���� �߰��Ͻ� ���ڰ��� �޴� �κ��Դϴ�
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
	<title>�Է°�</title>
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
<CENTER><B><font size=4 color="blue">���������� ����.</font></B></CENTER>
<br>
<TABLE  width="800" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="center" colspan=4>
			<br>
			���������� <font color = "red">���μ�����</font>�� ��ü������ ���ϵǴ� ��� ������ ��Ÿ���� �����ϴ�. 
			<br>
			�Ʒ��� ���� ���� �׸���߿��� �ͻ翡�� �ʿ��Ͻ� �κи� �����ż� ����Ͻø� �˴ϴ�.
			<br>
			<br>
		</td>
	</tr>
<TR>
	<TD><B>�׸��</B></TD>
	<TD><B>������</B></TD>
	<TD><B>�����</B></TD>
	<TD><B>���</B></TD>
</TR>
<TR>
	<TD>���α���</TD>
	<TD>authyn</TD>
	<TD><%if authyn = "O" then response.write "����" else response.write "����" end if%></TD>
	<TD>���ο�û�� ���Ͽ� ������ ����Ǵ��� <br>�����Ǵ��� ���ϰ��� �׸��� �����ϴ�.</TD>
</TR>
<TR>
	<TD>�ŷ���ȣ</TD>
	<TD>trno</TD>
	<TD><%=trno%></TD>
	<TD>�ŷ���ȣ�� �߿��մϴ�. <br>���������� ����ũŰ�� ����ϴ°����� ���� ������ҵ��� ó���� �� �ʿ��մϴ�.</TD>
</TR>
<TR>
	<TD>�ŷ�����</TD>
	<TD>trddt</TD>
	<TD><%=trddt%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>�ŷ��ð�</TD>
	<TD>trdtm</TD>
	<TD><%=trdtm%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>ī��� ���ι�ȣ/���� �ڵ��ȣ</TD>
	<TD>authno</TD>
	<TD><%=authno%></TD>
	<TD>���ι�ȣ�� ī��翡�� �߱��ϴ� ������ ����ũ���� �������� ������ �����Ͻʽÿ�.</TD>
</TR>
<TR>
	<TD>�߱޻��ڵ�/������¹�ȣ/������ü��ȣ/�޴����������</TD>
	<TD>isscd</TD>
	<TD><%=isscd%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>���Ի��ڵ�/�ǹ�-�����б���</TD>
	<TD>aqucd</TD>
	<TD><%=aqucd%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>�ֹ���ȣ</TD>
	<TD>ordno</TD>
	<TD><%=ordno%></TD>
	<TD>�ֹ���ȣ�� ��ü������ �Ѱ��ֽ� ���� �״�� �����ص帳�ϴ�.</TD>
</TR>
<TR>
	<TD>�ݾ�</TD>
	<TD>amt</TD>
	<TD><%=amt%></TD>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>�޼���1</TD>
	<TD>msg1</TD>
	<TD><%=msg1%></TD>
	<TD>�޼����� ī��翡�� ������ ���� �״�� ������ �帮�°�����<br> KSNET���� ������ ������ �ƴմϴ�.</TD>
</TR>
<TR>
	<TD>�޼���2</TD>
	<TD>msg2</TD>
	<TD><%=msg2%></TD>
	<TD>���μ����� �̺κп� OK�� ���ι�ȣ�� ǥ�õ˴ϴ�.</TD>
</TR>
<TR>
    <TD>��������</TD>
    <TD>result</TD>
    <TD><%=result%></TD>
    <TD>���������� ǥ�õ˴ϴ�.</TD>
</TR>
<TR>
	<TD>������߰� ���ڰ�</TD>
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