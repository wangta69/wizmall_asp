<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.board.asp" -->
<%
Set db		= new database
Set board	= new boards
Set util	= new	utility

strSQL		= "SELECT TOP 1 id, pass FROM " & table_name & " WHERE [uid]=" & uid
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	IF objRs("pass") = REQUEST("check_pwd") THEN 
		CALL board.BOARD_DELETE_DONE	
	Else 
		SELECT CASE board.checkDeleteUser(user_grade, user_id, objRs("id"))
		CASE 1
			IF objRs("pass") = REQUEST("check_pwd") THEN
				CALL board.BOARD_DELETE_DONE
			ELSE
				IF REQUEST("check_pwd") = "" THEN
					RESPONSE.REDIRECT "../wizboard.asp?bmode=qde&bid=" & bid & "&gid=" & gid & "&uid=" & uid & "&page=" & page & "&search_category=" & search_category & "&search_word=" & search_word & "&category=" & category 
				Else
					Call util.js_alert("비밀번호가 일치하지 않습니다.","")
				END IF
			END IF
		CASE 2
			Call util.js_alert("본인의 게시글만 삭제가 가능합니다.","")
		CASE 3
			CALL board.BOARD_DELETE_DONE	
		END SELECT
	End If

db.Dispose : Set db	= Nothing : Set objRs = Nothing : Set util	= Nothing : Set board = Nothing

Response.Redirect("../wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&adminmode=" & adminmode & "&page=" & page & "&search_category=" & search_category & "&search_title=" & search_title & "&search_keyword=" & search_keyword & "&category=" & category )
Response.End()
%>
