<!-- #include file = "../../../config/db_connect.asp"-->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.board.asp" -->
<%
	Dim db,strSQL,objRs
	''Dim util
	''Set util = new utility	
	Set db = new database

response.buffer=true
cp_type=trim(Request("cp_type"))

if cp_type="input" then

	cc_title=trim(Request("title"))
	cc_title=Replace(cc_title ,"'" ,"''" )

	cc_position=trim(Request("position"))
	cc_position=Replace(cc_position,"'","'")

	cc_kind=Request("kind")
	cc_open=Request("open")
	cc_year=Request("startYear")
	cc_month=Request("startMonth")
	cc_day=Request("startDay")

	cc_sdate=cdate(cc_year&"-"&cc_month&"-"&cc_day)

	cc_shour=Request("startHour")
	if len(cstr(cc_shour))=1 then
	cc_shour = "0"& cstr(cc_shour)
	end if
	
	cc_smin=Request("startMin")

	cc_ehour=Request("endHour")
	if len(cstr(cc_ehour))=1 then
	cc_ehour = "0"& cstr(cc_ehour)
	end if
	
	cc_emin=Request("endMin")

	cc_desc=trim(Request("desc"))
	cc_desc=Replace(cc_desc,"'","''")

	cc_reid=Request("reid")
	cc_retype=Request("retype")
	cc_reyear=Request("reYear")
	cc_remonth=Request("reMonth")
	cc_reday=Request("reday")

	cc_edate=cdate(cc_reyear&"-"&cc_remonth&"-"&cc_reday)

	cc_dtype=Request("cc_dtype")
	if cc_dtype="" then
		cc_dtype="1"
	elseif cc_dtype="2" then
		cc_shour="00"
		cc_smin="00"
		cc_ehour="23"
		cc_emin="59"
	elseif cc_dtype="3" then
		cc_sdate=cdate(cc_year&"-"&cc_month&"-1")
		cc_shour="00"
		cc_smin="00"
		cc_ehour="23"
		cc_emin="59"
		cc_reid="0"
		cc_retype="0"
	end if

	strSQL = "Insert Into Diary (cc_m_id,cc_Title,cc_Position,cc_Kind,cc_Open,cc_sDate,"
	strSQL=strSQL&" cc_sHour,cc_sMin,cc_eHour,cc_eMin,cc_Desc,cc_Reid,cc_ReType,cc_eDate,cc_dType) Values ( "
	
	strSQL=strSQL&" '"& User_ID &"' , "
	strSQL=strSQL&" '"& cc_title &"' , "
	strSQL=strSQL&" '"& cc_position &"' , "
	strSQL=strSQL&" '"& cc_kind &"' , "
	strSQL=strSQL&" '"& cc_open &"' , "
	strSQL=strSQL&" '"& cc_sdate &"' , "
	strSQL=strSQL&" '"& cc_shour &"' , "
	strSQL=strSQL&" '"& cc_smin &"' , "
	strSQL=strSQL&" '"& cc_ehour &"' , "
	strSQL=strSQL&" '"& cc_emin &"' , "
	strSQL=strSQL&" '"& cc_desc &"' , "
	strSQL=strSQL&" '"& cc_reid &"' , "
	strSQL=strSQL&" '"& cc_retype &"' , "
	strSQL=strSQL&" '"& cc_edate &"' , "
	strSQL=strSQL&" '"& cc_dtype &"'  "
	strSQL=strSQL&" ) "
	Call db.ExecSQL(strSQL, Nothing, DbConnect)

elseIf cp_type="edit" then

	cc_id=Request("cc_id")

	cc_title=trim(Request("title"))
	cc_title=Replace(cc_title ,"'" ,"''" )

	cc_position=trim(Request("position"))
	cc_position=Replace(cc_position,"'","'")

	cc_kind=Request("kind")
	cc_open=Request("open")
	cc_year=Request("startYear")
	cc_month=Request("startMonth")
	cc_day=Request("startDay")
	cc_sdate=cc_year&"-"&cc_month&"-"&cc_day
'	cc_sdate=datevalue(cc_sdate)&" "&timevalue(cc_sdate)

	cc_shour=Request("startHour")
	if len(cstr(cc_shour))=1 then
	cc_shour = "0"& cstr(cc_shour)
	end if
	
	cc_smin=Request("startMin")
	If cc_smin=0 or cc_smin=5 Then
		cc_smin="0"&cc_smin	
	End if
	

	cc_ehour=Request("endHour")
	if len(cstr(cc_ehour))=1 then
	cc_ehour="0"& cstr(cc_ehour)
	end if
	
	cc_emin=Request("endMin")
	If cc_emin=0 or cc_emin=5 Then
		cc_emin="0"&cc_emin	
	End if
	cc_desc=trim(Request("desc"))
	cc_desc=Replace(cc_desc,"'","''")

	cc_reid=Request("reid")
	cc_retype=Request("retype")
	cc_reyear=Request("reYear")
	cc_remonth=Request("reMonth")
	cc_reday=Request("reday")
	cc_edate=cc_reyear&"-"&cc_remonth&"-"&cc_reday
'	cc_edate=datevalue(cc_edate)&" "&timevalue(cc_edate)
	cc_dtype=Request("cc_dtype")
	
	if cc_dtype="" then
		cc_dtype="1"
	elseif cc_dtype="2" then
		cc_shour="00"
		cc_smin="00"
		cc_ehour="23"
		cc_emin="59"
	elseif cc_dtype="3" then
		cc_sdate=cdate(cc_year&"-"&cc_month&"-1")
		cc_shour="00"
		cc_smin="00"
		cc_ehour="23"
		cc_emin="59"
		cc_retype="0"
	end if

	strSQL="Update  Diary  Set "
	strSQL=strSQL&" cc_title = '"& cc_title  &"', "
	strSQL=strSQL&" cc_position= '"& cc_position &"', "
	strSQL=strSQL&" cc_kind = '"& cc_kind &"', "
	strSQL=strSQL&" cc_open = '"& cc_open &"', "
	strSQL=strSQL&" cc_sdate = convert(datetime,'"&cc_sdate&"',120), "
	strSQL=strSQL&" cc_shour = '"& cc_shour &"', "
	strSQL=strSQL&" cc_smin = '"& cc_smin &"', "
	strSQL=strSQL&" cc_ehour = '"& cc_ehour &"', "
	strSQL=strSQL&" cc_emin = '"& cc_emin &"', "
	strSQL=strSQL&" cc_desc = '"& cc_desc &"', "
	strSQL=strSQL&" cc_reid = '"& cc_reid &"', "
	strSQL=strSQL&" cc_retype = '"& cc_retype &"', "
	strSQL=strSQL&" cc_edate = convert(datetime,'"& cc_edate &"',120), " 
	strSQL=strSQL&" cc_dtype = '"&cc_dtype&"'  " 
	strSQL=strSQL&"  Where cc_id="&cc_id
	Call db.ExecSQL(strSQL, Nothing, DbConnect)

elseif cp_type="del" then
	
	cc_id=Request("cc_id")

	strSQL="Delete From  Diary  Where cc_id="&cc_id
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
end if
response.redirect "schedule_main.asp"

%>
