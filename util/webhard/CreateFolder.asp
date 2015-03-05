<%
Response.Write(Request("folderName"))
Response.Write(Request("path"))
If Request("folderName") <> "" Then

folderName = Replace(Request("path"),"/","\") & Request("folderName")

Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	If Not(FSO.FolderExists(folderName)) Then
		Response.Write(Request("folderName"))
		FSO.CreateFolder(folderName)
%>
<script language="JavaScript">
<!--
function onClose() {
window.opener.parent.location.reload();
//location.href = "./index.asp?Directory=<%=Replace(Request("path"),"/","\\")%>"
//opener.location.reload();
location.href = "./index.asp?Directory=<%=Request("path")%>"
window.close();
}
//-->
</script>
<body onload="javascript:onClose()">
<%
	else
%>
중복되는 폴더명을 이용하실 수 없습니다.<br>
<input type=button value=돌아가기 onclick='javascript:history.back();'>
<%
	End If
Set FSO = Nothing
Else
%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title> New Folder </title>
</head>
<style>
<!--@IMPORT URL(./Css/Dir.css);-->
<!--@IMPORT URL(./Css/Margin.css);-->
<!--@IMPORT URL(./Css/Line.css);-->
<!--@IMPORT URL(./Css/Cusor.css);-->
<!--@IMPORT URL(./Css/Input_box.css);-->
</style>
<script type='text/javascript' src='./Js/Dir.JS'></script>
<body><p>
<p align=center>
<input type=button value=돌아가기 onclick='javascript:history.back();'>
<p align=center><font color=red><%=Request("folderName")%>폴더 생성을 실패 했습니다.</font>
</body>
</html>
<%End If%>
