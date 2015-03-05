<% Option Explicit %>
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "visit_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim theme,menushow
dim YY, MM, DD
dim allRs, rows, rowsCount, cols, i
dim sumCount,ncount,refcount,link_url
dim vIP, vBrowser, vOS, vReferer, vTarget, vHH, vMT

menushow = Request("menushow")
theme = Request("theme")


call PageLoad()
call Manage()
call PageUnLoad()

'---------------------------------------------------------------------------------------------------------------
' 프로시저,함수
'---------------------------------------------------------------------------------------------------------------
sub PageLoad()

	
	YY = request("YY")
	MM = request("MM")
	DD = request("DD")

	if YY = "" then
		YY = year(date)
	end if

	if MM = "" then
		MM = month(date)
	end if

	if DD = "" then
		DD = day(date)
	end if

end sub
'---------------------------------------------------------------------------------------------------------------
sub PageUnLoad()
end sub
'---------------------------------------------------------------------------------------------------------------
sub Manage()
	
	'카운터 수의 합을 구한다
	strSQL = "select count(vNum) from " & theTable & " where vYY = "&YY&" and vMM = "&MM&" and vDD = "&DD&""
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			sumCount = objRs(0)
		end if

	objRs.close()
	set objRs = nothing	
	
	strSQL = "select vIP,vBrowser,vOS,vReferer,vTarget,vHH,vMT from " & theTable & " where vYY = "&YY&" and vMM = "&MM&" and vDD = "&DD&" order by vNum desc"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if objRs.eof or objRs.bof then
		else
			allRs = objRs.getstring(2,,chr(9)&chr(10),chr(11)&chr(12))
			rows = split(allRs,chr(11)&chr(12))
			rowsCount = ubound(rows)		
		end if

	objRs.close()
	set objRs = nothing

end sub
'---------------------------------------------------------------------------------------------------------------
function GetData(theNum)

	cols					= split(rows(theNum),chr(9)&chr(10))
	vIP					= cols(0)
	vBrowser			= cols(1)
	vOS					= cols(2)
	vReferer			= cols(3)
	vTarget			= cols(4)
	vHH					= cols(5)
	vMT					= cols(6)

	if trim(vBrowser) = "" then
		vBrowser = "unKnown"
	end if

	select case lcase(trim(vOS))
	case "" 
		vOS = "unKnown"

	case "windows nt 5.0" 
		vOS = "Windows 2000"

	case "windows nt 5.1" 
		vOS = "Windows XP"

	end select

end function
'---------------------------------------------------------------------------------------------------------------
function SetSize(theNum)

	if cint(theNum) < 10 then
		theNum = "0" & theNum
	end if

	SetSize = theNum	

end function
'---------------------------------------------------------------------------------------------------------------
function fncPreDay(theText)

	dim preMM

	preMM = dateadd("d",-1,cdate(YY&"-"&MM&"-"&DD))

	fncPreDay = "<a href='./main.asp?menushow="&menushow&"&theme="&theme&"&YY="&year(preMM)&"&MM="&month(preMM)&"&DD="&day(preMM)&"'>" & theText & "</a>"

end function
'---------------------------------------------------------------------------------------------------------------
function fncNextDay(theText)

	dim nextMM

	nextMM = dateadd("d",1,cdate(YY&"-"&MM&"-"&DD))

	fncNextDay = "<a href='./main.asp?menushow="&menushow&"&theme="&theme&"&YY="&year(nextMM)&"&MM="&month(nextMM)&"&DD="&day(nextMM)&"'>" & theText & "</a>"

end function
'---------------------------------------------------------------------------------------------------------------
%>
<link rel="stylesheet" type="text/css" href="visit_style.css">

<script language="javascript">
function setting()
{
	form = document.Form1;
	form.YY.value = '<%=YY%>';
	form.MM.value = '<%=MM%>';
	form.DD.value = '<%=DD%>';
}
</script>
<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>방문경로별 통계</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>


<form action="./main.asp" method="post" name="Form1" >
<input type="hidden" name=menushow value=<%=menushow%>>
<input type="hidden" name="theme" value=<%=theme%>>

<table class="table_main w_default">
<tr>
	<td align="left">
		<select name="YY">
		<%for i = year(date)-5 to year(date) + 5%>
		<option value="<%=i%>"><%=i%>년</option>
		<%next%>
		</select>
		<select name="MM">
		<%for i = 1 to 12%>
		<option value="<%=i%>"><%=i%>월</option>
		<%next%>
		</select>
		<select name="DD" onchange="document.Form1.submit();">
		<%for i = 1 to 31%>
		<option value="<%=i%>"><%=i%>일</option>
		<%next%>
		</select>
		[<a href="./main.asp?menushow=<%=menushow%>&theme=<%=theme%>">오늘</a>]&nbsp;&nbsp;<%=fncPreDay("☜ 이전날")%>&nbsp;|&nbsp;<%=fncNextDay("다음날 ☞")%>
	</td>
	<td align="right" valign="bottom" style="font-family:tahoma; font-size:8pt;">
		Total <%=sumCount%>&nbsp;
	</td>
</tr>
</table><br />

<%
	'-----------Referer Url을 카운트/링크 
	strSQL = "Select vreferer,refcount=count(*) From visit_counter"
	strSQL = strSQL &" Where vYY='"&YY&"' And vMM='"&MM&"' And vDD='"&DD&"' "
	strSQL = strSQL &" Group by vreferer Order by refcount Desc "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
%>
		<table class="table_main w_default">
			<col width="50px" />
			<col width="*" />
			<col width="80px" />
			<tr>
				<th>No</th>
				<th>Referer Url</th>
				<th>Count</th>
			</tr>
<%
ncount = 1
Do Until objRs.eof
	vreferer = objRs("vreferer")
	refcount = objRs("refcount")
	If vreferer="" or isnull(vreferer) Then
	vreferer = "즐겨찾기 또는 주소 직접입력 접속"
	link_url = vreferer
	Else
	link_url = "<a href="&vreferer&" target='_blank'>"&left(vreferer, 80)&"</a>"
	End if
%>
			<tr>
				<td align="center"><%=ncount%></td>
				<td><%=link_url%></td>
				<td align="center"><%=refcount%></td>
			</tr>
<%
objRs.movenext
ncount = ncount + 1
Loop
objRs.close
Set objRs = Nothing
%>			
		</table>


<div class="space20"></div>
        <table class="table_main w_default">
			<col width="50px" />
			<col width="*" />
			<col width="80px" />
			<col width="80px" />
          <tr align="center"> 
            <th rowspan="2">NO</th>
            <th>TIME</th>
            <th colspan="3">REFERER</th>
            <th>BROWSER</th>
          </tr>
          <tr align="center"> 
            <th>IP</th>
            <th colspan="3">TARGET</td>
            <th>OS</th>
          </tr>

                <%if rowsCount < 1 then%>
		<tr height="80">
			<td align="center" valign="center" rowspan="2" colspan="5">
				등록된 기록이 없습니다
			</td>
		</tr>
<%end if%>
<%for i = 0 to rowsCount - 1 : GetData(i)%>
		<tr> 
			<td rowspan="2" align="center"><%=rowsCount - i%></b></td>
			<td align="center"><%=SetSize(vHH)&":"&SetSize(vMT)%></td>
			<td colspan="3" style='word-break:break-all;padding:3'><a href="<%=vReferer%>" target="new"><%=left(vReferer, 60)%></a></td>
			<td align="center"><%=vBrowser%></td>
		</tr>
		<tr> 
			<td align="center"><%=vIP%></td>
			<td colspan="3"><a href="<%=vTarget%>"><%=vTarget%></a></td>
			<td align="center"><%=left(vOS, 20)%></td>
		</tr>

<%next%>
              </table>
            </td>
          </tr>
        </table>
</form>
</td>
              </tr>
            </table>
<script language=javascript>
<!--
setting();
//-->
</script>			
