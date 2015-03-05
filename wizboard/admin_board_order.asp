<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%
	Dim db,strSQL,objRs
	''Dim util
	''Set util = new utility	
	Set db = new database

IF SESSION("admin") = "" THEN
	RESPONSE.WRITE WindowAlert("관리자만 접근이 가능한 페이지 입니다.", "","./")
END IF

flag	= Request("flag")
c_no	= Request("c_no")

	''초기 setorder에 관해 초기화 시켜준다.
	strSQL = "update wiztable_board_config set setorder = intnum where setorder is null or setorder = 0 "
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	'' setorder의 최대값을 구한다.
	strSQL = "select max(setorder) maxsetorder from wiztable_board_config"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	maxsetorder	= objRs("maxsetorder")
	
	'' 현재 c_no에 매칭되는 setorder 값을 구한다.
	strSQL = "select setorder from wiztable_board_config where intnum = " & c_no
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	setorder	= objRs("setorder")
	
	if flag = "up" and setorder <> 1 then
		tvalue = setorder-1
		strSQL = "update wiztable_board_config set setorder = setorder + 1 where setorder = " & tvalue
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

		strSQL = "update wiztable_board_config set setorder = setorder - 1 where intnum = " & c_no
		Call db.ExecSQL(strSQL, Nothing, DbConnect)		
	elseif flag = "down" and setorder < maxsetorder then
		tvalue = setorder+1
		strSQL = "update wiztable_board_config set setorder = setorder - 1 where setorder = " & tvalue
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

		strSQL = "update wiztable_board_config set setorder = setorder + 1 where intnum = " & c_no
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
	end if
''strSQL = "select intnum, setorder from wiztable_board_config order by c_no asc"
	Response.Write("document.location.reload()")

%>
