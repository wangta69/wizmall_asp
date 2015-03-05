<% Option Explicit %>
<table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
	<tr>
		<td>
			<table border="0" width="100%" cellspacing="1" cellpadding="0" bordercolor="#ffffff" bordercolorlight="#000000">
				<tr >
        <td width="14%" bgcolor="#9BC05C" align="center"><font color="#ff4500">일(日)</td>
        <td width="14%" bgcolor="#9BC05C" align="center">월(月)</td>
        <td width="14%" bgcolor="#9BC05C" align="center">화(火)</td>
        <td width="14%" bgcolor="#9BC05C" align="center">수(水)</td>
        <td width="14%" bgcolor="#9BC05C" align="center">목(木)</td>
        <td width="14%" bgcolor="#9BC05C" align="center">금(金)</td>
        <td width="14%" bgcolor="#9BC05C" align="center">토(土)</td>
      </tr>

	<%
	for intLoopWeek=1 to 6   '주단위 루프 시작, 최대 6주 
		Response.Write "<tr bgcolor=E8F0E1>"&vbCR

		'///////////////////  날짜 출력 /////////////////////
		for intLoopDay=1 to 7  '요일단위 루프 시작, 일요일부터
			Response.Write "<td height=50 valign=top align=left> "
			
			if intFirstWeekDay > 1 then  '첫주시작일이 1보다 크면
				Response.Write "<font face=굴림 color=white>."&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else  '
				if intPrintDay > intLastDay then '입력날짜가 월말보다 크다면
					Response.Write "<font face=굴림 color=white>."&vbCR
				else '입력날짜가 현재월에 해당되면
				
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then '오늘 날짜이면은 글씨폰트를 다르게
					
					
					
						Response.Write "<a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntPrintDay&" >"&intPrintDay&"</b></a>"
						Response.Write "<a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntPrintDay & "&m=input&sdate="&intThisYear&"-"&intThisMonth&"-"&intPrintDay&"&shour=9><img src= ./diary/images/add.gif border=0 alt=일정추가></a><br />"&vbCR
					
					
					elseif  intLoopDay=1 then '일요일이면 빨간 색으로
						Response.Write "<a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntPrintDay&" ><font color=ff4500>"&intPrintDay&"</a>"
						Response.Write "<a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntPrintDay & "&m=input&sdate="&intThisYear&"-"&intThisMonth&"-"&intPrintDay&"&shour=9><img src= ./diary/images/add.gif border=0 alt=일정추가></a><br />"&vbCR
					else ' 그외의 경우
						Response.Write "<font face=굴림 color=#000000><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntPrintDay&" >"&intPrintDay&"</a>"
						Response.Write "<a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntPrintDay & "&m=input&sdate="&intThisYear&"-"&intThisMonth&"-"&intPrintDay&"&shour=9><img src= ./diary/images/add.gif border=0 alt=일정추가></a><br />"&vbCR
					end if
				
'삽입시작				
					intCday=intThisYear&"-"&intThisMonth&"-"&intPrintDay

					strSQL = "Select cc_id, cc_title,cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin,cc_desc,cc_dtype From  wizDiary  Where "
					strSQL = strSQL&" (cc_m_id='" & user_id & "'  or cc_open='1') and cc_reid = '0' "
					strSQL = strSQL&" and  datediff(""d"",cc_sdate,'"&intCday&"') = 0 "
					strSQL = strSQL&" and  (cc_dtype='1' or cc_dtype='2')  "
					strSQL = strSQL&"  Order by  cc_shour asc"&vbCR

					Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)



					If  not objRs.eof  Then
			
						Do while not objRs.eof 

							cc_id=objRs(0)
							cc_title=objRs(1)
							cc_sdate=objRs(2)
							cc_shour=objRs(3)
							cc_smin=objRs(4)
							cc_ehour=objRs(5)
							cc_emin=objRs(6)
							cc_desc=objRs(7)
							cc_dtype=objRs(8)
							if  cc_dtype="2" then
								lhour= "하루종일"
							else
								lhour=trim(cc_shour&":"&cc_smin&" ~ "&cc_ehour&":"&cc_emin)
							end if
							cc_title=Replace(cc_title,"<","&lt;")
							cc_title=Replace(cc_title,">","&gt;")

							cc_desc=left(cc_desc,150)
							cc_desc=Replace(cc_desc, "<" , "&lt;")
							cc_desc=Replace(cc_desc, ">" , "&gt;")
							cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br />")

							'Response.write "<img src=./diary/images/micon.gif border=0>"
							Response.Write  "<span><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d="&d&"&m=view&cid="&cc_id&" onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"');""  onMouseOut=""noview();"" >"&cc_title&"</a></span><br />"&vbCR	
							objRs.MoveNext
						Loop
					Else
						response.write "<span></span>"&vbCR
					End if
					objRs.close
					set objRs=nothing
					'/////////////////////////////////////////////  시간단위 일정등록 쿼리 종료 ////////////////////////////////////////////

					'///////////////////////////////////////////// 반복일정 설정된 해당시간쿼리 검사및 처리 시작 /////////////////////
					strSQL = "Select cc_id, cc_title, cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin,cc_desc,cc_reid, cc_retype, cc_edate,cc_dtype From  wizDiary  Where "
					strSQL = strSQL&" (cc_m_id='" & user_id & "'  or cc_open='1') "
					strSQL = strSQL&" and cc_reid <>  '0' "
					strSQL = strSQL&" and datediff(""d"", cc_edate,'"&intCday&"') <= 0 "  '종료일 > 현재일 은 
					strSQL = strSQL&" and datediff(""d"", cc_sdate,'"&intCday&"') >=0 "  '시작일 < 현재일
					strSQL = strSQL&" and  (cc_dtype='1' or cc_dtype='2')  "
					strSQL = strSQL&"  Order by  cc_shour asc"&vbCR

					Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

					if not objRs.eof then

						Do While not objRs.eof
							cc_id=objRs(0)
							cc_title=objRs(1)
							cc_sdate=objRs(2)
							cc_shour=objRs(3)
							cc_smin=objRs(4)
							cc_ehour=objRs(5)
							cc_emin=objRs(6)
							cc_desc=objRs(7)
							cc_reid=objRs(8)
							cc_retype=objRs(9)
							cc_edate=objRs(10)
							cc_dtype=objRs(11)
							if  cc_dtype="2" then
								lhour= "하루종일"
							else
								lhour=trim(cc_shour&":"&cc_smin&" ~ "&cc_ehour&":"&cc_emin)
							end if
							cc_title=Replace(cc_title,"<","&lt;")
							cc_title=Replace(cc_title,">","&gt;")

							cc_desc=left(cc_desc,150)
							cc_desc=Replace(cc_desc, "<" , "&lt;")
							cc_desc=Replace(cc_desc, ">" , "&gt;")
							cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br />")
				
							sqlday=cdate(cc_sdate)
							cday=datediff("d",sqlday,intCday) '레코드 저장일과 출력셀의 날짜와의  날짜차이
							cmonth=datediff("m",sqlday,intCday) '레코드 저장일과 출력셀의 날짜와의 월 차이
										

							if  cc_retype="1" and (cday mod cc_reid)=0  then '일일단위 반복설정
								'오늘날짜와 일정날짜의 차이를 반복주기로 나눠서 0이면 출력
								Response.write "<img src=./diary/images/micon.gif border=0>"
								response.write "<span><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d="&d&"&m=view&cid="&cc_id&"  onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"');""  onMouseOut=""noview();"">"&cc_title&"</a></span><br />"&vbCR				
							elseif cc_retype="2" and (cday mod cc_reid*7 )=0 then '주단위 반복설정
								Response.write "<img src=./diary/images/micon.gif border=0>"
								response.write  "<span> <a href=main.asp?menushow="&menushow&"&theme="&theme&"&d="&d&"&m=view&cid="&cc_id&"  onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"' );"" onMouseOut=""noview();"">"&cc_title&"</a></span><br />"&vbCR				
							elseif cc_retype="3" and day(sqlday)= intPrintDay and (cmonth mod cc_reid )=0 then '월단위 반복설정
							'오늘날짜와 일정날짜의 월 차이를 반복주기로 나눠서 0이면 출력
								Response.write "<img src=./diary/images/micon.gif border=0>"
								response.write "<span><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d="&d&"&m=view&cid="&cc_id&" onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"' );""  onMouseOut=""noview();"">"&cc_title&"</a></span><br />"&vbCR				
							else '년단위 반복설정

							end if
							objRs.MoveNext
						Loop
					End if
					'//////////////////////////////////////////// 반복일정 설정된 해당시간 쿼리 검사 및 처리 종료 /////////////////////

				
'삽입종료
				end if	
				intPrintDay=intPrintDay+1 '날짜값을 1 증가
				if intPrintDay>intLastDay then '만약 날짜값이 월말값보다 크면 루프문 탈출
					Stop_Flag=1
				end if
			end if



			Response.Write "</td>"
		
		Next
		Response.Write "</tr>"
		
		if Stop_Flag=1 then
			exit for
		end if
	next
	Set rslink=Nothing
	%>
</table>
</td>
</tr>
</table>

<%
if intThisDay >= intPrevLastDay then
	intPrevDay=intPrevLastDay
else
	intPrevDay=intThisDay
end if

if intThisDay >= intNextLastDay then
	intNextDay=intNextLastDay
else
	intNextDay=intThisDay
end if

%>
<table width="630" border="0">
  <tr>          
    <td width="32%" align="right">
      <a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Year=<%=intPrevYear%>&F_Month=<%=intPrevMonth%>&F_Day=<%=intPrevDay%>"> 
      <img src="./diary/images/icon01_02_pre.gif" width="58" height="19" border=0></a>
    </td>
    <td width="13%" valign="middle">
      <a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Year=<%=intPrevYear%>&F_Month=<%=intPrevMonth%>&F_Day=<%=intPrevDay%>">[ <%=intPrevMonth%>월 달]</a></td>
    <td width="10%" valign="middle"></td>
    <td width="13%" valign="middle">
      <a href="./main.asp?menushow=menu13&theme=diary/Schedule_main&d=m&F_Year=<%=intNextYear%>&F_Month=<%=intNextMonth%>&F_Day=<%=intNextDay%>">
      [ <%=intNextMonth%>월 달]</a></td>
    <td width="32%" align="left" valign="bottom">
      <a href="./main.asp?menushow=menu13&theme=diary/Schedule_main&d=m&F_Year=<%=intNextYear%>&F_Month=<%=intNextMonth%>&F_Day=<%=intNextDay%>">
      <img src="./diary/images/icon01_02_next.gif" width="58" height="19" border=0></a>
    </td>    
  </tr>
</table>
