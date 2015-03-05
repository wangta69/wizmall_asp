<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database


Server.ScriptTimeout = 100000

DirectoryPath = SYSTEM_URL & "config\"

Set abc = Server.CreateObject("ABCUpload4.XForm")

content=abc("content")
content = replace(content,chr(13) & chr(10),"<br />")
subject=abc("subject")

'if abc("attachFile_ppt") <> "" then
   'filename_ppt = abc("attachFile_ppt")
'end if

abc.AbsolutePath = True

Set oFile = abc("attachFile")(1)

Set oFile_ppt = abc("attachFile_ppt")(1)

'실제적인 파일 업로드를 처리하는 부분
If oFile.FileExists Then 

    strFileName = oFile.SafeFileName
	'response.write strfilename
	'response.end
    FileSize = oFile.Length
    FileType = oFile.FileType

    if oFile.Length > 4096000 then
        Response.Write "<script language=javascript>"
        Response.Write "alert(""4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"");"
        Response.Write "history.back();"
        Response.Write "</script>"
        Response.end
    else
        strFileWholePath = GetUniqueName(strFileName, DirectoryPath) '결과값 받음
        oFile.Save strFileWholePath
    End If
    
End If


If oFile_ppt.FileExists Then 

    strFileName_ppt = oFile_ppt.SafeFileName
	'response.write strfilename
	'response.end
    FileSize = oFile_ppt.Length
    FileType = oFile_ppt.FileType

    if oFile_ppt.Length > 4096000 then
        Response.Write "<script language=javascript>"
        Response.Write "alert(""4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"");"
        Response.Write "history.back();"
        Response.Write "</script>"
        Response.end
    else
        strFileWholePath_ppt = GetUniqueName(strFileName_ppt, DirectoryPath) '결과값 받음
        oFile_ppt.Save strFileWholePath_ppt
    End If
    
End If



Set oConn = Server.CreateObject("ADODB.Connection")

Set objConn = Server.CreateObject("ADODB.Connection")
    strConn = "Driver={Microsoft Excel Driver (*.xls)}; DBQ=" & DirectoryPath & strFileName 
    objConn.Open strConn
        
	ex_sql="select `Sheet1`.`이름`, `Sheet1`.`이메일주소`, `Sheet1`.`회사명` "
	ex_sql=ex_sql & " from `Sheet1` "
	ex_sql=ex_sql & " order by `Sheet1`.`이름`, `Sheet1`.`이메일주소`, `Sheet1`.`회사명` "

	Set oRS=objConn.execute(ex_sql)
		   		

Do While not oRS.eof 

Set objMail = Server.CreateObject("CDONTS.NewMail")


html = content 	

objMail.mailformat = cdomailformatmime

if strFileName_ppt <> "" Then
'objMail.Attach
objMail.attachFile DirectoryPath & strFileName_ppt 
end if

   objMail.From="member@kma.or.kr"
   objMail.To=oRS("이메일주소")
   objMail.Subject= oRS("이름") & " 님께 : " & abc("subject")
  
   objMail.BodyFormat = 0     ' HTML일떄 0, 일반 Text일때 1 으로 설정한다.
   objMail.MailFormat = 0     ' HTML일떄 0, 일반 Text일때 1 으로 설정한다.
   objMail.body = html        
   objMail.send               '이제 메일을 보낸다.	 	
oRS.movenext	

Set objMail	=Nothing

Loop




'유니크한 파일경로및 파일이름을 얻어내는 함수
Function GetUniqueName(byRef strFileName, DirectoryPath)

    Dim strName, strExt
    ' 확장자를 제외한 파일명을 얻는다.
    strName = Mid(strFileName, 1, InstrRev(strFileName, ".") - 1) 
         strExt = 	Mid(strFileName, InstrRev(strFileName, ".") + 1)

    Dim fso
    Set fso = Server.CreateObject("Scripting.FileSystemObject")

    Dim bExist : bExist = True 
    '우선 같은이름의 파일이 존재한다고 가정
    Dim strFileWholePath : strFileWholePath = DirectoryPath & "\" & strName & "." & strExt 
    '저장할 파일의 완전한 이름(완전한 물리적인 경로) 구성
    Dim countFileName : countFileName = 0 
    '파일이 존재할 경우, 이름 뒤에 붙일 숫자를 세팅함.

    Do While bExist ' 우선 있다고 생각함.
        If (fso.FileExists(strFileWholePath)) Then ' 같은 이름의 파일이 있을 때
            countFileName = countFileName + 1 '파일명에 숫자를 붙인 새로운 파일 이름 생성
            strFileName = strName & "(" & countFileName & ")." & strExt
            strFileWholePath = DirectoryPath & "\" & strFileName
        Else
            bExist = False
        End If
    Loop
    GetUniqueName = strFileWholePath
End Function


'oRS.close
'Set oRS=Nothing
'oConn.close
'Set oConn=Nothing



%>
<html>
<head>
<title>메일 보내기</title>
</head>
<body bgcolor="#ffffff">
<p>　</p>
<p>　</p>
<p><font face="돋움" size="4" color="#000080"><strong>　</strong></font></p>
<p align="center"><strong><font face="Comic Sans MS" size="6" color="#FF8000">Mail</font><font
face="돋움" size="4" color="#000080"> 을 잘 보냈습니다.</font></strong></p>
<p align="center"><font face="돋움" size="4" color="#000080"><strong>수고하셨습니다.</strong></font></p>
</body>
</html>
<HTML>
