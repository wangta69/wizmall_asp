<% Option Explicit %>
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.board.asp" -->

<%
	Dim util, board, db
	Set util = new utility : Set db = new database : Set board = new boards

	Dim uid, bid, gid
	Dim filename, pds_dir, strSQL, objRs

	uid			= REQUEST("down_num")
	bid			= REQUEST("bid")
	gid			= REQUEST("gid")
	filename	= request("file")
	Dim table_name : table_name =  "wizboard_" & bid & "_" & gid 


	'다운권한 체크(한번더 체크 하여 보안을 강화)
	Dim option_secret :  option_secret = board.getContentOptionSecret(table_name)
	Dim bd_num : bd_num  = board.getParentbdnum(uid)
	if option_secret = 1 and SESSION("secret_session") <> bid & "_" & gid & "_" & bd_num and util.is_Admin() = False then
		Call util.js_alert("잘못된 접근입니다.","")
	Else
		pds_dir		= PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\attached\"
		Call util.fileDown(filename, pds_dir)
		Set util = Nothing	
	end If
		
	db.Dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing : Set board = Nothing

%>
