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
Set util = new utility	
Set db = new database


Function URLDecode(URLStr)  ' URL Decode Function
    sURL = Trim(URLStr)
    sBuffer = ""
    Index = 1
    'response.write sURL
    
    Do While Index <= Len(sURL)
        cChar = Mid(sURL, Index, 1)
        
        If cChar = "+" Then
            sBuffer = sBuffer & " "
            Index = Index + 1
        ElseIf cChar = "%" Then
            cChar = Mid(sURL, Index + 1, 2)
            
            If CInt("&H" & cChar) < &H80 Then
                sBuffer = sBuffer & Chr(CInt("&H" & cChar))
                Index = Index + 3
            Else
                cChar = Replace(Mid(sURL, Index + 1, 5), "%", "")
                sBuffer = sBuffer & Chr(CInt("&H" & cChar))
                Index = Index + 6
            End If
        Else
            sBuffer = sBuffer & cChar
            Index = Index + 1
        End If
    Loop
    
    URLDecode = sBuffer
End Function


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

tencodevalue = Request("encodevalue")

dim value(2,2)
encodevalue = URLDecode(tencodevalue)
tmparr = split(encodevalue, "&")
for i=0 to ubound(tmparr)
	tmparr1 = split(tmparr(i), "=")
	value(i,0) = tmparr1(0)
	value(i,1) = tmparr1(1)
next

'존재유무를 책크후 없으면 넣고 있으면 skip한다.
strSQL = "select count(*) from sendmailcount where mid="&value(0,1)&" and email='"&value(1,1)&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
if objRs(0) <= 0 then 
	strSQL = "insert into sendmailcount (mid,email,flag,wdate) values ("&value(0,1)&",'"&value(1,1)&"','1',getdate())"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
end if
%>
