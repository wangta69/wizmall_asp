<% 
class boards '' 클래스 선언합니다..
	' 에러 처리
	Function ExecError(str1, str2, bid, gid)
		IF str2 = 1 Then
			Response.Redirect PATH_URL & "wizboard.asp?bmode=error&bid=" & bid & "&gid=" & gid & "&msg=" + str1
		Else
			Response.Redirect "/wizboard/error.asp?msg=" + str1
		End if
	End Function

	' login 처리
	Function ExecLogin(bid, gid, category, adminmode)
	''Response.Write(bid &","& gid &","& category &","& adminmode)
	''
		Dim str1, str2, rtnurl

		IF str2 = 1 Then
			Response.Redirect PATH_URL & "wizboard.asp?bmode=error&bid=" & bid & "&gid=" & gid & "&msg=" + str1
		Else

			rtnurl = Request.ServerVariables("path_info") & "?" & server.Urlencode(Request.ServerVariables("QUERY_STRING"))
			Response.Redirect "./wizmember.asp?smode=login&rtnurl="&rtnurl
			''Response.Redirect "./wizboard.asp?bid=" & bid & "&gid=" & gid & "&bmode=memlogin&fromlogin=wizboard.asp&rtnurl="&rtnurl
			''Response.Redirect "./wizmember.asp?smode=login&rtnurl="&rtnurl&"&fromlogin=wizboard.asp&loginflag1="&gid&"&loginflag2="&bid&"&loginflag3="&category&"&loginflag4="&adminmode
		End if
	End Function

	'' // 글쓰기, 글읽기, 다운로드, 리스팅 권한 체크
	Function checkAccess(user_grade, allowed_grade)
		IF user_grade = "" THEN user_grade = 11
		IF allowed_grade = 11 THEN
			checkAccess = True
		ELSEIF SESSION("admin") = "super" THEN
			checkAccess = True			
		ELSE
			IF INT(allowed_grade) < INT(user_grade) THEN
				checkAccess = False
			ELSE
				checkAccess = True
			END IF
		END IF
	End Function

	'' // 글쓰기, 글읽기, 다운로드, 리스팅 권한 체크(앞으로는 이것으로 일괄 처리)
	Function  accessGradeCheck(user_grade, allowed_grade)
		IF user_grade = "" THEN user_grade = 11
		IF allowed_grade = 11 THEN
			accessGradeCheck = True
		ELSEIF SESSION("admin") = "super" THEN
			accessGradeCheck = True			
		ELSE
			IF INT(allowed_grade) < INT(user_grade) THEN
				IF INT(user_grade) = 11 then
					response.write "<script>alert('로그인후 이용해주세요');history.go(-1);</script>"
					response.end
				ELSE 
					
				END IF
			ELSE
			END IF
		END IF
		
		

			''[에러메시지로 보내기  Response.Redirect PATH_URL & "wizboard.asp?bmode=error&bid=" & bid & "&gid=" & gid & "&msg=" + str1
			''[회원가입로그인으로 보내기] Response.Redirect "./wizmember.asp?smode=login&fromlogin=wizboard.asp&loginflag1="&gid&"&loginflag2="&bid&"&loginflag3="&category&"&loginflag4="&adminmode
				
	End Function

		
	' // 댓글 삭제 권한 체크
	Function checkDeleteUser(user_grade, user_id, writer_id)
		IF user_id = "admin" THEN
			checkDeleteUser = 3
		ELSE
			IF user_id = "" THEN
				checkDeleteUser = 1
			ELSE
				IF writer_id = user_id THEN checkDeleteUser = 3 ELSE checkDeleteUser = 2
			END IF
		END IF
	End Function		

	' // 본인글인지 체크
	Function checkWriteEdit(user_grade, user_id, writer_id)
		IF (user_grade = 0) OR (user_grade = 11) THEN
			checkWriteEdit = True
		ELSE
			IF writer_id = "guest" THEN
				IF user_id <> "guest" THEN checkWriteEdit = False ELSE checkWriteEdit = True
			ELSE
				IF user_id = writer_id THEN checkWriteEdit = False ELSE checkWriteEdit = True
			END IF
		END IF
	End Function

	Function getSearchFontChange(isSearch, search_category, search_word, str)
		IF isSearch = 1 THEN
			IF InStr(search_category, "subject") <> "0" THEN getSearchFontChange = Replace(str, search_word, "<font color=red>" & search_word & "</font>")
			IF InStr(search_category, "writer") <> "0" AND InStr(search_word, "img") = "0" THEN getSearchFontChange = Replace(str, search_word, "<font color=red>" & search_word & "</font>")
			IF InStr(search_category, "content") <> "0" THEN getSearchFontChange = Replace(str, search_word, "<font color=red>" & search_word & "</font>")
			IF InStr(search_category, "userid") <> "0" THEN getSearchFontChange = Replace(str, search_word, "<font color=red>" & search_word & "</font>")
			IF InStr(search_category, "ip") <> "0" THEN getSearchFontChange = Replace(str, search_word, "<font color=red>" & search_word & "</font>")
		ELSE
			getSearchFontChange = str
		END IF
	End Function
	' // 댓글 갯수 출력
	Function getCommentCount(setUseComment, intComment)
		IF setUseComment = True THEN
			IF INT(intComment) = 0 THEN
				getCommentCount = ""
			ELSE
				getCommentCount = "[" & intComment & "]"
			END IF
		ELSE
			getCommentCount = ""
		END IF
	End Function

	SUB BOARD_DELETE_DONE
		
		Dim filename
		'' 현재 삭제될 글에 등록된 정보를 가져온다.
		strSQL	= "SELECT [uid], [bd_idx_num], [bd_num], [bd_step], [bd_level], [category], [filename] FROM " & table_name & " WHERE [uid] = " & uid
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			bd_step		= objRs("bd_step")
		bd_num		= objRs("bd_num")
		bd_level	= objRs("bd_level")
		bd_idx_num	= objRs("bd_idx_num")
		filename	= objRs("filename")

		''리플글이 존재할 경우
		strSQL	= "SELECT [uid] FROM " & table_name & " WHERE [bd_num] = '" & bd_num & "' AND [bd_step] = '" & bd_step + 1 &  "' AND [bd_level] = '" & bd_level + 1 & "'"

		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		IF NOT objRs.EOF THEN CALL ExecError("답변글이 존재하는 게시글 입니다.", 1, bid, gid)
	
		''리플글이 없을경우 삭제 실행
		Call db.BeginTrans(DbConnect)
		On Error Resume Next

		strSQL = "DELETE FROM " & table_name & " WHERE [uid] = " & uid
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

		strSQL = "UPDATE " & table_name & " SET [bd_step] = [bd_step] - 1 WHERE [bd_num] = " & bd_num & " AND [bd_step] > " & bd_step
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

		strSQL = "UPDATE " & table_name & " SET [bd_idx_num] = [bd_idx_num] - 1 WHERE [bd_idx_num] > " & bd_idx_num
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

		Dim pds_dir
		filenameArr    = split(objRs("filename"), "|")


		''첨부화일 삭제
		for i = 0 to Ubound(filenameArr)
			pds_dir = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
			IF filenameArr(i) <> "" THEN CALL FileDelete(pds_dir, filenameArr(i))	
		next
		
		''리플글 삭제
		strSQL	= "SELECT [filename] FROM " & table_name_comment & " WHERE [b_uid] = " & uid
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		
		WHILE NOT objRs.EOF
			if IsNull(objRs("filename")) = FALSE then
				reple_filenameArr    = split(objRs("filename"), "|")
				''첨부화일 삭제
				for i = 0 to Ubound(reple_filenameArr)
					pds_dir = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
					IF reple_filenameArr(i) <> "" THEN CALL FileDelete(pds_dir, reple_filenameArr(i))	
				next
			end if
		objRs.MOVENEXT
		Wend
		
		strSQL = "DELETE FROM " & table_name_comment & " WHERE [b_uid] = " & uid
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
				
		If Err.number = 0 Then Call db.CommitTrans(DbConnect) Else Call db.RollbackTrans(DbConnect)

	END Sub


	Sub boardlist()
		Dim temp, difftime, op_flag, filenameArr
		Set util	=	new utility
		uid 			= objRs("uid")
		name			= objRs("name")
		name			= util.ReplaceHtmlText("1", name)
		contents		= util.ReplaceHtmlText(enable_html, objRs("content"))
		subject			= objRs("subject")
		count			= objRs("count")
		regdate			= objRs("regdate")
		op_flag			= objRs("op_flag")
		
		filename		= objRs("filename")
		if IsNull(filename) = false then filenameArr		= SPLIT(filename, "|") 
		ListFile1 = ""
		if not isNull(filename) then  
			filenameArr = split(filename, "|")
			For i = 0 to Ubound(filenameArr)
				if i = 0 then ListFile1 = filenameArr(i)
			next
		end if
		
		if setrepleenable = 1 Then Reple_count = "["&objRs("replecount")&"]"
		
		if not isNull(op_flag) then  
			op_flag_value	= SPLIT(op_flag, "|")
			for i=0 to Ubound(op_flag_value)
				if i = 0 then option_html	= op_flag_value(0)
				if i = 1 then option_secret	= op_flag_value(1)
				if i = 2 then option_notice	= op_flag_value(2)
			next
		end if
		
		
		
		''email			= util.getEmailChange(objRs("email"))
		''homepage		= util.getReplaceInput(objRs("homepage"),"")
		''IF homepage		= "http://" OR homepage = "HTTP://" THEN homepage = ""


	'' // 글자 길이 제한
		IF INT(util.getLenStr(subject)) > INT(setSubjectCut) THEN subject = LEFT(subject, INT(setSubjectCut) - 3) & "..."
		''subject = getSearchFontChange(isSearch, search_category, search_word, subject)
		
	' 리플 아이콘 처리
		IF INT(objRs("bd_level")) > 0 THEN
			FOR I = 1 TO INT(objRs("bd_level"))
				Reple_Icon = Reple_Icon & "&nbsp;"
			NEXT
				Reple_Icon = Reple_Icon & "<img src=" & skin_path & "icon/re_btn.gif align=absmiddle>&nbsp;"
		ELSE
			Reple_Icon = ""
		END IF
		'' 신규 글 아이콘 등록		
		difftime = DateDiff("h",objRs("regdate"),now())
		if difftime <= 24 Then New_Icon =  "<img src=" & skin_path & "icon/new_btn.gif align=absmiddle>" Else New_Icon = ""

		' 비밀 게시물
		if option_secret = 1 then
			SecretImg = "<img src=" & skin_path & "images/key.gif>"
			contents = "비밀게시물 입니다."
		else
			SecretImg =""
		end if
		' 첨부 아이콘 구하기
			if ListFile1 <> "" Then Attached_Icon =  "<img src=" & skin_path & "images/icon_data.gif align=absmiddle>" Else Attached_Icon = ""

		'' 사용자 정의 존재시
''			Dim sub_content1, i
''			if IsNull(objRs("sub_content1")) = False then
''				sub_content1			= Split(objRs("sub_content1"), "::")
''				For i = 0 To Ubound(sub_content1)
''					If i = 0 then cont1 = sub_content1(i)
''					If i = 1 then cont2 = sub_content1(i)
''					If i = 2 then cont3 = sub_content1(i)
''				Next
''			End If

	End Sub
	
	'' 게시물 기본 링크
	Function linkStr(str)
		Dim tmp_str
	''str은 일반텍스트 이미지(html)
		tmp_str = "<a href='wizboard.asp?bmode=view&bid=" & bid & "&gid=" & gid & "&adminmode=" & adminmode & "&uid=" & uid & "&page=" & page
		tmp_str = tmp_str & "&category=" & category & "&search_category=" & search_category & "&search_title=" & search_title & "&search_keyword=" & search_keyword & "'" 
		tmp_str = tmp_str & " style='TEXT-DECORATION: none;COLOR: #777777'>"
		tmp_str = tmp_str & str
		tmp_str = tmp_str & "</a>"
		linkStr = tmp_str
	End Function 

	Sub paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
		Dim TP, CB, SP, EP, TB, prev_page, next_page, I
		TP = Round(TotalCount / setPageSize + 0.49) ''총페이지수(Total Page) : 총게시물수 / 페이지당 리스트수  
		CB = Round(page / setPageLink + 0.49) ''현재블록(Current Block) : 현재페이지 / 표시되는 페이지 수
		SP = (CB - 1) * setPageLink + 1'' 블록의 처음 페이지(Start Page) 구하기
		EP = (CB * setPageLink) ''블록의 마지막 페이지(End Page) : 현재 블록 * 표시되는 페이지수
		TB = Round(TP / setPageLink + 0.49) '' 총블록수(Total Block) : 총페이지수 / 표시되는 페이지 수 

		Response.Write "<table id='paging'><tr><td align='center'>"
		IF INT(CB) > 1 THEN
			prev_page = SP - 1
			RESPONSE.WRITE "<a href='" & linkurl & "&page=" & prev_page & "'><img src='" & preimg & "' border=0></a>"
		END IF
		Response.Write "</td> <td align='center'>"


		FOR I = SP TO EP 
			IF I <= TP THEN
				IF INT(I) = INT(page) THEN
					RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
				ELSE
					RESPONSE.WRITE "<a href='" & linkurl & "&page=" & I & "'>&nbsp;"& I & "&nbsp;</a>"
				END IF
			END IF
		NEXT
		Response.Write "</td><td align='center'>"
		IF INT(CB) < INT(TB) THEN 
			next_page = EP + 1
			RESPONSE.WRITE "<a href='" & linkurl & "&page=" & next_page & "'><img src='" & nextimg & "' border=0></a>"
		END IF	

		Response.Write "</td> </tr></table>"
	End Sub

	'' // 파일 확장자에 따른 실행 변수 설정
	Function getViewFile(filename, bid, gid, setBoardWidth, imgsize_width, imgsize_height)
		ImgDir = "./config/wizboard_group/"&gid&"/"&bid&"/attached/"
		imgDir1 = PATH_SYSTEM&"config\wizboard_group\"&gid&"\"&bid&"\attached\"
		f_fileExt = Ucase(mid(filename, instrrev(filename, ".") + 1))
		SELECT CASE f_fileExt
			CASE "JPG","JPEG","GIF","BMP","PNG"
			
				ImageSize = split(util.getImageSize(imgDir1&filename), "|")
				imgsize_width = ImageSize(0)
				imgsize_height = ImageSize(1)
				IF imgsize_width <> "" AND imgsize_height <> "" THEN
					IF INT(setBoardWidth) > 100 THEN
						IF INT(imgsize_width) > INT(setBoardWidth) THEN
							imgsize_height = INT(imgsize_height * setBoardWidth / imgsize_width)
							imgsize_width = setBoardWidth
						END IF
						imgsize_width = ROUND(imgsize_width - 0.5 + 1,0)
						imgsize_height = ROUND(imgsize_height - 0.5 + 1,0)
					END IF
					imgsize_width = " width=" & imgsize_width
					imgsize_height = " height=" & imgsize_height
				ELSE
					imgsize_width = ""
					imgsize_height = ""
				END IF

				getViewFile = "<img name=previmg src=" & ImgDir & filename & imgsize_width & imgsize_height & " style='border-color:rgb(153,153,153)' onClick='openImgLayer(this.src)'>"
			CASE "SWF"
					IF INT(setBoardWidth) < 100 THEN
						getViewFile = "<embed src='" & ImgDir & filename & "' width='600' height='500'>"
					ELSE
						getViewFile = "<embed src='" & ImgDir & filename & "' width='" & INT(setBoardWidth-10) & "' height='" & INT(setBoardWidth*0.75) & "'>"
					END IF
			CASE "WAV","MP3"
				getViewFile = "<bgsound src='" & ImgDir & filename & "'>"
			CASE "ASF","ASX","AVI","WMV","WMA"
				imgsize_width	= setBoardWidth
				imgsize_height	= INT((2*imgsize_width) / 3)
				
				getViewFile = "<embed style='WIDTH: " & imgsize_width & "px; HEIGHT: " & imgsize_height & "px' height=" & imgsize_height & " type=video/x-ms-wmv width=" & imgsize_width & " src='" & ImgDir & filename & "' loop='true' autostart='true'>"

				''getViewFile = "<OBJECT ID='MPlay2' style='WIDTH: " & imgsize_width & "px; HEIGHT: " & imgsize_height & "px' CLASSID='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' standby='Loading Windows Media Player components...' width='" & imgsize_width & "' height='" & imgsize_height & "' type=video/x-ms-wmv>" & vbcrlf
				''getViewFile = getViewFile & "<PARAM NAME='URL' VALUE='" & ImgDir & filename & "'>" & vbcrlf
				''getViewFile = getViewFile & "<PARAM NAME='AutoStart' VALUE='True'>" & vbcrlf
				'getViewFile = getViewFile & "<param name='EnableFullScreenControls' value='true'>" & vbcrlf
				'getViewFile = getViewFile & "<PARAM NAME='UIMode' VALUE='full'>" & vbcrlf
				'getViewFile = getViewFile & "<PARAM NAME='AllowChangeDisplaySize' VALUE='true'>" & vbcrlf
				'getViewFile = getViewFile & "<PARAM NAME='EnableFullScreenControls' VALUE='true'>" & vbcrlf
				'getViewFile = getViewFile & "<PARAM NAME='AutoSize' VALUE='true'>" & vbcrlf
				''getViewFile = getViewFile & "</OBJECT>"
		CASE ELSE
				getViewFile = FALSE
		END SELECT
	End Function

	Sub MakeInitFile(bid,gid,settitle,setskin,SKIP)''위즈보드 테이블 생성
		''owner 변수는 config/db_conneect 에서 받아옴 : 1: 기본, 2면 db 계정과 동일
		Dim Db_Owner, sp_owner
		If owner = 2 then 
			Db_Owner	= Db_Odbc_User 
			sp_owner = Db_Odbc_User 
		Else 
			Db_Owner = ""
			sp_owner = ""
		End If	
		
		''세팅시는 SKIP = True 로 설정하여  기존 보드가 있을시 스킵하여 다음으로 진행한다.
		Dim Errcode : Errcode = 0
		If IsNull(gid) Or gid = "" Then gid = "root"
		CALL util.folderMaker(PATH_SYSTEM & "config\wizboard_group")
		CALL util.folderMaker(PATH_SYSTEM & "config\wizboard_group\"&gid)

		strSQL = "select intnum from " & Db_Owner &"[wiztable_board_config] where bid = '" & bid & "' and gid = '" & gid & "' "
		Set db	= new database
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		IF NOT(objRs.EOF) Then Errcode = 1
		If Errcode = 1 And SKIP <> True Then Call util.js_alert("이미 등록되어 있는 게시판 아이디 입니다.","")

		Set objRs	= db.ExecSQLReturnRS("SELECT * FROM SYSOBJECTS WHERE [name] = 'wizboard_" & bid & "_" & gid & "' ", Nothing, DbConnect)
		IF NOT(objRs.EOF) Then Errcode = 1
		If Errcode = 1 And SKIP <> True Then Call util.js_alert("DB에 [wizboard_" & bid & "_" & gid & "] 테이블이 존재합니다.\n\n먼저 해당 테이블을 삭제하시고 진행해 주시기 바랍니다.","")
		
		If Errcode = 0 Then 
			CALL util.folderMaker(PATH_SYSTEM & "config\wizboard_group\root\" & bid)
			CALL util.folderMaker(PATH_SYSTEM & "config\wizboard_group\root\" & bid &"\attached")
			CALL util.FileMakeTxt(PATH_SYSTEM & "config\wizboard_group\root\" & bid & "\prohibit.txt", "새끼|개새끼|소새끼|병신|지랄|씨팔|십팔|니기미|찌랄|지랄|쌍년|쌍놈|빙신|좆까|니기미|좆같은게|잡놈|벼엉신|바보새끼|씹새끼|씨발|씨팔|시벌|씨벌|떠그랄|좆밥|쉐이|등신|싸가지|미친놈|미친넘|찌랄|죽습니다|씨밸넘|존나")
			CALL util.FileMakeTxt(PATH_SYSTEM & "config\wizboard_group\root\" & bid & "\prohibit_file.txt", "phtml|pml|sphp3|sphp4|shtml|html|xml|xhtml|class|jar|java|php|asp")
			CALL util.FileMakeTxt(PATH_SYSTEM & "config\wizboard_group\root\" & bid & "\allow_file_ext.txt", "gif,jpeg,jpg,bmp,png,psd,ai,hwp,doc,xls,xlsx,pdf,ppt,pptx,zip,alz,avi,mepg,wmv")

			Dim paramInfo(4)
			''wizmembers 용
			paramInfo(0) = db.MakeParam("@bid", adVarChar, adParamInput,20, bid)
			paramInfo(1) = db.MakeParam("@gid", adVarChar, adParamInput,20, gid)
			paramInfo(2) = db.MakeParam("@dbo", adVarChar, adParamInput,20, sp_owner)
			paramInfo(3) = db.MakeParam("@setTitle", adVarChar, adParamInput,20, settitle)
			paramInfo(4) = db.MakeParam("@setSkin", adVarChar, adParamInput,20, setskin)		
			Call db.ExecSP("usp_mk_boardtb", paramInfo, DbConnect) 
		End If 
		db.Dispose : Set db = Nothing :Set objRs = Nothing
	End Sub

	Sub getList(table_name,setPageSize,whereis,page,orderby,selectfield)
		Dim paramList(5)
		paramList(0) = db.MakeParam("@tablename", adVarChar, adParamInput,30, table_name)
		paramList(1) = db.MakeParam("@listcnt", adVarChar, adParamInput,5, setPageSize)
		paramList(2) = db.MakeParam("@whereis", adVarChar, adParamInput,200, whereis)
		paramList(3) = db.MakeParam("@page", adVarChar, adParamInput,5, page)
		paramList(4) = db.MakeParam("@orderby", adVarChar, adParamInput,40, orderby)
		paramList(5) = db.MakeParam("@selectfield", adVarChar, adParamInput,100, selectfield)
		Set objRs = db.ExecSPReturnRS("usp_boardlist", paramList, DbConnect)
	End Sub
	
	Function getBoardName(bid, gid)
		strSQL = "select settitle from wiztable_board_config where bid = '" & bid & "' and gid = '" & gid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		getBoardName				= objRs("settitle")
	End Function

	''현재 옵션에서 secret 정보를 가져온다.
	Function getContentOptionSecret(tablename)
		Dim fieldvalue
		fieldvalue = getContentField(tablename, "op_flag")
		getContentOptionSecret = getContentOption(fieldvalue, "secret")
	End Function
	

	'filedown.asp 및 wizboard.asp에서 권한 체크용으로 바라볾
	Function getContentOption(op_flag, rtn_option)
		
		Dim op_flag_value, i, option_html, option_secret, option_notice
		if IsNull(op_flag) = false then 
			op_flag_value	= SPLIT(op_flag, "|")
			for i=0 to UBound(op_flag_value)
				if i = 0 then option_html	= op_flag_value(0)
				if i = 1 then option_secret	= op_flag_value(1)
				if i = 2 then option_notice	= op_flag_value(2)
			next
		end if
		Select Case rtn_option
			Case "html"
				getContentOption = option_html
			Case "secret"
				getContentOption = option_secret
			Case "notice"
				getContentOption = option_notice
		End Select
	End Function
	
	''현재 글이 secret 일경우 부모글의 bdnum을 가져온다.
	Function getParentbdnum(uid)
		Dim tb_name
		tb_name		= "wizboard_" & bid & "_" & gid
		strSQL		= "select bd_num from " & tb_name & " where uid = '" & uid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		getParentbdnum	= objRs("bd_num")
	End Function

	''현재 글이 secret 일경우 부모글의 password 가져온다.
	Function getParentpass(bd_num)
		Dim tb_name
		tb_name		= "wizboard_" & bid & "_" & gid
		strSQL		= "select pass from " & tb_name & " where bd_num = '" & bd_num & "' and bd_step = 0" 
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		getParentpass	= objRs("pass")
	End Function


	''현재 아이템의 특정 필드만 가져오기
	Function getContentField(tablename, field)
		strSQL = "select " & field & " from " & tablename & " where uid = " & uid
		Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		getContentField = objRs(0)
	End Function

	Sub sample()
		Response.Write("sample 입니다.")
	End Sub
end class 
%>