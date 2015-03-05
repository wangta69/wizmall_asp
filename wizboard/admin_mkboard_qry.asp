<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.board.asp" -->
<%
	Dim gid, bid, setTitle, setSkin, exec, Db_Owner
	Dim setHeadFile,setHeadMsg,setFootFile,setFootMsg,setBoardWidth,setBoardAlign,setSubjectCut,setPageSize
	Dim setBoardWidthStep,setPageLink,setAdminOnly,memberonly_mode
	Dim strSQL,objRs
	Dim db,util,board
	Set util = new utility : Set db = new database : Set board = new boards
	
	gid			= REQUEST("gid")
	bid			= REQUEST("bid")
	setTitle	= util.getReplaceInput(REQUEST("setTitle"), "")
	setSkin		= REQUEST("setSkin")	
	exec		= REQUEST("exec")

	
	IF gid = "" then Call util.js_alert("그룹명을 선택해주세요.","")
	IF bid = "" then Call util.js_alert("게시판아이디를 입력해주세요.","")
	IF setTitle = "" then Call util.js_alert("게시판 게시판 타이틀을 입력해주세요.","")
	IF setSkin = "" then Call util.js_alert("게시판 스킨을 선택해주세요.","")


	IF util.is_Admin = False then Call util.js_close("등급이 맞지 않습니다.","")

	setHeadFile			= util.getReplaceInput(REQUEST("setHeadFile"), "")
	setHeadMsg			= util.getReplaceInput(REQUEST("setHeadMsg"), "")
	setFootFile			= util.getReplaceInput(REQUEST("setFootFile"), "")
	setFootMsg			= util.getReplaceInput(REQUEST("setFootMsg"), "")
	setBoardWidth		= REQUEST("setBoardWidth")
	setBoardAlign		= REQUEST("setBoardAlign")
	setSubjectCut		= REQUEST("setSubjectCut")
	setPageSize			= REQUEST("setPageSize")
	setPageLink			= REQUEST("setPageLink")
	setAdminOnly		= REQUEST("setAdminOnly")
	memberonly_mode		= "11|11|11"
	
	if setBoardWidth		= "" then setBoardWidth = "100"
	if setBoardWidthStep	= "" then setBoardWidthStep = "%"
	if setSubjectCut		= "" then setSubjectCut = "50"
	if setPageSize			= "" then setPageSize = "10"
	if setPageLink			= "" then setPageLink = "10"
	if setAdminOnly			= "" then setAdminOnly = "0"
	
	IF exec = "edit" THEN

	ELSE
		Call board.MakeInitFile(bid,gid,settitle,setskin,True)
		Call util.js_alert("게시판 생성이 완료되었습니다.", "admin.asp?bid=" & bid & "&gid=" & gid)
	END IF
%>
