<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
Dim uid: uid					= Request("uid")
Dim pskinname, exe_file

strSQL = "select pskinname from wizpopup where uid=" & uid
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

pskinname		= objRs("pskinname")

if pskinname = "" then pskinname = "default"

exe_file =  "./" & pskinname & "/index.asp"

SERVER.EXECUTE(exe_file)
%>