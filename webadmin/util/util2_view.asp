<% Option Explicit %>
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim page,F_Year,F_Month,F_Day,cc_id,m_id,menushow,theme

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

page		= Request("page")
F_Year		= Request("F_Year")
F_Month		= Request("F_Month")
F_Day		= Request("F_Day")
cc_id		= Request("cc_id")
m_id		= Request("m_id")
menushow	= Request("menushow")
theme		= Request("theme")

''count 수를 올린다.
strSQL = "update wizDiary set cc_count = cc_count + 1 where cc_id = "&cc_id
Call db.ExecSQL(strSQL, Nothing, DbConnect)

Dim cc_sdate,cc_title,cc_m_name,cc_count,cc_desc,tmpdate
	
strSQL = "select * from wizDiary where cc_id = "&cc_id
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	cc_sdate	= objRs("cc_sdate")
	cc_title	= objRs("cc_title")
	cc_m_name	= objRs("cc_m_name")
	cc_count	= objRs("cc_count")
	''cc_desc	= objRs("cc_desc")
	cc_desc		= util.ReplaceHtmlText(0, objRs("cc_desc"))
	tmpdate		= split(cc_sdate, "-")
	F_Year		= tmpdate(0)
	F_Month		= tmpdate(1)
	F_Day		= tmpdate(2)
%>
<fieldset class="desc w_desc">
			<legend>일정관리</legend>
			<div class="notice">[note]</div>
			<div class="comment">원하시는 날짜를 클릭하신 후 메모를 넣어주세요</div>
</fieldset>
<div class="space20"></div>
<table class="table_main w_default">
  <tr>
    <td colspan="6"><%=cc_title%></td>
  </tr>
  <tr>
    <th class="agn_c">성명</th>
    <td><%=cc_m_name%></td>
    <th class="agn_c">일정</th>
    <td><%=cc_sdate%></td>
    <th class="agn_c">조회수</th>
    <td><%=cc_count%></td>
  </tr>
  <tr>
    <td colspan="6"><%=cc_desc%></td>
  </tr>

</table>
<div class="agn_c w_default">
<span class="button bull"><a href="./main.asp?menushow=<%=menushow%>&theme=util/util2&m_id=<%=m_id%>&page=<%=page%>&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>&F_Day=<%=F_Day%>">리스트</a></span>
<span class="button bull"><a href="./main.asp?menushow=<%=menushow%>&theme=util/util2_write&smode=qup&cc_id=<%=cc_id%>&m_id=<%=m_id%>&page=<%=page%>&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>&F_Day=<%=F_Day%>">수정</a></span>
<span class="button bull"><a href="./main.asp?menushow=<%=menushow%>&theme=util/util2_qry&query=qde&cc_id=<%=cc_id%>&m_id=<%=m_id%>&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>">삭제</a></span>
