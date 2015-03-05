<!-- #include file = "../../lib/cfg.common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="VI60_defaultClientScript" content="JavaScript">
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<style type="text/css">
<!--
a {
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
h1 {
	font-family: arial, helvetica, sans-serif;
	font-size: 18pt;
	font-weight: bold;
}
h2 {
	font-family: arial, helvetica, sans-serif;
	font-size: 14pt;
	font-weight: bold;
}
body, td {
	font-family: arial, helvetica, sans-serif;
	font-size: 10pt;
}
th {
	font-family: arial, helvetica, sans-serif;
	font-size: 11pt;
	font-weight: bold;
}
//
-->
</style>
<title>SYSINFO v1.0.0.0</title>
</head>
<body>
<table align="center" border="1" cellpadding="5" cellspacing="0" width="600" bgcolor="#000000" style="border-collapse: collapse" bordercolor="#111111">
  <tr valign="middle" bgcolor="#9999cc">
    <td align="left" nowrap><font size="5"> SYSINFO</b>&nbsp;<br />
      Server Name: <font color="#000080"><%=request.ServerVariables("SERVER_NAME")%>:<%=request.ServerVariables("SERVER_PORT")%></b> Local Addr: <font color="#000080"><%=request.ServerVariables("LOCAL_ADDR")%></b> Remote Addr: <font color="#000080"><%=request.ServerVariables("REMOTE_ADDR")%>:<%=request.ServerVariables("REMOTE_PORT")%></b></td>
  </tr>
</table>
<%
'===============================================================
'	드라이브 체크(driveexists)
'
'	response.write "'C' 드라이브 체크: "& driveexists("c") &"<hr>"
'
function driveexists(driveletter)
	set fc = server.createobject("scripting.filesystemobject")
	driveexists = fc.driveexists(driveletter)
	set fc = nothing
end function

'===============================================================
'	드라이브 정보(getdrive)
'
'	set drive = getdrive("C")
'	response.write "DriveType Property: "& drive.DriveType &"<br />"
'	response.write "DriveLetter Property: "& drive.DriveLetter &"<br />"
'	response.write "path Property: "& drive.path &"<br />"
'	response.write "IsReady Property: "& drive.IsReady &"<br />"
'	if drive.IsReady then
'		response.write "RootFolder Property: "& drive.RootFolder &"<br />"
'		response.write "SerialNumber Property: "& drive.SerialNumber &"<br />"
'		response.write "VolumeName Property: "& drive.VolumeName &"<br />"
'		response.write "ShareName Property: "& drive.ShareName &"<br />"
'		response.write "FileSystem Property: "& drive.FileSystem &"<br />"
'		response.write "TotalSize Property: "& formatnumber(drive.TotalSize / 1024, 0) &" Kbyte<br />"
'		response.write "AvailableSpace Property: "& formatnumber(drive.AvailableSpace / 1024, 0) &" Kbyte<br />"
'		response.write "FreeSpace Property: "& formatnumber(drive.FreeSpace / 0124, 0) &" Kbyte<br />"
'	end if
'	response.write "<hr>"
'
function getdrive(driveletter)
	getdrive = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.driveexists(driveletter) then
		set getdrive = fc.getdrive(driveletter)
	end if
	set fc = nothing
end function

'===============================================================
'	드라이브 리스트(drives)
'
'	set dlist = drives
'	for each drive in dlist
'		response.write "DriveType Property: "& drive.DriveType &"<br />"
'		response.write "DriveLetter Property: "& drive.DriveLetter &"<br />"
'		response.write "path Property: "& drive.path &"<br />"
'		response.write "IsReady Property: "& drive.IsReady &"<br />"
'		if drive.IsReady then
'			response.write "RootFolder Property: "& drive.RootFolder &"<br />"
'			response.write "SerialNumber Property: "& drive.SerialNumber &"<br />"
'			response.write "VolumeName Property: "& drive.VolumeName &"<br />"
'			response.write "ShareName Property: "& drive.ShareName &"<br />"
'			response.write "FileSystem Property: "& drive.FileSystem &"<br />"
'			response.write "TotalSize Property: "& formatnumber(drive.TotalSize / 1024, 0) &" Kbyte<br />"
'			response.write "AvailableSpace Property: "& formatnumber(drive.AvailableSpace / 1024, 0) &" Kbyte<br />"
'			response.write "FreeSpace Property: "& formatnumber(drive.FreeSpace / 0124, 0) &" Kbyte<br />"
'		end if
'		response.write "<br />"
'	next
'	response.write "<hr>"
'
function drives
	set fc = server.createobject("scripting.filesystemobject")
	set drives = fc.drives
	set fc = nothing
end function


'===============================================================
'	폴더 체크(folderexists)
'	response.write "'.' 디렉토리 체크: "& folderexists(".") &"<hr>"
'
function folderexists(foldername)
	set fc = server.createobject("scripting.filesystemobject")
	folderexists = fc.folderexists(getabsolutepathname(foldername))
	set fc = nothing
end function

'===============================================================
'	폴더 정보(getfolder)
'
'	set folder = getfolder(".")
'	response.write "Drive Property: "& folder.Drive &"<br />"
'	response.write "IsRootFolder Property: "& folder.IsRootFolder &"<br />"
'	response.write "ParentFolder Property: "& folder.ParentFolder &"<br />"
'	response.write "Path Property: "& folder.Path &"<br />"
'	response.write "Name Property: "& folder.Name &"<br />"
'	response.write "Type Property: "& folder.Type &"<br />"
'	response.write "Attributes Property: "& folder.Attributes &"<br />"
'	response.write "Size Property: "& formatnumber(folder.Size / 1024, 0) &" Kbyte<br />"
'	response.write "ShortName Property: "& folder.ShortName &"<br />"
'	response.write "ShortPath Property: "& folder.ShortPath &"<br />"
'	response.write "DateCreated Property: "& folder.DateCreated &"<br />"
'	response.write "DateLastAccessed Property: "& folder.DateLastAccessed &"<br />"
'	response.write "DateLastModified Property: "& folder.DateLastModified &"<br />"
'	response.write "Files Property: [Object]<br />"
'	response.write "subFolders Property: [Object]<br />"
'	response.write "<hr>"
'
function getfolder(foldername)
	getfolder = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.folderexists(getabsolutepathname(foldername)) then
		set getfolder = fc.getfolder(getabsolutepathname(foldername))
	end if
	set fc = nothing
end function


'===============================================================
'	폴더 리스트(subfolders)
'
'	set folders = subfolders(".")
'	for each folder in folders
'		response.write "Drive Property: "& folder.Drive &"<br />"
'		response.write "IsRootFolder Property: "& folder.IsRootFolder &"<br />"
'		response.write "ParentFolder Property: "& folder.ParentFolder &"<br />"
'		response.write "Path Property: "& folder.Path &"<br />"
'		response.write "Name Property: "& folder.Name &"<br />"
'		response.write "Type Property: "& folder.Type &"<br />"
'		response.write "Attributes Property: "& folder.Attributes &"<br />"
'		response.write "Size Property: "& formatnumber(folder.Size / 1024, 0) &" Kbyte<br />"
'		response.write "ShortName Property: "& folder.ShortName &"<br />"
'		response.write "ShortPath Property: "& folder.ShortPath &"<br />"
'		response.write "DateCreated Property: "& folder.DateCreated &"<br />"
'		response.write "DateLastAccessed Property: "& folder.DateLastAccessed &"<br />"
'		response.write "DateLastModified Property: "& folder.DateLastModified &"<br />"
'		response.write "Files Property: [Object]<br />"
'		response.write "subFolders Property: [Object]<br />"
'		response.write "<br />"
'	next
'	response.write "<hr>"
'
function subfolders(path)
	subfolders = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.folderexists(getabsolutepathname(path)) then
		set ff = fc.getfolder(getabsolutepathname(path))
		set subfolders = ff.subfolders
		set ff = nothing
	end if
	set fc = nothing
end function

'===============================================================
'	폴더 만들기(createfolder)
'	response.write "'./test' 폴더 만들기: "& createfolder("./test") &"<hr>"
'
function createfolder(foldername)
	createfolder = false
	set fc = server.createobject("scripting.filesystemobject")
	if not fc.folderexists(getabsolutepathname(foldername)) then
		createfolder = fc.createfolder(getabsolutepathname(foldername))
	end if
	set fc = nothing
end function

'===============================================================
'	폴더 복사(copyfolder)
'	response.write "'./test' to './test1' 폴더 복사: "& copyfolder("./test", "./test1", false) &"<hr>"
'
function copyfolder(folderobj, foldersrc, overwrite)
	copyfolder = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.folderexists(getabsolutepathname(folderobj)) and not fc.folderexists(getabsolutepathname(foldersrc)) then
		copyfolder = fc.copyfolder(getabsolutepathname(folderobj), getabsolutepathname(foldersrc), overwrite)
	end if
	set fc = nothing
end function

'===============================================================
'	폴더 이동(movefolder)
'	response.write "'./test1' to './test2' 폴더 이동: "& movefolder("./test1", "./test2")
'	response.write "'./test2' to './test1' 폴더 이동: "& movefolder("./test2", "./test1") &"<hr>"
'
function movefolder(folderobj, foldersrc)
	movefolder = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.folderexists(getabsolutepathname(folderobj)) and not fc.folderexists(getabsolutepathname(foldersrc)) then
		movefolder = fc.movefolder(getabsolutepathname(folderobj), getabsolutepathname(foldersrc))
	end if
	set fc = nothing
end function

'===============================================================
'	폴더 삭제(deletefolder)
'	response.write "'./test' 폴더 삭제: "& deletefolder("./test", false) &"<hr>"
'	response.write "'./test1' 폴더 삭제: "& deletefolder("./test1", false) &"<hr>"
'
function deletefolder(foldername, force)
	deletefolder = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.folderexists(getabsolutepathname(foldername)) then
		deletefolder = fc.deletefolder(getabsolutepathname(foldername), force)
	end if
	set fc = nothing
end function

'===============================================================
'	파일 체크(fileexists)
'	response.write "'./default.asp' 파일 체크: "& fileexists("./default.asp") &"<hr>"
'
function fileexists(filename)
	set fc = server.createobject("scripting.filesystemobject")
	fileexists = fc.fileexists(getabsolutepathname(filename))
	set fc = nothing
end function

'===============================================================
'	파일 정보(getfile)
'
'	set file = getfile("./default.asp")
'	response.write "Drive Property: "& file.Drive &"<br />"
'	response.write "ParentFolder Property: "& file.ParentFolder &"<br />"
'	response.write "Path Property: "& file.Path &"<br />"
'	response.write "Name Property: "& file.Name &"<br />"
'	response.write "Type Property: "& file.Type &"<br />"
'	response.write "Attributes Property: "& file.Attributes &"<br />"
'	response.write "Size Property: "& formatnumber(file.Size / 1024, 0) &" Kbyte<br />"
'	response.write "ShortName Property: "& file.ShortName &"<br />"
'	response.write "ShortPath Property: "& file.ShortPath &"<br />"
'	response.write "DateCreated Property: "& file.DateCreated &"<br />"
'	response.write "DateLastAccessed Property: "& file.DateLastAccessed &"<br />"
'	response.write "DateLastModified Property: "& file.DateLastModified &"<br />"
'	response.write "<hr>"
'
function getfile(filename)
	getfile = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.fileexists(getabsolutepathname(filename)) then
		set getfile = fc.getfile(getabsolutepathname(filename))
	end if
	set fc = nothing
end function

'===============================================================
'	파일 리스트(files)
'
'	set flist = files(".")
'	for each file in flist
'		response.write "Drive Property: "& file.Drive &"<br />"
'		response.write "ParentFolder Property: "& file.ParentFolder &"<br />"
'		response.write "Path Property: "& file.Path &"<br />"
'		response.write "Name Property: "& file.Name &"<br />"
'		response.write "Type Property: "& file.Type &"<br />"
'		response.write "Attributes Property: "& file.Attributes &"<br />"
'		response.write "Size Property: "& formatnumber(file.Size / 1024, 0) &" Kbyte<br />"
'		response.write "ShortName Property: "& file.ShortName &"<br />"
'		response.write "ShortPath Property: "& file.ShortPath &"<br />"
'		response.write "DateCreated Property: "& file.DateCreated &"<br />"
'		response.write "DateLastAccessed Property: "& file.DateLastAccessed &"<br />"
'		response.write "DateLastModified Property: "& file.DateLastModified &"<br />"
'		response.write "<hr>"
'	next
'
function files(path)
	set files = getfolder(path).files
end function

'===============================================================
'	text 파일 스트림 열기(openastextstream)
'
'	filename = "./test.txt"
'	createtextfile filename, true
'	set sfo = opentextstream(filename)
'
'	response.write "'./test.txt' 파일에 내용 쓰기: 'testw'<br />"
'	set sfow = sfo.openastextstream(2, -2)
'	sfow.write("testw")
'	sfow.close
'
'	set sfor = sfo.openastextstream(1, -2)
'	response.write "'./test.txt' 파일 내용 읽기: '"& sfor.readall &"'<br />"
'	sfor.close
'
'	set sfo = nothing
'
function opentextstream(filename)
	set opentextstream = getfile(filename)
end function

'===============================================================
'	text 파일 열기(opentextfile)
'
'	response.write "'./test.txt' 파일에 내용 쓰기: 'test'<br />"
'	set ofc = opentextfile("./test.txt", 2)
'	ofc.write("test")
'	ofc.close
'	set ofc = nothing
'
'	set ofc = opentextfile("./test.txt", 1)
'	response.write "'./test.asp' 파일 읽기 모드로 열기: '"& ofc.readall &"'<br />"
'	ofc.close
'	set ofc = nothing
'
'	response.write "'./test.txt' 파일에 내용 추가하기: 'test2'<br />"
'	set ofc = opentextfile("./test.txt", 8)
'	ofc.write("test2")
'	ofc.close
'	set ofc = nothing
'
'	set ofc = opentextfile("./test.txt", 1)
'	response.write "'./test.asp' 파일 읽기 모드로 열기: '"& ofc.readall &"'<hr>"
'	ofc.close
'	set ofc = nothing
'
function opentextfile(filename, iomode)
	set fc = server.createobject("scripting.filesystemobject")
	set opentextfile = fc.opentextfile(getabsolutepathname(filename), iomode, true)
	set fc = nothing
end function

'===============================================================
'	text 파일 생성(createtextfile)
'	createtextfile "./test.txt", true
'	response.write "'./test.txt' 파일 생성<br />"
'	createtextfile "./test.txt", false
'	response.write "'./test.txt' 파일 생성<hr>"
'
function createtextfile(filename, overwrite)
	set fc = server.createobject("scripting.filesystemobject")
	if fc.fileexists(getabsolutepathname(filename)) and not overwrite then
		flag = fc.movefile(getabsolutepathname(filename), getabsolutepathname(filename)&"."&replace(now,":","-"))
	end if
	set createtextfile = fc.createtextfile(getabsolutepathname(filename), overwrite)
	set fc = nothing
end function

'===============================================================
'	파일 복사(copyfile)
'	response.write "'./test.txt' to './test1.txt' 파일 복사: "& copyfile("./test.txt", "./test1.txt", false) &"<hr>"
'
function copyfile(fileobj, filesrc, overwrite)
	copyfile = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.fileexists(getabsolutepathname(fileobj)) and not fc.fileexists(getabsolutepathname(filesrc)) then
		copyfile = fc.copyfile(getabsolutepathname(fileobj), getabsolutepathname(filesrc), overwrite)
	end if
	set fc = nothing
end function

'===============================================================
'	파일 이동(movefile)
'	response.write "'./test.txt' to './test1.txt' 파일 이동: "& movefile("./test.txt", "./test1.txt") &"<br />"
'	response.write "'./test1.txt' to './test.txt' 파일 이동: "& movefile("./test1.txt", "./test.txt") &"<hr>"
'
function movefile(fileobj, filesrc)
	movefile = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.fileexists(getabsolutepathname(fileobj)) and not fc.fileexists(getabsolutepathname(filesrc)) then
		movefile = fc.movefile(getabsolutepathname(fileobj), getabsolutepathname(filesrc))
	end if
	set fc = nothing
end function

'===============================================================
'	파일 삭제(deletefile)
'	response.write "'./test1.txt' 파일 삭제: "& deletefile("./test1.txt", false) &"<hr>"
'
function deletefile(filename, force)
	deletefile = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.fileexists(getabsolutepathname(filename)) then
		deletefile = fc.deletefile(getabsolutepathname(filename), force)
	end if
	set fc = nothing
end function

'===============================================================
'	전체경로 반환(getabsolutepathname)
'	response.write "'.' 전체경로 반환: "& getabsolutepathname(".\test\test.co.kr") &"<br />"
'	response.write "'.' 전체경로 반환: "& getabsolutepathname("c:\test\test.co.kr") &"<br />"
'	response.write "'.' 전체경로 반환: "& getabsolutepathname("test\test.co.kr") &"<hr>"
'
function getabsolutepathname(path)
	getabsolutepathname = path
	if server.createobject("scripting.filesystemobject").getdrivename(getabsolutepathname) = "" then getabsolutepathname = ".\"& getabsolutepathname end if
	if instr(getabsolutepathname, ".") = 1 then getabsolutepathname = server.mappath(getabsolutepathname) end if
	getabsolutepathname = server.createobject("scripting.filesystemobject").getabsolutepathname(getabsolutepathname)
end function

'===============================================================
'	드라이브 이름 반환(getdrivename)
'	response.write "c:\abc\test.asp' 드리아브 이름 반환: "& getdrivename("c:\abc\test.asp") &"<br />"
'	response.write "'.\abc\test.asp' 드리아브 이름 반환: "& getdrivename(".\abc\test.asp") &"<hr>"
'
function getdrivename(path)
	set fc = server.createobject("scripting.filesystemobject")
	getdrivename = fc.getdrivename(getabsolutepathname(path))
	set fc = nothing
end function

'===============================================================
'	이름 반환(getbasename)
'	response.write "'c:\abc\test.asp' 이름 반환: "& getbasename("c:\abc\test.asp") &"<br />"
'	response.write "'c:\abc\test' 이름 반환: "& getbasename("c:\abc\test") &"<hr>"
'
function getbasename(filename)
	set fc = server.createobject("scripting.filesystemobject")
	getbasename = fc.getbasename(filename)
	set fc = nothing
end function

'===============================================================
'	확장명 반환(getextensionname)
'	response.write "'c:\abc.aa\test.asp' 확장명 반환: "& getextensionname("c:\abc\test.asp") &"<br />"
'	response.write "'c:\abc.bb\test' 확장명 반환: "& getextensionname("c:\abc\test") &"<hr>"
'
function getextensionname(filename)
	set fc = server.createobject("scripting.filesystemobject")
	getextensionname = fc.getextensionname(filename)
	set fc = nothing
end function

'===============================================================
'	전체 이름(확장명 포함) 반환(getfilename)
'	response.write "'c:\abc.aa\test.asp' 전체 이름(확장명 포함) 반환: "& getfilename("c:\abc\test.asp") &"<br />"
'	response.write "'c:\abc.bb\test' 전체 이름(확장명 포함) 반환: "& getfilename("c:\abc\test") &"<hr>"
'
function getfilename(filename)
	set fc = server.createobject("scripting.filesystemobject")
	getfilename = fc.getfilename(filename)
	set fc = nothing
end function

'===============================================================
'	파일 버젼 반환(getfilename)
'	response.write "'default.asp' 파일 버젼 반환: "& getfileversion("default.asp") &"<hr>"
'
function getfileversion(filename)
	getfileversion = false
	set fc = server.createobject("scripting.filesystemobject")
	if fc.fileexists(getabsolutepathname(filename)) then
		getfileversion = fc.getfileversion(getabsolutepathname(filename))
	end if
	set fc = nothing
end function

'===============================================================
'	상위 폴더 반환(getparentfoldername)
'	response.write "'./default.asp' 상위 폴더 반환: "& getparentfoldername("./default.asp") &"<br />"
'	response.write "'.' 상위 폴더 반환: "& getparentfoldername(".") &"<hr>"
'
function getparentfoldername(path)
	set fc = server.createobject("scripting.filesystemobject")
	getparentfoldername = fc.getparentfoldername(getabsolutepathname(path))
	set fc = nothing
end function

'===============================================================
'	시스템 폴더 반환(getspecialfolder)
'	response.write "'0' 윈도우 폴더 반환: "& getspecialfolder(0) &"<br />"
'	response.write "'1' 시스템 폴더 반환: "& getspecialfolder(1) &"<br />"
'	response.write "'2' 임시 폴더 반환: "& getspecialfolder(2) &"<hr>"
'
function getspecialfolder(special)
	set fc = server.createobject("scripting.filesystemobject")
	getspecialfolder = fc.getspecialfolder(special)
	set fc = nothing
end function

'===============================================================
'	임시 파일 이름 반환(gettempname)
'	response.write "임시 파일 이름 반환: "& gettempname &"<hr>"
'
function gettempname
	set fc = server.createobject("scripting.filesystemobject")
	gettempname = fc.GetTempName
	set fc = nothing
end function

'===============================================================
'	지정된 이름으로 중복되지 않는 이름 반환(getfileexists)
'	response.write "'./test.txt' 중복되지 않는 파일 이름 반환: "& getfileexists("./test.txt") &"<hr>"
'
function getfileexists(filename)
	set fc = server.createobject("scripting.filesystemobject")
	getfileexists = getabsolutepathname(filename)
	parentfoldername = fc.getparentfoldername(getabsolutepathname(filename))
	basename = fc.getbasename(getabsolutepathname(filename))
	extensionname = fc.getextensionname(getabsolutepathname(filename))

	if not fc.folderexists(parentfoldername) then
		flag = fc.CreateFolder(parentfoldername)
	end if

	i = 0
	do while fc.fileexists(getfileexists)
		if fc.fileexists(getfileexists) then
			i = i + 1
			getfileexists = parentfoldername &"\"& basename &"_"& i &"."& extensionname
		end if
	loop
	set fc = nothing
end function

'==============================================================================================================================
'	응용

'===============================================================
'	text 파일 전체 읽기(file_readall)
'
'	response.write "'./test.txt' 파일 전체 읽기:"& file_readall("./test.txt") &"<hr>"
'
function file_readall(filename)
	set fcr = opentextfile(filename, 1)
	file_readall = fcr.readall
	fcr.close
	set fcr = nothing
end function

'===============================================================
'	text 파일 전체 쓰기(file_writeall)
'
'	response.write "'./test.txt' 파일 전체 쓰기:"& file_writeall("./test.txt", "test") &"<hr>"
'
function file_writeall(filename, str)
	set fcw = opentextfile(filename, 2)
	file_writeall = fcw.write(str)
	fcw.close
	set fcw = nothing
end function
%>
<h2 align="center">Drives</h2>
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Drive</th>
    <th>Information</th>
  </tr>
  <% for each drive in drives
		select case int(drive.DriveType)
			case 1
				dDriveType = "Floppy Drive"
			case 2
				dDriveType = "Local Drive"
			case 4
				dDriveType = "CD Drive"
			case else			
				dDriveType = drive.DriveType &" none"
		end select
		dVolumeName = dDriveType

		if drive.IsReady then
			if drive.VolumeName <> "" then dVolumeName = drive.VolumeName end if
		end if %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap ><%= dVolumeName &" ("& drive.path &")" %></b></td>
    <td align="left"><%= "DriveLetter: "& drive.DriveLetter %><br />
      <%= "DriveType: "& drive.DriveType &" ("& dDriveType &")" %><br />
      <%= "IsReady: "& drive.IsReady %><br />
      <%		if drive.IsReady then %>
      <%= "FileSystem: "& drive.FileSystem %><br />
      <%= "SerialNumber: "& drive.SerialNumber %><br />
      <%= "ShareName: "& drive.ShareName %><br />
      <%= "RootFolder: "& drive.RootFolder %><br />
      <%= "TotalSize: "& formatnumber(drive.TotalSize / 1024, 0) &" Kbyte" %><br />
      <%= "AvailableSpace: "& formatnumber(drive.AvailableSpace / 1024, 0) &" Kbyte" %><br />
      <%= "FreeSpace: "& formatnumber(drive.FreeSpace / 1024, 0) &" Kbyte" %>
      <%		end if %>
    </td>
  </tr>
  <%	next %>
</table>
<%	response.Flush %>
<br />
</body>
</html>
<%	response.Flush %>
