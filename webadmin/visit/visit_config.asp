<%

dim theTable
theTable = "visit_counter"


'---------------------------------------------------------------------------------------------------------------
'	공통
'---------------------------------------------------------------------------------------------------------------

sub CheckDate(YY,MM,DD)

	if YY <> "" then	
		if isNumeric(YY) then
			YY = int(YY)
			if YY < 1 or YY > 9999 then YY = ""
		else
			YY = ""
		end if
	end if

	if MM <> "" then	
		if isNumeric(MM) then
			MM = int(MM)
			if MM < 1 or MM > 12 then MM = ""
		else
			MM = ""
		end if
	end if

	if DD <> "" then	
		if isNumeric(DD) then
			DD = int(DD)
			if DD < 1 or DD > 31 then DD = ""
		else
			DD = ""
		end if
	end if

	dim temp

	temp = true

	if YY <> "" and MM <> "" then temp = isDate(YY&"-"&MM)	
	if YY <> "" and MM <> "" and DD <> "" then temp = isDate(YY&"-"&MM&"-"&DD)	

	if not temp then
		YY = ""
		MM = ""
		DD = ""
	end if

end sub
'---------------------------------------------------------------------------------------------------------------
'(이전,다음) 년,월,일 변경
function ChangeDate(prevTextYY, nextTextYY, prevTextMM, nextTextMM, prevTextDD, nextTextDD,theme)

	dim rValue, tempPrev, tempNext, theCase

	if YY <> "" then
		theCase = "YY"
	end if
	if YY <> "" and MM <> "" then
		theCase = "MM"
	end if
	if YY <> "" and MM <> "" and DD <> "" then
		theCase = "DD"
	end if

	select case ucase(theCase)
	case "YY"
		tempPrev = cint(YY) - 1
		tempNext = cint(YY) + 1

		if tempPrev < 1 then
			tempPrev = 1
		end if

		if tempNext > 2100 then
			tempNext = 2100
		end if

		rValue = "&nbsp;<a href='"&Request.ServerVariables("SCRIPT_NAME")&"?menushow="&menushow&"&theme="&theme&"&YY="&tempPrev&"'>" & prevTextYY & "</a>&nbsp;|&nbsp;"
		rValue = rValue & "<a href='"&Request.ServerVariables("SCRIPT_NAME")&"?menushow="&menushow&"&theme="&theme&"&YY="&tempNext&"'>" & nextTextYY & "</a>"

	case "MM"
		tempPrev = dateadd("m",-1,cdate(YY&"-"&MM))
		tempNext = dateadd("m",1,cdate(YY&"-"&MM))

		rValue = "&nbsp;<a href='"&Request.ServerVariables("SCRIPT_NAME")&"?menushow="&menushow&"&theme="&theme&"&YY="&year(tempPrev)&"&MM="&month(tempPrev)&"'>" & prevTextMM & "</a>&nbsp;|&nbsp;"
		rValue = rValue & "<a href='"&Request.ServerVariables("SCRIPT_NAME")&"?menushow="&menushow&"&theme="&theme&"&YY="&year(tempNext)&"&MM="&month(tempNext)&"'>" & nextTextMM & "</a>"

	case "DD"
		tempPrev = dateadd("d",-1,cdate(YY&"-"&MM&"-"&DD))
		tempNext = dateadd("d",1,cdate(YY&"-"&MM&"-"&DD))

		rValue = "&nbsp;<a href='"&Request.ServerVariables("SCRIPT_NAME")&"?menushow="&menushow&"&theme="&theme&"&YY="&year(tempPrev)&"&MM="&month(tempPrev)&"&DD="&day(tempPrev)&"'>" & prevTextDD & "</a>&nbsp;|&nbsp;"
		rValue = rValue & "<a href='"&Request.ServerVariables("SCRIPT_NAME")&"?menushow="&menushow&"&theme="&theme&"&YY="&year(tempNext)&"&MM="&month(tempNext)&"&DD="&day(tempNext)&"'>" & nextTextDD & "</a>"

	end select

	ChangeDate = rValue

end function
'---------------------------------------------------------------------------------------------------------------
'시각 효과를 높이기 위해 상대적인 그래프 크기를 늘린다
function resizingGraph(maxCount,sumCount)
	
	dim temp

	if maxCount = 0 or sumCount = 0 then
		temp = 0
	else
		temp = sumCount / maxCount
	end if

	resizingGraph = temp

end function
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------

%>
