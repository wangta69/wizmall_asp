<%
If Request.Form <> "" Then
	path = Request.Form("path")
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

		For Each key in Request.Form("select_item")

		it = Split(key,"?")
		item = path+it(1)
		mode = it(0)

			If mode = "Folder" Then
'				objFSO.MoveFolder(item)
response.write "*" & item & "이동<br>"
response.write "*" & item & mode & "모드<br>"
			ElseIf mode = "File" Then
'				objFSO.MoveFile(item)
response.write "*" & item & "이동<br>"
response.write "*" & item & mode & "모드<br>"
			End if
		Next
	Set objFSO = Nothing
End if
%>
<script language="JavaScript">
<!--
//parent.location.href='./index.asp?Directory=<%=Replace(path,"\","\\")%>'
//-->
</script>