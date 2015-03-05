<!-- #include file ="./ListThumbs.inc" -->

<html>
    <head>
    <title>Classic ASP thumbnail solution test page</title>
    </head>
    <body style="font-family: Verdana;" >
    <h2><center>Thumbnails with classic ASP and free COM Objects</center></h2>
    <form id="Form1" method="post">

     <%
         If Len(Request.Form("VPath"))>0 Then
           VPath = Request.Form("VPath")
         Else VPath="/ThumbAsp"
         End If
         If Len(Request.Form("Width"))>0 Then
           Width = CInt(Request.Form("Width"))
         Else Width=200
         End If
         If Len(Request.Form("Height"))>0 Then
           Height = CInt(Request.Form("Height"))
         Else Height=200
         End If
         If Len(Request.Form("Quality"))>0 Then
           Quality = CInt(Request.Form("Quality"))
         Else Quality=75
         End If
         AllowPaging = Len(Request.Form("AllowPaging"))>0

         If Len(Request.Form("PageSize"))>0 Then
           PageSize = CInt(Request.Form("PageSize"))
         Else PageSize=8
         End If
         If Len(Request.Form("Columns"))>0 Then
           Columns = CInt(Request.Form("Columns"))
         Else Columns=4
         End If
         If Len(Request.Form("Filter"))>0 Then
           aFilter = Request.Form("Filter")
         Else aFilter="*.jpg;*.gif"
         End If
         AllowStretch = Len(Request.Form("AllowStretch"))>0
         ShowFilenames = Len(Request.Form("ShowFilenames"))>0
         ShellThumbnails = Len(Request.Form("ShellThumbnails"))>0
     %>
     <TABLE align="center" style="font-size:80%">
     <tr><td>
     Virtual path with images:<input type='text' name='VPath' value='<%=VPath%>' size='25'/>
     Columns:<input type='text' name='Columns' value='<%=Columns%>' size='3' />
     Filter:<input type='text' name='Filter' value='<%=aFilter%>' size='10' />
     </td></tr>  <tr><td>
     Width:<input type='text' name='Width' value='<%=Width%>' size='4' />
     Height:<input type='text' name='Height' value='<%=Height%>' size='4' />
     Quality:<input type='text' name='Quality' value='<%=Quality%>' size='4' />
     <input type="checkbox" name="AllowPaging" value="1"
       <%if AllowPaging Then %>checked<%end if%>/>Allow paging &nbsp;&nbsp;
     Page size:<input type='text' name='PageSize' value='<%=PageSize%>' size='4' />
     </td></tr>
     </td></tr>  <tr><td>
     <input type="checkbox" name="AllowStretch" value="1"
       <%if AllowStretch Then %>checked<%end if%>/>Allow Stretch &nbsp;&nbsp;
     <input type="checkbox" name="ShowFilenames" value="1"
       <%if ShowFilenames Then %>checked<%end if%>/>Show Filenames&nbsp;&nbsp;
     <input type="checkbox" name="ShellThumbnails" value="1"
       <%if ShellThumbnails Then %>checked<%end if%>/>Shell Thumbnails &nbsp;&nbsp;
     <tr><td align="center"><input type="submit" value="Submit" name="B1"></td></tr>
     </TABLE><p/>
	<%
	Call ListThumbs(VPath,Columns,aFilter,AllowPaging,PageSize,Width,Height,Quality,AllowStretch,ShowFilenames,ShellThumbnails)
	%>
        </form>
    </body>
</html>
