<%
Function write_success(noti)
    '//결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
    ''write_log "C:\Temp\write_success.log", noti
	strSQL = "update wizbuyer set processing = '2', pay_date=getdate() where codevalue='"&oid&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
    write_success = true
End Function

Function write_failure(noti)
    '//결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
   '' write_log "C:\Temp\write_failure.log", noti  
    write_failure = true
End Function

Function write_hasherr(noti)
    '//결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
  ''  write_log "C:\Temp\write_hasherr.log", noti
    write_hasherr = true
End Function

Function write_log(file, noti)
    Dim fso, ofile, slog

    slog = ""
    slog = slog & "메세지타입:" & noti(0) & chr(13)&chr(10) 
    slog = slog & "응답코드:" & noti(1) & chr(13)&chr(10)
    slog = slog & "응답메세지:" & noti(2) & chr(13)&chr(10)
    slog = slog & "거래아이디:" & noti(3) & chr(13)&chr(10)
    slog = slog & "상점아이디:" & noti(4) & chr(13)&chr(10)
    slog = slog & "주문번호:" & noti(5) & chr(13)&chr(10)
    slog = slog & "금액:" & noti(6) & chr(13)&chr(10)
    slog = slog & "결제수단:" & noti(8) & chr(13)&chr(10)
    slog = slog & "결제일시:" & noti(9) & chr(13)&chr(10)
    slog = slog & "구매자명:" & noti(10) & chr(13)&chr(10)
    slog = slog & "상품정보:" & noti(11) & chr(13)&chr(10)

    
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if fso.fileExists(file) then    
        Set ofile = fso.OpenTextFile(file, 8, True)
    else
        Set ofile = fso.CreateTextFile(file, True)
    end if
    
    ofile.Writeline slog

    ofile.close
    Set ofile = Nothing
    Set fso = Nothing
End Function

%>
