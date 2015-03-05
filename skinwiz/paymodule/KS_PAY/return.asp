<%
	proceed = request.form("proceed")
	xid     = request.form("xid")
	eci     = request.form("eci")
	cavv    = request.form("cavv")
	cardno = request.form("cardno")
	errCode = request.form("errCode")
%>
<html>
<body>
<script language="javascript">
<!--
	function return_proceed()
	{
		parent.paramSet("<%=xid%>","<%=eci%>","<%=cavv%>", "<%=cardno%>");
	
		parent.proceed('<%=proceed%>');
		location.href="https://kspay.ksnet.to/totmpi/dummy.jsp";
	}

	return_proceed();
-->
</script>
</body>
</html>