
<%
Set fso = Server.CreateObject("Scripting.FileSystemObject")

Response.ContentType = "image/jpeg"
' ---- parameter parsing ----'
Dim VFilePath,FilePath,Width,Height,Quality,bShellThumbnails,bStretch,bCreate
VFilePath = Request("VFilePath")
If Len(VFilePath)=0 Then VFilePath="NoThumb.gif"
FilePath = Server.MapPath(VFilePath)
If Not fso.FileExists(FilePath) Then
  FilePath = Server.MapPath("NoThumb.gif")
End If
If Len(Request("Width"))>0 Then
  Width = Int(Request("Width"))
Else Width = 200
End If
If Len(Request("Height"))>0 Then
  Height = Int(Request("Height"))
Else Height = 200
End If
If Len(Request("Quality"))>0 Then
  Quality = Int(Request("Quality"))
Else Quality = 75
End If
If Len(Request("ShellThumbnails"))>0 Then
  bShellThumbnails = (Request("ShellThumbnails")="True")
Else bShellThumbnails = False
End If
If Len(Request("AllowStretch"))>0 Then
  bStretch = (Request("AllowStretch")="True")
Else bStretch = False
End If

Dim BinData
If bShellThumbnails Then
 ' Create COM Shell Thumbnail object
  Set objThumb = Server.CreateObject("ThumbExtract.FileThumbExtract")
  Call objThumb.SetPath(FilePath)
  Call objThumb.SetThumbnailSize(Width,Height)
  Call objThumb.ExtractThumbnail
  BinData = objThumb.ThumbJpgData(Quality)
Else
 ' Create COM CxImage wrapper object
  Set objCxImage = Server.CreateObject("CxImageATL.CxImage")
  Call objCxImage.Load(FilePath,GetFileType(FilePath))
  Call objCxImage.IncreaseBpp(24)
  ' determine thumbnail size and resample original image data
  If Not bStretch Then ' retain aspect ratio
	 widthOrig = CDbl(objCxImage.GetWidth())
	 heightOrig = CDbl(objCxImage.GetHeight())
	 fx = widthOrig/Width
	 fy = heightOrig/Height 'subsample factors
	 ' must fit in thumbnail size
	 If fx>fy Then f=fx Else f=fy  ' Max(fx,fy)
	 If f<1 Then f=1
	 widthTh = Int(widthOrig/f)
	 heightTh = Int(heightOrig/f)
  Else
	 widthTh = Width
	 heightTh = Height
  End If
  Call objCxImage.Resample(widthTh,heightTh,2)
  BinData = objCxImage.ImageForASP(2,Quality)
End If

' output in Response '
Response.BinaryWrite BinData

Function GetFileType(sFile)
  dot = InStrRev(sFile, ".")
  filetype=2
  If dot > 0 Then sExt = LCase(Mid(sFile, dot + 1, 3))
  If sExt = "bmp" Then filetype = 0
  If sExt = "gif" Then filetype = 1
  If sExt = "jpg" Then filetype = 2
  If sExt = "png" Then filetype = 3
  If sExt = "ico" Then filetype = 4
  If sExt = "tif" Then filetype = 5
  If sExt = "tga" Then filetype = 6
  If sExt = "pcx" Then filetype = 7
  GetFileType=filetype
End Function

%>
