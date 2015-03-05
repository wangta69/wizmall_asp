<SCRIPT LANGUAGE="VBScript" RUNAT="Server">


Sub Application_OnStart
	Application("nowCount") = 0
End Sub


Sub Application_OnEnd

End Sub


Sub Session_OnStart

	dim theTable
	theTable = "visit_COUNTER"

    Application.Lock
        Application("nowCount") = Application("nowCount") + 1
    Application.UnLock
   
	dim dbConnect, db
    dbConnect = "Provider=SQLOLEDB.1;Data Source=localhost;Initial catalog=사용자DataBase이름;User id=사용자아이디;Password=사용자패스워드;"
    set db = server.createObject("ADODB.Connection") 
    db.open dbConnect 

	dim temp    
    temp = request.ServerVariables("HTTP_USER_AGENT")
    temp = split(temp,";")

	dim vBrowser, vOS
    if ubound(temp) > 1 then
		vBrowser = temp(1)
		vOS = temp(2)
        vOS = replace(vOS,")","")

		vBrowser = trim(vBrowser)
		vOS = trim(vOS)
		vBrowser = replace(vBrowser,"'","''")
		vOS = replace(vOS,"'","''")
    end if

	dim vReferer, vIP, vTarget, vDW	
    vReferer = request.ServerVariables("HTTP_REFERER")
	vIP = request.ServerVariables("REMOTE_ADDR")
	vTarget = request.ServerVariables("SCRIPT_NAME") & "?" & request.ServerVariables("QUERY_STRING")
	vDW = weekday(date)

	dim vSeason
	select case month(date)
	case 3,4,5 vSeason = 1
	case 6,7,8 vSeason = 2
	case 9,10,11 vSeason = 3
	case 12,1,2 vSeason = 4
	end select

	dim sql
	sql = "insert into "&theTable&"(vIP,vYY,vMM,vDD,vHH,vMT,vDW,vSeason,vBrowser,vOS,vReferer,vTarget) "
	sql = sql & "values('"&vIP&"',"&year(date)&","&month(date)&","&day(date)&","&hour(now)&","&minute(now)&","&vDW&","&vSeason&",'"&vBrowser&"','"&vOS&"','"&vReferer&"','"&vTarget&"')"
	db.execute sql

	db.close()
	set db = nothing

End Sub


Sub Session_OnEnd

	Application.Lock 
		Application("nowCount")=Application("nowCount") - 1
	Application.UnLock

End Sub


</script>
