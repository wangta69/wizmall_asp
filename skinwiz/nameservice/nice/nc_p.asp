<!-- #include file = "../../../config/membercheck_info.asp" -->
<%
response.expires = -1 
Dim SITEID, SITEPW, LOGDIR

	SITEID = realnameID	' 사이트 수정해 주세요.
	SITEPW = realnamePWD	' 사이트 비밀번호 수정해 주세요.
	 
	Dim sName, sJumin
	sJumin = Trim(request.Form("jumin1")) & Trim(request.Form("jumin2")) 'nc.asp 에서 입력한 주민번호를 가져온다.
	
	
	sName = Trim(request.Form("name"))	'nc.asp 에서 입력한 이름을 가져온다.
	
	' 객체 생성
	' dll 호출 한다.
	if ( sJumin <> "" And sName <> "" ) then
		Set oDll =  Server.CreateObject("cb_name.NameChk")
	    oDll.bstrLogFile = LOGDIR
		
		' 한신평으로 아래인자값을 넘겨준다. iRtn 변수에 결과값 받아온다.
		' 인자 : 사이트코드, 비밀번호, 주민번호, 이름, 암호화길이, 사용포트 갯수...
	    iRtn = oDll.fnNameChk(SITEID, SITEPW, sJumin, sName, 21, 5)
	    Set oDll = Nothing
	
	
		' ---> iRtn 결과값에 따라 아래와 같이 처리하여 준다. (결과값의 자세한 사항은 리턴코드.txt 파일을 참고해 주세요~)
		'				iRtn 변수값이 1 이면 --> 실명인증 성공 : XXX.asp 로 페이지 이동. 
		'											2 이면 --> 실명인증 실패 : 주민과 이름이 일치하지 않음. 사용자가 직접 www.namecheck.co.kr 로 접속하여 등록 or 1600-1522 콜센터로 접수요청.
		'																	아래와 같이 한신평에서 제공한 자바스크립트 이용하셔도 됩니다.		
		'											3 이면 --> 한신평 해당자료 없음 : 사용자가 직접 www.namecheck.co.kr 로 접속하여 등록 or 1600-1522 콜센터로 접수요청.
		'																	아래와 같이 한신평에서 제공한 자바스크립트 이용하셔도 됩니다.
		'											5 이면 --> 체크썸오류(주민번호생성규칙에 어긋난 경우: 임의로 생성한 값입니다.)
		'											50이면 --> 크레딧뱅크의 명의도용차단 서비스 가입자임 : 직접 명의도용차단 해제 후 실명인증 재시도.
		'																	아래와 같이 한신평에서 제공한 자바스크립트 이용하셔도 됩니다.
		'											그밖에 --> 30번대, 60번대 : 통신오류 ip: 203.234.219.72 port: 81~85(5개) 방화벽 관련 오픈등록해준다. 
		'																(결과값의 자세한 사항은 리턴코드.txt 파일을 참고해 주세요~) 
        select case iRtn
        case 1
        ' 실명인증 성공입니다. 업체에 맞게 페이지 처리 하시면 됩니다.
        Response.write iRtn   
 
%>
			<script language='javascript'>
				//alert("인증성공!! ^^");
			</script>

	
			<!-- 페이지 처리를 하실때에는 아래와같이 처리하셔도 됩니다. 이동할 페이지로 수정해서 사용하시면 됩니다. 	-->
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
		'리턴값 2인 사용자의 경우, www.namecheck.co.kr 의 실명등록확인 또는 02-1600-1522 콜센터로 문의주시기 바랍니다.   			
%>
            <script language="javascript">
               history.go(-1); 
               var URL ="http://www.creditbank.co.kr/its/its.cb?m=namecheckMismatch"; 
               var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no, width= 640, height= 480, top=0,left=20"; 
               window.open(URL,"",status); 
            </script> 
<%
		case 3
		'리턴값 3인 사용자의 경우, www.namecheck.co.kr 의 실명등록확인 또는 02-1600-1522 콜센터로 문의주시기 바랍니다.   			
%>
            <script language="javascript">
               history.go(-1); 
               var URL ="http://www.creditbank.co.kr/its/its.cb?m=namecheckMismatch"; 
               var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no, width= 640, height= 480, top=0,left=20"; 
               window.open(URL,"",status); 
            </script> 

<%
		case 50
		'리턴값 50 명의도용차단 서비스 가입자의 경우, www.creditbank.co.kr 에서 명의도용차단해제 후 재시도 해주시면 됩니다. 
		' 또는 02-1600-1533 콜센터로문의주세요.
%>	

            <script language="javascript">
               history.go(-1); 
               var URL ="http://www.creditbank.co.kr/its/itsProtect.cb?m=namecheckProtected"; 
               var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no, width= 640, height= 480, top=0,left=20"; 
               window.open(URL,"",status); 
            </script> 
 
<%
		case else
		'인증에 실패한 경우는 리턴코드.txt 를 참고하여 리턴값을 확인해 주세요~
%>
			<script language='javascript'>
				alert("인증에 실패 하였습니다. 리턴코드:[<%=iRtn%>]");
				history.go(-1);
			</script>
<%
		end select 		
	else
		Response.write "<Script Language='JavaScript'>"
		Response.write "	alert('성명이나 주민번호를 입력하세요.');"
		Response.write "	history.go(-1);"
		Response.write "</Script>"			
	end if
%>
