<%@LANGUAGE="VBScript"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<%
Response.Expires = -1
Response.Buffer=True
Dim CurrentFolder, objFSO, aliasDir, Url, objCurrentFolder, ParentDir, colFolders, objFolder, objFile
Dim te, filetype, FileSize, FileSizeType, FolderSize, FolderSizeType
Dim mem_id
%>
<html>
<head>
<title>FTP No This page is ActiveServerPage || FileSystemObject</title>
<style>
<!--@IMPORT URL(./Css/Dir.css);-->
<!--@IMPORT URL(./Css/Margin.css);-->
<!--@IMPORT URL(./Css/Line.css);-->
<!--@IMPORT URL(./Css/Cusor.css);-->
<!--@IMPORT URL(./Css/Input_box.css);-->
</style>
<!-- METADATA TYPE="typelib" FILE="c:\WINDOWS\System32\scrrun.dll" -->
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
</head>
<script type='text/javascript' src='./Js/Dir.JS'></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function openWin(detail, imgwidth, imgheight) {
    var STATE = "";
    STATE = "scrollbars=no,toolbar=no,menubar=no,resizable=no,status=no,width=" + imgwidth + ",height=" + imgheight;
    window.open(detail, "", STATE);
  }
function edit_file(filename,path){
new_win("Edit_File.asp?path="+path+"&filename="+filename,600,200)

}
//-->
</SCRIPT>
<!-- #include file = Config.asp-->
<!-- <body bgcolor="#ffffff" oncontextmenu='return false;' ondragstart='return false' onselectstart='return false' >-->
<body bgcolor="#ffffff" >
<%
Response.Flush
CurrentFolder = MainFolder
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

If Request("Directory") = "" Then
CurrentFolder = MainFolder
Else

	If (objFSO.FolderExists(Request("Directory"))) Then
	CurrentFolder = Request("Directory")
	Else
	CurrentFolder = MainFolder
	End If

End IF

aliasDir = Replace(CurrentFolder,MainFolder,"")
aliasDir = Replace(aliasDir,"\","/")
Url = Replace(CurrentFolder,Server.Mappath("/"),"")
Url = Replace(Url,"\","/")' & "/"
'상위 디렉토리를 점검
If CurrentFolder <> MainFolder  Then
ParentDir = CurrentFolder
ParentDir = left(ParentDir,Len(CurrentFolder)-1)
ParentDir = StrReverse(ParentDir)
ParentDir = Mid(ParentDir,Instr(ParentDir,"\"),Len(CurrentFolder))
ParentDir = StrReverse(ParentDir)
End If
%>
<img src="./image/title_hard.gif"><br><br>
<%
If Instr(1,CurrentFolder,MainFolder,1) < 1 or Instr(1,CurrentFolder,"..\",1) > 0 Then
%> 
<div align="center">[잘못된 접근입니다.] <%
Else
' 현재 디레토리의 폴더를 가지고 온다.
Response.Write("CurrentFolder:" & CurrentFolder)
Set objCurrentFolder = objFSO.GetFolder(CurrentFolder)
%> </div>
<table width=750 border=0 cellpadding=0 cellspacing=0 >
  <tr> 
    <td> <!---------------------------------------------------------------------------> 
      <div id=stat name=stat style='display:;'>
        <div align="center"><font color=red>test<img src="../images/interface/bbs.gif" width="16" height="16">
          <font color="#FF6600">디렉토리를 읽는 중 입니다. 잠시만 기다려 주세요.</font></font></div>
      </div>
      <%Response.Flush%> 
      <table width="100%" align=center border=0 cellpadding=1 cellspacing=0 style='margin-top:5px;' >
        <form name=dir_List method=post action=''>
          <input type=hidden name=path value='<%=CurrentFolder%>'>
          <input type=hidden name=target value=''>
           <tr>
           <td  colspan=7  class=Line_A_LR>
           <table width="750" border="0" cellpadding="0" cellspacing="1" bgcolor="#B4DC24">
           <tr> 
            <td height="5"></td>
            <td height="5"></td>
            <td height="5"></td>
            <td height="5"></td>
            <td height="5"></td>
            <td height="5"></td>
            <td height="5"></td>
          </tr>
           <tr align="center" bgcolor="#E1F1F5"> 
            <td  height="30" width="37" bgcolor="#F5FDD9" class="text11-black">선택</td>
            <td  width="307" bgcolor="#F5FDD9" class="text11-black">이름</td>
            <td  width="52" bgcolor="#F5FDD9" class="text11-black">크기</td>
            <td  width="118" bgcolor="#F5FDD9" class="text11-black">종류</td>
            <td  width="83" bgcolor="#F5FDD9" class="text11-black">만든날짜</td>
            <td  width="83" bgcolor="#F5FDD9" class="text11-black">수정날짜</td>
            <td  width="70" bgcolor="#F5FDD9" class="text11-black">옵션</td>
          </tr>
          </table>
          </td>
          </tr>
          
          <%
If ParentDir <> "" Then
%> 
          <tr> 
            <td colspan=7 class=Line_A_LR> 
              <p><a href='folderView.asp?mem_id=<%=mem_id%>&Directory=<%=ParentDir%>' onMouseOver="window.status=' '; return true;"><img src='./image/Folders/OpenFolder.Gif' border=0> 
                ▲ 상위 폴더 ... </a> 
            </td>
          </tr>
          <%Else%> 
          <tr> 
            <td colspan=7 class=Line_A_LR height="50" bgcolor="#f7f7f7"> 
              <p class=oh>&nbsp;<font color="#FF423C"><span style="font-size:12pt;"><b>이용전에 반드시 읽어주세요!! </b></span><br>
             <font size="2" face="돋움"> &nbsp;자료는 반드시 <b>업체명폴더</b>에 올려주시고, 등록자가 불분명한 폴더는 관리자에 의해 <b>사전경고없이 삭제됨</b>을 알려드립니다.</font></font> 
            </td>
          </tr>
          <tr> 
            <td colspan=7 hegiht="2" bgcolor="#cccccc"> 
                          </td>
          </tr>
          <%End If%> <%Response.Flush%> <%
'하위 폴더의 목록을 가지고 온다.
Set colFolders = objCurrentFolder.SubFolders
For Each objFolder in colFolders

if Int((objFolder.Size)/1024) < 1 Then
FolderSize = objFolder.Size
FolderSizeType = "Byte"
ElseIf Int((objFolder.Size)/1024) > 1 Then
	FolderSize = objFolder.Size/1024
	If (FolderSize/1024) > 1 Then
	FolderSize = (FolderSize/1024)
	FolderSizeType = "MB"
	Else
	FolderSize = FolderSize
	FolderSizeType = "KB"
	End If
End If
%> 
          <tr onMouseOver='this.className="td_Z";' onMouseOut='this.className="";'> 
            <td height=20  width="37"> 
              <p align=center> 
                <input type=checkbox name=select_item value='Folder?<%=objFolder.Name%>'>
            </td>
            <td  width="307"> 
              <p><a href='./folderView.asp?mem_id=<%=mem_id%>&directory=<%=CurrentFolder%><%=objFolder.Name%>\' onMouseOver="window.status=' '; return true;"><img src='./image/Folders/Folder.Gif' width=21 height=13 border=0 ><%=objFolder.Name%></a> 
            </td>
            <td  width="52"> 
              <p align=center><%=left(FolderSize, Instr(FolderSize,".")+2)%>&nbsp;<%=FolderSizeType%> 
            </td>
            <td  width="118"> 
              <p align=center><%=objFolder.Type%> 
            </td>
            <td  width="83"> 
              <p align=center><%=Mid(objFolder.DateCreated,6,Len(objFolder.DateCreated)-5)%> 
            </td>
            <td  width="83"> 
              <p align=center><%=Mid(objFolder.DateLastModified,6,Len(objFolder.DateLastModified)-5)%> 
            </td>
            <td  width="70"> 
              <p align=center> <!-- <input type="image"  src="./image/btn_edit.gif" alt="수정" onClick="javascript:edit_folder('<%=objFolder.Name%>')"> --> 
            </td>
          </tr>
          <tr> 
            <td height="1" colspan="7" background="./image/dot.gif"></td>
          </tr>
          <%Next%> <%For Each objFile in objCurrentFolder.Files%> <%


te=Instr(1,StrReverse(objFile.Name),".",1)-1
if te > 0 then 
'Response.Write (te)
filetype = Right(objFile.Name,te)
else
filetype = objFile.Name
end if
if Int((objFile.Size)/1024) < 1 Then
FileSize = objFile.Size
FileSizeType = "Byte"
ElseIf Int((objFile.Size)/1024) > 1 Then
	FileSize = objFile.Size/1024
	If (FileSize/1024) > 1 Then
	FileSize = (FileSize/1024)
	FileSizeType = "MB"
	Else
	FileSize = FileSize
	FileSizeType = "KB"
	End If
End If

%> 
          <tr onMouseOver='this.className="td_Z";' onMouseOut='this.className="";'> 
            <td height=20 width="37"> 
              <p align=center> 
                <input type=checkbox name=select_item value='File?<%=objFile.Name%>'>
            </td>
            <td  width="307"> 
              <p> <a href="download.asp?filename=<%=objFile.Name%>&URL=<%=Url%>" onMouseOver="window.status=' '; return true;">
                <img src='./image/Files/<%=filetype%>.gif' onError="this.src='image/Files/UnKnown.gif'" border=0> 
                <%=objFile.Name%></a> 
            </td>
            <td  width="52"> 
              <p align=center><%=left(FileSize, Instr(FileSize,".")+2)%> &nbsp;<%=FilesizeType%> 
            </td>
            <td  width="118"> 
              <p align=center><%=objFile.Type%> 
            </td>
            <td  width="83"> 
              <p align=center><%=Mid(objFile.DateCreated,6,Len(objFile.DateCreated)-5)%> 
            </td>
            <td  width="83"> 
              <p align=center><%=Mid(objFile.DateLastModified,6,Len(objFile.DateLastModified)-5)%> 
            </td>
            <td  width="70"> 
              <p align=center> <a href="#" onClick="javascript:edit_file('<%=objFile.Name%>','<%=Replace(CurrentFolder,"\","/")%>')"><img src="./image/btn_edit.gif" border="0" width="63" height="21"></a>	
            </td>
          </tr>
          <tr> 
            <td height="1" colspan="7" background="./image/dot.gif"></td>
          </tr>
          <%Next%> 
          <tr> 
            <td  colspan=7> 
             <table width="750" border="0" cellpadding="0" cellspacing="1" bgcolor="#B4DC24">
          <tr> 
            <td height="5"></td>
          </tr>
        </table>
            </td>
          </tr>
   </form>
		  <tr>
			<td  colspan=7>
				<table width=100% align=center cellpadding=0 cellspacing=0 >
					<tr> 
						<td>
						<p><IMG src="./image/search_icon.gif" width=37 height=39 border=0 align="absmiddle"> <font color="#FF3300">업로딩할 파일</font>을 선택해주십시오.</p>
						</td>
						<td>
						<p align=center><!--#Include file="./FileUp_Form.asp"--> 
						</td>
					</tr>
				</table>
			</td>
		  </tr>
        
          <tr> 
            <td colspan=7 align = "center"> 
              
                <input type="button"  value="선택삭제"  alt="삭제" onClick='javascript:check("Delete");' class="submit" name=b1 style="CURSOR: hand">&nbsp;&nbsp; 
	            <input type="button"  value="쓰기"  alt="쓰기" onClick='javascript:make_file("<%=Replace(CurrentFolder,"\","/")%>");' style="CURSOR: hand" class="submit" name=b1>&nbsp;&nbsp;  
                <input type="button"  value="새폴더"  alt="새폴더" style="CURSOR: hand" onClick="javascript:openWin('Create_folder.asp?now_folder=<%=Replace(CurrentFolder,"\","/")%>', '300', '150')" onMouseOver="window.status=' '; return true;" class="submit" name=b1> 
            </td>
          </tr>
        
      </table>
      
      <script language="JavaScript">
<!--
document.all.stat.style.display='none';
//-->
</script>
    </td>
  </tr>
</table>
</BODY>
</HTML>
<%
Set objCurrentFolder = Nothing
Set colFolders = Nothing
End If
Set objFSO = Nothing
%>