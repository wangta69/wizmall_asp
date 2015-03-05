<%
Function IsFileOfType(afile,infile_type)
  IsFileOfType = (UCase(Right(afile,Len(infile_type)))=UCase(infile_type))
End Function

Sub WriteGotoPageScript
 Response.Write "<script language=""javascript"">" & vbCrLf & _
  "//<!--" & vbCrLf & "function GoToPage(vpath,n) { " & vbCrLf & _
  "document.forms(0).hdnCurPage.value=n;" & vbCrLf & _
  "document.forms(0).submit(); " & vbCrLf & _
  "}" & vbCrLf & "//-->" & vbCrLf & "</" & "script>" & vbCrLf
End Sub

Function ListThumbs(VPath,Columns,Filter,AllowPaging,PageSize,Width,Height,Quality,AllowStretch,ShowFilenames,ShellThumbnails)
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set ScriptName = Request.ServerVariables("SCRIPT_NAME")
  ScriptPath = Left(ScriptName,InstrRev(ScriptName,"/"))
  If Right(VPath,1)<>"/" Then VPath=VPath & "/"
  path = Server.MapPath(VPath):  If Right(path,1)<>"\" Then path=path & "\"
  ' analyze filter string
  If Len(Filter)=0 Then Filter = "*.gif;*.jpg;*.bmp"
  arSuffixes = Split(Filter,";")
  For i=0 To UBound(arSuffixes)
   pos=Instr(1,arSuffixes(i),".")
   If pos>0 Then arSuffixes(i) = Mid(arSuffixes(i),pos) ' e.g. ".gif"
  Next 
  Dim CurPage,TotalPages
  ' -- write client script and hidden field for current page and path
  If AllowPaging Then Call WriteGotoPageScript
  If Len(Request.Form("hdnCurPage"))>0 Then
    CurPage = CInt(Request.Form("hdnCurPage"))
  Else CurPage=1
  End If
  Response.Write "<input type='hidden' name='hdnCurPage' value='" & CurPage & "' />" & vbCrLf
  If Request.Form("hdnPrevPath")<> VPath Then CurPage = 1 ' restart page numbering
  Response.Write "<input type='hidden' name='hdnPrevPath' value='" & VPath & "' />" & vbCrLf
  
  Dim arrFilesAll(),ubn
  If fso.FolderExists(path) Then
    Set oFolder = fso.GetFolder(path)
    For Each oFile in oFolder.Files
      bFileInFilter=False
      For i=0 To UBound(arSuffixes)
        If IsFileOfType(oFile.Name,arSuffixes(i)) Then bFileInFilter=True
      Next
      If bFileInFilter Then
        ReDim Preserve arrFilesAll(ubn)
        arrFilesAll(ubn) = oFile.Name
        ubn=ubn+1
      End If ' if in filter
    Next
   End If
  
  If AllowPaging Then
   TotalPages = CInt(ubn/PageSize)
   If ubn Mod PageSize>0 Then TotalPages = TotalPages + 1
   if TotalPages=0 Then TotalPages=1
    ' make sure current page is in the [1,totalPages] range
   if CurPage>TotalPages  Then 
     CurPage=TotalPages
   else 
     if CurPage<1 Then CurPage=1
   end if
   ' range of files to read
   StartIndex = (CurPage-1)*PageSize
   EndIndex = CurPage*PageSize
   If ubn < EndIndex Then EndIndex = ubn
  Else
   StartIndex = 0: EndIndex = ubn
  End If
  ' write thumbnail hrefs
  If fso.FolderExists(path) Then
    Response.Write "<TABLE ALIGN='CENTER'>" & vbCrLf
    For index=StartIndex To EndIndex-1
      FileName = arrFilesAll(index)
      ' Response.write path & FileName
      Set oFile=fso.GetFile(path & FileName) : FileSize=oFile.Size
      nCol = nCol+1
      VFilePath = VPath & FileName
      sHREF = "<a href='" & VFilePath & "'>" & _
        "<img src='" & ScriptPath & "ThumbGenerate.asp?VFilePath=" & _
      Server.URLEncode(VFilePath) & "&Width=" & Width & "&Height=" & Height & "&Quality=" & Quality & _
      "&ShellThumbnails=" & ShellThumbnails & "&AllowStretch=" & AllowStretch & _
      "' border=0 alt='Name: " & FileName & "&#10;&#13;Size: " & CInt(FileSize/1024) & " Kb'/> </a>"
      If nCol = 1 Then Response.Write "<TR>"
       Response.Write "<TD align='Center' style='background-color:White;border-width:1px;border-style:Solid;font-size:8pt;'>" & vbCrLf
       Response.Write sHREF & vbCrLf 
       If ShowFilenames Then Response.Write "<br/>" & FileName
       Response.Write "</TD>" & vbCrLf
       If nCol = Columns Then
         Response.Write "</TR>" & vbCrLf
           nCol = 0
       End If 
     Next
     Response.Write NumImagesDisplayed(EndIndex-StartIndex,AllowPaging,ubn,CurPage,TotalPages)
     If AllowPaging Then
       Response.Write CreateNavBar(VPath,CurPage,TotalPages,Columns)
     End If
     Response.Write "</TABLE>" & vbCrLf
  Else
    Response.Write "Directory Does Not Exist<P>" & vbCrLf
  End If
End Function

Function NumImagesDisplayed(NumDisplayed,AllowPaging,TotalFiles,CurPage,TotalPages) 
 s = "<tr><td align='Center' colspan='" & Columns & "' style='background-color:#FFFFC0;font-size:8pt;'>"
 s = s & NumDisplayed
 if AllowPaging  Then s = s & " of " & TotalFiles
 s = s & " thumbnails"
 if AllowPaging Then
   s = s & "  (Page " & CurPage & " of " & TotalPages & ")"
 end if
 s =  s & "</td></tr>"
 NumImagesDisplayed = s
End Function

Function CreateNavBar(VPath,CurPage,TotalPages,Columns)
if TotalPages = 1 Then Exit Function
s = "<tr><td align='Center' colspan='" & Columns & "' style='font-size:8pt;'>"
if CurPage>1 Then
  'GoToPage client script updates hidden field with target page
  'and then causes a postback
  s =  s & "<A href=""javascript:GoToPage('" & VPath & "'," & CurPage-1 & _
   ");"">&lt;&lt; Prev</A>&nbsp;&nbsp;"
End If
for i=1 To TotalPages
  if i=CurPage Then
    s =  s & "<b>" & i & "</b>" 
  else 
    s =  s & "<A href=""javascript:GoToPage('" & VPath & "'," & i & ");"">" & _
     i & "</A>"
  end if
  s =  s & "&nbsp;"
  If i Mod 10=0 Then s = s & "<br/>"
Next
If CurPage<TotalPages Then
  s =  s & "&nbsp;<A href=""javascript:GoToPage('" & VPath & "'," & CurPage+1 & _
   ");"">Next &gt;&gt;</A>&nbsp;&nbsp;"
End If
s =  s & "</td></tr>"
CreateNavBar = s 
End Function

%>