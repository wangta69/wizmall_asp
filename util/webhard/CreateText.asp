<%
If Trim(Request.Form("file_name"))<>"" Then

	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

		path = Replace(Request.Form("path"),"/","\")
		strTextFile = path & Request.Form("file_name")&"."&Request.Form("file_ext")

		Set objTStream = objFSO.CreateTextFile(strTextFile, True, False)

			For Each currentline in Split(Request.Form("content"),chr(13)&chr(10))
				objTStream.WriteLine currentline
			Next

			objTStream.Close
		Set objTStream=Nothing
%>
<script language="JavaScript">
<!--
opener.location.reload();
window.close();

//-->
</script>
<%End If%>