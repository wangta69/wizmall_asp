<%@LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<%
Dim table_name
Dim qry,uid,iid,compname,name,juminno,juminno1,juminno2,tel,tel1,tel2,tel3,hand,hand1,hand2,hand3,fax,fax1,fax2,fax3
Dim email,email_1,email_2,url,zip,zip1,zip2,address1,address2,subject,contents,contents1,contents2,option1,option2,option3,frompage



Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database
Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename, fileinfo, filename


table_name = "wizinquire" 
DefaultPath = PATH_SYSTEM & "config\wizinquire\"

' // 컴포넌트 지정
attached_count = util.SetUploadComponent



'iid,compname,name,juminno,tel,hand,fax,email,url,zip,address1,address2,subject,contents,contents1,contents2,option1,option2,option3,attached,wdate	
qry			= UPLOAD("qry")
uid			= UPLOAD("uid")
iid			= UPLOAD("iid")
compname	= UPLOAD("compname")
name		= UPLOAD("name")
juminno		= UPLOAD("juminno1")&"-"&UPLOAD("juminno2")
tel1		= UPLOAD("tel1")
tel2		= UPLOAD("tel2")
tel3		= UPLOAD("tel3")
tel			= UPLOAD("tel")		: If tel = "" then tel = tel1 & "-" & tel2 & "-" & tel3
hand1		= UPLOAD("hand1")
hand2		= UPLOAD("hand2")
hand3		= UPLOAD("hand3")
hand		= UPLOAD("hand")	: If hand = "" then hand = hand1 & "-" & hand2 & "-" & hand3
fax1		= UPLOAD("fax1")
fax2		= UPLOAD("fax2")
fax3		= UPLOAD("fax3")
fax			= UPLOAD("fax")		: If fax = "" then fax = fax1 & "-" & fax2 & "-" & fax3


email_1		= UPLOAD("email_1")
email_2		= UPLOAD("email_2")
email		= UPLOAD("email")	: if email = "" then email = email_1 & "@" & email_2
url			= UPLOAD("url")
''zip			= UPLOAD("zip")
zip			= UPLOAD("zip1") & "-" & UPLOAD("zip2")
address1	= UPLOAD("address1")
address2	= UPLOAD("address2")
subject		=  trim(replace(UPLOAD("subject"),"'","&#39;"))
contents	= UPLOAD("contents")
contents1	= UPLOAD("contents1")
contents2	= UPLOAD("contents2")
option1		= UPLOAD("option1")
option2		= UPLOAD("option2")
option3		= UPLOAD("option3")
frompage	= UPLOAD("frompage")
	
	
		
' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
	
' // 체크가 모두 끝나면 파일 저장한다.
filename	= util.FileUploadModule(UPLOAD("attached"), "", "", "gif,jpeg,jpg,bmp,png,psd,ai,hwp,doc,xls,xlsx,pdf,ppt,pptx,zip,alz,avi,mepg,wmv")



If uid <> "" Then qry = "qup"
	SELECT CASE qry
	CASE "qin"
		strSQL = "INSERT INTO " & table_name & " ("
		strSQL = strSQL & "iid,compname,name,juminno,tel,hand,fax,email,url,zip,address1,address2,subject,contents,contents1,contents2,option1,option2,option3,attached,wdate"
		strSQL = strSQL & ") VALUES (" 
		strSQL = strSQL & "'" & iid & "','" & compname & "','" & name & "','" & juminno & "','" & tel & "','" & hand & "','" & fax & "','" & email & "','" & url & "','" & zip & "','" & address1 & "','" & address2 & "','" & subject & "','" & contents & "','" & contents1 & "','" & contents2 & "',"
		strSQL = strSQL & "'" & option1 & "','" & option2 & "','" & option3 & "','" & filename & "',getdate()"
		'Response.Write(strSQL & "<br>")
		strSQL = strSQL & ") "
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		''메일 발송
		Dim mail_to, mail_from, mail_subject, mail_content, mail_attached
		mail_to			= ""''
		mail_from		= ""''
		mail_subject	= "온라인의뢰가 작성되었습니다."
		mail_content	= "온라인의뢰가 작성되었습니다. <br/> 자세한 내용은 관리자단의 온라인의뢰를 참조해주시기 바랍니다."
		''Call util.fnc_sendmail(mail_to, mail_from, mail_subject, mail_content, mail_attached)
		''Response.End()

		if frompage = "popup" then
			Response.Write("<script>window.alert('성공적으로 접수되었습니다.');self.close();</script>")
			Response.End()
		else
			Response.Write("<script>window.alert('성공적으로 접수되었습니다.');location.replace('../');</script>")
			Response.End()
		end if
	CASE "qup"
		strSQL = "update " & table_name & " set " &_
		"compname	= '" & compname & "'" &_
		",name		= '" & name & "'" &_
		",juminno	= '" & juminno & "'" &_
		",tel		= '" & tel & "'" &_
		",hand		= '" & hand & "'" &_
		",fax		= '" & fax & "'" &_
		",email		= '" & email & "'" &_
		",url		= '" & url & "'" &_
		",zip		= '" & zip & "'" &_
		",address1	= '" & address1 & "'" &_
		",address2	= '" & address2 & "'" &_
		",subject	= '" & subject & "'" &_
		",contents	= '" & contents & "'" &_
		",contents1	= '" & contents1 & "'" &_
		",contents2	= '" & contents2 & "'" &_
		",option1	= '" & option1 & "'" &_
		",option2	= '" & option2 & "'" &_
		",option3	= '" & option3 & "'" &_
		",attached	= '" & filename & "'" &_
		" where uid = '" & uid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		if iid = "inq2" then
			Response.Write("<script>location.replace('../webadmin/main.asp?menushow=menu13&theme=inquire/inquire2&iid=inq2');</script>")
			Response.End()
		elseif frompage = "popup" then
			Response.Write("<script>self.close();</script>")
			Response.End()
		else
			Response.Write("<script>location.replace('../');</script>")
			Response.End()
		end if
	CASE "reple"

	END Select
	db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
