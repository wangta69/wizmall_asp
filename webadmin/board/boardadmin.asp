<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
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


Dim bid,theme,menushow,AdminBID,AdminGID,gid,smode


bid = request("bid")
theme = request("theme")
menushow = request("menushow")
AdminBID = request("AdminBID")
AdminGID = request("AdminGID")
gid = request("gid")
smode = request("smode")

Function readGroupSelect(gid)
	Dim SELECT_VALUE
	Set objRs	= db.ExecSQLReturnRS("select gid FROM  wiztable_group_config ", Nothing, DbConnect)
		readGroupSelect = "<option value=''> 선택해주세요"& vbcrlf
	WHILE NOT(objRs.EOF)
		IF gid = objRs("gid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		readGroupSelect = readGroupSelect & "<option value='" & objRs("gid") & "'" & SELECT_VALUE & ">" & objRs("gid") & vbcrlf
	objRs.MOVENEXT
	WEND
END Function
%>

<script>
<!--
function reSize() {
    try {
        var objBody = auto_iframe.document.body;
        var objFrame = document.all["auto_iframe"];
        ifrmHeight = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight);
        objFrame.style.height = ifrmHeight;
    }
        catch(e) {}
}

function init_iframe() {
    reSize();
    setTimeout('init_iframe()',1)
}

init_iframe();
//-->
</script>
<table class="table_outline">
  <tr>
    <td>
	
	
	<fieldset class="desc">
        <legend>게시판관리</legend>
        <div class="notice">[note]</div>
        <div class="comment">게시판의 생성및 게시물삭제 비번, 기타 등 게시물에 대한 조치를 취하는 곳입니다.</div>
      </fieldset>
      <p></p>
	  
	  <%
if AdminBID <> "" then
Response.Write "<iframe src='../wizboard.asp?adminmode=true&BID="&AdminBID&"&GID="&AdminGID&"' width='760' height='800' frameborder='0' framespacing='0' name='auto_iframe' id='auto_iframe' scrolling='no'></iframe>"
end if
%>
	  <br /> 
<% 
'response.Write("smode = " & smode & ", bid = " & bid & ",gid = " & gid)
if smode="list" then		  
%>
<iframe frameborder="O" height="200" scrolling="auto" id="YieldFrame"  src="./boardobjRs.asp?bid=<%=bid%>&gid=<%=gid%>&adminmode=true"  width="100%"> </iframe>
<%
end if
%>

</td>
  </tr>

</table>
