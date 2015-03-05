<% Option Explicit %>
<!-- #include file="../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file="../../lib/class.util.asp" -->
<!-- #include file="../../lib/class.database.asp" -->
<!-- #include file="../../lib/class.member.asp" -->
<!-- #include file = "../../config/common_array.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim theme, menushow
Dim mgrade, totalmember, input_date, smode
Dim Loopcnt, strSQL, objRs, selected, tmp_date
Dim this_year, this_month, this_day

Dim db, util, member
Set db		= new database : Set util	= new utility : Set member	= new members

theme				= Request("theme")
menushow			= Request("menushow")
mgrade				= Request("mgrade")
input_date			= Request("input_date")
smode				= Request("smode")

if mgrade	= ""  then mgrade = 10
if smode	= "" then smode = "hour"
''step 1 : 전체 데이터
strSQL = "select count(*) as totalmember from wizmembers m "
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
totalmember	= objRs("totalmember")

''step 2 : 검색 
if input_date = "" then
	this_year	= Year(Now())
	this_month	= Month(Now())
	this_day	= Day(Now())
	input_date	= this_year & "-" & this_month & "-" & this_day
else
	tmp_date = split(input_date, "-")
	this_year	= tmp_date(0)
	this_month	= tmp_date(1)
	this_day	= tmp_date(2)
end if
%>
<script type="text/javascript" src="/js/jquery.plugins/jquery.wizchart-1.0.2.js" ></script>
<script language="JavaScript">
<!--
$(function(){
	
	$(".btn_search").click(function(){
		var smode = $(this).attr("smode");
		$("#smode").val(smode);
		$("#s_form").submit();
	});
	
	$(".startbar").chart({	height:5,bgcolor:"red"});
});
function ModeChange(mode)
{
	document.logform.mode.value=mode;
	document.logform.submit();
}
//-->
</script>
<table class="table_outline">
	<tr>
		<td>
		
<fieldset class="desc">
        <legend>회원가입통계</legend>
        <div class="notice">[note]</div>
        <div class="comment">회원가입통계입니다.</div>
      </fieldset>
      <p></p>
	  

			<table class="table_main w_default">
				<tr>
					<td>총 가입자수 : <%=totalmember%></td>
				</tr>
					</table><!----------->

<form name='s_form' id="s_form" action='./main.asp' method='post'>
							<input type="hidden" name="menushow"  value='<%=menushow%>'>
							<input type="hidden" name="theme" value='<%=theme%>'>
							<input type="hidden" name="smode" id="smode" value="" />
							<table>
								<tr>
									<td>
										<select name="mgrade">
											<%
for Loopcnt=1 to Ubound(MemberGradeArr)
	if int(mgrade) = int(Loopcnt) then selected = "selected" else selected = ""
	if MemberGradeArr(Loopcnt) <> "" then 
		Response.Write("<option value='"&Loopcnt&"' "&selected&">"&MemberGradeArr(Loopcnt)&"</option>"&Chr(13)&Chr(10))
	end if
next 
%>
										</select>
										<input type="text" name="input_date" class="datepicker" value="<%=input_date%>" />
										<span class="btn_search button bull" smode="" ><a>확인</a></span> <span class="btn_search button bull" smode="month" ><a>월별</a></span> <span class="btn_search button bull" smode="day" ><a>일별</a></span> <span class="btn_search button bull" smode="hour" ><a>시간</a></span></td>
								</tr>
							</table>
						</form>
					<table class="table_main w_default">
													<%
Dim endCount, ment
Redim reg_count(12)
Dim	total_count : total_count	= 0
Select Case smode
    Case "month"
		endCount = 12
		ment = "월"
		Redim Preserve reg_count(12)
		For Loopcnt = 1 To endCount
			tmp_date = this_year & "-" & util.FillZero(Loopcnt, 2)
			strSQL = "SELECT count(*) FROM wizmembers WHERE mgrade='" & mgrade & "' and CONVERT(VARCHAR(7),mregdate,120 ) =  '" & tmp_date & "' "
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			reg_count(Loopcnt)	= objRs(0)
			total_count = total_count + reg_count(Loopcnt)
		Next
    Case "day"
		endCount = 31
		ment = "일"
		Redim Preserve reg_count(31)
		For Loopcnt = 1 To endCount
			tmp_date = this_year & "-" &  util.FillZero(this_month, 2) & "-" &  util.FillZero(Loopcnt, 2)
			strSQL = "SELECT count(*) FROM wizmembers WHERE mgrade='" & mgrade & "' and CONVERT(VARCHAR(10),mregdate,120 ) =  '" & tmp_date & "' "
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			reg_count(Loopcnt)	= objRs(0)
			total_count = total_count + reg_count(Loopcnt)
		Next
    Case "hour"
		endCount = 23
		ment = "시"
		Redim Preserve reg_count(24)
		For Loopcnt = 1 To endCount
			tmp_date = this_year & "-" &  util.FillZero(this_month, 2) & "-" &  util.FillZero(this_day, 2) & " " &  util.FillZero(Loopcnt, 2)
			strSQL = "SELECT count(*) FROM wizmembers WHERE mgrade='" & mgrade & "' and CONVERT(VARCHAR(13),mregdate,120 ) =  '" & tmp_date & "' "
			''Response.Write(strSQL)
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			reg_count(Loopcnt)	= objRs(0)
			total_count = total_count + reg_count(Loopcnt)
		Next
    Case "weekday"
		endCount = 7
		ment = "시"
		Redim Preserve reg_count(7)
	''	w = date(w, mktime(0,0,0,thismonth, thisday, thisyear));
	''	thisday = thisday-w;
	''	for(i=0; i<=endCount; i++){
	''		startdate = mktime(0,0,0,thismonth,thisday+i, thisyear);
	''		enddate = mktime(0,0,-1,thismonth,thisday+i+1, thisyear);
	''		sqlstr = "SELECT count(*) FROM ".WIZTABLE["MEMBER"]." WHERE mgrade='mgrade' and mregdate between startdate and enddate";
	''		regcnt[i] = dbcon->get_one(sqlstr);
	''		total_count += regcnt[i];
	''	}			
End Select

Function t_week(cnt)
	If smode <> "weekday" then 
		t_week = cnt & ment
	else
		Select Case cnt
			Case "1"
				t_week = "일"
			Case "2"
				t_week = "월"
			Case "3"
				t_week = "화"
			Case "4"
				t_week = "수"
			Case "5"
				t_week = "목"
			Case "6"
				t_week = "금"	
			Case "7"
				t_week = "토"																						
		End Select
	end if
End Function

Dim per, re_per
For Loopcnt = 1 To endCount
	if total_count <> 0 then
		per = round(100*reg_count(Loopcnt)/total_count)
		re_per = per
	else
		per		= 0
		re_per	= 0
	end if
%>
													<tr height=20>
														<td bgcolor=efefef><%=t_week(Loopcnt)%></td>
														<td width=500>
														<div><ul><li ratio="<%=re_per%>" class="startbar" alt='건수 ' style="list-style:none"></li></ul></div> </td>
														<td><%=reg_count(Loopcnt)%> &nbsp;&nbsp; ( <%=per%> %)</td>
													</tr>
													<%
Next
%>
												</table>
</td>
	</tr>
</table>