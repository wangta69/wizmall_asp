<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%

	IF SESSION("user_info") = "" Then
	 
		RESPONSE.REDIRECT "login.asp"
	Else

		''IF SESSION("admin") = "" THEN
		''	Set objRs	= db.ExecSQLReturnRS("SELECT [strLoginID] FROM [wiztable_main_board] ", Nothing, DbConnect)
		''	IF RS.EOF THEN
		''		RESPONSE.REDIRECT "login.asp"
		''''	ELSE
		''		SESSION("admin") = "board"
		''		RESPONSE.REDIRECT "admin.asp"
		''	END IF
		''ELSE
			RESPONSE.REDIRECT "admin.asp"
		''END IF
	END IF

	SET objRs = NOTHING
%>
