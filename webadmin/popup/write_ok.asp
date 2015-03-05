<% Option Explicit %>
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%><%
On Error Resume Next 	'바로 다음소스 실행

gubun		= request("gubun")
seq			= request("seq")
isuse		= request("isuse")
intcookie	= request("intcookie")
intscroll	= request("intscroll")
strWid		= request("strWid")
strHeight	= request("strHeight")
title		= request("title")
htm			= request("htm")
memo		= replace(request("memo"),"'","''")
year1		= request("year1")
year2		= request("year2")
month1		= request("month1")
month2		= request("month2")
day1		= request("day1")
day2		= request("day2")

startdate	= year1&"-"&month1&"-"&day1
enddate		= year2&"-"&month2&"-"&day2



if htm <> "1" then  'html형식이 아닌경우..
  memo = Server.HTMLEncode(memo)
else
  memo = replace(memo,chr(13),"<br />")
end if


if gubun="edit" then

	strSQL = "update popup set htm="&htm&",isuse="&isuse&",strWid="&strWid&",strHeight="&strHeight&",title='"&title&"',startdate='"&startdate&"',enddate='"&enddate&"',memo='"&memo&"',intscroll='"&intscroll&"',intcookie='"&intcookie&"' where seq="&seq, noOfrecords 
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
elseif gubun="del" then
	Call db.ExecSQL("delete popup where seq="&seq, Nothing, Nothing)

else
	strSQL = "insert into popup (title,startdate,enddate,memo,htm,isuse,strWid,strHeight) values ('"&title&"','"&startdate&"','"&enddate&"','"& memo &"',"&htm&","&isuse&","&strWid&","&strHeight&")"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
end if


if Err then
%>
	<script language="javascript">
	alert("작업이 제대로 완료되지 않았습니다.\n\n다시 시도해 주세요.");
	history.back();
	</script>
<%	
response.end
end if


response.redirect "/webadmin/main.asp?menushow=menu14&theme=popup/list"
%>
