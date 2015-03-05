<% Option Explicit %>
<%
intThisYear=Request("F_Year") '년도넘겨받기
intThisMonth=Request("F_Month") '월 넘겨받기
intThisDay=Request("F_Day") '일 넘겨받기

datToday=Date()  '오늘 날짜

NowThisYear=Year(datToDay) ' 현재연도값
NowThisMonth=Month(datToday) '현재 월값
NowThisDay=Day(datToday) '오늘 날짜 값

if intThisYear="" then '만약 년도와 월값을 넘겨받지 않았다면
	intThisYear=NowThisYear '현재 년도를 년도 변수에
	intThisMonth=NowThisMonth ' 현재 월을 월 변수에
end if

if intThisDay="" then
	intThisDay=NowThisDay '현재 날짜를 일 변수에
end if

if intThisMonth=1 then '1월달이라면 
	intPrevYear=intThisYear-1 '이전달 년도 = 이번년도 - 1
	intPrevMonth=12 '이전달 = 12월
	intNextYear=intThisYear '다음달 년도 = 이번달 년도
	intNextMonth=2 '다음달 = 2월
elseif intThisMonth=12 then '12월달이라면
	intPrevYear=intThisYear '이전달 년도 = 이번달 년도
	intPrevMonth=11 '이전달 = 11월
	intNextYear=intThisYear + 1 '다음달 년도 = 이번달 년도 + 1
	intNextMonth=1 ' 다음달 = 1월
else '1월과 12월을 제외한 경우에는
	intPrevYear=intThisYear '이전달 년도 = 이번달 년도
	intPrevMonth=intThisMonth -1 '이전달 = 이번달  - 1
	intNextYear=intThisYear '다음달 년도 = 이번달 년도
	intNextMonth=intThisMonth+1 '다음달 = 이번달 + 1
end if

call exec_LastDay(intThisMonth,intThisYear) '이번달의 월말값 계산
intLastDay=datLastDay

call exec_LastDay(intPrevMonth,intPrevYear) '지난달의 월말값 계산
intPrevLastDay=datLastDay

call exec_LastDay(intNextMonth,intNextYear) '다음달의 월말값 계산
intNextLastDay=datLastDay

datFirstDay=DateSerial(intThisYear, intThisMonth, 1) '넘겨받은 날짜의 월초기값 파악
intFirstWeekday=Weekday(datFirstDay, vbSunday) '넘겨받은 날짜의 주초기값 파악


datThisDay=cdate(intThisYear&"-"&intThisMonth&"-"&intThisDay) '해당 년-월-일의 날짜변환
intThisWeekday=Weekday(datThisDay) '해당 날짜의 요일값

	
Select Case intThisWeekday 
	Case 1
		varThisWeekday="일"	
	Case 2
		varThisWeekday="월"		
	Case 3
		varThisWeekday="화"		
	Case 4
		varThisWeekday="수"		
	Case 5
		varThisWeekday="목"		
	Case 6
		varThisWeekday="금"	
	Case 7
		varThisWeekday="토"		
End Select
	
intPrintDay=1 '출력 초기일 값은 1부터



Stop_Flag=0


dim datLastDay
function exec_LastDay(datMonth,datYear) 
	if datMonth=4 or datMonth=6 or datMonth=9 or datMonth=11 then  '4월 6월 9월 11월이면 월말값은 30일
		datLastDay=30
	elseif datMonth=2 and not (datYear mod 4) = 0 then  '2월이고  년도를 4로 나눈 값이 0이 아니면 28일
		datLastDay=28
	elseif datMonth=2 and (datYear mod 4) = 0 then '윤달 계산
		if (datYear mod 100) = 0 then
			if (datYear mod 400) = 0 then
				datLastDay=29
			else
				datLastDay=28
			end if
		else
			datLastDay=29
		end if
	else
		datLastDay=31
	end if 
end function
%>
