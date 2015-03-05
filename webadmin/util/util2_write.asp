<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim menushow, theme, page, F_Year, F_Month, F_Day, cc_id, smode, m_id
Dim cc_m_name, cc_title, cc_Desc, cc_sdate
Dim strSQL,objRs
Dim db, util
''Set util = new utility	
Set db = new database

menushow	= Request("menushow")
theme		= Request("theme")
page		= Request("page")
F_Year		= Request("F_Year") : if F_Year= 0 then F_Year = Year(date)
F_Month		= Request("F_Month") : if F_Month = 0 then F_Month = Month(date)
F_Day		= Request("F_Day"): if F_Day = 0 then F_Day = Day(date)
cc_id		= Request("cc_id")
smode		= Request("smode")
m_id		= Request("m_id")

if smode = "qup" then
	strSQL			= "select cc_m_name, cc_sdate, cc_title, cc_Desc from wizDiary where cc_id = '"&cc_id&"'"
	Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	cc_m_name		= objRs("cc_m_name")
	cc_sdate			= objRs("cc_sdate")
	cc_title			= objRs("cc_title")
	cc_Desc			= objRs("cc_Desc")
end if
%>
<script language="JavaScript" type="text/JavaScript">
<!--
$(function(){
	$(".btn_save").click(function(){
		if($("#cc_m_name").val() == ""){
			alert("성함을 넣어주세요");
			$("#cc_m_name").focus();
		}else if($("#cc_Title").val() == ""){
			alert("제목을 넣어주세요");
			$("#cc_Title").focus();
		}else if($("#cc_Desc").val() == ""){
			alert("내용을 넣어주세요");
			$("#cc_Desc").focus();
		}else $("#s_form").submit();
	});
});
//-->
</script>

<fieldset class="desc w_desc">
<legend>일정 등록</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<form name="s_form" id="s_form" action="./main.asp" method="post">
  <input type="hidden" name="menushow" value="<%=menushow%>">
  <input type="hidden" name="theme" value="util/util2_qry">
  <input type="hidden" name="query" value="<%=smode%>">
  <input type="hidden" name="F_Year" value="<%=F_Year%>">
  <input type="hidden" name="F_Month" value="<%=F_Month%>">
  <input type="hidden" name="F_Day" value="<%=F_Day%>">
  <input type="hidden" name="cc_id" value="<%=cc_id%>">
  <input type="hidden" name="m_id" value="<%=m_id%>">
  <table class="table_main w_default">
  	<col width="150px" title=""/>
    <col width="*" title=""/>
    <col width="150px" title=""/>
     <col width="*" title=""/>
    <tr>
      <th>이름</th>
      <td><input name="cc_m_name" type="text" id="cc_m_name" value="<%=cc_m_name%>" size="20" /></td>
      <th>일정</th>
      <td><%=F_Year%>-<%=F_Month%>-<%=F_Day%></td>
    </tr>
    <tr>
      <th>제목</th>
      <td colspan="3"><input name="cc_Title" type="text" id="cc_Title" value="<%=cc_Title%>" size="50" /></td>
    </tr>
    <tr>
      <td align="center" valign="top" colspan="4">
        <textarea name="cc_Desc" rows="20" style="width:100%" id="cc_Desc"><%=cc_Desc%></textarea>
      </td>
    </tr>
  </table>
  <div class="w_default agn_c"><span class="button bull btn_save"><a>저장</a></span> <span class="button bull"><a href="/webadmin/main.asp?menushow=menu13&theme=util/util2">취소</a></span></div>
</form>
