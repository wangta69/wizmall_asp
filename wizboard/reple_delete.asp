<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file = "../lib/cfg.board.asp" -->
<%
Set util = new utility	
Set db = new database
Set board = new boards


	Dim reple_uid

	uid				= REQUEST("uid")
	reple_uid		= REQUEST("reple_uid")
	bid				= REQUEST("bid")
	gid				= REQUEST("gid")
	page			= REQUEST("page")
	category		= REQUEST("category")
	adminmode		= REQUEST("adminmode")
	
	if session("admin") = "super" then 
		CALL COMMENT_DELETE_DONE
	else 
		strSQL = "select * from wizboard_" & bid & "_" & gid & "_reply where uid = '" & reple_uid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	
		IF objRs("pass") = REQUEST("passwd") THEN
			CALL COMMENT_DELETE_DONE
		ELSE
			RESPONSE.WRITE "<script language=javascript>" & vbcrlf
			RESPONSE.WRITE "alert('비밀번호가 일치하지 않습니다.');" & vbcrlf
			RESPONSE.WRITE "history.back(-1);" & vbcrlf
			RESPONSE.WRITE "</script>" & vbcrlf
		END IF
	end if

	SUB COMMENT_DELETE_DONE
		strSQL = "delete from wizboard_" & bid & "_" & gid & "_reply where uid = '" & reple_uid & "'"
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

		strSQL = "update wizboard_" & bid & "_" & gid &""
		strSQL = strSQL & " set replecount = replecount - 1"
		strSQL = strSQL & " where uid = " & uid
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		RESPONSE.WRITE "<script language=javascript>" & vbcrlf
		RESPONSE.WRITE "opener.location.replace('../wizboard.asp?bmode=view&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&page="& page &"&category="& category &"&search_category="&search_category&"&search_word="&search_word&"&adminmode="&adminmode&"');" & vbcrlf
		RESPONSE.WRITE "self.close();" & vbcrlf
		RESPONSE.WRITE "</script>" & vbcrlf
	END SUB
	
	SET objRs =NOTHING
%>
