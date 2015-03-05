<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../..//lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.board.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Dim pskinname, pwidth, pheight, ptop, pleft, psubject, click_url, pcontents, pattached, imgposition, popupenable, pattachedarr
Dim imgpath0, isimg, background
''Set util = new utility	
Set db = new database
%>
<%
Dim uid: uid				= Request("uid")

strSQL = "select * from wizpopup where uid=" & uid

Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

pskinname		= objRs("pskinname")
pwidth			= objRs("pwidth")
pheight			= objRs("pheight")
ptop			= objRs("ptop")
pleft			= objRs("pleft")
psubject		= objRs("psubject")
click_url		= objRs("click_url")
pcontents		= objRs("pcontents")
pattached		= objRs("pattached")
imgposition		= objRs("imgposition")
popupenable		= objRs("popupenable")

pattachedarr = split(pattached, "|")

''Response.Write ("Ubound(pattachedarr) = " & Ubound(pattachedarr)) 

if Ubound(pattachedarr) >= 1 then 
	if pattachedarr(0) <> "" then isimg = "true"
	imgpath0 = "../../../config/wizpopup/"&pattachedarr(0)
else
	isimg = "false"
	imgpath0 = ""
end if

%>
<html>
<head>
<title><%=psubject%></title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="../../../css/base.css" type="text/css">
<script language="javascript" src="../../../js/jquery-1.4.2.min.js"></script>
<script language="javascript">
<!-- 
$(function(){
	$(".btn_direct_go").click(function(){
		opener.location.href="<%=click_url%>";
		self.close();
	});
});

function setCookie( name, value, expiredays ) 
{ 
	var todayDate = new Date(); 
	todayDate.setDate( todayDate.getDate() + expiredays ); 
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 
function closeWin() 
{ 
	if ( document.forms[0].Notice.checked )
	//만약 새창에서 여러개의 form 을 사용하고 있으면 forms[0] 에서 공지창 안띄우기 form의 순서(0부터 시작)로 고쳐줍니다. 예: forms[4] 
	setCookie( "Notice_<%=uid%>", "done" , 1); 
	self.close(); 
} 

// --> 
</script>
<style>
body {
	margin: 0;
	padding: 0;
}
#content {
	border: #9a9a9a 1px solid;
	overflow: auto;
	width: <%=pwidth%>px;
	height: <%=(pheight-30)%>px;
	text-align: left
}
</style>
</head>
<body>
<div id="content">
    <% 
if isimg = "true" and imgposition = "top" then %>
<div class="agn_c"><img src="<%=imgpath0%>" border="0"></div>
    <%
end if
if pcontents <> "" then
%>
<%=pcontents%>
    <%
end if
if imgpath0 = "true" and imgposition = "bottom" then %>
<div class="agn_c"><img src="<%=imgpath0%>" border="0"></div>
    <%
end if
if click_url <> "" then %>
<div class="agn_r"><span class="button bull btn_direct_go"><a>바로가기</a></span></div>
    <%
end if
%>
</div>
<form>
  <div class="agn_r">
  오늘 하루 이창 열지 않음
  <input type="checkbox" name="Notice" value="checkbox">
  <span class="button"><a href="javascript:onclick=closeWin()">닫기</a></span></div>
</form>

</body>
</html>
