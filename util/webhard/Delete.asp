<%
On error resume Next
Dim path
path = Request.Form("path")
If Request.Form <> "" Then
	
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

		For Each key in Request.Form("select_item")

		it = Split(key,"?")
		item = path+it(1)
		mode = it(0)

			If mode = "Folder" Then
				objFSO.DeleteFolder(item)
			ElseIf mode = "File" Then
				objFSO.DeleteFile(item)
			End if
		Next
	Set objFSO = Nothing
End if

Response.Redirect "./folderView.asp?Directory="&path
%>
