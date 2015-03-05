<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file = "../lib/cfg.board.asp" -->
<%
Set db = new database : Set board = new boards
if bmode = "qde" Then
	strSQL		= "SELECT TOP 1 * FROM " & table_name & " WHERE [uid]=" & uid
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		SELECT CASE checkDeleteUser(connUserLevel, connUserLoginID, objRs("id"))
		CASE 1
			IF objRs("pass") = REQUEST("check_pwd") THEN
				CALL BOARD_DELETE_DONE
			ELSE
				IF REQUEST("check_pwd") = "" THEN
					RESPONSE.REDIRECT "../wizboard.asp?bmode=qde&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&page=" & page & "&search_category=" & search_category & "&search_word=" & search_word & "&category=" & category & "&order_c=" & order_c & "&order_da=" & order_da
				ELSE
					RESPONSE.WRITE "<script language=javascript>" & vbcrlf
					RESPONSE.WRITE "alert('비밀번호가 일치하지 않습니다.');" & vbcrlf
					RESPONSE.WRITE "history.back(-1);" & vbcrlf
					RESPONSE.WRITE "</script>" & vbcrlf
				END IF
			END IF
		CASE 2
			RESPONSE.WRITE "<script language=javascript>" & vbcrlf
			RESPONSE.WRITE "alert('본인의 게시글만 삭제가 가능합니다.');" & vbcrlf
			RESPONSE.WRITE "history.back(-1);" & vbcrlf
			RESPONSE.WRITE "</script>" & vbcrlf
		CASE 3
			CALL BOARD_DELETE_DONE	
		END SELECT
	
		SUB BOARD_DELETE_DONE
	' 현재 삭제될 글에 등록된 정보를 가져온다.
	strSQL	= "SELECT [uid], [bd_idx_num], [bd_num], [bd_step], [bd_level], [category], [filename] FROM " & table_name & " WHERE [uid] = " & uid
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		
	'리플글이 존재할 경우
	strSQL	= "SELECT [uid] FROM " & table_name & " WHERE [bd_num] = '" & rs("bd_num") & "' AND [bd_step] = '" & rs("bd_step") + 1 &  "' AND [bd_level] = '" & rs("bd_level") + 1 & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	IF NOT objRs.EOF THEN CALL ExecError("답변글이 존재하는 게시글 입니다.", 1, bid, gid)

	
	strSQL = "DELETE FROM " & table_name & " WHERE [uid] = " & uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL = "UPDATE " & table_name & " SET [bd_step] = [bd_step] - 1 WHERE [bd_num] = " & rs("bd_num") & " AND [bd_step] > " & rs("bd_step")
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL = "UPDATE " & table_name & " SET [bd_idx_num] = [bd_idx_num] - 1 WHERE [bd_idx_num] > " & rs("bd_idx_num")
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
				

			Dim repleCount, filename, pds_dir
	
	
			filenameArr    = split(rs("filename"), "|")
	
	for i = 0 to Ubound(filenameArr)
			pds_dir = PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
			IF filenameArr(i) <> "" THEN CALL FileDelete(pds_dir, filenameArr(i))	
	
	next
	
	
	
			RESPONSE.REDIRECT "../wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&adminmode=" & adminmode & "&page=" & page & "&search_category=" & search_category & "&search_word=" & search_word & "&category=" & category
		END SUB
elseif smode = "edit" then
	strSQL		= "SELECT TOP 1 * FROM " & table_name & " WHERE [uid]=" & uid
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	IF objRs("pass") = REQUEST("check_pwd") THEN
		SESSION("bid") = bid&"_"&gid&"_"&uid 
		
					RESPONSE.REDIRECT "../wizboard.asp?bmode="&bmode&"&smode="&smode&"&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&adminmode=" & adminmode & "&page=" & page & "&search_category=" & search_category & "&search_word=" & search_word & "&category=" & category

	else
					RESPONSE.WRITE "<script language=javascript>" & vbcrlf
					RESPONSE.WRITE "alert('비밀번호가 일치하지 않습니다.');" & vbcrlf
					RESPONSE.WRITE "history.back(-1);" & vbcrlf
					RESPONSE.WRITE "</script>" & vbcrlf
	end if
elseif bmode = "view" Then ''비밀글 로그인 시
	bd_num = board.getParentbdnum(uid)

	strSQL		= "SELECT TOP 1 * FROM " & table_name & " WHERE [uid]=" & uid
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

	IF objRs("pass") = REQUEST("check_pwd") THEN
		SESSION("secret_session") = bid & "_" & gid & "_" & bd_num 
		RESPONSE.REDIRECT "../wizboard.asp?bmode="&bmode&"&smode="&smode&"&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&adminmode=" & adminmode & "&page=" & page & "&search_category=" & search_category & "&search_word=" & search_word & "&category=" & category

	Else
		''부모글의 아이디 패스워드도 책크하여 바로 볼수 있게 처리
		
		ParentPass = board.getParentpass(bd_num)
		If ParentPass = REQUEST("check_pwd") Then
			SESSION("secret_session") = bid & "_" & gid & "_" & bd_num 
			RESPONSE.REDIRECT "../wizboard.asp?bmode="&bmode&"&smode="&smode&"&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&adminmode=" & adminmode & "&page=" & page & "&search_category=" & search_category & "&search_word=" & search_word & "&category=" & category
		Else
					RESPONSE.WRITE "<script language=javascript>" & vbcrlf
					RESPONSE.WRITE "alert('비밀번호가 일치하지 않습니다.');" & vbcrlf
					RESPONSE.WRITE "history.back(-1);" & vbcrlf
					RESPONSE.WRITE "</script>" & vbcrlf
		End If
	end If
end If
db.Dispose : Set db = Nothing : SET objRs = Nothing : Set board = Nothing
%>
