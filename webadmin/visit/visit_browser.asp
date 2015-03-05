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
''Set util = new utility	
Set db = new database

dim YY, MM, DD
dim allRs, rows, rowsCount, cols, i
dim sumCount, maxCount, minCount
dim curSize, curPer, curBrowser, curCount
dim sqlValue
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
	DD = request ("DD")

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

	if DD <> "" then
		if sqlValue <> "" then sqlValue = sqlValue & " and " end if
		sqlValue = sqlValue & " vDD = "&DD&""
	end if

	if sqlValue <> "" then sqlValue = " where " & sqlValue


	'카운터 수의 합을 구한다
	strSQL = "select count(vNum) from " & theTable & sqlValue & ""
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			sumCount = objRs(0)
		end if

	objRs.close()
	set objRs = nothing	

	'MaxCount 쿼리
	strSQL = "select top 1 vBrowser,count(vNum) as a from " & theTable & sqlValue & " group by vBrowser order by a desc"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			maxCount = objRs(1)
		end if

	objRs.close()
	set objRs = nothing

	'MinCount 쿼리
	strSQL = "select top 1 vBrowser,count(vNum) as a from " & theTable & sqlValue & " group by vBrowser order by a asc"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			minCount = objRs(1)
		end if

	objRs.close()
	set objRs = nothing

	'브라우저별 데이터 쿼리
	strSQL = "select vBrowser,count(vNum) from " & theTable & sqlValue & " group by vBrowser order by vBrowser"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			allRs = objRs.getstring(2,,chr(9)&chr(10),chr(11)&chr(12))
			rows = split(allRs,chr(11)&chr(12))
			rowsCount = ubound(rows)		
		end if

	objRs.close()
	set objRs = nothing

	addSize = resizingGraph(maxCount,sumCount)

end sub
'---------------------------------------------------------------------------------------------------------------
function GetData(theNum)

	cols					= split(rows(theNum),chr(9)&chr(10))
	curBrowser		= cols(0)
	curCount			= cols(1)
	
	curSize				= int(((curCount/sumCount) * 500))
	curPer				= round(((curCount/sumCount) * 100),2)

	if trim(curBrowser) = "" then
		curBrowser = "unknown"
	end if

end function
'---------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------
%>

<script language="javascript">
function setting()
{
	form = document.Form1;
	form.YY.value = '<%=YY%>';
	form.MM.value = '<%=MM%>';
	form.DD.value = '<%=DD%>';
}
function rbar (st,col) { st.style.backgroundColor = '#F0F3F4';return;}
function cbar (st) { st.style.backgroundColor = '';return;}
</script>

<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>브라우저별방문자 통계</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>	
	
 <form action="./main.asp" method="post" name="Form1">
         <input type="hidden" name="menushow" value="<%=menushow%>">
        <input type="hidden" name="theme" value="visit/visit_browser">
        <table class="table_main w_default">
          <tr> 
            <td align="left"> <select name="YY" onChange="document.Form1.submit();">
                <option value="">전체</a> 
                <%for i = year(date)-5 to year(date) + 5%>
                <option value="<%=i%>"><%=i%>년</option>
                <%next%>
              </select> <select name="MM" onChange="document.Form1.submit();">
                <option value="">전체</option>
                <%for i = 1 to 12%>
                <option value="<%=i%>"><%=i%>월</option>
                <%next%>
              </select> <select name="DD" onChange="document.Form1.submit();">
                <option value="">전체</option>
                <%for i = 1 to 31%>
                <option value="<%=i%>"><%=i%>일</option>
                <%next%>
              </select>
              [<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_browser">전체</a>&nbsp;|&nbsp;<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_browser&YY=<%=year(date)%>">올해</a>&nbsp;|&nbsp;<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_browser&YY=<%=year(date)%>&MM=<%=month(date)%>">이번달</a>&nbsp;|&nbsp;<a href="./main.asp?menushow=<%=menushow%>&theme=visit/visit_browser&YY=<%=year(date)%>&MM=<%=month(date)%>&DD=<%=day(date)%>">오늘</a>] 
              &nbsp;<%=ChangeDate("☜ 이전해","다음해 ☞","☜ 이전달","다음달 ☞","☜ 이전날","다음날 ☞",theme)%> </td>
            <td align="right" valign="bottom" style="font-family:tahoma; font-size:8pt;"> 
              Total <%=sumCount%>&nbsp; </td>
          </tr>
        </table>
        <br />
        <table class="table_main w_default">
			<col width="150px" />
			<col width="80px" />
			<col width="*" />

          <tr align="center"> 
            <th>BROWSER</th>
            <th>COUNT</th>
            <th>GRAPH</th>
          </tr>
          <%if rowsCount < 1 then%>
          <tr height="80"> 
            <td colspan="3" align="center" valign="center"> 등록된 기록이 없습니다 </td>
          </tr>
          <%end if%>

                <%for i = 0 to rowsCount - 1 : GetData(i)%>
                <tr height="40" onMouseOver="rbar(this);" onMouseOut="cbar(this);">	
                  <td align="center" width="73"><%=curBrowser%></td>
                  <td align="center" width="53"><%=curCount%></td>
                  <td valign="center"><img src="image_visit/graph.gif" width="<%=int(curSize * addSize)%>" height="30" align="absmiddle">&nbsp;<%=curPer%>%</td>
                </tr>
                <%next%>

        </table>
        </form></td>
  </tr>
</table>
</body>
</html>
