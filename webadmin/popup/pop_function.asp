<%
	Function UseText(value)
		value = replace(value, "&" , "&amp;")
		value = replace(value, "<", "&lt;")
		value = replace(value, ">", "&gt;")
		value = replace(value, "'", "&quot;")
		UseText = value
	End Function
	
	Function ShowText(value,con_type)
		con_type = trim(con_type)

		If con_type = "html" Then
           value = UseHTML(Server.HTMLEncode(value))
        End If
		If con_type = "text" Then
		    value = Replace(UseHTML(value), vbLf, vbLf & "<br />")
	    End If
		ShowText = value
	End Function

	Function UseHTML(value)
		value = replace(value, "&lt;", "<")
		value = replace(value, "&gt;", ">")
		value = replace(value, "&quot;","'")
		value = replace(value, "&amp;", "&" )
 		UseHTML = value
	End Function 
	
	'유니크한 파일경로및 파일이름을 얻어내는 함수

Function GetUniqueName(byRef strFileName, DirectoryPath)

    Dim strName, strExt
    ' 확장자를 제외한 파일명을 얻는다.
    strName = Mid(strFileName, 1, InstrRev(strFileName, ".") - 1) 
         strExt = Mid(strFileName, InstrRev(strFileName, ".") + 1)
		'JPG와 GIF가 아닌 경우 돌려보낸다.
		'IF ((strExt <> "JPG") and (strExt <> "GIF") and (strExt <> "jpg") and (strExt <> "gif")) and (strExt <> "swf") and (strExt <> "SWF")) then
		'	Response.Write "<script language='javascript'>"
		'	Response.Write "alert('jpg , gif, swf 파일만 업로드하실 수 있습니다');"
		'	Response.Write "history.back();"
		'	Response.Write "</script>"
		'END IF

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



'파일 가로세로 사이즈 구하기
Sub GetImageSize(ByVal f, ByRef x, ByRef y)
    Set p = LoadPicture(f) 
    x = CLng(CDbl(p.Width) * 24 / 635) ' CLng 의 라운드 오프의 기능을 이용하고 있다. 
    y = CLng(CDbl(p.Height) * 24 / 635) ' CLng 의 라운드 오프의 기능을 이용하고 있다. 
    Set p = Nothing 
End Sub 


'*********************************************************
'1. 페이지 바로가기 함수
'* # FUNCTION NAME : 페이지별 바로가기
'* # FUNCTION CONT. : 게시판에서 페이지별 바로가기를 생성해 준다.
'* # MODIFICATIONS :
' 주) f_key 가 'n' 일때는 페이지 이동 form 을 외부 파일에서 선언해준다.
 '*********************************************************

Sub gotoPageHTML(page,Pagecount,Url,f_key)
	
	'-------------------------------------------------------------------------------
	'	페이지 바로 가기 함수
	'-------------------------------------------------------------------------------
	Response.write "<script language='javascript'>"
	Response.write "function go_page(page)"
	Response.write "{document.s_page.gotopage.value=page;document.s_page.submit()}"
	Response.write "</script>"
		
	If f_key = "y" Then
		Response.write " <form name='s_page' action='"&Url&"' method='get'>"
		Response.write " <input type='hidden' name='gotopage'>"
		Response.write " </form>"
	END if
	
	'-------------------------------------------------------------------------------


	Dim blockpage, i
   	blockpage=Int((page-1)/7)*7+1
   	'********** 이전 7 개 구문 시작 **********
   	if blockPage = 1 Then
      		Response.Write " "
   	Else
      		Response.Write "<a href=javascript:go_page('" & blockPage-7 & "')><img src='../image/left.gif' width='6' height='9' align='absmiddle' border='0'></a> "
   	End If
   	'********** 이전 7 개 구문 끝**********
	
	Response.Write "<FONT size='2'>"

   	i=1
   	Do Until i > 7 or blockpage > Pagecount
      		If blockpage=int(page) Then
         		Response.Write "&nbsp;<font color='EB2027'>" & blockpage & "</font>&nbsp;"
      		Else 
         		Response.Write "&nbsp;<a href=javascript:go_page('" & blockpage & "')>" & blockpage & "</a>&nbsp;"
      		End If

      		blockpage=blockpage+1
      		i = i + 1
   	Loop
   	
	Response.Write "</FONT>"

   	'********** 다음 7 개 구문 시작**********
   	if blockpage > Pagecount Then
      		Response.Write " " 
   	Else
      		Response.Write " <a href=javascript:go_page('" & blockPage+7 & "')><img src='../image/right.gif' width='6' height='9' align='absmiddle' border='0'></a> "
   	End If
   	'********** 다음 7 개 구문 끝**********

End Sub
%>
