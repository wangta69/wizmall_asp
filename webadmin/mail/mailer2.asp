<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database


Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename

Dim MailSkin,contenttype,body_txt,FromName,reply,query,MailReceive,startseq,stopseq,sex,grade
Dim personal,testMailAddress,personalind,personalmass,attached
Dim userfile, loopcnt, Loopcnt1, fileinfo, smode
Dim filename, mail_attached_sp, id, ulevel, userfile_name, addsource
Dim soption, mailreject, genderSelect, gradeSelect, userMailList
Dim whereis, seq
Dim toEmail, FromEmail, Subject, mailtitle, result, mail_attached

	DefaultPath			= PATH_SYSTEM & "config\" ''파일저장경로
	'' // 컴포넌트 지정
	attached_count = util.SetUploadComponent	

	contenttype			= util.getReplaceInput(UPLOAD("contenttype"), "")
	MailSkin			= util.getReplaceInput(UPLOAD("MailSkin"), "ns")
	body_txt			= util.getReplaceInput(UPLOAD("body_txt"), "")
	FromName			= util.getReplaceInput(UPLOAD("FromName"), "ns")
	FromEmail			= util.getReplaceInput(UPLOAD("FromEmail"), "ns")
	reply				= util.getReplaceInput(UPLOAD("reply"), "ns")
	subject				= util.getReplaceInput(UPLOAD("subject"), "ns")
	query				= util.getReplaceInput(UPLOAD("query"), "ns")
	MailReceive			= util.getReplaceInput(UPLOAD("MailReceive"), "ns")
	startseq			= util.getReplaceInput(UPLOAD("startseq"), "ns")
	stopseq				= util.getReplaceInput(UPLOAD("stopseq"), "ns")
	sex					= util.getReplaceInput(UPLOAD("sex"), "ns")
	grade				= util.getReplaceInput(UPLOAD("grade"), "ns")
	userfile			= util.getReplaceInput(UPLOAD("userfile"), "ns")
	''personal			= util.getReplaceInput(UPLOAD("personal"), "ns")
	testMailAddress		= util.getReplaceInput(UPLOAD("testMailAddress"), "ns")
	personalind			= util.getReplaceInput(UPLOAD("personalind"), "ns")
	personalmass		= util.getReplaceInput(UPLOAD("personalmass"), "ns")
	''CALL util.folderMaker(DefaultPath)
	
	''파일 업로드 처리
	
		
	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
	
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "", "", "gif,jpeg,jpg,bmp,png,psd,ai,hwp,doc,xls,xlsx,pdf,ppt,pptx,zip,alz,avi,mepg,wmv")
	mail_attached_sp = split(filename, "|")
	for loopcnt = 0 to UBound(mail_attached_sp)
		if mail_attached_sp(loopcnt) <> "" then
			mail_attached(loopcnt) = DefaultPath&mail_attached_sp(loopcnt)
		end if	
	next
%>
<p>&nbsp;</p>
<table width="750" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <table width=100% cellspacing=0 border=1 bgcolor=C0C0C0 align="CENTER" bordercolordark="white" bordercolorlight="#DDDDDD">
          <tr> 
            <td align=center bgcolor=F3F3F3><font color="#092F7B"> 메일발송중!!!!</font></td>
          </tr>

          <tr> 
            <td align=center> &nbsp;&nbsp;&nbsp;&nbsp; <p>메일을 보내고 있습니다. 잠시만 기다려 
                주십시요!</p>
              <p>(서버 Traffic 상 다수의 메일 발송은 문제가 될 수 있습니다.)</p>
</td>
          </tr>
      </table></td>
  </tr>
</table>
<br />
<%
	id = FromName
	if query = "grade" then 
		ulevel = grade 
	else 
		ulevel = "전체"
	end if
	
	if query = "gender" then
		sex = sex
	else 
		sex = "전체"
	end if

	'' 보내는 메일 저장이 있으면 메일 DB에 저장 끝
	strSQL = "insert into wizsendmaillist "&_
	"(sendername,senderemail,reply,subject,contenttype,mailskin,body_txt,userfile,addsource,soption,mailreject,startseq,"&_
	"stopseq,genderselect,gradeselect,testmailaddress,usermaillist,sdate)"&_
	"values"&_
	"('"&FromName&"','"&FromEmail&"','"&reply&"','"&subject&"','"&contenttype&"','"&MailSkin&"','"&body_txt&"'"&_
	",'"&userfile_name&"','"&addsource&"','"&soption&"','"&mailreject&"','"&startseq&"','"&stopseq&"','"&genderSelect&"'"&_
	",'"&gradeSelect&"','"&testMailAddress&"','"&userMailList&"',getdate())"
	
	Call db.ExecSQL(strSQL, Nothing, DbConnect)


if query = "amail" Then
	mailtitle = testMailAddress & " 님께 : " & subject
	result = util.fnc_sendmail(testMailAddress, FromEmail, mailtitle, body_txt, mail_attached)
	if result = FALSE then Call util.js_alert("메일발송실패", "")
	Call util.js_alert(testMailAddress&" 로 메일 발송을 완료하였습니다.", "")
else 	
	if reply = "" then reply = FromEmail
    whereis = "where m.uid <> ''"
	if MailReceive <> "" then whereis = whereis & " and i.emailenable = '1'"
	Select Case query
		Case "seq"
			whereis = whereis & "  m.uid >= '"&startseq&"' and m.uid <= '"&stopseq&"'"
	
		Case "date"
			whereis = whereis & "  convert(varchar(10), m.mregdate, 121) >= '"&startdate&"' and convert(varchar(10), m.mregdate, 121) <= '"&stopdate&"'"
	
		Case "area"
			whereis = whereis & " i.address1 like '"&address1&"%'"
	
		Case "gender"
			whereis = whereis & " and i.gender = '"&gender&"'"
			
		Case "grade"
			whereis = whereis & " and m.mgrade = '"&grade&"'"		
	End Select 
    
	strSQL = "select i.email, m.mname from wizmembers m left join wizmembers_ind i on m.mid = i.mid "&whereis&" order by m.uid asc	"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	seq=0
	WHILE NOT objRs.EOF
       mailtitle= objRs("mname") & " 님께 : " & subject
       toEmail = objRs("email") 
	  result = util.fnc_sendmail(toEmail, FromEmail, mailtitle, body_txt, mail_attached)
	   seq = seq+1
	objRs.MOVENEXT
	WEND
	Response.Write( "<script>window.alert('"&seq&" 개의 메일 발송을 완료하였습니다.'); history.go(-1)</script>")
	Response.End()
end if    
db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>
