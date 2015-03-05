<%@LANGUAGE="VBScript"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = config.asp-->
<%
Dim objFSO,CurrentFolder,sub_objFolder, search_subFolder, folderPath, folderName, temp_i, temp_j, n
Dim url, m
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

If Request("Directory") = "" Then
CurrentFolder = MainFolder
Else
CurrentFolder = Request("Directory") 
End IF

sub searchFolder(Targetfolder)

	For Each sub_objFolder in objFSO.GetFolder(Targetfolder).SubFolders
If IsNull(sub_objFolder) Then
Exit For
End if
		If sub_objFolder.Name <> "" Then
		Set search_subFolder = sub_objFolder.SubFolders
			folderPath = sub_objFolder.Path&"\"
			folderName = sub_objFolder.Name
		Set search_subFolder = Nothing

temp_i = Replace(folderPath,MainFolder,"")
temp_j = Replace(temp_i,"\","")
n = len(temp_i)- len(temp_j)
url = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("PATH_INFO") & folderName

%>
	aux<%=n%> = insFld(foldersTree, gFld("<%=folderName%>", "./folderView.asp?Directory=<%=replace(folderPath,"\","\\")%>"))
<%
		End If

call searchFolder_N(folderPath)

	Next

end sub

sub searchFolder_N(Targetfolder)

	For Each sub_objFolder in objFSO.GetFolder(Targetfolder).SubFolders
If IsNull(sub_objFolder) Then
Exit For
End if
		If sub_objFolder.Name <> "" Then
		Set search_subFolder = sub_objFolder.SubFolders
			folderPath = sub_objFolder.Path&"\"
			folderName = sub_objFolder.Name
		Set search_subFolder = Nothing

temp_i = Replace(folderPath,MainFolder,"")
temp_j = Replace(temp_i,"\","")
n = len(temp_i)- len(temp_j)
%>
		aux<%=n%> = insFld(aux<%=n-1%>, gFld("<%=folderName%>", "./folderView.asp?Directory=<%=replace(folderPath,"\","\\")%>"))
<%
		End If

	searchFolder_M (folderPath)
	Next

end sub 

sub searchFolder_M(Targetfolder)

	For Each sub_objFolder in objFSO.GetFolder(Targetfolder).SubFolders
If IsNull(sub_objFolder) Then
Exit For
End if
		If sub_objFolder.Name <> "" Then
		Set search_subFolder = sub_objFolder.SubFolders
			folderPath = sub_objFolder.Path&"\"
			folderName = sub_objFolder.Name
		Set search_subFolder = Nothing
temp_i = Replace(folderPath,MainFolder,"")
temp_j = Replace(temp_i,"\","")
m = len(temp_i)- len(temp_j)
%>
		aux<%=m%> = insFld(aux<%=m-1%>, gFld("<%=folderName%>", "./folderView.asp?Directory=<%=replace(folderPath,"\","\\")%>"))
<%
		End If

	searchFolder_N(folderPath)
	Next

end sub

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<style><!--@IMPORT URL(./Css/Dir.css);--></style>
<script src="./js/browserDetect.js"></script>
<script src="./js/folderStructure.js"></script>
<script language="JavaScript">
<!--
// Decide if the names are links or just the icons
USETEXTLINKS = 1  //replace 0 with 1 for hyperlinks

// Decide if the tree is to start all open or just showing the root folders
STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree
foldersTree = gFld("<b>공용 웹하드</b>", "folderView.asp")
<%call searchFolder(MainFolder)%>
//-->
</script>
</head>

<body topmargin=16 marginheight=16 onLoad="window.status=' '" oncontextmenu='return false;' ondragstart='return false' onselectstart='return false'>

<!-- Removing this link will make the script stop from working -->
<table border=0>
		<tr>
			<td>
				<p>
				<a href='http://www.mmartins.com' target=_top></a>
				</p>
			</td>
		</tr>
	</table>
<!-- Build the browser's objects and display default view of the tree. -->
<script language="JavaScript">
initializeDocument()
</script>
</body>
</html>
