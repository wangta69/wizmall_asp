<% 
class members '' 클래스 선언합니다..

	private Sub Class_Initialize()
	
	End Sub

	Private Sub Class_Terminate()
	
	End Sub


	Sub DeleteMember(id)
		Dim strSQL, conn
		Set db		= new database
		Set conn = db.BeginTrans(DbConnect)
		On Error Resume Next
		strSQL = "delete from wizmembers where mid = '" & id & "'"
		Call db.ExecSQL(strSQL, Nothing, conn)

		strSQL = "delete from wizmembers_ind where mid = '" & id & "'"
		Call db.ExecSQL(strSQL, Nothing, conn)
		
		strSQL = "delete from wizpoint where id = '" & id & "'"
		Call db.ExecSQL(strSQL, Nothing, conn)
		
        If Err.number <> 0 Then     ''오류 발생 시 이 부분 실행
            db.RollbackTrans conn
			Response.Write("오류발생")
        Else
            db.CommitTrans conn
        End If

		db.Dispose : Set db = Nothing : Set conn = Nothing
	End Sub
	
End Class	
%>

