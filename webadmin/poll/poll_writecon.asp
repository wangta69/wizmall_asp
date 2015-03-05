<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

dim menushow,theme,query,flag,t_name,p_idx_no,p_que,p_ans_qty,p_ans(10)
Dim Loopcnt
	
menushow	= request("menushow")
theme		= request("theme")
query		= request("query")
flag		= request("flag")
t_name		= "wizpoll"
p_idx_no	= request("p_idx_no")
p_que		= request("p_que")
p_ans_qty	= int(request("p_ans_qty"))

	
for Loopcnt=0 to p_ans_qty
	p_ans(Loopcnt) = request("p_ans("&Loopcnt&")")
next

if query = "qin" then	
	strSQL = "insert into " & t_name & " (flag, p_que,p_ans_qty, p_ans1,p_ans2,p_ans3,p_ans4,p_ans5,p_ans6,p_ans7,p_ans8,p_ans9,p_ans10) values('"
	strSQL = strSQL & flag        & "','"
	strSQL = strSQL & p_que       & "',"
	strSQL = strSQL & p_ans_qty   & ",'"
	strSQL = strSQL & p_ans(0)    & "','"
	strSQL = strSQL & p_ans(1)    & "','"
	strSQL = strSQL & p_ans(2)    & "','"
	strSQL = strSQL & p_ans(3)    & "','"
	strSQL = strSQL & p_ans(4)    & "','"
	strSQL = strSQL & p_ans(5)    & "','"
	strSQL = strSQL & p_ans(6)    & "','"
	strSQL = strSQL & p_ans(7)    & "','"
	strSQL = strSQL & p_ans(8)    & "','"
	strSQL = strSQL & p_ans(9)    & "');"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL = "select max(p_idx_no) from wizpoll;"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)	
	
	strSQL = "insert into wizpoll_value (pv_p_no) values(" & objRs(0) & ");"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	response.redirect "../main.asp?menushow="&menushow&"&theme=poll/poll_list"
	
elseif query = "qup" then

	strSQL = "update " & t_name & " set "
	strSQL = strSQL & "flag='"     & flag      & "',"
	strSQL = strSQL & "p_que='"     & p_que      & "',"
	strSQL = strSQL & "p_ans_qty="  & p_ans_qty  & ","
	for Loopcnt=0 to p_ans_qty
	    if Loopcnt < p_ans_qty then 
			strSQL = strSQL & "p_ans" & Loopcnt+1 & "='"    & p_ans(Loopcnt)   & "',"
	    else 
        	strSQL = strSQL & "p_ans" & Loopcnt+1 & "='"    & p_ans(Loopcnt)   & "' "
 	    end if 
	next
	strSQL = strSQL & " where p_idx_no=" & p_idx_no & ";"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	response.redirect "../main.asp?menushow="&menushow&"&theme=poll/poll_list"
	
end if

db.Dispose : set db = Nothing : Set objRs = Nothing : Set util = Nothing
	
%>
