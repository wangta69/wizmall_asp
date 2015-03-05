<!--METADATA TYPE= "typelib"  NAME= "ADODB Type Library"
      FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"  -->
<%
''DBhelper
''http://www.taeyo.pe.kr/Lecture/20_Tips/DBHelper.asp
''http://blog.naver.com/PostView.nhn?blogId=saltynut&logNo=120030862678

	Class database
		Private DefaultConnString
		Private DefaultConnection
		Private cmd, params, i
		private sub Class_Initialize()
			Set DefaultConnection = Nothing
		End Sub
	
    '---------------------------------------------------
    ' SP를 실행하고, RecordSet을 반환한다.
	' Class_Initialize 에 정의된것을 사용할 경우 아래와 같이 Nothing
	' Public Function ExecSPReturnRS(spName, params, Nothing)
    '---------------------------------------------------
	Public Function ExecSPReturnRS(spName, params, connectionString)

		Dim rs, cmd, i
		If IsObject(connectionString) Then
			If connectionString is Nothing Then
				If DefaultConnection is Nothing Then
					Set DefaultConnection = CreateObject("ADODB.Connection")
					DefaultConnection.Open DefaultConnString        
				End If      
				Set connectionString = DefaultConnection
			End If
		End If

		Set rs = CreateObject("ADODB.RecordSet")
		Set cmd = CreateObject("ADODB.Command")

		cmd.ActiveConnection = connectionString
		cmd.CommandText = spName
		cmd.CommandType = adCmdStoredProc
		Set cmd = collectParams(cmd, params)
		''cmd.Parameters.Refresh
		On Error Resume Next
		rs.CursorLocation = adUseClient
		rs.Open cmd, ,adOpenStatic, adLockReadOnly
		If Err.number <> 0 Then  Call ErrMsg(strSP)

		''Response.Write("<br>cmd.Parameters.Count:"&cmd.Parameters.Count&"<br>")
		For i = 0 To cmd.Parameters.Count - 1	

			If cmd.Parameters(i).Direction = adParamOutput OR cmd.Parameters(i).Direction = adParamInputOutput OR cmd.Parameters(i).Direction = adParamReturnValue Then
				If IsObject(params) Then	
					If params is Nothing Then
						Exit For	        
					End If	      
				Else
					params(i)(4) = cmd.Parameters(i).Value
				End If
			End If
		Next
		
		Set cmd.ActiveConnection = Nothing
		Set cmd = Nothing

		If rs.State = adStateClosed Then
			Set rs.Source = Nothing
		End If

		Set rs.ActiveConnection = Nothing
		Set ExecSPReturnRS = rs
		''Response.Write("<br>rs:"&rs(1)&"<br>")
	End Function

    '---------------------------------------------------
    ' SQL Query를 실행하고, RecordSet을 반환한다.
    '---------------------------------------------------
    Public Function ExecSQLReturnRS(strSQL, params, connectionString)
		Dim rs, cmd
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
      
	    Set rs = CreateObject("ADODB.RecordSet")
	    Set cmd = CreateObject("ADODB.Command")

	    cmd.ActiveConnection = connectionString
	    cmd.CommandText = strSQL
	    cmd.CommandType = adCmdText
	    Set cmd = collectParams(cmd, params)	
    	
		On Error Resume Next
	    rs.CursorLocation = adUseClient
	    rs.Open cmd, , adOpenStatic, adLockReadOnly
    	If Err.number <> 0 Then  Call ErrMsg(strSQL)

	    Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing	
		If rs.State = adStateClosed Then
			Set rs.Source = Nothing
		End If
	    Set rs.ActiveConnection = Nothing
    	
	    Set ExecSQLReturnRS = rs
    End Function

    '---------------------------------------------------
    ' SP를 실행한다.(RecordSet 반환없음)
    '---------------------------------------------------
    Public Sub ExecSP(strSP,params,connectionString)

      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
	    Set cmd = CreateObject("ADODB.Command")
		On Error Resume Next
	    cmd.ActiveConnection = connectionString
		cmd.CommandText = strSP
		cmd.CommandType = adCmdStoredProc
	    Set cmd = collectParams(cmd, params)
		cmd.Execute , , adExecuteNoRecords
	    If Err.number <> 0 Then  Call ErrMsg(strSP)

	    For i = 0 To cmd.Parameters.Count - 1	  
	      If cmd.Parameters(i).Direction = adParamOutput OR cmd.Parameters(i).Direction = adParamInputOutput OR cmd.Parameters(i).Direction = adParamReturnValue Then
	        If IsObject(params) Then	    
	          If params is Nothing Then
	            Exit For	        
	          End If	      
	        Else
	        
	          params(i)(4) = cmd.Parameters(i).Value
	        End If
	      End If
	    Next	

	    Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing
    End Sub

    '---------------------------------------------------
    ' SP를 실행한다.(RecordSet 반환없음)
    '---------------------------------------------------
    Public Sub ExecSQL(strSQL,params,connectionString)      
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
      
	    Set cmd = CreateObject("ADODB.Command")

	    cmd.ActiveConnection = connectionString
	    cmd.CommandText = strSQL
	    cmd.CommandType = adCmdText
	    Set cmd = collectParams(cmd, params)

		On Error Resume Next

	    cmd.Execute , , adExecuteNoRecords
		
		If Err.number <> 0 Then  Call ErrMsg(strSQL)
	    
		Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing
    End Sub

	'---------------------------------------------------
	' 트랜잭션을 시작하고, Connetion 개체를 반환한다.
	'---------------------------------------------------
	Public Function BeginTrans(connectionString)
		Dim conn
		If IsObject(connectionString) Then
			If connectionString is Nothing Then
				connectionString = DefaultConnString
			End If
		End If

		Set conn = Server.CreateObject("ADODB.Connection")
		conn.Open connectionString
		conn.BeginTrans
		Set BeginTrans = conn
	End Function

    '---------------------------------------------------
    ' 활성화된 트랜잭션을 커밋한다.
    '---------------------------------------------------
    Public Sub CommitTrans(connectionObj)
      If Not connectionObj Is Nothing Then
        connectionObj.CommitTrans
        connectionObj.Close
        Set ConnectionObj = Nothing
      End If
    End Sub

    '---------------------------------------------------
    ' 활성화된 트랜잭션을 롤백한다.
    '---------------------------------------------------
    Public Sub RollbackTrans(connectionObj)
      If Not connectionObj Is Nothing Then
        connectionObj.RollbackTrans
        connectionObj.Close
        Set ConnectionObj = Nothing
      End If
    End Sub

    '---------------------------------------------------
    ' 배열로 매개변수를 만든다.
    '---------------------------------------------------
    Public Function MakeParam(PName,PType,PDirection,PSize,PValue)
		If PSize = 0 Then PSize = 1 '--- 에러 방지
      MakeParam = Array(PName, PType, PDirection, PSize, PValue)
    End Function

    '---------------------------------------------------
    ' 매개변수 배열 내에서 지정된 이름의 매개변수 값을 반환한다.
    '---------------------------------------------------		
    Public Function GetValue(params, paramName)
		Dim param
      For Each param in params
        If param(0) = paramName Then
          GetValue = param(4)
          Exit Function
        End If
      Next
    End Function

    Public Sub Dispose
		if (Not DefaultConnection is Nothing) Then 
			if (DefaultConnection.State = adStateOpen) Then DefaultConnection.Close
			Set DefaultConnection = Nothing
		End if
    End Sub

    '---------------------------------------------------------------------------
    '---------------------------------------------------------------------------
    Private Function collectParams(cmd,argparams)
		Dim i, l, v, u
	    If VarType(argparams) = 8192 or VarType(argparams) = 8204 or VarType(argparams) = 8209 then 
		    params = argparams
		    For i = LBound(params) To UBound(params)
			    l = LBound(params(i))
			    u = UBound(params(i))
			    ' Check for nulls.
			    If u - l = 4 Then
				    If VarType(params(i)(4)) = vbString Then
					    If params(i)(4) = "" Then
						    v = Null
					    Else
						    v = params(i)(4)
					    End If
				    Else
					    v = params(i)(4)
				    End If
					''Response.Write(params(i)(0)&", "&params(i)(1)&", "&params(i)(2)&", "& params(i)(3)&", "& v & "<br>")
				    cmd.Parameters.Append cmd.CreateParameter(params(i)(0), params(i)(1), params(i)(2), params(i)(3), v)
					
			    End If
		    Next

		    Set collectParams = cmd
		    Exit Function
	    Else
		    Set collectParams = cmd
	    End If
    End Function

	Sub ErrMsg(str)
	
		
		Response.Write "Number : " & Err.Number & "<br>"
		Response.Write "<b3>" & Err.Source & "<hr noshade></h3>"
		Response.Write "Description : " & Err.Description & "<br>"	
		Response.Write "SQL : " & str & "<br>"
		Response.End()
		If params <> "" Then
		 For i = LBound(params) To UBound(params)
			    l = LBound(params(i))
			    u = UBound(params(i))
			    If u - l = 4 Then
				    If VarType(params(i)(4)) = vbString Then
					    If params(i)(4) = "" Then  v = Null Else  v = params(i)(4)
				    Else
					    v = params(i)(4)
				    End If
					''Response.Write(params(i)(0)&", "&params(i)(1)&", "&params(i)(2)&", "& params(i)(3)&", "& v & "<br>")
			    End If
		    Next
		End If
		''Response.Write "ASPCode : " & Err.ASPCode & "<br>"
		''Response.Write "Category : " & Err.Category & "<br>"
		''Response.Write "File : " & Err.File & "<br>"
		''Response.Write "Line : " & Err.Line & "<br>"
		''Response.Write "Column : " & Err.Column & "<br>"
		''Response.Write "ASPDescription : " & Err.ASPDescription & "<br>"
		Response.End()
	End Sub

	End Class
%>
