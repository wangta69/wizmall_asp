<!-- #include file = "./cfg.board.asp" -->
<!--#include file="../lib/JSON_2.0.4.asp"-->
<script language="JScript" runat="server" src='../lib/json2.js'></script>
<%
Set util = new utility : Set db = new database : Set board = new boards
	if bmode = "view" then
		'' view 제한 체크 
		IF board.checkAccess(user_grade, memberonly_viewmode) = FALSE Then call board.ExecLogin(bid, gid, category, adminmode)
		
		''등록된 게시물, 게시물 보기 카운트올리기, 이전, 다음 항목 가져오기 프로시저
		paramInfo(0) = db.MakeParam("@smode", adVarwChar, adParamInput,30, "")
		paramInfo(1) = db.MakeParam("@tablename", adVarwChar, adParamInput,50, table_name)
		paramInfo(2) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)
		paramInfo(3) = db.MakeParam("@category", adInteger, adParamInput,5, category)
		paramInfo(4) = db.MakeParam("@rtn_puid", adInteger, adParamOutput,11, 0)
		paramInfo(5) = db.MakeParam("@rtn_nuid", adInteger, adParamOutput,11, 0)
		paramInfo(6) = db.MakeParam("@rtn_psub", adVarwChar, adParamOutput,150, "")
		paramInfo(7) = db.MakeParam("@rtn_nsub", adVarwChar, adParamOutput,150, "")

		Set objRs	= db.ExecSPReturnRS("usp_board_view", paramInfo, DbConnect)
		
		preuid		= db.GetValue(paramInfo, "@rtn_puid")
		presubject	= db.GetValue(paramInfo, "@rtn_psub")
		nextuid		= db.GetValue(paramInfo, "@rtn_nuid")
		nextsubject	= db.GetValue(paramInfo, "@rtn_nsub")


		''등록된 게시물을 불러온다
		Dim v_category,v_id,v_name,v_email,v_homepage,v_pass,v_subject,v_flag,v_txtbold, v_txtcolor,v_sub_subject1,v_sub_subject2
		Dim v_content,v_sub_content1,v_sub_content2,v_op_flag,v_count,v_reccount,v_replecount,v_filename
		Dim v_filesize,v_filedown,v_ip,v_moddate,v_regdate
		Dim jsonParse
		

		v_category		= objRs("category")
		v_id			= objRs("id")
		v_name			= objRs("name")
		v_email			= objRs("email")
		v_homepage		= objRs("homepage")
		''v_pass		= objRs("pass")
		v_subject		= objRs("subject")
		v_flag			= objRs("flag")
		Set jsonParse	= JSON.parse(v_flag) '' [1,2,3]

		'Response.Write(jsonParse.)
		v_sub_subject1	= objRs("sub_subject1")
		v_sub_subject2	= objRs("sub_subject2")
		v_content		= objRs("content")
		v_sub_content1	= objRs("sub_content1")
		v_sub_content2	= objRs("sub_content2")
		v_op_flag		= objRs("op_flag")
		v_count			= objRs("count")
		v_reccount		= objRs("reccount")
		v_replecount	= objRs("replecount")
		v_filename		= objRs("filename")
		''v_filesize	= objRs("filesize")
		v_filedown		= objRs("filedown")
		v_ip			= objRs("ip")
		''v_moddate		= objRs("moddate")
		v_regdate		= objRs("regdate")
	
		if IsNull(v_op_flag) = false then 
			op_flag_value	= SPLIT(v_op_flag, "|")
			for i=0 to UBound(op_flag_value)
				if i = 0 then option_html	= op_flag_value(0)
				if i = 1 then option_secret	= op_flag_value(1)
				if i = 2 then option_notice	= op_flag_value(2)
			next
		end If
		
		Response.Write(v_flag)

		If option_secret = "" Then option_secret = 0

		if IsNull(v_filename) = True then v_filename = "|" ''에러방지용으로 처리
		filenameArr		= SPLIT(v_filename, "|")
		for i=0 to ubound(filenameArr)
			attached_file(i) =  filenameArr(i)
		next

		v_content = util.ReplaceHtmlText(option_html, v_content)
		Set objRs = Nothing
			
	elseif bmode = "list" then

		'' // 리스팅 제한 체크
		IF board.checkAccess(user_grade, memberonly_listmode) = FALSE Then call board.ExecLogin(bid, gid, category, adminmode)
		whereis		= " WHERE ( notice <> 1 or notice is null )"
		
		'' // 게시글 토탈 카운팅
		if search_title <> "" and search_keyword <> "" then whereis = whereis & "  and " & search_title & " like '%" & search_keyword & "%'"
		if category <> 0 then whereis = whereis & " and category in (0, " & category & ")"
		
		strSQL = "SELECT COUNT(uid) FROM " & table_name & whereis & " "
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		
		'' // 전체 게시물 및 전체 페이지
		
		TotalCount = objRs(0)
		TotalPage = TotalCount / setPageSize
		IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
			TotalPage = int(TotalPage) + 1
		Else
			TotalPage = int(TotalPage)
		End If
		Set objRs = Nothing
	elseif bmode = "write" then 
			'' // write 제한 체크
			IF board.checkAccess(user_grade, memberonly_writemode) = FALSE Then call board.ExecLogin(bid, gid, category, adminmode)

			smode = REQUEST("smode") : IF smode = "" THEN smode = "qin"
			
			IF smode = "edit" THEN
				'' // 수정할 수 있는 권한이 있는지 체크
				''IF checkWriteEdit(connUserLevel, connUserLoginID, strUserID) = False THEN CALL ExecError("수정할 수 있는 권한이 없습니다.", 1,  bid, gid)
				''등록된 게시물을 불러온다	
				paramInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,30, smode)
				paramInfo(1) = db.MakeParam("@tablename", adVarChar, adParamInput,50, table_name)
				paramInfo(2) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)
				paramInfo(3) = db.MakeParam("@category", adInteger, adParamInput,5, category)
				paramInfo(4) = db.MakeParam("@rtn_puid", adInteger, adParamOutput,11, 0)
				paramInfo(5) = db.MakeParam("@rtn_nuid", adInteger, adParamOutput,11, 0)
				paramInfo(6) = db.MakeParam("@rtn_psub", adVarChar, adParamOutput,150, "")
				paramInfo(7) = db.MakeParam("@rtn_nsub", adVarChar, adParamOutput,150, "")

				Set objRs = db.ExecSPReturnRS("usp_board_view", paramInfo, DbConnect)


				Dim w_category,w_id,w_name,w_email,w_homepage,w_pass,w_subject,w_txtbold, w_txtcolor,w_sub_subject1,w_sub_subject2,w_content,w_sub_content1
				Dim w_sub_content2,w_op_flag,w_count,w_reccount,w_replecount,w_filename,w_filesize,w_filedown,w_ip,w_moddate,w_regdate

				''strSQL = "select * from wizboard_" & bid & "_" & gid & " where uid=" & uid
				''Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				w_category		= objRs("category")
				w_id			= objRs("id")
				w_name			= objRs("name")
				w_email			= objRs("email")
				w_homepage		= objRs("homepage")
				w_pass			= objRs("pass")
				w_subject		= objRs("subject")
				w_sub_subject1	= objRs("sub_subject1")
				w_sub_subject2	= objRs("sub_subject2")
				w_content		= objRs("content")
				w_sub_content1	= objRs("sub_content1")
				w_sub_content2	= objRs("sub_content2")
				w_op_flag		= objRs("op_flag")
				w_count			= objRs("count")
				w_reccount		= objRs("reccount")
				w_replecount	= objRs("replecount")
				w_filename		= objRs("filename")
				''w_filesize	= objRs("filesize")
				w_filedown		= objRs("filedown")
				w_ip			= objRs("ip")
				''w_moddate		= objRs("moddate")
				w_regdate		= objRs("regdate")
				''Response.Write("adsdfasdf")
				''Response.Write(w_subject)
				if IsNull(w_op_flag) = false then 
					op_flag_value	= SPLIT(w_op_flag, "|")
					for i=0 to UBound(op_flag_value)
						if i = 0 then option_html	= op_flag_value(0)
						if i = 1 then option_secret	= op_flag_value(1)
						if i = 2 then option_notice	= op_flag_value(2)
					next
				end if
	
				
				if IsNull(w_filename) = False then 
					filenameArr		= SPLIT(w_filename, "|")
					for i=0 to ubound(filenameArr)
						attached_file(i) =  filenameArr(i)
					next
				end if
									
				w_subject 		= util.ReplaceHtmlText("0", w_subject)
				w_sub_subject1 	= util.ReplaceHtmlText("0", w_sub_subject1)
				w_sub_subject2 	= util.ReplaceHtmlText("0", w_sub_subject2)
				w_content			= objRs("content")
				
				Set objRs = Nothing
			ELSE
				w_name			= user_name
				w_id			= user_id
				w_pass			= user_pwd
			END IF
		
			IF smode = "reple" Then
				
				IF intNotice = 1 THEN CALL board.ExecError("답변을 할 수 있는 게시글이 아닙니다.", 1,  bid, gid)
				IF smode = "reple" AND board.checkAccess(user_grade, memberonly_writemode) = FALSE THEN 
					CALL board.ExecError("답변글 쓰기가 제한되어 있습니다.", 1,  bid, gid)
				End If
				strSQL = "select subject, content from wizboard_" & bid & "_" & gid & " where uid=" & uid
				Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				w_subject	= objRs("subject")
				w_content	= objRs("content")
				w_subject 	= "Re : " & util.ReplaceHtmlText("0", w_subject)
				w_content	= util.ReplaceHtmlText("1", w_content)
				w_content	= Chr(13)&Chr(10)&Chr(13)&Chr(10)&Chr(13)&Chr(10)&Chr(13)&Chr(10)&Chr(13)&Chr(10)&_
								"------------ [Original Message] --------------------------"&Chr(13)&Chr(10)&"&gt;&gt;"&_
								w_content
				Set objRs = Nothing
			END IF
			

			''Dim script
			''script = "" &_
			''		"<script language='JavaScript'>"&Chr(13)&Chr(10) &_
			''		"<!--"&Chr(13)&Chr(10) &_
			''		"function WRITE_FUNC(f){"&Chr(13)&Chr(10) &_
			''		"if(autoCheckForm(f)){"&Chr(13)&Chr(10)

			''		if sethtmleditor = 1 then script = script & "f.content.value = SubmitHTML();"&Chr(13)&Chr(10)
			''		script = script & "f.spamfree.value='"&util.Linuxtime()&"';"&Chr(13)&Chr(10) &_
			''		"document.all.write_view.style.display = '';"&Chr(13)&Chr(10) &_
			''		"document.all.write_form.style.display ='none';"&Chr(13)&Chr(10) &_
			''		"return true;"&Chr(13)&Chr(10) &_
			''		"}else return false;"&Chr(13)&Chr(10) &_
			''		"}"&Chr(13)&Chr(10) &_
			''		"//-->"&Chr(13)&Chr(10) &_
			''		"</script>"&Chr(13)&Chr(10)
			''Response.Write(script)
       	
	end If
	
    db.Dispose : Set db		= Nothing : Set util	= Nothing : Set board = Nothing	
	
'' 각종 Dim(변수) 정의
	If bmode = "write"	then
	
	ElseIf bmode = "view" then
	
	Else
		''리스트 thumbnail을 위한 변수 정의
		Dim DefaultPath : DefaultPath			= PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
		Dim name,contents,subject
		Dim filename,selectfield,ListImg
		Dim orderby, ListNum, cnt, tmpcnt, ListFile1
		Dim Reple_Icon, New_Icon, Attached_Icon,Reple_count, regdate, count
		Dim tmporder
		''Dim sub_subject1, sub_subject2
	End If 
%>