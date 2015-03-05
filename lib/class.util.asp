<% 
class utility '' 클래스 선언합니다..
	Public arg1, arg2 ''외부인수값 활용을 위해 광범위하게 정의

	private sub Class_Initialize()
	
	End Sub

	Public Function die(str, flag)
		Response.Write(str)
		Response.Write("<br>")
		if flag = 1 then Response.End()
	End Function


	Public Function js_alert(str, gotostr)
		if gotostr = "" then gotostr = "back"
		SELECT CASE gotostr
			CASE "alert"
				Response.Write( "<script>alert('" & str & "');</script>")
			CASE "close"
				Response.Write( "<script>" )
				Response.Write( "alert('" & str & "');" )
				If arg1 = "reload" Then 
					Response.Write( "opener.location.reload();" )
				ElseIf arg1 = "goto" Then 
					Response.Write( "opener.location.href='"&arg2&"';" )
				End If 
				Response.Write( "self.close();" )
				Response.Write( "</script>" )
				Response.End()
			CASE "back"://현재 페이지 닫기
				Response.Write( "<script>alert('" & str & "');history.go(-1);</script>")
				Response.End()
			Case Else
				Response.Write( "<script>alert('" & str & "');location.href='" & gotostr & "'</script>")
				Response.End()
		END Select
		
	End Function
	
	Public Function js_location(gotostr, flag)
		SELECT CASE flag
			Case "close"
				Response.Write("<script>self.close();opener.location.href='" & gotostr & "'</script>")
				Response.End()
			Case "close_reload"
				Response.Write("<script>self.close();opener.location.reload();</script>")
				Response.End()				
			Case Else
				Response.Write("<script>location.href='" & gotostr & "'</script>")
				Response.End()
		END SELECT	
	End Function
	
	Sub js_close(str, gotostr)
		Response.Write("<script>")
		If str <> "" Then  Response.Write("alert('"& str & "');")
		If gotostr <> "" Then Response.Write("opener.location.replace('"& gotostr &"');")
		Response.Write("window.close();")
		Response.Write("</script>")
		Response.End()
	End Sub

''###################################################################	
''   입력 텍스트 관련 trim 처리
''###################################################################

	Public Function secstr(str)''보안 필터링(로그인회원관련)
		str = trim(str)
		str = replace(str, "'", "금지어")
		str = replace(str, "`", "금지어")
		str = replace(str, ";", "금지어")
		str = replace(str, "--", "금지어")
		str = replace(str, " and ", "금지어")
		str = replace(str, " exec ", "금지어")
		str = replace(str, " create ", "금지어")
		str = replace(str, " insert ", "금지어")
		str = replace(str, "1=1", "금지어")
		str = replace(str, "1=2", "금지어")
		str = replace(str, "%25", "금지어")
		secstr = str
	End Function

	Public Function secFilter(str)''단일 검색관련(우편번호)
		str = trim(str)
		str = replace(str, "exec", "금지어")
		str = replace(str, "create", "금지어")
		str = replace(str, "insert", "금지어")
		str = replace(str, "1=1", "금지어")
		str = replace(str, "1=2", "금지어")
		secFilter = str
	End Function


	'' // ' 또는 공백 체크
	Function getReplaceInput(str, ns)
		if str <> "" and isNull(str) = false Then
			getReplaceInput = trim(replace(str,"'","&#39;"))
			if ns = "ns" Then getReplaceInput=replace(getReplaceInput, " ", "")
		End if
	End Function
	
	
	'' // HTML 태그 정렬 부분
	Function ReplaceHtmlText(flag, str2)
		SELECT CASE flag
		case "0"
			ReplaceHtmlText = ReplaceTag2Text(str2)
		case "1"
			ReplaceHtmlText = ReplaceTag2Html(str2)
		case "2"
			ReplaceHtmlText = ReplaceTag2HtmlBr(str2)
		end select
	End Function
	
	function ReplaceTag2Html(str)
		If IsNull(str) = False then
			str = replace(str,"<%","&lt;&#37;")
			str = replace(str,"&#39;","'")
			str = SecurityFilter(str)
			ReplaceTag2Html = str
		End if
	End Function


	'' // HTML br 태그 모드로 사용할 경우
	Function ReplaceTag2HtmlBr(str)
		If IsNull(str) = False then
			str = replace(str,"<%","&lt;&#37;")
			str = replace(str,chr(13)&chr(10),"<BR>")
			ReplaceTag2HtmlBr = str
		End if
	End Function
	
	Function  SecurityFilter(str)
		If IsNull(str) = False then
			str = Replace(str, "meta http-equiv", "")
			str = Replace(str, "url=http", "")
			str = Replace(str, "script", "")
			SecurityFilter = str
		End if
	End Function

	'' // E-MAIL 아스키 코드로 변경 (str : 메일 주소)
	Function getEmailChange(str)
		Dim temp
		If IsNull(str) = False then
			str = Replace(str,"'","")
			if str <> "" Then
				temp = ""
				For i = 1 To Len(str)
					temp = temp & "+" & AscW(Mid(str,i,1))
				Next
					temp = Mid(temp,2)
					getEmailChange = temp
			End If
		End if
	End Function
	
	'' // 문자 길이 체크
	'' // 문자 길이 체크
	Function getLenStr(str)
		Dim ns, t, s, si, a
		IF ISNULL(str) THEN 
			getLenStr = 0
		Else
			ns = LEN(str)
			t = 0
			If ns > 0 Then 
				FOR si = 1 TO ns
					s = mid(str, si, 1)
					a = asc(s)
					IF ((a > 0) AND (a < 127)) THEN
						t = t + 1
					ELSE
						t = t + 2
					END IF
				Next
			End If
			getLenStr = t
		End If
	End Function
		
	'' // TEXT 모드로 사용할 경우
	Function ReplaceTag2Text(str)
		If IsNull(str) = False then
			str = replace(str,"&amp;","&amp;amp;")
			str = replace(str,"&lt;","&amp;lt;")
			str = replace(str,"&gt;","&amp;gt;")
			str = replace(str,"&quot;","&amp;quot;")
			str = replace(str,"<","&lt;")
			str = replace(str,chr(13)&chr(10),"<BR>")
			str = replace(str,chr(34),"&quot;")
			ReplaceTag2Text = str
		End if
	End Function

	''특정숫자크기만큼 앞자리 0을 채워 정리
	Function FillZero(str, nLength)
		Dim nTemp
		

		nTemp = Len(str)
		''Response.Write(nTemp & "," & nLength)
		If nLength < nTemp Then
			FillZero = str
		Else
			FillZero = Trim(String(nLength - nTemp, "0")) & Trim(str)
		End If
	End Function


	Public Function htmleditorImg(str, uid)''상품등록 편집기 사용시 경로 변경
		Dim folder : folder = session.SessionID
		Dim s_editor_dir : s_editor_dir = PATH_SYSTEM & "config\tmp_file\editor\" & folder
		Dim t_editor_dir : t_editor_dir = PATH_SYSTEM & "config\wizeditor\wizmall\" & uid
		
		Call CopyFolder(s_editor_dir, t_editor_dir) 
		Call DeleteFolder(s_editor_dir)

		str = Replace(str, "/tmp_file/editor/" & folder, "/wizeditor/wizmall/" & uid)
		htmleditorImg = str
	End Function


	Public Function htmleditorImg_board(str, gid, bid, uid)''상품등록 편집기 사용시 경로 변경
		Dim folder : folder = session.SessionID
		Dim s_editor_dir : s_editor_dir = PATH_SYSTEM & "config\tmp_file\editor\" & folder
		Dim t_editor_dir : t_editor_dir = PATH_SYSTEM & "config\wizeditor\wizboard\" & gid & "\" & bid & "\" & uid
		
		Call folderMaker(PATH_SYSTEM & "config\wizeditor\wizboard\")
		Call folderMaker(PATH_SYSTEM & "config\wizeditor\wizboard\" & gid)
		Call folderMaker(PATH_SYSTEM & "config\wizeditor\wizboard\" & gid & "\" & bid)
		Call folderMaker(PATH_SYSTEM & "config\wizeditor\wizboard\" & gid & "\" & bid & "\" & uid)
		Call CopyFolder(s_editor_dir, t_editor_dir) 
		Call DeleteFolder(s_editor_dir)
		str = Replace(str, "/tmp/editor/" & folder, "/wizeditor/wizboard/" & gid & "/" & bid & "/" & uid)
		htmleditorImg_board = str
	End Function


	Function URLDecode(Expression)
		Dim strSource, strTemp, strResult, strchr
		Dim lngPos, AddNum, IFKor

		strSource = Replace(Expression, "+", " ")
		For lngPos = 1 To Len(strSource)
			AddNum = 2
			strTemp = Mid(strSource, lngPos, 1)
			If strTemp = "%" Then
				If lngPos + AddNum < Len(strSource) + 1 Then
					strchr = CInt("&H" & Mid(strSource, lngPos + 1, AddNum))
					If strchr > 130 Then
						AddNum = 5
						IFKor = Mid(strSource, lngPos + 1, AddNum)
						IFKor = Replace(IFKor, "%", "")
						strchr = CInt("&H" & IFKor )
					End If
					strResult = strResult & Chr(strchr)
					lngPos = lngPos + AddNum
				End If
			Else
				strResult = strResult & strTemp
			End If
		Next

		URLDecode = strResult

	End Function 


	Function SetUploadComponent()
		''Dim DefaultPath 상단에서 지정
		IF upload_component = "1" THEN 'ABC UPLOAD
			SET UPLOAD = Server.CreateObject("ABCUpload4.XForm")
			UPLOAD.AbsolutePath = True
			UPLOAD.MaxUploadSize = 524288000
			UPLOAD.Overwrite = False
			''UPLOAD.CodePage = cfg.Item("CodePage")
		ELSEIF upload_component = "2" THEN 'DEXT UPLOAD
			SET UPLOAD = Server.CreateObject("DEXT.FileUpload")
			UPLOAD.DefaultPath = DefaultPath
			UPLOAD.CodePage = cfg.Item("CodePage")
		ELSEIF upload_component = "3" THEN 'SITE GALAXY UPLOAD
			'Const MAX_FILE = 1         '파일 갯수
			'Const MAX_SIZE = 2048      '최대 업로드 크기
			Session.CodePage = cfg.Item("CodePage")    '### 한국어 및 다국어 세팅
			SET UPLOAD = Server.CreateObject("SiteGalaxyUpload.Form")			
		END If
		SetUploadComponent = UPLOAD("attached").COUNT
	End Function 

	Function FileUploadInfo(upload_file)
		' // 업로드 사이즈 체크 및 이미지 파일 너비 체크

		''Response.Write(upload_component & ", " & upload_file & ", " & attached_count)
		Dim i, k
		IF upload_component = "1" THEN    'ABCUpload4.XForm
			for i = 1 to attached_count 
				k = i + 1
				'IF upload_file.FileExists THEN
				'	imgsize(i) = uploadWidthHeight(upload_file.ImageWidth, upload_file.ImageHeight)
				'	attached_filesize(i) = upload_file.Length
				'END IF
			next
		ELSEIF upload_component = "2" THEN'DEXT.FileUpload
			for i = 1 to attached_count 
				IF upload_file.FileName <> "" THEN
					imgsize(i) = uploadWidthHeight(upload_file.ImageWidth, upload_file.ImageHeight)
					attached_filesize(i) = upload_file.FileLen
				END IF
			next
		ELSEIF upload_component = "3" THEN'SITE GALAXY UPLOAD
			for i = 1 to attached_count 
				''IF upload_file <> "" THEN
					''파일크기
					''tmp_filesize = upload_file(i).Size
					''attached_filesize(i) = tmp_filesize / 1024

					''imgsize(i) = uploadWidthHeight(upload_file.ImageWidth, upload_file.ImageHeight)
					''attached_filesize(i) = upload_file.Size
					''upload_file.MimeType ''결과로 image...
				''END IF
			next		
		END IF
	End Function

	'
	'filename: 
	'avaext: 
	'
	Function Check_Ext(filename,avaext)
		Dim bad_file, FileStartName, FileEndName, p, ok_file
		Check_Ext = false
		avaext	= Replace(avaext, Chr(13), "")
		avaext	= Replace(avaext, Chr(10), "")
		If instr(filename, "\0") Then
			Response.Write ""
			Response.End
		End If
		
		'업로드 금지 확장자 체크
		bad_file = "asp,html,htm,asa,hta,exe"
		
		filename = Replace(filename, " ", "")
		filename = Replace(filename, "%", "")

		''FileStartName = Left(filename,InstrRev(filename,".")-1)
		FileEndName = LCase(Mid(filename, InstrRev(filename, ".")+1))
			
		bad_file = split(bad_file, ",")

		for each p in bad_file
			if instr(FileEndName, p)>0 then
				Check_Ext = false
				Exit Function
			end if
		next
		
		'허용할 확장자 체크
		if avaext <> "" Then
			''Response.Write(avaext & "<br />")
			ok_file = split(avaext, ",")
			
			for each p in ok_file
				p	= Trim(p)
				if instr(FileEndName, p)>0 then
					Check_Ext = True
					Exit Function
				End If
			next
		End If
	End Function

	Function Msg_FileExt(filename, avaext, msgtype)
		'msgtype : default
		''Response.Write(filename&","&avaext)
		Dim Result_Ext
		Result_Ext = Check_Ext(filename,avaext)
	
		if Result_Ext = False then  
			Select Case msgtype
				Case "sample"
					'' 다양한 변수 적용가능
				 Case Else  
					Call js_alert("허용되지 않은 확장자("&filename&")가 첨부화일에 포함되었습니다.","")							
			End Select
		End If
	End Function

	Function FileUploadModule(upload_file, u_mode, d_file, avaext)

		Dim i, k, u_del_file
		If d_file <> "" Then 
			u_del_file = Split(d_file, ",")
			ReDim Preserve u_del_file(attached_count)
		Else
			ReDim u_del_file(attached_count)
		End If

''upload_component : 업로드컴포넌트종류, upload_file : 업로드파일, attached_count :첨부된 갯수, old_filename : 기존 업로드된 파일, DefaultPath : 업로드경로, u_del_file : 삭제파일index, u_mode :  모드
		if isArray(old_filename) = FALSE then ReDim old_filename(attached_count)

		IF upload_component = "1" and attached_count <> 0 THEN    'ABCUpload4.XForm
			for i = 1 to attached_count
				k = i - 1
				IF upload_file(i).FileExists THEN
					attached_file(i) = check_file(DefaultPath, upload_file(i).SafeFileName)
					Call Msg_FileExt(attached_file(i), avaext, "default")
					upload_file(i).Save DefaultPath & attached_file(i)
					IF u_mode = "edit" THEN	
						IF old_filename(k) <> "" AND ISNULL(old_filename(k)) = False THEN CALL FileDelete(DefaultPath, old_filename(k))
					END IF
				else
					IF u_mode = "edit" and Trim(u_del_file(k)) = "1" THEN
						CALL FileDelete(DefaultPath, old_filename(k))
						attached_file(i) = ""
					ELSEIF u_mode = "edit" THEN 
						attached_file(i) = old_filename(k)
					END IF			
					
				END IF
				FileUploadModule = FileUploadModule & attached_file(i) & "|"
			next
		ELSEIF upload_component = "2" and attached_count <> 0 THEN    'DEXT.FileUpload

			for i = 1 to attached_count
				k = i - 1	
				IF upload_file(i).FileName <> "" THEN
					attached_file(i) = check_file(DefaultPath, upload_file(i).FileName)
					''Upform.FileExists(upfile)
					Call Msg_FileExt(attached_file(i), avaext, "default")
					upload_file(i).saveAS DefaultPath & attached_file(i)
					IF u_mode = "edit" THEN		
						IF old_filename(k) <> "" AND ISNULL(old_filename(k)) = False THEN CALL FileDelete(DefaultPath, old_filename(k))
					END IF
				else
					IF u_mode = "edit" and Trim(u_del_file(k)) = "1" THEN	
						CALL FileDelete(DefaultPath, old_filename(k))
						attached_file(i) = ""
					ELSEIF u_mode = "edit" THEN 
						attached_file(i) = old_filename(k)					
					END IF
									
				END IF
				FileUploadModule = FileUploadModule & attached_file(i) & "|"
			next
		ELSEIF upload_component = "3" and attached_count <> 0 THEN    'SITE GALAXY UPLOAD
			for i = 1 to attached_count
				k = i - 1	
				IF upload_file(i) <> "" And IsNull(upload_file(i)) = false Then
					attached_file(i) = check_file(DefaultPath, Mid(upload_file(i), InstrRev(upload_file(i),"\") + 1))
					Call Msg_FileExt(attached_file(i), avaext, "default")
					upload_file(i).saveAS DefaultPath & attached_file(i)
					IF u_mode = "edit" THEN		
						IF old_filename(k) <> "" AND ISNULL(old_filename(k)) = False THEN CALL FileDelete(DefaultPath, old_filename(k))
					END IF
				Else
					
					IF u_mode = "edit" and Trim(u_del_file(k)) = "1" THEN	
						CALL FileDelete(DefaultPath, old_filename(k))
						attached_file(i) = ""
					ELSEIF u_mode = "edit" THEN 	
						On Error Resume Next
						attached_file(i) = old_filename(k)	
						If Err.number <> 0 Then     '오류 발생 시 이 부분 실행
							attached_file(i) = ""
						Else
							''Response.Write "오류가 없습니다."
							
						End If
						Error.Clear				
					END IF
									
				END IF
				FileUploadModule = FileUploadModule & attached_file(i) & "|"
			next		
		END If
	End Function


''###################################################################	
''   썸내일(thumbnail) START
''###################################################################
	Function ThumnailForMall(upload_file)
		Dim bigfile, midfile, smallfile
		
		If copyenable = "1" then
			bigfile	= split(upload_file, "|")
			''"thumb_250_250_" & bigfile(0)
			''thumb_100_100_" & bigfile(0),
			midfile = makeThumbnail(DefaultPath, bigfile(0), "thumb_250_250_" & bigfile(0), 250, 250) ''중간크기
			smallfile = makeThumbnail(DefaultPath, bigfile(0), "thumb_100_100_" & bigfile(0), 100, 100)''
			''makeThumbnail("img_path", "img_name", "thumb_name", "thumb_wsize", "thumb_hsize")
			ThumnailForMall = bigfile(0) & "|" & midfile & "|" & smallfile
		else
			ThumnailForMall = upload_file
		end if	
		
	End Function
	
''###################################################################	
''   실제 썸내일(thumbnail) START
''###################################################################
	Function makeThumbnail(ByVal img_path, ByVal img_name, ByVal thumb_name, ByVal thumb_wsize, ByVal thumb_hsize)
		Dim thumb_path, thumb_image, objImage
	
		''Response.Write(image_component)
		''Response.End()
		'썸네일 이미지 생성
		Select Case image_component
			Case "2" '' Dext
				Set objImage		= Server.CreateObject("DEXT.ImageProc")
				IF objImage.SetSourceFile(img_path & img_name) Then
					thumb_name		= check_file(img_path, thumb_name) ''중복파일 체크
					thumb_path		= img_path & thumb_name'' &".png"
					thumb_image		= objImage.SaveasThumbnail(thumb_path, thumb_wsize, thumb_hsize, true)
					thumb_image		= thumb_name
				End IF
				Set objImage  = Nothing ''객체소멸
			Case "3" ''
				Set Image = Server.CreateObject("Nanumi.ImagePlus")
				IF objImage.SetSourceFile(img_path &"\"& img_name) Then
					Image.OpenImageFile img_path &"\"& img_name
					''Response.Write "이미지 너비: " & CStr(Image.Width)& "<br>" 
					''Response.Write "이미지 높이: " & CStr(Image.Height)& "<br>"
					''Image.ImageFormat = "JPG" 
					Image.ChangeSize thumb_wsize, thumb_hsize
					Image.SaveFile img_path &"\"& img_name
					Image.Dispose
					thumb_image			= img_name 
					Set Image = Nothing
				End IF
				''http://www.nanumi.net/	
							
		End Select
		makeThumbnail = thumb_image
	End Function
	
	
''###################################################################	
''   파일관련 START
''###################################################################
	'' // 폴더 생성
	Function folderMaker(path)
		Dim FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF NOT(FSO.FolderExists(path)) THEN
			FSO.CreateFolder(path)
		END IF
		SET FSO = Nothing
	End Function
	
	'' // 폴더 삭제

	Function folderDelete(path)
		DIM FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(path)) THEN FSO.DeleteFolder(path)
		SET FSO = NOTHING
	END Function
	
	'' // 
	Function ShowFolderList(path,skin)
''		Response.Write(path)
		Dim FSO, F, F1, S, SF
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(path)) THEN
			SET F = FSO.GetFolder(path)
			SET SF = F.SubFolders
			
			FOR EACH F1 IN SF
				IF skin = "" THEN skin = F1.name
				IF F1.name = skin THEN S = S & "<option selected value=" & f1.name & ">" & f1.name & "</option>" ELSE S = S & "<option value=" & f1.name & ">" & f1.name & "</option>"
			NEXT
			ShowFolderList = S
		END If
		SET FSO = NOTHING
	END Function
	
	'' // 폴더 이동
	SUB MoveFolder(source,dest)
''		Response.Write(path)
		Dim FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(source)) THEN
			FSO.MoveFolder source, dest 
		END If
		SET FSO = NOTHING
	END SUB

	'' // 폴더 copy
	SUB CopyFolder(source,dest)
''		Response.Write(path)
		Dim FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(source)) THEN
			FSO.CopyFolder source, dest 
		END If
		SET FSO = NOTHING
	END Sub

	
		'' // 폴더 삭제
	SUB DeleteFolder(source)
		Dim FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(source)) THEN
			FSO.DeleteFolder source
		END If
		SET FSO = NOTHING
	END Sub

	'' // 파일 생성
	Function FileMaker(path)
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF NOT(FSO.fileExists(path)) THEN
			SET FILE = FSO.createTextFile(path,ForWriting)
			FILE.writeline("")
			FILE.close
		END IF
		SET FSO = NOTHING
	END Function
	
	'' // 파일 생성 및 내용 추가
	Function FileMakeTxt(path, str)
		Dim FSO, FILE, ForWriting
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(path) THEN
		FSO.DeleteFile(path)
		END IF

		SET FILE = FSO.createTextFile(path,ForWriting)
		FILE.writeline(str)
		FILE.close
		SET FSO = NOTHING
	END Function
	
	'' // 파일내용 불러오기
	Function FileReadTxt(path)
		Dim FSO, TextStream, S, NewLine
		Const OpenFileForReading = 1
		Const OpenFileForWriting = 2
		Const OpenFileForAppending = 8
		
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.FileExists(path) THEN 
			Set TextStream = FSO.OpenTextFile(path, OpenFileForReading) 
			S = TextStream.ReadAll & NewLine & NewLine
			TextStream.Close 
			FileReadTxt = S
		ELSE
			Response.Write(path&"를 찾을 수 없습니다.")
		END IF
		SET FSO = NOTHING
	END Function

	Function ReadFile(file)''상기와 동일 내용
		''Const ForReading = 1, ForWriting = 2, ForAppending = 8
		''Dim fso, f
		Dim FSO, f
		Set FSO = CreateObject("Scripting.FileSystemObject")
		If FSO.fileExists(file) Then
			
		if cfg.Item("lan") = "utf-8" then
			Set f = FSO.OpenTextFile(file, 1, False, -1)
		else 
			Set f = FSO.OpenTextFile(file, 1, False, -2)
		end if
		
			ReadFile = f.ReadAll
			f.Close
			Set f = Nothing
		End If
		Set FSO = Nothing
	End Function

	'' // 파일 삭제
	Function FileDelete(path, filename)
		Dim FSO, strfile
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		strfile = path & filename
		IF FSO.FileExists(strfile) THEN FSO.DeleteFile(strfile)
		SET FSO = NOTHING
	End Function
	
	'' // 파일 카피 함수
	Function FileCopy(PATH_SYSTEM, bid, exec_board, gid, strFilename, smode)
		Dim path1, path2, desFilename, copyFilename, FSO
		path1 = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\"
		path2 = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & exec_board & "\"

		IF smode <> "" THEN
			path1 = path1 & "thrum\"
			path2 = path2 & "thrum\"
		END IF

		desFilename = path1 & strFilename
		copyFilename = path2 & check_file(path2, strFilename)
		FileCopy = check_file(path2, strFilename)

		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		FSO.CopyFile desFilename, copyFilename
		SET FSO = NOTHING
	End Function

	'' // 파일 카피 함수
	Function CopyAFile(source1, target1)
		Dim FSO
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(target1) THEN
		else
			IF FSO.fileExists(source1) THEN	
				FSO.CopyFile source1, target1
			end if
		end if
	END Function

	'' // 파일이동
	Function MoveAFile(source1, target1)
	   Dim FSO
	   Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	   IF FSO.fileExists(target1) THEN
	   else
	   	IF FSO.fileExists(source1) THEN	
	   		FSO.MoveFile source1, target1
		end if
	   end if
	END Function





''###################################################################	
''   파일관련 END
''###################################################################

''###################################################################	
''   기타 잡동사니 Util
''###################################################################

	Public Function Linuxtime()''
		Linuxtime = DateDiff("s", "1970-01-01 00:00:00", now())
	End Function

	Public Function denyAdmin(user_id)''일반 사용자만 접근
		If user_id  = "admin" Then Call js_alert("일반계정으로 로그인해 주시기 바랍니다.", "")
	End Function

	Function convertnum(num) ''
		
		if num = "" then num = 0
		if IsNumeric(num) = FALSE Then num = Cint(num)
		convertnum = num
	End Function

	Public Function SelectList(value, Arr)
		Dim i, selected
		For i=1 to Ubound(Arr)
			If value = Arr(i) Then selected = "selected" Else selected = ""
			Response.Write "<option value='"&Arr(i)&"' "&selected&">"&Arr(i)&"</option>"&Chr(13)&Chr(10)
		Next
	End Function

'' // 
Function getSelectdate(showtype,selectdate)
''showtype : year :
Dim intselectdate, SelectYear, SelectMonth, SelectDay, SelectHour, SelectMinute, StartYear, EndYear
Dim i, selected
	if TypeName(selectdate) = "Null" then selectdate = ""
	if selectdate <>  "" then intselectdate  = selectdate
''	Response.Write(VarType(intselectdate))
''	Response.Write(",")
	if VarType(intselectdate) <> 2 Then intselectdate  = Cint(intselectdate)
''	Response.Write(intselectdate)
''	Response.Write(",")
''	Response.Write(VarType(intselectdate))
	if selectdate = "" then
		SelectYear = Year(date)
		SelectMonth = Month(date)
		SelectDay = Day(date)
		SelectHour = Hour(time)
		SelectMinute = Minute(time)
	elseif showtype = "year" then
		SelectYear = intselectdate
	elseif showtype = "month" then
		SelectMonth = intselectdate
	elseif showtype = "day" then
		SelectDay = intselectdate	
	elseif showtype = "hour" then
		SelectHour = intselectdate
	elseif showtype = "minute" then
		SelectMinute = intselectdate					
	end if

	if showtype = "year" then ''연도출력
		StartYear = Year(date) -1 
		EndYear = Year(date) +3
		FOR i = StartYear TO EndYear
			IF i = SelectYear THEN  Selected = "selected" Else Selected = ""
			getSelectdate = getSelectdate & "<option " & Selected & " value=" & i & ">" & i & "</option>"&Chr(13)&Chr(10)
		NEXT
	elseif showtype = "month" then ''
	
		FOR i = 1 TO 12
			IF i = Cint(SelectMonth) THEN  Selected = "selected" Else Selected = ""
			getSelectdate = getSelectdate & "<option " & Selected & " value=" & i & ">" & i & "</option>"&Chr(13)&Chr(10)
		NEXT
	elseif showtype = "day" then ''
		FOR i = 1 TO 31
			IF i = SelectDay THEN  Selected = "selected" Else Selected = ""
			getSelectdate = getSelectdate & "<option " & Selected & " value=" & i & ">" & i & "</option>"&Chr(13)&Chr(10)
		NEXT
	elseif showtype = "hour" then ''
''Response.Write("SelectHour:"&SelectHour)
		FOR i = 0 TO 23
			IF i = SelectHour THEN  Selected = "selected" Else Selected = ""
			getSelectdate = getSelectdate & "<option " & Selected & " value=" & i & ">" & i & "</option>"&Chr(13)&Chr(10)
		NEXT
	elseif showtype = "minute" then '
		FOR i = 0 TO 59
			IF i = SelectMinute THEN  Selected = "selected" Else Selected = ""
			getSelectdate = getSelectdate & "<option " & Selected & " value=" & i & ">" & i & "</option>"&Chr(13)&Chr(10)
		NEXT						
	else
	
	end if		

END Function		

	Public Function PointProc(id, point, ptype,pcontent, pflag, pmode, uid)
		'' 포인트 내용(ptype)
		'' member :1: 회원가입 ,2: 로그인포인트, 3: 회원추천->contents:추천인아이디
		'' board : 11:글등록->contents(bid:gid:uid)
		'' order : 21:물품구매->contents(wizCart.uid), 22:물품환불(취소)->contents(wizCart.uid), 23:포인트결제->contents:wizBuyers.OrderID, 24:포인트결제취소->contents:wizBuyers.OrderID
		'' event : 기타코드-> 기타코드
		'' admin : 41
		'' pcontent : 내용 
		'' pflag 0 : 즉시 실행, flag 1:보류(보류일경우 관리자 확인 필요)
		'' pmode
		If IsNull(pflag) Or pflag = "" Then pflag = 0
		If IsNull(pmode) Or pmode = "" Then pmode = "qin"
		Set db = new database
		''Response.Write(pmode & "," & id & "," & ptype & "," & point & "," & pflag & "," & uid & "," & pcontent)
		Dim paramInfo(7)
		paramInfo(0)	= db.MakeParam("@pmode", adVarChar, adParamInput,20, pmode)
		paramInfo(1)	= db.MakeParam("@id", adVarChar, adParamInput,30, id)
		paramInfo(2)	= db.MakeParam("@ptype", adInteger, adParamInput,11, ptype)
		paramInfo(3)	= db.MakeParam("@point", adInteger, adParamInput,11, point)
		paramInfo(4)	= db.MakeParam("@flag", adInteger, adParamInput,11, pflag)
		paramInfo(5)	= db.MakeParam("@uid", adInteger, adParamInput,11, uid)
		paramInfo(6)	= db.MakeParam("@content", adVarChar, adParamInput,100,pcontent)
		paramInfo(7)	= db.MakeParam("@rtn_point", adInteger, adParamOutput,11, 0)
		Set objRs = db.ExecSPReturnRS("usp_point", paramInfo, DbConnect)
		PointProc = db.GetValue(paramInfo, "@return_out")
		db.Dispose : Set db = Nothing
	End Function


	Sub paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
		Dim TP, CB, SP, EP, TB, prev_page, next_page, I
		TP = Round(TotalCount / setPageSize + 0.49) ''총페이지수(Total Page) : 총게시물수 / 페이지당 리스트수  
		CB = Round(page / setPageLink + 0.49) ''
		SP = (CB - 1) * setPageLink + 1'' 
		EP = (CB * setPageLink) ''
		TB = Round(TP / setPageLink + 0.49) '' 

		Response.Write "<span class='paging'>"
		IF INT(CB) > 1 THEN
			prev_page = SP - 1
			RESPONSE.WRITE "<a href='" & linkurl & "&page=" & prev_page & "'><img src='" & preimg & "' border=0></a>"
		END IF



		FOR I = SP TO EP 
			IF I <= TP THEN
				IF INT(I) = INT(page) THEN
					RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
				ELSE
					RESPONSE.WRITE "<a href='" & linkurl & "&page=" & I & "'>&nbsp;"& I & "&nbsp;</a>"
				END IF
			END IF
		NEXT

		IF INT(CB) < INT(TB) THEN 
			next_page = EP + 1
			RESPONSE.WRITE "<a href='" & linkurl & "&page=" & next_page & "'><img src='" & nextimg & "' border=0></a>"
		END IF	

		Response.Write "</span>"
	End Sub

	Sub pagingScript (page,setPageSize,setPageLink,TotalCount,ScriptName)
		Dim TP, CB, SP, EP, TB, prev_page, next_page, I
		TP = Round(TotalCount / setPageSize + 0.49) ''총페이지수(Total Page) : 총게시물수 / 페이지당 리스트수  
		CB = Round(page / setPageLink + 0.49) ''
		SP = (CB - 1) * setPageLink + 1'' 
		EP = (CB * setPageLink) ''
		TB = Round(TP / setPageLink + 0.49) '' 

		Response.Write "<span class='paging'>"
		IF INT(CB) > 1 THEN
			prev_page = SP - 1
			RESPONSE.WRITE "<a href='javascript:" & ScriptName & "(" & prev_page & ")'><img src='" & preimg & "' border=0></a>"
		END IF



		FOR I = SP TO EP 
			IF I <= TP THEN
				IF INT(I) = INT(page) THEN
					RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
				ELSE
					RESPONSE.WRITE "<a href='javascript:" & ScriptName & "(" & I & ")'>&nbsp;"& I & "&nbsp;</a>"
				END IF
			END IF
		NEXT

		IF INT(CB) < INT(TB) THEN 
			next_page = EP + 1
			RESPONSE.WRITE "<a href='javascript:" & ScriptName & "(" & next_page & ")'><img src='" & nextimg & "' border=0></a>"
		END IF	

		Response.Write "</span>"
	End Sub


	''이곳에서 에러발생시 폴더 퍼미션 확인
	Function getImageSize(filepath)
		Dim objImg, FSO, imageWidth, imageHeight, f_fileExt
		f_fileExt = Ucase(mid(filepath, instrrev(filepath, ".") + 1))
		
		SET FSO = Server.CreateObject("scripting.fileSystemObject")
		On Error Resume Next
		IF FSO.FileExists(filepath) Then
			IF f_fileExt = "GIF" or f_fileExt = "JPG" Or f_fileExt = "JPEG" Then''PNG일경우 에러 발생
				On Error Resume Next''LoadPicture는 CYMK를 인식하지 못한다. 80004005 에러 발생
				SET objImg = LoadPicture(filepath)
				If Err.number<>0 Then 'error 발생시 (정상처리시 0 return)
				Else
					imageWidth = INT(objImg.width / 26.4)
					imageHeight = INT(objImg.height / 26.54)
				End If
				SET objImg = Nothing
			End IF
		ELSE
			imageWidth = 100
			imageHeight = 100
		END If
		Set FSO = Nothing 
		getImageSize = imageWidth & "|" & imageHeight
	END Function	


function fnc_sendmail(mail_to, mail_from, mail_subject, mail_content, mail_attached)
	''mail_form :  user_name<user_email>
	''mail_attached 는 배열
	Dim f_arrayflag, f_objConfig, f_Flds, f_configure, f_objMessage
	Dim i
	
	
    if CheckValidEmail(mail_to) = True then 
        f_arrayflag = IsArray(mail_attached)
		
        On Error Resume Next
    
        Set f_objConfig = Server.CreateObject("CDO.configuration")
    
        Set f_Flds = f_objConfig.Fields
        f_configure = "http://schemas.microsoft.com/cdo/configuration"
    
        With f_Flds
            .Item(f_configure&"/sendusing")					= 2
            .item(f_configure&"/smtpserverport")			= 25
			.Item(f_configure&"/smtpserver")				= "localhost"
           ''.Item(f_configure&"/smtpserver")				= "xxx.xxx.xxx.xxx"
			
            .Item(f_configure&"/smtpserverpickupdirectory")	= "c:\Inetpub\mailroot\Pickup"
            .Item(f_configure&"/smtpconnectiontimeout")		= 30
            .update
        End With
        
        Set f_objMessage = Server.CreateObject("CDO.Message")
        Set f_objMessage.Configuration = f_objConfig
        
        With f_objMessage
           .BodyPart.Charset		="ks_c_5601-1987"
             ''.HTMLBodyPart.Charset	="ks_c_5601-1987"
            ''.BodyPart.Charset		="euc-kr"
            ''.HTMLBodyPart.Charset	="euc-kr"
            If f_arrayflag = True Then
                ''.bodyformat = 0 '' 0은 html
                ''.mailformat = 0 '' 0은 html
                For i=0 To UBound(mail_attached)
                    if mail_attached(i) <> "" then''첨부화일처리
                        .AddAttachment mail_attached(i)
                    end If
                next
            End if
    
            .To			= mail_to
            .From		= mail_from
            .Subject	= mail_subject
            .HTMLBody	= mail_content''html로 보낼경우
            ''.TextBody = mail_content''text로 보낼경우
            ''.Cc = mail_cc ''참조
            ''.Bcc = mail_bcc ''숨은참조
            ''.DNSOptions = 14 '
            .Send
        End With
       
        Set f_Flds		= Nothing
        Set f_objMessage	= Nothing
        Set f_objConfig	= Nothing
            
        If Err.number <> 0 Then     '오류 발생 시 이 부분 실행
            Response.Write "<b3>" & Err.Source & "<hr noshade></h3>"
            Response.Write "오류 번호 : " & Err.number & "<br>"
            Response.Write "내용 : " & Err.Description & "<br>"
            Response.Write "이메일 : " & mail_to & "<br>"
			''Response.End()
            fnc_sendmail = FALSE
        Else
            ''Response.Write "오류가 없습니다."
            fnc_sendmail = TRUE
        End If
	End If
	Err.Clear   '에러를 명시적을 지운다.
End Function


Function CheckValidEmail(email)''
	Dim regEx
	If email <> "" and not isnull(email) and not isempty(email) Then
		email = Trim(email)
		Set regEx = New RegExp
		regEx.Pattern = "^([a-z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-z0-9_\-]+\.)+))([a-z]{2,4}|[0-9]{1,3})(\]?)"
		regEx.Global = False
		regEx.IgnoreCase = True
		CheckValidEmail = regEx.Test(email)
	Else
		CheckValidEmail = False
	End If
End Function

	'' // 폼 서브밋 함수
	Function htmlFromSubmit(msg, url)
		htmlFromSubmit = "<form name=frm1 method=post>" & vbcrlf
		htmlFromSubmit = htmlFromSubmit & "</form>" & vbcrlf
		htmlFromSubmit = htmlFromSubmit & "<script language=javascript>" & vbcrlf
		htmlFromSubmit = htmlFromSubmit & "alert('" & msg & "');" & vbcrlf
		htmlFromSubmit = htmlFromSubmit & "document.frm1.action='" & url & "';" & vbcrlf
		htmlFromSubmit = htmlFromSubmit & "document.frm1.submit();" & vbcrlf
		htmlFromSubmit = htmlFromSubmit & "</script>" & vbcrlf
	END Function	
	
	
	
	'' // 파일 확장자 체크
	Function check_fileExt(filename)
		f_fileExt = Ucase(mid(filename, instrrev(filename, ".") + 1))
		IF f_fileExt = "GIF" or f_fileExt = "JPG" Or f_fileExt = "JPEG" or f_fileExt = "PNG" THEN
			check_fileExt = True
		ELSE
			check_fileExt = False
		END IF
	End Function
	
	' // 중복 파일 체크 (pds_dir : 경로명, filename : 업로드 파일명)
	Function check_file(pds_dir, filename)
		Dim f_FSO, f_filenameonly, f_fileExt, f_cnt
		filename = replace(filename, " ", "_")
		filename = replace(filename, "%", "")
	
		SET f_FSO = Server.CreateObject("scripting.FileSystemObject")
		IF f_FSO.fileExists(pds_dir & filename) THEN
			IF InStrRev(filename,".") <> 0 THEN
				f_filenameonly = Left(filename,InstrRev(filename,".")-1)
				f_fileExt = Mid(filename, InStrRev(filename,"."))
			ELSE
				f_filenameonly = filename
				f_fileExt = ""
			END IF

			f_cnt = 0
			DO WHILE (1)
				filename = f_filenameonly & "[" & f_cnt & "]" & f_fileExt
				IF NOT f_FSO.fileExists(pds_dir & filename) THEN EXIT DO
				f_cnt = f_cnt + 1
			LOOP
		END IF
		SET f_FSO = nothing

		check_file = filename
	End Function
	
	' // 업로드 사이즈 체크
	Function UploadSizeCheck(str, setUploadSize)
		IF INT(setUploadSize) < INT(str) THEN UploadSizeCheck = False ELSE UploadSizeCheck = True
	End Function

	' // 업로드 이미지 높이 및 너비 체크
	Function uploadWidthHeight(str1, str2)
		IF str1 = "0" THEN str1 = ""
		IF str2 = "0" THEN str2 = ""
		uploadWidthHeight = str1 & "|" & str2
	End Function
	
	

	
	Function getFileSize(filepath)
	   Dim f_FSO, f
	   
	   Set f_FSO = CreateObject("Scripting.FileSystemObject")
	   Set f = f_FSO.GetFile(filepath)
	   
	   getFileSize = FormatNumber(f.size/1024)''KB
	End Function	
		



									

	'' // 첨부화일에 따른 이미지 출력
	Function getAttachedIcon(filename, DefaultPath, IconSkin)
		Dim f_fileExt
		f_fileExt = Ucase(mid(filename, instrrev(filename, ".") + 1))

		SELECT CASE f_fileExt
			CASE "JPG","JPEG","GIF","BMP","PNG"
				getAttachedIcon = DefaultPath&filename
			CASE "SWF"
			CASE "WAV","MP3"
			CASE "ASF","ASX","AVI","WMV","WMA"
				getAttachedIcon = "wizboard/iconimg/"&IconSkin&"/movie.gif"
		CASE ELSE

		END SELECT
	End Function

	'' '' // 첨부화일에 따른 이미지 출력 + getAttachedIcon
	Function findThumbnail(filename, path,  IconSkin, width, height)
		''현재하위폴더에 thumnail폴더가 있는지 체크하고 없으면 만들어 준다.
		''lib/exe.board.asp 에서 정의 Dim DefaultPath : DefaultPath			= PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
		Dim f_fileExt
		f_fileExt = Ucase(mid(filename, instrrev(filename, ".") + 1))
		
		SELECT CASE f_fileExt
			CASE "JPG","JPEG","GIF","BMP","PNG"
				Dim DefaultThumbPath	 : DefaultThumbPath = DefaultPath & "thumbnail_" & width & "_" & height
				Call folderMaker(DefaultThumbPath)
				Dim FSO1
				SET FSO1 = CreateObject("Scripting.FileSystemObject")
				IF NOT(FSO1.fileExists(DefaultThumbPath & "\" & filename)) THEN
					Dim thumbnailfile : thumbnailfile =makeThumbnail(DefaultPath, filename, "thumb_" & filename, width, height)
					
					IF FSO1.fileExists(DefaultPath & "thumb_" & filename) Then
						FSO1.MoveFile DefaultPath & "thumb_" & filename, DefaultThumbPath  & "\" & filename
						findThumbnail = path & "thumbnail_" & width & "_" & height & "/" & filename
					Else
						findThumbnail = path & filename
					End If
				Else
					findThumbnail = path & "thumbnail_" & width & "_" & height & "/" & filename
				END IF
				SET FSO1 = Nothing
			CASE "SWF"
			CASE "WAV","MP3"
			CASE "ASF","ASX","AVI","WMV","WMA"
				findThumbnail = "wizboard/iconimg/"&IconSkin&"/movie.gif"				
			CASE ELSE

		END SELECT
	
	End Function




	function LoginAccessAllow(grade)
	intgrade = Cint(grade)
	if session("user_grade") <> "" then intuser_grade = Cint(session("user_grade"))
		if SESSION("admin")	<> "super" then
			if intuser_grade = "" then
				LoginAccessAllow = false
			elseif intuser_grade > intgrade then
				LoginAccessAllow = false
			else
				LoginAccessAllow = true
			end if
		else
			LoginAccessAllow = true
		end if
	end function 


	function getCategoryName(category, bid, gid)
		fSQL = "select categoryname from wiztable_category where bid = '" & bid & "' and gid = '" & gid & "' and intcategorynum = "  & category
		Set fRs	= db.ExecSQLReturnRS(fSQL, Nothing, DbConnect)
		if fRs.EOF then
			getCategoryName = "" 
		else
			getCategoryName = fRs("categoryname")
		end if
	end function 


	''html태그 삭제 함수
	function strip_tags(content, cutlen) '' 아래 stripTags 사용
		''사용예 response.write strip_tags("ABCDEF<img src='/ZYXWVUTSRQPO/'>GHIJKL",20)
		j=1
		tmpb=2
		length = len(content)
		tmpcontent = content

		Do while length > 0
		k = mid(tmpcontent,j,1)

		if k="<" then
		tmpb = 0
		elseif k = ">" then
		tmpb = 1
		end if

		if tmpb = 0 then
			tmpcontent = left(tmpcontent,j-1) & mid(tmpcontent,j+1)
			elseif tmpb = 1 then
			tmpcontent = left(tmpcontent,j-1) & mid(tmpcontent,j+1)
			tmpb = 2
		else
			j=j+1
		end if

		length = length -1
		loop

		if cutlen <> 0 then
			tmpcontent = left(tmpcontent, cutlen)
		end if

		strip_tags = tmpcontent

	end function

	Function stripTags (ByVal HTML_Content)
		stripTags = ""
		If (Len (HTML_Content) > 0) Then
			stripTags = Trim (EregiReplace (HTML_Content, "<[^>]*>", ""))
		End If
	End Function


	Function EregiReplace(ByVal strSource, strPattern, strReplace)
		Dim ReEx
		If Len(strSource) > 0 And Len(strPattern) > 0 Then
			Set ReEx = New RegExp
			ReEx.Pattern = strPattern
			ReEx.IgnoreCase = True
			ReEx.Global = True
			strSource = ReEx.Replace(strSource, strReplace)
		End If
		EregiReplace = strSource
	End Function


	''###########################################
	'' 
	''###########################################

	Function cutWord (ByVal Word_String, ByVal Cut_Length, ByVal Tail_String)
		Dim l_WordLength
		Dim l_WordTail
		Dim l_CuttingWord
		Dim l_LoopIDx
		Dim l_CharCode

		l_WordLength = 0.00
		l_CuttingWord = ""
		If (Len (Tail_String) > 0) Then
			l_WordTail = Tail_String
		Else
			l_WordTail = ".."
		End If

		For l_LoopIDx = 1 To Len (Word_String)
			l_CharCode = Asc (Mid (Word_String, l_LoopIDx, 1))
			If (l_CharCode < 0) Then
				'Union 문자
				l_WordLength = l_WordLength + 1.4
			ElseIf (l_CharCode >= 97 And l_CharCode <= 122) Then
				'
				l_WordLength = l_WordLength + 0.75
			ElseIf (l_CharCode >= 65 And l_CharCode <= 90) Then
				'영문 대문자
				l_WordLength = l_WordLength + 1
			Else
				'기타 숫자및 특수기호 @#..
				l_WordLength = l_WordLength + 0.8
			End If
			If (l_WordLength > Cut_Length) Then
				l_CuttingWord = l_CuttingWord & l_WordTail
				Exit For
			End If
			l_CuttingWord = l_CuttingWord & Mid (Word_String, l_LoopIDx, 1)
		Next
		cutWord = l_CuttingWord
	End Function

	Function getImageFile (ByVal File_List)''추후 삭제
		getImageFile = ""
		If (Not IsArray (File_List)) Then
			Exit Function
		End If

		Dim l_LoopIDx
		Dim l_FileName, l_FileExtension

		For l_LoopIDx = 0 To UBound (File_List)
			l_FileName = Trim (File_List (l_LoopIDx))
			l_FileExtension = LCase (Mid (l_FileName, InstrRev (l_FileName, ".") + 1))
			If ((l_FileExtension = "jpg") Or _
				(l_FileExtension = "jpeg") Or _
				(l_FileExtension = "gif") Or _
				(l_FileExtension = "png")) Then
				getImageFile = l_FileName
				Exit For
			End If
		Next
	End Function

	''###########################################
	'' 파일처리되는 설정파일
	''###########################################
	Sub makeFile_skinInfo()
		Dim FILE, FSO, ForWriting
		file = PATH_SYSTEM & "config\skin_info.asp"
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(file) THEN FSO.DeleteFile(file)
		SET FILE = FSO.createTextFile(file, ForWriting)
		
		FILE.WRITELINE("<%")
		FILE.WRITELINE("	' 이 파일은 위즈몰 스킨 환경 설정 파일입니다.")
		FILE.WRITELINE("")
		FILE.WRITELINE("Dim LayoutSkin, MainSkin, MenuSkin, ShopSkin, IconSkin, ListNo, PageNo")
		FILE.WRITELINE("Dim SubListNo, DefaultOrder, ViewerSkin, GoodsDisplayEstim, GoodsDisplayPid,  SearchSkin")
		FILE.WRITELINE("Dim CartSkin, CoorBuySkin, MemberSkin, WishSkin, ZipCodeSkin, HtmlSkin")	
		FILE.WRITELINE("	LayoutSkin		= " & CHR(34) & LayoutSkin & CHR(34))	
		FILE.WRITELINE("	MainSkin		= " & CHR(34) & MainSkin & CHR(34))
		FILE.WRITELINE("	MenuSkin		= " & CHR(34) & MenuSkin & CHR(34))
		FILE.WRITELINE("	ShopSkin		= " & CHR(34) & ShopSkin & CHR(34))
		FILE.WRITELINE("	IconSkin		= " & CHR(34) & IconSkin & CHR(34))
		FILE.WRITELINE("	ListNo			= " & CHR(34) & ListNo & CHR(34))
		FILE.WRITELINE("	PageNo			= " & CHR(34) & PageNo & CHR(34))
		FILE.WRITELINE("	SubListNo		= " & CHR(34) & SubListNo & CHR(34))
		FILE.WRITELINE("	DefaultOrder	= " & CHR(34) & DefaultOrder & CHR(34))
		FILE.WRITELINE("	ViewerSkin		= " & CHR(34) & ViewerSkin & CHR(34))
		FILE.WRITELINE("	GoodsDisplayEstim		= " & CHR(34) & GoodsDisplayEstim & CHR(34))
		FILE.WRITELINE("	GoodsDisplayPid		= " & CHR(34) & GoodsDisplayPid & CHR(34))		
		FILE.WRITELINE("	CartSkin		= " & CHR(34) & CartSkin & CHR(34))
		FILE.WRITELINE("	CoorBuySkin		= " & CHR(34) & CoorBuySkin & CHR(34))
		FILE.WRITELINE("	MemberSkin		= " & CHR(34) & MemberSkin & CHR(34))
		FILE.WRITELINE("	SearchSkin		= " & CHR(34) & SearchSkin & CHR(34))
		FILE.WRITELINE("	WishSkin		= " & CHR(34) & WishSkin & CHR(34))
		FILE.WRITELINE("	ZipCodeSkin		= " & CHR(34) & ZipCodeSkin & CHR(34))
		FILE.WRITELINE("	HtmlSkin		= " & CHR(34) & HtmlSkin & CHR(34))
		FILE.WRITELINE(CHR(37 ) & ">")
		FILE.CLOSE

		Set FSO	= Nothing : Set FILE = Nothing
		On Error Resume Next
	End Sub	

	Sub makeFile_membercheckInfo()
		Dim FILE, FSO, ForWriting
		FILE = PATH_SYSTEM & "config\membercheck_info.asp"
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(FILE) THEN FSO.DeleteFile(FILE)
		SET FILE = FSO.createTextFile(FILE, ForWriting)
		
		FILE.WRITELINE("<%")
		FILE.WRITELINE("'' 이 파일은 회원가입관련 환경 설정 파일입니다.")
		FILE.WRITELINE("Dim ESex,CSex,ECompany,CCompany,ECompnum,CCompnum,ETel2,CTel2,EMailReceive,CMailReceive,EBirthDay")
		FILE.WRITELINE("Dim CBirthDay,CMarrStatus,EMarrStatus,EJob,CJob,EScholarship,CScholarship,EAddress3")
		FILE.WRITELINE("Dim CAddress3,ERecID,CRecID,EGrantSta,EPoint,RPoint,LPoint,INCLUDE_MALL_SKIN,SendMail")
		FILE.WRITELINE("Dim realnameModule, realnameID, realnamePWD")
		FILE.WRITELINE("")
		FILE.WRITELINE("ESex			= " & CHR(34) & ESex & CHR(34))
		FILE.WRITELINE("CSex			= " & CHR(34) & CSex & CHR(34))
		FILE.WRITELINE("ECompany		= " & CHR(34) & ECompany & CHR(34))
		FILE.WRITELINE("CCompany		= " & CHR(34) & CCompany & CHR(34))
		FILE.WRITELINE("ECompnum		= " & CHR(34) & ECompnum & CHR(34))
		FILE.WRITELINE("CCompnum		= " & CHR(34) & ECompnum & CHR(34))
		FILE.WRITELINE("ETel2			= " & CHR(34) & ETel2 & CHR(34))
		FILE.WRITELINE("CTel2			= " & CHR(34) & CTel2 & CHR(34))
		FILE.WRITELINE("EMailReceive    = " & CHR(34) & EMailReceive & CHR(34))
		FILE.WRITELINE("CMailReceive    = " & CHR(34) & CMailReceive & CHR(34))
		FILE.WRITELINE("EBirthDay		= " & CHR(34) & EBirthDay & CHR(34))
		FILE.WRITELINE("CBirthDay		= " & CHR(34) & CBirthDay & CHR(34))
		FILE.WRITELINE("EMarrStatus     = " & CHR(34) & EMarrStatus & CHR(34))
		FILE.WRITELINE("CMarrStatus     = " & CHR(34) & EMarrStatus & CHR(34))
		FILE.WRITELINE("EJob			= " & CHR(34) & EJob & CHR(34))
		FILE.WRITELINE("CJob			= " & CHR(34) & CJob & CHR(34))
		FILE.WRITELINE("EScholarship    = " & CHR(34) & EScholarship & CHR(34))
		FILE.WRITELINE("CScholarship    = " & CHR(34) & CScholarship & CHR(34))
		FILE.WRITELINE("EAddress3		= " & CHR(34) & EAddress3 & CHR(34))
		FILE.WRITELINE("CAddress3		= " & CHR(34) & CAddress3 & CHR(34))
		FILE.WRITELINE("ERecID			= " & CHR(34) & ERecID & CHR(34))
		FILE.WRITELINE("CRecID			= " & CHR(34) & CRecID & CHR(34))
		FILE.WRITELINE("EGrantSta		= " & CHR(34) & EGrantSta & CHR(34))
		FILE.WRITELINE("EPoint			= " & CHR(34) & EPoint & CHR(34))
		FILE.WRITELINE("RPoint			= " & CHR(34) & RPoint & CHR(34))
		FILE.WRITELINE("LPoint			= " & CHR(34) & LPoint & CHR(34))
		FILE.WRITELINE("INCLUDE_MALL_SKIN     = " & CHR(34) & INCLUDE_MALL_SKIN & CHR(34))
		FILE.WRITELINE("SendMail     = " & CHR(34) & SendMail & CHR(34))
		FILE.WRITELINE("realnameModule     = " & CHR(34) & realnameModule & CHR(34))
		FILE.WRITELINE("realnameID     = " & CHR(34) & realnameID & CHR(34))
		FILE.WRITELINE("realnamePWD     = " & CHR(34) & realnamePWD & CHR(34))
		FILE.WRITELINE(CHR(37 ) & ">")
		FILE.CLOSE
		
		Set FSO	= Nothing : Set FILE = Nothing
		On Error Resume Next
	End Sub	


	Sub makeFile_cartInfo()
		Dim FILE, FSO, ForWriting
		file = PATH_SYSTEM & "config\cart_info.asp"
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(file) THEN FSO.DeleteFile(file)
		SET FILE = FSO.createTextFile(file, ForWriting)
		
		FILE.WRITELINE("<%")
		FILE.WRITELINE("'' 이 파일은 결제관련 스킨 환경 설정 파일입니다.")
		FILE.WRITELINE("Dim ONLINE_ENABLE, CARD_ENABLE, PG_PACK, CARD_ID, CARD_PASS, CARD_ENABLE_MONEY, PHONE_ENABLE, AUTOBANKING_ENABLE, POINT_ENABLE")
		FILE.WRITELINE("Dim POINT_ENABLE_MONEY, TACKBAE_CUTLINE, TACKBAE_MONEY, TACKBAE_ALL")
		FILE.WRITELINE("ONLINE_ENABLE     = " & CHR(34) & ONLINE_ENABLE & CHR(34))
		FILE.WRITELINE("CARD_ENABLE     = " & CHR(34) & CARD_ENABLE & CHR(34))
		FILE.WRITELINE("PG_PACK     = " & CHR(34) & PG_PACK & CHR(34))
		FILE.WRITELINE("CARD_ID     = " & CHR(34) & CARD_ID & CHR(34))
		FILE.WRITELINE("CARD_PASS     = " & CHR(34) & CARD_PASS & CHR(34))
		FILE.WRITELINE("CARD_ENABLE_MONEY     = " & CHR(34) & CARD_ENABLE_MONEY & CHR(34))
		FILE.WRITELINE("PHONE_ENABLE     = " & CHR(34) & PHONE_ENABLE & CHR(34))
		FILE.WRITELINE("AUTOBANKING_ENABLE     = " & CHR(34) & AUTOBANKING_ENABLE & CHR(34))
		FILE.WRITELINE("POINT_ENABLE     = " & CHR(34) & POINT_ENABLE & CHR(34))
		FILE.WRITELINE("POINT_ENABLE_MONEY     = " & CHR(34) & POINT_ENABLE_MONEY & CHR(34))
		FILE.WRITELINE("TACKBAE_CUTLINE     = " & CHR(34) & TACKBAE_CUTLINE & CHR(34))
		FILE.WRITELINE("TACKBAE_MONEY     = " & CHR(34) & TACKBAE_MONEY & CHR(34) & "")
		FILE.WRITELINE("TACKBAE_ALL     = " & CHR(34) & TACKBAE_ALL & CHR(34))
		FILE.WRITELINE(CHR(37 ) & ">")
		FILE.CLOSE
		
		Set FSO	= Nothing : Set FILE = Nothing
		On Error Resume Next
	End Sub	

	Sub makeFile_bankInfo()
		Dim FILE, i, j, FSO, ForWriting
		Dim ziroarr,ArrCount,tmpCount, strText, FILEPATH
		FILEPATH = PATH_SYSTEM & "config\bank_info.asp"


		strText = "<%"
		strText = strText & chr(13)&chr(10)
		strText = strText & "'' 이 파일은 무통장입금 계좌정보 설정 파일입니다."
		strText = strText & chr(13)&chr(10)
		ziroarr = split(ZIRO_LIST, chr(13)&chr(10))
		ArrCount = Ubound(ziroarr)
		tmpCount = ArrCount+1
		strText = strText & "Dim ZIRO_LIST(" & tmpCount & ")"
		strText = strText & chr(13)&chr(10)
		for i = 0 to ArrCount
			j = i + 1
			if ziroarr(i) <> "" Then
				strText = strText & "ZIRO_LIST("&j&")     = " & CHR(34) & ziroarr(i) & CHR(34)
				strText = strText & chr(13)&chr(10)
			End If
		next
		strText = strText & CHR(37) & ">"
		
		if cfg.Item("lan") = "utf-8" then
			Call util.WriteToFile(strText , FILEPATH)
		else 
			SET FILE = FSO.createTextFile(FILEPATH, ForWriting)
			SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
			IF FSO.fileExists(FILEPATH) THEN FSO.DeleteFile(FILEPATH)	
			FILE.WriteText strText		
			FILE.CLOSE
			Set FSO	= Nothing : Set FILE = Nothing
			''On Error Resume Next
		end if
	End Sub	


	Sub makeFile_adminInfo(strText, FILEPATH)
		if cfg.Item("lan") = "utf-8" then
			Call util.WriteToFile(strText , FILEPATH)
		else 
			Dim FSO, ForWriting, FILE
			SET FILE = FSO.createTextFile(FILEPATH, ForWriting)
			SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
			IF FSO.fileExists(FILEPATH) THEN FSO.DeleteFile(FILEPATH)	
			FILE.WriteText strText		
			FILE.CLOSE
			Set FSO	= Nothing : Set FILE = Nothing
			''On Error Resume Next
		end if
	End Sub	


	Sub WriteToFile (strText, strFile) '' utf-8
		Dim Stream
		Set Stream = CreateObject ("ADODB.Stream")
		With Stream
		.Open
		.CharSet = "utf-8"
		.WriteText strText
		.SaveToFile strFile, 2
		End With
		Set Stream = Nothing
	End Sub


	Sub CreateFile(pstrFile)
	
		Dim objStream
		Set objStream = CreateObject( "ADODB.Stream" )
		objStream.Open
		objStream.Type = 2
		objStream.Position = 0
		objStream.Charset = "utf-8"
		
		objStream.LoadFromFile pstrFile
		objStream.SaveToFile pstrFile, 2
		objStream.flush
		objStream.Close
		Set objStream = Nothing
	End Sub


	Sub ConvertStringToUtf8Bytes(strText)
	
		Dim objStream
		Dim data() 
		
		Set objStream = CreateObject( "ADODB.Stream" )
		objStream.Charset = "utf-8"
		objStream.Mode = adModeReadWrite
		objStream.Type = adTypeText
		objStream.Open
		
		objStream.WriteText strText
		objStream.Flush
	
	
		objStream.Position = 0
		objStream.Type = adTypeBinary
		objStream.Read 3 '' skip first 3 bytes as this is the utf-8 marker
		data = objStream.Read()
		
		Response.Write(pstrFile)
		objStream.LoadFromFile pstrFile
		objStream.SaveToFile pstrFile, 2
		objStream.flush
		objStream.Close
		ConvertStringToUtf8Bytes = data
		Set objStream = Nothing
	
	
	End Sub
	

	Function is_Admin()
		''is_Admin 을 실행하기 앞서 user_id 변수값은 lib/cfg.common.asp 에서 받아오므로 받드시 인클루드 시켜야 한다. 
		if user_id = "admin" and user_grade = 0 then is_Admin = true Else is_Admin = False
	End Function

	Sub fileDown(filename, path)
		Dim user_agent, content_disp, contenttype
		Dim downFilename
		downFilename = Mid(filename,InstrRev(filename,"/")+1) '파일 이름 추출, ..\ 등의 하위 경로 탐색은 제거 됨
		downFilename = Mid(downFilename,InstrRev(downFilename,"%2F")+1) '파일 이름 추출, ..\ 등의 하위 경로 탐색은 제거 됨
		user_agent = Request.ServerVariables("HTTP_USER_AGENT")
		''Response.Write("downFilename:"&downFilename)
		''Response.End()
		If InStr(user_agent, "MSIE") > 0 Then
			'IE 5.0인 경우.
			''inline 일경우 브라우저에서 바로 디스플레이
			If InStr(user_agent, "MSIE 5.0") > 0 Then
				content_disp = "inline;filename="
				contenttype = "application/x-msdownload"
			'IE 5.0이 아닌 경우.
			Else
				content_disp = "inline;filename="
				contenttype = "application/unknown"
			End If
		Else
		'Netscape등 기타 브라우저인 경우.
			content_disp = "attachment;filename="
			contenttype = "application/unknown"
		End If

		RESPONSE.EXPIRES = 0
		RESPONSE.CONTENTTYPE = contenttype
		 
		''RESPONSE.ADDHEADER "Content-Disposition","attachment; filename=" & filename
		RESPONSE.ADDHEADER "Content-Disposition","attachment; filename=" & Server.UrlPathEncode(downFilename)''한글파일명 깨짐 방지
		Response.CacheControl = "public" 
		

		Dim objStream, strFile
		SET objStream = Server.CreateObject("ADODB.Stream")
		objStream.OPEN
		objStream.TYPE = 1
		objStream.LoadFromFile path & downFilename
		strFile = objStream.READ
		Response.BinaryWrite strFile
		SET objStream = Nothing
		
	End Sub





	Sub getClickedPd
		Response.Write("<table width=""90px"" border=""0"" cellspacing=""0"" cellpadding=""0"" class='agn_c'>")
		Dim cookiecnt, subcnt, i
		Dim t_pname, t_price, t_category, t_uid, t_img
		cookiecnt = Request.Cookies("cookieKey")("cookiecnt")
		subcnt = 0
		for i = cookiecnt to 1 step - 1
			t_pname		= Request.Cookies("cookieKey" & i)("t_pname")
			t_price		= Request.Cookies("cookieKey" & i)("t_price")
			t_category	= Request.Cookies("cookieKey" & i)("t_category")
			t_uid		= Request.Cookies("cookieKey" & i)("t_uid")
			t_img		= Request.Cookies("cookieKey" & i)("t_img")
			if subcnt < 3 then
			Response.Write("<tr>")
			Response.Write("<td><table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">")
			Response.Write("<tr>")
			Response.Write("<td><a href=""wizmart.asp?smode=view&code=" & t_category & "&no=" & t_uid & """><img src=""/config/wizstock/" & t_img & """ border=""0"" width=""70"" height=""70""></a></td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td align=""center"" style=""word-break:break-all;"">" & t_pname & "</td>")
			Response.Write("</tr>")
			Response.Write("</table></td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td height=""1"" bgcolor=""#F0F0F0""></td>")
			Response.Write("</tr> ")
			end if
		subcnt = subcnt+1
		next 
		Response.Write("</table>")
	End Sub
	
	
	Function getBanner(Position, width, height)
		Dim b_url, b_target, b_attached, b_showflag
		''IF NOT objRs.EOF THEN 
		SELECT CASE Position
			CASE "top"
				strSQL		= "select top 1 url, target, attached, showflag from wizbanner where flag1 = '1'"
				Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				If NOT objRs.EOF Then
					b_url		= objRs("url")
					b_target	= objRs("target")
					b_attached	= objRs("attached")
					getBanner = "<a href='" & b_url &"' target='" & b_target & "'><img src='./config/banner/" & b_attached & "'></a>"
				End If
			CASE "bottom"
				strSQL		= "select top 1 url, target, attached, showflag from wizbanner where flag1 = '2'"
				Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				If NOT objRs.EOF Then
					b_url		= objRs("url")
					b_target	= objRs("target")
					b_attached	= objRs("attached")
					getBanner = "<a href='" & b_url &"' target='" & b_target & "'><img src='./config/banner/" & b_attached & "'></a>"
				End If
			CASE "maintop"
				strSQL		= "select top 1 url, target, attached, showflag from wizbanner where flag1 = '3'"
				Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				If NOT objRs.EOF Then
					b_url		= objRs("url")
					b_target	= objRs("target")
					b_attached	= objRs("attached")
					getBanner = "<a href='" & b_url &"' target='" & b_target & "'><img src='./config/banner/" & b_attached & "'></a>"	
				End If
			CASE "maincenter"
				strSQL		= "select top 3 url, target, attached, showflag from wizbanner where flag1 = '3' order by ordernum asc"
				Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				If NOT objRs.EOF Then
					b_url		= objRs("url")
					b_target	= objRs("target")
					b_attached	= objRs("attached")
					getBanner = "<a href='" & b_url &"' target='" & b_target & "'><img src='./config/banner/" & b_attached & "'></a>"
				End If
		END Select
	End Function
	
	Sub getBanners(flag1, width, height)
		Dim b_url, b_target, b_attached, b_showflag, i
		strSQL		= "select url, target, attached, showflag from wizbanner where flag1 = " & flag1 & " order by ordernum asc"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		i = 0
		WHILE NOT objRs.EOF
			If i < UBound(bannerList) Then
				b_url		= objRs("url")
				b_target	= objRs("target")
				b_attached	= objRs("attached")
				bannerList(i) = "<a href='" & b_url &"' target='" & b_target & "'><img src='./config/banner/" & b_attached & "'></a>"	
				''Response.Write(bannerList(i))
				i = i + 1
			End If
		objRs.MOVENEXT
		Wend
	End Sub
End Class
%>
