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
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

dim countStart
strSQL="select top 1 vYY,vMM,vDD,vHH,vMT from "&theTable&" order by vNum"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
countStart = objRs(0) & "-" & objRs(1) & "-" & objRs(2) & " " & objRs(3) & ":" & objRs(4)
countStart = cdate(countStart)

dim countTotal
strSQL="select count(vNum) from "&theTable&""
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

countTotal = objRs(0)

dim countYesterday
strSQL="select count(vNum) from "&theTable&" where vYY = "&year(date-1)&" and vMM = "&month(date-1)&" and vDD = "&day(date-1)&""
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

countYesterday = objRs(0)

dim countToday
strSQL="select count(vNum) from "&theTable&" where vYY = "&year(date)&" and vMM = "&month(date)&" and vDD = "&day(date)&""
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

countToday = objRs(0)

dim countTop
strSQL = "select top 1 vYY,vMM,vDD,count(vNum) as vC from "&theTable&" group by vYY,vMM,vDD order by vC desc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

countTop = objRs(3)

dim countUnder
strSQL = "select top 1 vYY,vMM,vDD,count(vNum) as vC from "&theTable&" group by vYY,vMM,vDD order by vC asc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

countUnder = objRs(3)


dim countAVG
strSQL = "select avg(vC) from (select vYY,vMM,vDD,count(vNum) as vC from "&theTable&" group by vYY,vMM,vDD) x"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

countAVG = objRs(0)
%>
<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>총방문자 통계</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>


<table class="table_main w_default">
        <tr> 
          <th width="188">전체 방문자수 : </th>
          <td width="562" align="left"><%=formatnumber(countTotal,0)%></td>
        </tr>
        <tr> 
          <th>어제 방문자수 : </th>
          <td align="left"><%=formatnumber(countYesterday,0)%></td>
        </tr>
        <tr> 
          <th>오늘  방문자수 : </th>
          <td align="left"><%=formatnumber(countToday,0)%></td>
        </tr>
        <tr> 
          <th>현재 접속자수 : </th>
          <td align="left"><%=application("nowCount")%>connection(s)...</td>
        </tr>
        <tr> 
          <th>최고 방문자수 : </th>
          <td align="left"><%=formatnumber(countTop,0)%></td>
        </tr>
        <tr> 
          <th>최저 방문자수 : </th>
          <td align="left"><%=formatnumber(countUnder,0)%></td>
        </tr>
        <tr> 
          <th>일일 평균 방문자수 : </th>
          <td align="left"><%=formatnumber(countAVG,0)%></td>
        </tr>
        <tr> 
          <td colspan="2" align="center">since <%=formatdatetime(countStart,2)%><%=formatdatetime(countStart,4)%>(<%=DateDiff("d", countStart, date)%>th)</td>
        </tr>
      </table></td>
  </tr>
</table>
