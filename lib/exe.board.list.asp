<!-- #include file = "./cfg.board.asp" -->
<%
Set util = new utility : Set db = new database : Set board = new boards


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

    db.Dispose : Set db		= Nothing : Set util	= Nothing : Set board = Nothing	
	
'' 각종 Dim(변수) 정의

	''리스트 thumbnail을 위한 변수 정의
	Dim DefaultPath : DefaultPath			= PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
	Dim name,contents,subject
	Dim filename,selectfield,ListImg
	Dim orderby, ListNum, cnt, tmpcnt, ListFile1
	Dim Reple_Icon, New_Icon, Attached_Icon,Reple_count, regdate, count
	Dim tmporder


%>