<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "visit_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim theme,menushow
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

dim YY, MM, DD
dim allRs, rows, rowsCount, cols, i, j
dim sumCount, maxCount, minCount
dim arrData(31,3), curSize, curPer, curDW, curCount
dim dataLength
dim addSize

theme = request("theme")
menushow = request("menushow")

call PageLoad()
call Manage()
call PageUnLoad()

'---------------------------------------------------------------------------------------------------------------
' 프로시저,함수
'---------------------------------------------------------------------------------------------------------------
sub PageLoad()
	
	YY = request ("YY")
	MM = request ("MM")

	call CheckDate(YY,MM,DD)

end sub
'---------------------------------------------------------------------------------------------------------------
sub PageUnLoad()
end sub
'---------------------------------------------------------------------------------------------------------------
sub Manage()

	dim sqlValue

	sqlValue = ""
	if YY <> "" then
		sqlValue = " vYY = "&YY&""
	end if

	if MM <> "" then
		if sqlValue <> "" then sqlValue = sqlValue & " and " end if
		sqlValue = sqlValue & " vMM = "&MM&""
	end if

	if sqlValue <> "" then sqlValue = " where " & sqlValue

	'카운터 수의 합을 구한다
	strSQL = "select count(vNum) from "&theTable&sqlValue&""
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			sumCount = objRs(0)
		end if

	objRs.close()
	set objRs = nothing	

	'일별 카운터를 구한다
	strSQL = "select vDW,count(vNum) from "&theTable&sqlValue&" group by vDW order by vDW"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			allRs = objRs.getstring(2,,chr(9)&chr(10),chr(11)&chr(12))
			rows = split(allRs,chr(11)&chr(12))
			rowsCount = ubound(rows)		
		end if

	objRs.close()
	set objRs = nothing

	'배열 초기화
	for i = 0 to ubound(arrData)
		for j = 0 to 2
			arrData(i,j) = 0
		next
	next

	'날짜변 데이터를 배열에 담는다
	maxCount = 0
	minCount = 100000
	for i = 0 to rowsCount - 1

		GetData(i)

		curSize		= int(((curCount/sumCount) * 550))
		curPer		= round(((curCount/sumCount) * 100),2)

		if cdbl(maxCount) < cdbl(curCount) then
			maxCount = curCount
		end if

		if cdbl(minCount) > cdbl(curCount) then 
			minCount = curCount
		end if

		arrData(curDW,0) = curCount
		arrData(curDW,1) = curSize
		arrData(curDW,2) = curPer

	next

	dataLength = 7

	if minCount = 100000 then minCount = 0
	if cint(rowsCount) < cint(dataLength) then minCount = 0

	addSize = resizingGraph(maxCount,sumCount)

end sub
'---------------------------------------------------------------------------------------------------------------
function GetData(theNum)

	cols			= split(rows(theNum),chr(9)&chr(10))
	curDW		= cols(0)
	curCount	= cols(1)

end function
'---------------------------------------------------------------------------------------------------------------
function SetDetail(theNum)

	if arrData(theNum,0) = maxCount and maxCount <> 0 then
		arrData(theNum,0) = "<b style='color:red'>" & arrData(theNum,0) & "</b>"
	end if

	select case cint(theNum)
	case 1 curDW = "日"
	case 2 curDW = "月"
	case 3 curDW = "火"
	case 4 curDW = "水"
	case 5 curDW = "木"
	case 6 curDW = "金"
	case 7 curDW = "土"
	end select

end function
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------

%>
<script language="javascript">
function setting()
{
	form = document.Form1;
	form.YY.value = '<%=YY%>';
	form.MM.value = '<%=MM%>';
}
function rbar (st,col) { st.style.backgroundColor = '#F0F3F4';return;}
function cbar (st) { st.style.backgroundColor = '';return;}
</script>
<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>주별방문자 통계</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>

<form action="./main.asp" method="post" name="Form1">
        <input type="hidden" name="menushow" value="<%=menushow%>">
        <input type="hidden" name="theme" value="visit/visit_dayofweek">
        <table class="table_main w_default">
          <tr> 
            <td align="left"> <select name="YY" onChange="document.Form1.submit();">
                <option value="">전체</option>
                <%for i = year(date)-5 to year(date) + 5%>
                <option value="<%=i%>"><%=i%>년</option>
                <%next%>
              </select> <select name="MM" onChange="document.Form1.submit();">
                <option value="">전체</option>
                <%for i = 1 to 12%>
                <option value="<%=i%>"><%=i%>월</option>
                <%next%>
              </select>
              [<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_dayofweek">전체</a>&nbsp;|&nbsp;<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_dayofweek&YY=<%=year(date)%>">올해</a>&nbsp;|&nbsp;<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_dayofweek&YY=<%=year(date)%>&MM=<%=month(date)%>">이번달</a>] 
              &nbsp;<%=ChangeDate("☜ 이전해","다음해 ☞","☜ 이전달","다음달 ☞","☜ 이전날","다음날 ☞",theme)%> </td>
            <td align="right" valign="bottom" style="font-family:tahoma; font-size:8pt;"> 
              Total <%=sumCount%>&nbsp;:&nbsp;Max <%=maxCount%>&nbsp;:&nbsp;Min <%=minCount%>&nbsp; </td>
          </tr>
        </table>
        <br />

        <table class="table_main w_default">
          <tr> 
            <th width=6%>DAY</th>
            <th width=7% align="center">COUNT</th>
            <th width="89%">GRAPH</th>
          </tr>
          <tr> 
            <td colspan="3" > <table width="100%" border="0" cellspacing="0" cellpadding="0" background="image_visit/background1.gif">
                <%for i = 1 to dataLength : SetDetail(i)%>
                <tr onMouseOver="rbar(this);" onMouseOut="cbar(this);" height="40">	
                  <td width="43" align="center"><%=curDW%></td>
                  <td width="53" align="center"><%=arrData(i,0)%></td>
                  <td valign="center"><img src="image_visit/graph.gif" width="<%=int(arrData(i,1) * addSize)%>" height="30" align="absmiddle">&nbsp;<%=arrData(i,2)%>%</td>
                </tr>
                <%next%>
              </table></td>
          </tr>
          <tr align="center" bgcolor="#E2EAF1" height="15"> 
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
