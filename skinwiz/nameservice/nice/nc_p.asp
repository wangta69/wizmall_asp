<!-- #include file = "../../../config/membercheck_info.asp" -->
<%
response.expires = -1 
Dim SITEID, SITEPW, LOGDIR

	SITEID = realnameID	' ����Ʈ ������ �ּ���.
	SITEPW = realnamePWD	' ����Ʈ ��й�ȣ ������ �ּ���.
	 
	Dim sName, sJumin
	sJumin = Trim(request.Form("jumin1")) & Trim(request.Form("jumin2")) 'nc.asp ���� �Է��� �ֹι�ȣ�� �����´�.
	
	
	sName = Trim(request.Form("name"))	'nc.asp ���� �Է��� �̸��� �����´�.
	
	' ��ü ����
	' dll ȣ�� �Ѵ�.
	if ( sJumin <> "" And sName <> "" ) then
		Set oDll =  Server.CreateObject("cb_name.NameChk")
	    oDll.bstrLogFile = LOGDIR
		
		' �ѽ������� �Ʒ����ڰ��� �Ѱ��ش�. iRtn ������ ����� �޾ƿ´�.
		' ���� : ����Ʈ�ڵ�, ��й�ȣ, �ֹι�ȣ, �̸�, ��ȣȭ����, �����Ʈ ����...
	    iRtn = oDll.fnNameChk(SITEID, SITEPW, sJumin, sName, 21, 5)
	    Set oDll = Nothing
	
	
		' ---> iRtn ������� ���� �Ʒ��� ���� ó���Ͽ� �ش�. (������� �ڼ��� ������ �����ڵ�.txt ������ ������ �ּ���~)
		'				iRtn �������� 1 �̸� --> �Ǹ����� ���� : XXX.asp �� ������ �̵�. 
		'											2 �̸� --> �Ǹ����� ���� : �ֹΰ� �̸��� ��ġ���� ����. ����ڰ� ���� www.namecheck.co.kr �� �����Ͽ� ��� or 1600-1522 �ݼ��ͷ� ������û.
		'																	�Ʒ��� ���� �ѽ��򿡼� ������ �ڹٽ�ũ��Ʈ �̿��ϼŵ� �˴ϴ�.		
		'											3 �̸� --> �ѽ��� �ش��ڷ� ���� : ����ڰ� ���� www.namecheck.co.kr �� �����Ͽ� ��� or 1600-1522 �ݼ��ͷ� ������û.
		'																	�Ʒ��� ���� �ѽ��򿡼� ������ �ڹٽ�ũ��Ʈ �̿��ϼŵ� �˴ϴ�.
		'											5 �̸� --> üũ�����(�ֹι�ȣ������Ģ�� ��߳� ���: ���Ƿ� ������ ���Դϴ�.)
		'											50�̸� --> ũ������ũ�� ���ǵ������� ���� �������� : ���� ���ǵ������� ���� �� �Ǹ����� ��õ�.
		'																	�Ʒ��� ���� �ѽ��򿡼� ������ �ڹٽ�ũ��Ʈ �̿��ϼŵ� �˴ϴ�.
		'											�׹ۿ� --> 30����, 60���� : ��ſ��� ip: 203.234.219.72 port: 81~85(5��) ��ȭ�� ���� ���µ�����ش�. 
		'																(������� �ڼ��� ������ �����ڵ�.txt ������ ������ �ּ���~) 
        select case iRtn
        case 1
        ' �Ǹ����� �����Դϴ�. ��ü�� �°� ������ ó�� �Ͻø� �˴ϴ�.
        Response.write iRtn   
 
%>
			<script language='javascript'>
				//alert("��������!! ^^");
			</script>

	
			<!-- ������ ó���� �ϽǶ����� �Ʒ��Ͱ��� ó���ϼŵ� �˴ϴ�. �̵��� �������� �����ؼ� ����Ͻø� �˴ϴ�. 	-->
			<html>
				<head>
				</head>
				<body onLoad="document.form1.submit()">
					<form name="form1" method="post" action="/wizmember.asp?mode=regis_step2">
						<input type="hidden" name="jumin1" value="<%=Trim(request.Form("jumin1"))%>">
						<input type="hidden" name="jumin2" value="<%=Trim(request.Form("jumin2"))%>">
						<input type="hidden" name="name" value="<%=sName%>">
					</form>
				</body>
			</html>>
		
			
     
<%
		case 2
		'���ϰ� 2�� ������� ���, www.namecheck.co.kr �� �Ǹ���Ȯ�� �Ǵ� 02-1600-1522 �ݼ��ͷ� �����ֽñ� �ٶ��ϴ�.   			
%>
            <script language="javascript">
               history.go(-1); 
               var URL ="http://www.creditbank.co.kr/its/its.cb?m=namecheckMismatch"; 
               var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no, width= 640, height= 480, top=0,left=20"; 
               window.open(URL,"",status); 
            </script> 
<%
		case 3
		'���ϰ� 3�� ������� ���, www.namecheck.co.kr �� �Ǹ���Ȯ�� �Ǵ� 02-1600-1522 �ݼ��ͷ� �����ֽñ� �ٶ��ϴ�.   			
%>
            <script language="javascript">
               history.go(-1); 
               var URL ="http://www.creditbank.co.kr/its/its.cb?m=namecheckMismatch"; 
               var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no, width= 640, height= 480, top=0,left=20"; 
               window.open(URL,"",status); 
            </script> 

<%
		case 50
		'���ϰ� 50 ���ǵ������� ���� �������� ���, www.creditbank.co.kr ���� ���ǵ����������� �� ��õ� ���ֽø� �˴ϴ�. 
		' �Ǵ� 02-1600-1533 �ݼ��ͷι����ּ���.
%>	

            <script language="javascript">
               history.go(-1); 
               var URL ="http://www.creditbank.co.kr/its/itsProtect.cb?m=namecheckProtected"; 
               var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no, width= 640, height= 480, top=0,left=20"; 
               window.open(URL,"",status); 
            </script> 
 
<%
		case else
		'������ ������ ���� �����ڵ�.txt �� �����Ͽ� ���ϰ��� Ȯ���� �ּ���~
%>
			<script language='javascript'>
				alert("������ ���� �Ͽ����ϴ�. �����ڵ�:[<%=iRtn%>]");
				history.go(-1);
			</script>
<%
		end select 		
	else
		Response.write "<Script Language='JavaScript'>"
		Response.write "	alert('�����̳� �ֹι�ȣ�� �Է��ϼ���.');"
		Response.write "	history.go(-1);"
		Response.write "</Script>"			
	end if
%>
