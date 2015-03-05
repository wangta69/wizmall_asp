<% 
class admin_member '' 클래스 선언합니다..
	Public arg1, arg2 ''외부인수값 활용을 위해 광범위하게 정의

	Sub makeFile_memberagreementInfo()
		Dim FILE, FSO, ForWriting
		FILE = PATH_SYSTEM & "config\memberagreement_info.asp"
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(FILE) THEN FSO.DeleteFile(FILE)
		if cfg.Item("lan") = "utf-8" then
			SET FILE = FSO.createTextFile(FILE, ForWriting, True)
		else 
			SET FILE = FSO.createTextFile(FILE, ForWriting)
		end if
		
		FILE.WRITELINE(member_agreement)
		FILE.CLOSE
		Set FSO	= Nothing : Set FILE = Nothing
		On Error Resume Next
	End Sub	
 
	Sub makeFile_useagreementInfo()
		Dim FILE, FSO, ForWriting
		FILE = PATH_SYSTEM & "config\useagreement_info.asp"
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(FILE) THEN FSO.DeleteFile(FILE)
		if cfg.Item("lan") = "utf-8" then
			SET FILE = FSO.createTextFile(FILE, ForWriting, True)
		else 
			SET FILE = FSO.createTextFile(FILE, ForWriting)
		end if
		
		FILE.WRITELINE(use_agreement)
		FILE.CLOSE
		Set FSO	= Nothing : Set FILE = Nothing
		On Error Resume Next
	End Sub	
	
	Sub makeFile_privacyagreementInfo()
		Dim FILE, FSO, ForWriting
		FILE = PATH_SYSTEM & "config\privacyagreement_info.asp"
		SET FSO   = Server.CreateObject("Scripting.FileSystemObject")
		IF FSO.fileExists(FILE) THEN FSO.DeleteFile(FILE)
		if cfg.Item("lan") = "utf-8" then
			SET FILE = FSO.createTextFile(FILE, ForWriting, True)
		else 
			SET FILE = FSO.createTextFile(FILE, ForWriting)
		end if
		
		FILE.WRITELINE(privacy_agreement)
		FILE.CLOSE
		Set FSO	= Nothing : Set FILE = Nothing
		On Error Resume Next
	End Sub	
		
End Class	
%>
