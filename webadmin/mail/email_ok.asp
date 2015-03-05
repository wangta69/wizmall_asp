<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
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




Server.ScriptTimeout = 100000

DirectoryPath = SYSTEM_URL & "config\"
Set abc = Server.CreateObject("ABCUpload4.XForm")

content=abc("content")
subject=abc("subject")
gubun=abc("gubun")

abc.AbsolutePath = True
Set oFile = abc("attachFile")(1)

'실제적인 파일 업로드를 처리하는 부분
If oFile.FileExists Then 

    strFileName = oFile.SafeFileName
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

If gubun="total" Then

strSQL = "Select  a.wid,wpass,per_email,per_name From i_member a , i_personm b where a.ven_code=b.per_vcode and b.per_email <> '' and a.wid <> ''"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
End if

If gubun="a" then

strSQL = "Select ngubun,a.wid,wpass,per_email,per_name From i_member a , i_personm b where a.ven_code=b.per_vcode and a.gubun='조찬' and b.per_email <> '' and a.wid <> '' and (ngubun = '납부사' or ngubun='납부사(신규)')"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

End If

If gubun="b" then

strSQL = "Select ngubun,a.wid,wpass,per_email,per_name From i_member a , i_personm b where a.ven_code=b.per_vcode and a.gubun='회원' and b.per_email <> '' and a.wid <> '' and (ngubun = '납부사' or ngubun='납부사(신규)')"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
End If


'####################################### 메일 발송전 db에 정보 입력 시작 ##################################
'CREATE TABLE [dbo].[sendmail] (
'	[uid] [int] IDENTITY (1, 1) NOT NULL ,
'	[subject] [varchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
'	[content] [text] COLLATE Korean_Wansung_CI_AS NOT NULL ,
'	[flag] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
'	[total] [int] NOT NULL ,
'	[wdate] [smalldatetime] NULL 
') ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
'GO


'CREATE TABLE [dbo].[sendmailcount] (
'	[mid] [int] NOT NULL ,
'	[email] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
'	[flag] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
'	[wdate] [smalldatetime] NULL 
')
'GO

flag = right(gubun, 1)
mailcnt = 0
strSQL = "insert into sendmail (subject,content,flag,wdate,total) values ('"&subject&"','"&content&"','"&flag&"',getdate(),"&mailcnt&")"
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "select max(uid) from sendmail"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
uid = objRs(0)
'###################################### #메일 발송전 db에 정보 입력 끝 ##################################


'####################################### 메일 발송 시작 ##################################

If gubun="c" then		'개인일때

	Set objMail = Server.CreateObject("CDONTS.NewMail")	   

'메일첨부	
	objMail.mailformat = cdomailformatmime
	
	if strFileName <> "" Then
	objMail.attachFile DirectoryPath & strFileName 
	end if
'메일첨부 끝	
	
	   objMail.From="member@kma.or.kr"
	   objMail.To=abc("gaein_email")
	   objMail.Subject= abc("gaein_name") & " 님께 : " & abc("subject")
	   
	   objMail.BodyFormat = 0     ' HTML일떄 0, 일반 Text일때 1 으로 설정한다.
	   objMail.MailFormat = 0     ' HTML일떄 0, 일반 Text일때 1 으로 설정한다.
	   UrlLink = server.urlencode("mid=" & uid & "&revmail=" &abc("gaein_email"))
	   objMail.body = content & "<img src="""&PATH_URL&"webadmin/mailopencheck.asp?encodevalue="& UrlLink & """ width='0' height='0' border='0'>"       
	   objMail.send               '이제 메일을 보낸다.

	set objMail = nothing 
	mailcnt = mailcnt + 1

	'''''''''''''''''''' 개인일때  이메일링 끝''''''''''

Else   '개인이 아닐때


		   		

	Do While not rs.eof 
	
	Set objMail = Server.CreateObject("CDONTS.NewMail")

		wid=rs("wid")
		wpass=rs("wpass")

		html = content & "<p>" & "&nbsp;&nbsp;id:" & wid & "&nbsp;&nbsp;password:" & wpass & "<p>"	
'메일첨부	
	objMail.mailformat = cdomailformatmime
	
	if strFileName <> "" Then
	objMail.attachFile DirectoryPath & strFileName 
	end if
'메일첨부 끝	
			   objMail.From="member@kma.or.kr"
			   objMail.To=rs("per_email")
			   objMail.Subject= rs("per_name") & " 님께 : " & abc("subject")
			  
			   objMail.BodyFormat = 0     ' HTML일떄 0, 일반 Text일때 1 으로 설정한다.
			   objMail.MailFormat = 0     ' HTML일떄 0, 일반 Text일때 1 으로 설정한다.
			   UrlLink = server.urlencode("mid=" & uid & "&revmail=" &abc("gaein_email"))
			   objMail.body = html & "<img src="""&PATH_URL&"webadmin/mailopencheck.asp?encodevalue=" & UrlLink & """ width='0' height='0' border='0'>"    
			   objMail.send               '이제 메일을 보낸다.	 	
		rs.movenext	

		Set objMail	=Nothing
		mailcnt = mailcnt + 1
	Loop
End if
'####################################### 메일 발송 끝 ##################################

'####################################### 메일 발송후  db에 카운드 정보 update ##################################
strSQL = "update sendmail set total = "&mailcnt
Call db.ExecSQL(strSQL, Nothing, DbConnect)
'###################################### #메일 발송전 db에 정보 입력 끝 ##################################


set rs = Nothing
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
