<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "schedule/cal_logic.asp"-->
<!-- #include file = "schedule/lunartosol.asp" -->
<!-- #include file = "../../config/db_connect.asp"-->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

'/////// 헤드라인 보이기 끝   달력 시작////////

d=Request("d")
 If d="" Then
	d="m"
 End if
 m=Request("m")


%>
<html>
<head>
<title>동안교회</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="/common/main.css" type="text/css">

</head>
<script language="javascript">
function schedule(d,f_year,f_month,f_day)
{
   window.open("schedule/schedule_main.asp?d="+d+"&f_year="+f_year+"&f_month="+f_month+"&f_day="+f_day,"일정","width=850,height=530,resizable=no")

}


function monthschedule(m,view,value3)
{
 
     window.open("schedule/schedule_main.asp?d="+m+"&m="+view+"&cid="+value3,"일정","width=850,height=530,resizable=no")

}

</script>

<body text="#666666" link="#000000" vlink="#000000" alink="#99CC00" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<center>

<table border=0 width=180>
                                <tr> 
                                  <td colspan=2 align="center"> <font color="#669900"><a href=calendar.asp?d=m&F_Year=<%=intPrevYear&"&F_Month="&intPrevMonth&"&F_Day=1"%>>◁</a> 
                                    <%=intThisYear%>년 <%=intThisMonth%>월 <%=intThisDay%>일<a href=calendar.asp?d=m&F_Year=<%=intNextYear&"&F_Month="&intNextMonth&"&F_Day=1"%>> ▷</a> 
                                     
                                </tr>
                              </table>
                              <table border=0 width=180 cellpadding=0 cellspacing=0 >
                                <tr > 
                                  <td  align="center" bgcolor=#DDDDDD>일</td>
                                  <td  align="center" bgcolor=#EEEEEE>월</td>
                                  <td  align="center" bgcolor=#EEEEEE>화</td>
                                  <td  align="center" bgcolor=#EEEEEE>수</td>
                                  <td  align="center" bgcolor=#EEEEEE>목</td>
                                  <td  align="center" bgcolor=#EEEEEE>금</td>
                                  <td  align="center" bgcolor=#EEEEEE>토</td>
                                </tr>
                                <%
Stop_Flag=0
intFirstWeekday=Weekday(datFirstDay, vbSunday) '넘겨받은 날짜의 주초기값 파악
intPrintDay=1
	for intLoopWeek=1 to 6   '주단위 루프 시작, 최대 6주 

		Response.Write "<tr>"&vbCR
		for intLoopDay=1 to 7 '요일단위 루프 시작, 일요일부터

			if intFirstWeekDay > 1 then '첫주시작일이 1보다 크면
				Response.Write "<td bgcolor=#FFFFFF align="center" valign=top><font color=white>."&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else  '
				if intPrintDay > intLastDay then '입력날짜가 월말보다 크다면
					Response.Write "<td  bgcolor=#FFFFFF  align="center" valign=top><font color=white>."&vbCR
				else '입력날짜가 현재월에 해당되면
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then '오늘 날짜이면은 글씨폰트를 다르게
						Response.Write "<td  bgcolor=#FFFFFF align="center" valign=top><a href=javascript:schedule('"& d & "'," & intthisyear & "," & intthismonth & "," &  intprintday & ")>" & "<font color=000000>"&intPrintDay&"</a></b><br />"&vbCR
					elseif  intLoopDay=1 then '일요일이면 빨간 색으로
						Response.Write "<td bgcolor=#FFFFFF  align="center" valign=top><a href=javascript:schedule('"& d & "'," & intthisyear & "," & intthismonth & "," &  intprintday & ")>" & "<font color=ff4500>"&intPrintDay&"</a><br />"&vbCR
					else ' 그외의 경우
						Response.Write "<td bgcolor=#FFFFFF  align="center" valign=top><font color=#000000><a href=javascript:schedule('"& d & "'," & intthisyear & "," & intthismonth & "," &  intprintday & ")>" &intPrintDay&"</a><br />"&vbCR
					end if
				end if										
				intPrintDay=intPrintDay+1 '날짜값을 1 증가
				if intPrintDay > intLastDay then '만약 날짜값이 월말값보다 크면 루프문 탈출
					Stop_Flag=1
				end if
			end if
			Response.Write "</td>"
		next
		Response.Write "</tr>"
		if Stop_Flag=1 then
			exit for
		end if
	next
	Set rslink=Nothing
		%>
                              </table>
                              <table border="0" width="180" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
                                <tr> 
                                  <td> 
                                    <table border="0" width="100%" cellspacing="0" cellpadding="3" bordercolor="#ffffff" bordercolorlight="#000000">
                                      <tr> 
                                        <td bgcolor=#EEEEEE><%=intThisMonth%>월중 일정</b></td>
		            <td bgcolor=#EEEEEE align=right><% response.write "<a href=javascript:schedule('"& d & "'," & intthisyear & "," & intthismonth & "," &  intprintday-10 & ")><img src='/images/btn_more2.gif' border=0 align=absmiddle></a>" %>
                                        </td>
                                      </tr>
                                      <tr height=40> 
                                        <td bgcolor=#FFFFFF colspan=2> 
                                          <%
					intMday=intThisYear&"-"&intThisMonth&"-1"
					strSQL = "Select top 2 cc_id, cc_title,cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin,cc_desc From  wizDiary  Where "
					strSQL = strSQL&" (cc_m_id='" & user_id & "'  or cc_open='1') and cc_reid = '0' "
					strSQL = strSQL&" and  datediff(""d"",cc_sdate,'"&intMday&"') = 0 "
					strSQL = strSQL&" and  cc_dtype='3'  "
					strSQL = strSQL&"  Order by cc_id desc, cc_shour asc"&vbCR
					
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

							cc_title=Replace(cc_title,"<","&lt;")
							cc_title=Replace(cc_title,">","&gt;")

							cc_desc=left(cc_desc,150)
							cc_desc=Replace(cc_desc, "<" , "&lt;")
							cc_desc=Replace(cc_desc, ">" , "&gt;")
							cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br />")


							lhour=intThisMonth&"월중 일정"

							Response.write "<img src='/images/i_smile_green.gif' border=0 align=absmiddle>"
							Response.Write  " <a href=javascript:monthschedule('" & d & "','view'," &cc_id &") >"&cc_title&"</a><br />"&vbCR	
							objRs.MoveNext
						Loop
						             
					Else
						response.write "<span>날짜를 클릭하셔요</span>"&vbCR
					End if
					objRs.close
					set objRs=nothing

					%>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
		  </table>
</center>		  
</body>
</html>
