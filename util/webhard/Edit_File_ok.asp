<%
Dim path, filename, New_filename
path			= Request("path")
filename		= Request("filename")
New_filename	= Request("New_filename")
If Request.form <> "" Then

	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set file = objFSO.GetFile(path&filename)
	file.Move(path&New_filename)
	Set objFSO = Nothing
End if
%>
<script language="JavaScript">
<!--
opener.location.reload();
window.close();
//-->
</script>