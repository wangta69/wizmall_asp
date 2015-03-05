<!-- #include file = "./cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "./class.util.asp" -->
<!-- #include file = "./class.database.asp" -->
<!-- #include file = "./class.board.asp" -->
<%
	Dim bmode, smode,adminmode,uid, gid, bid, page, category  
	Dim setTitle,setSkin,sethtmleditor,setHeadFile,setHeadMsg,setFootFile,setFootMsg,setSubjectCut
	Dim setPageSize,setPageLink,setmemberonly,setrepleenable,setcategoryenable,memberonly_mode
	Dim setadminonly,setfileenable,setfilenum,setlistinview,setlistorder,setBoardWidth,setBoardWidthStep
	Dim setBoardAlign,setmallinclude,setsecurityflag, intNotice
	Dim memberonly_mode_arr, setsecurityflag_arr
	Dim setsecurityiframe,setsecurityscript,memberonly_listmode,memberonly_viewmode,memberonly_writemode
	Dim TotalCount, TotalPage, whereis, search_title, search_keyword, search_category, SecretImg	
	Dim FMENU_NUM, sub_cat_no, sub_cat_name
	Dim attached_file(20),exe_file, filenameArr, file_path
	Dim catwhere, op_flag_value, op_flag_str
	Dim i
	Dim preuid, presubject, nextuid, nextsubject
	Dim option_html,option_secret,option_notice, enable_html, content
	Dim bd_idx_num, bd_num, bd_step, bd_level
	Dim strSQL, strSQL1,objRs,objRs1, cmd, params, result, sqlsubcount
	Dim db,util,board
	Dim paramInfo(7)
	Set util = new utility : Set db = new database : Set board = new boards

	'' // 게시판 기본 사용 변수
	bmode		= Request("bmode")               : IF bmode = "" Then bmode = "list"
	smode		= Request("smode")
	uid			= Request("uid")
	bid			= Request("bid")
	gid			= Request("gid")
	adminmode	= Request("adminmode")
	Dim table_name : table_name =  "wizboard_" & bid & "_" & gid
	Dim table_name_comment : table_name_comment		= table_name & "_reply"
	Dim attached_dir : attached_dir = "config/wizboard_group/" & gid & "/" & bid & "/attached/"
	
	IF bid = "" or isNULL(bid) Then call board.ExecError("게시판 아이디를 입력해 주시기 바랍니다.", 2, "", "")
	IF gid = "" or isNull(gid) Then Call board.ExecError("게시판 그룹명을 입력해 주시기 바랍니다.", 2, "", "")
	
	page            = Trim(Request("page"))              : IF page		= "" or isNull(page) Then page = 1
	category        = Request("category")          : IF category	= "" or isNull(category) Then category = 0
	search_title    = Request("search_title")      : search_title	= util.secstr(search_title)
	search_keyword  = Request("search_keyword")    : search_keyword	= util.secstr(search_keyword)
	search_category = Request("search_category")   : IF search_category <> "" THEN search_category = replace(search_category," ","+")
	

	'' // 게시판 환경 설정 및 그룹 정보 쿼리

	strSQL = "select * from wiztable_board_config where bid = '" & bid & "' and gid = '" & gid & "' "
	
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	'' // 게시판이 존재하지 않을 경우 ERROR 발생
	If objRs.BOF or objRs.EOF Then call board.ExecError("존재하지 않는 게시판에 접근을 시도하셨습니다.<br><br>게시판 아이디 및 그룹명을 확인하세요", 2 ,"","")

	
	setTitle                = objRs("setTitle")
	setSkin                 = objRs("setSkin")
	sethtmleditor           = objRs("sethtmleditor")
	setHeadFile             = objRs("setHeadFile")
	setHeadMsg              = objRs("setHeadMsg")
	setFootFile             = objRs("setFootFile")
	setFootMsg              = objRs("setFootMsg")
	setSubjectCut           = objRs("setSubjectCut")
	setPageSize             = objRs("setPageSize")
	setPageLink             = objRs("setPageLink")
	setmemberonly           = objRs("setmemberonly")
	setrepleenable          = objRs("setrepleenable")
	setcategoryenable		= objRs("setcategoryenable")
	memberonly_mode         = objRs("memberonly_mode")	
	setadminonly			= objRs("setadminonly")
	setfileenable			= objRs("setfileenable")
	setfilenum				= objRs("setfilenum")
	setlistinview			= objRs("setlistinview")
	setlistorder			= objRs("setlistorder")
	setBoardWidth			= objRs("setBoardWidth")
	setBoardWidthStep		= objRs("setBoardWidthStep")
	setBoardAlign			= objRs("setBoardAlign")
	setmallinclude			= objRs("setmallinclude")
	setsecurityflag			= objRs("setsecurityflag")
	if setsecurityflag <> "" and not isnull(setsecurityflag) then 
		setsecurityflag_arr			= split(setsecurityflag, "|")
		setsecurityiframe		= setsecurityflag_arr(0)
		setsecurityscript		= setsecurityflag_arr(1)
	end if
	if memberonly_mode <> "" and not isnull(memberonly_mode) then 
		memberonly_mode_arr		= split(memberonly_mode, "|")
		memberonly_listmode		= memberonly_mode_arr(0)
		memberonly_viewmode		= memberonly_mode_arr(1)
		memberonly_writemode	= memberonly_mode_arr(2)
	end if	
	Dim skin_path, setUserIP

	skin_path               = "./wizboard/skin/" & setSkin & "/"
	file_path	 			= PATH_URL & "config/wizboard_group/" & gid & "/" & bid & "/attached/"

    db.Dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing : Set board = Nothing
%>
