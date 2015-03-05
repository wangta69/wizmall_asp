<%
Response.AddHeader "Pragma", "No-Cache"
Response.Expires = -1000
Response.CacheControl = "Private"
Server.ScriptTimeOut = 2000

Dim cfg
Set cfg = Server.CreateObject("Scripting.Dictionary")

cfg.Add "ver","4.1"
''cfg.Add "lan","euc-kr"
''cfg.Add "CodePage","949" 

''cfg.Add "lan","Shift_JIS"
''cfg.Add "CodePage","932" 

cfg.Add "lan","utf-8"
cfg.Add "CodePage","65001"
Response.codepage	= cfg.Item("CodePage") 
Response.Charset		= cfg.Item("lan") 

''session("user_info")	= objRs("mid")&"|"&objRs("mpwd")&"|"&objRs("mname")&"|"&objRs("mgrade")&"|"&objRs("mpoint")
if session("user_info") <> "" Then
	Dim user_info_sp, user_id, user_pwd, user_name, user_grade, user_point_str, user_point
	user_info_sp = split(session("user_info"), "|")
	user_id			= user_info_sp(0)
	user_pwd		= user_info_sp(1)
	user_name		= user_info_sp(2)
	user_grade		= user_info_sp(3)
	user_point_str	= user_info_sp(4)
	if user_point_str = "" then user_point_str = "0"
	user_point = Cint(user_point_str)
end if
	
''2.3 update

''web knight 관련 호환성을 높임

''기존 변수 변경
''mode -> smode
''query -> qry
''delete -> qde
''insert -> qin
''delete -> qup
''09.02.03
''wizbard reple table에 [ip]필드 추가
''categoryfield확장
'' 아래는 프로그램 충돌을 방지하기 위해 앞으로 진행예정
''보드의 option 필드 -> op_flag
''모든 필드이 name -> username 
''변수명통일 list->objRs , strSQL->strSQL

%>