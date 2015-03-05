<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim theme,menushow,smode,qry,idx	,name,grp,email,company,buseo,work
Dim hphone1,hphone2,hphone3,cphone1,cphone2,cphone3,hand1,hand2,hand3,fax1,fax2,fax3
Dim post1,post2,addr1,addr2,memo,shard,phone1,phone2,phone3,post,hphone,cphone,hand,fax,phone


Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database

theme		= Request("theme")
menushow	= Request("menushow")
smode		= Request("smode")
qry			= Request("qry")
idx			= Request("idx")


name		= Request("name")
grp			= Request("grp")
email		= Request("email")
company		= Request("company")
buseo		= Request("buseo")
work		= Request("work")
hphone1		= Request("hphone1")
hphone2		= Request("hphone2")
hphone3		= Request("hphone3")
cphone1		= Request("cphone1")
cphone2		= Request("cphone2")
cphone3		= Request("cphone3")
hand1		= Request("hand1")
hand2		= Request("hand2")
hand3		= Request("hand3")
fax1		= Request("fax1")
fax2		= Request("fax2")
fax3		= Request("fax3")
post1		= Request("post1")
post2		= Request("post2")
addr1		= Request("addr1")
addr2		= Request("addr2")
memo		= Request("memo")
shard		= Request("shard")
phone1		= Request("phone1")
phone2		= Request("phone2")
phone3		= Request("phone3")

post	= post1 & "-" & post2
hphone	= hphone1 & "-" & hphone2 & "-" & hphone3'' 집 전화번호 조합
cphone	= cphone1 & "-" & cphone2 & "-" & cphone3''회사 전화번호 조합 
hand	= hand1 & "-" & hand2 & "-" & hand3'' 핸드폰 번호 조합 
fax		= fax1 & "-" & fax2 & "-" & fax3'' 팩스 번호 조합 
phone 	= phone1 & "-" & phone2 & "-" & phone3
If qry = "qin" then
	''쿼리문 조합
	strSQL = "insert into wizmailaddressbook (" &_
	"[userid],[name],[grp],[email],[company],[buseo],[work],[hphone],[cphone],[hand],[fax],[post],[addr1],[addr2],[memo],[wdate],[shard],[phone]"&_
	")values( "&_
	"'"&user_id&"','"&name&"','"&grp&"','"&email&"'" &_
	",'"&company&"','"&buseo&"','"&work&"','"&hphone&"','"&cphone&"'" &_
	",'" & hand & "','"&fax&"','"&post&"','"&addr1&"','"&addr2&"','"&memo&"'" &_
	",getdate(),'','"&phone&"')"
	
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Write "<script>window.alert('성공적으로 저장되었습니다.');location.replace('./main.asp?menushow="&menushow&"&theme=mail/address1');</script>"
ElseIf qry = "qup" then
	'' 쿼리문 조합
	strSQL = "update wizmailaddressbook set "&_
	" name='" & name & "',grp='" & grp & "',email='" & email & "',company='" & company & "',buseo='" & buseo & "',[work]='" & work & "'"&_
	",hphone='" & hphone & "',cphone='" & cphone & "',hand='" & hand & "',fax='" & fax & "',post='" & post & "',addr1='" & addr1 & "'"&_
	",addr2='" & addr2 & "',memo='" & memo & "',phone='" & phone & "'"&_
	"  where idx = '" & idx & "'"
	Response.Write(strSQL)
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Write "<script>window.alert('성공적으로 저장되었습니다.');location.replace('./main.asp?menushow="&menushow&"&theme=mail/address5&qry=modify&idx="&idx&"');</script>"
End if


If idx <> "" Then 
	smode	= "qup"
	Dim wdate,postsp,hphonesp,faxsp,cphonesp,handsp,zip1,zip2
	''strSQL = "select * from wizmailaddressbook where idx = '" & idx & "' and userid = '" & user_id & "'"
	strSQL = "select * from wizmailaddressbook where idx = '" & idx & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	name		= objRs("name")
	grp			= objRs("grp")
	email		= objRs("email")
	company		= objRs("company")
	buseo		= objRs("buseo")
	work		= objRs("work")
	hphone		= objRs("hphone")
	cphone		= objRs("cphone")
	hand		= objRs("hand")
	fax			= objRs("fax")
	post		= objRs("post")
	addr1		= objRs("addr1")
	addr2		= objRs("addr2")
	memo		= objRs("memo")
	wdate		= objRs("wdate")
	shard		= objRs("shard")
	phone		= objRs("phone")
	
	postsp		= split(post, "-")
	post1		= postsp(0)
	post2		= postsp(1)
	hphonesp	= split(hphone, "-")
	hphone1		= hphonesp(0)
	hphone2		= hphonesp(1)
	hphone3		= hphonesp(2)
	cphonesp	= split(cphone, "-")
	cphone1		= cphonesp(0)
	cphone2		= cphonesp(1)
	cphone3		= cphonesp(2)
	handsp		= split(hand, "-")
	hand1		= handsp(0)
	hand2		= handsp(1)
	hand3		= handsp(2)
	faxsp		= split(fax, "-")
	fax1		= faxsp(0)
	fax2		= faxsp(1)
	fax3		= faxsp(2)
else
	smode	= "qin"	
End if
%>
<table cellspacing=0 bordercolordark=white width="879" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1>
  <tr> 
    <td colspan='2'> <table cellpadding='0' cellspacing='0' border='0' width='100%'>
        <tr height='20'>
          <td colspan='3'></td>
        </tr>
        <tr height='30'> 
          <td width='5%'>&nbsp;</td>
          <td width='75%'> 
<%		  
 ''switch(LB){
''	case "group":
''	Response.Write("그룹 관리")
''	break
''	default:
''	Response.Write("주소록 관리")
''	break
''}
%>
            </b></td>
          <td width='20%'></td>
        </tr>
      </table></td>
  </tr>
  <tr valign='top'>
    <td>
<script language='javascript'>

function sendit() 
{
var f = document.WizMailFrm;
        if (f.name.value == '') {
            alert('\n이름을 입력해 주세요!\n\n');
			f.name.focus();
            return;
        }
		f.submit();
        
}

function OpenZipcode(){
window.open("../util/zipcode/default/index.asp?form=WizMailFrm&zip1=post1&zip2=post2&firstaddress=addr1&secondaddress=addr2","ZipWin","width=350,height=250,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
}
</script>

<table width='98%' border='0' align='center' cellpadding='0' cellspacing='0'>
<form action='./main.asp' name='WizMailFrm' method='post'>
<input type='hidden' name='menushow' value='<%=menushow%>'>
<input type='hidden' name='theme' value='<%=theme%>'>
<input type='hidden' name='qry' value='<%=smode%>'>
<input type='hidden' name='idx' value='<%=idx%>'>
  <tr> 
    <td width='300'>
	  <table cellpadding='0' cellspacing='0' border='0'>
        <tr height='20'> 
                  <td width='13'>&nbsp;</td>
		  <td>주소추가</td>
        </tr>
      </table>
	</td>
    <td width='250' align='right'>(<font color='red'>*)는 필수 입력 사항입니다.</td>
  </tr>
  <tr> 
    <td colspan='2'> 
	  <table cellspacing=0 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1>
        <tr height='23'> 
                  <td width='150' bgcolor='E0E4E8'>&nbsp;&nbsp; 이름 <font color='red'>*</td>
          <td>&nbsp;<input name="name" type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=name%>" size='25' maxlength='10'></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 그룹</td>
          <td>&nbsp;<select name='grp' class='select'>
<%
strSQL = "select * from wizmailaddressbook_g where userid='" & user_id & "' order by idx asc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
	code	= objRs("code")
	subject	= objRs("subject")
	if grp	= code then
		selected = "selected"
	else
		selected = ""
	end if
	Response.Write("<option value='"&code&"' "&selected&">"&subject&"</option>"&chr(13)&chr(10))
objRs.MOVENEXT
WEND
%>
            </select></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 전자우편</td>
          <td>&nbsp;<input name='email' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=email%>" size='50' maxlength='60'></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 회사</td>
          <td>&nbsp;<input name='company' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=company%>" size='30'></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 부서</td>
          <td>&nbsp;<input name='buseo' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=buseo%>" size='30'></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 직책</td>
          <td>&nbsp;<input name='work' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=work%>" size='30'></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 집 전화번호</td>
          <td>&nbsp;<input name='hphone1' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=hphone1%>" size='5' maxlength='3'> - 
		  <input name='hphone2' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=hphone2%>" size='5' maxlength='4'> - 
		  <input name='hphone3' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=hphone3%>" size='5' maxlength='4'>
		  <input name='phone' type='radio' value='1' checked>대표번호</td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 사무실 전화번호</td>
          <td>&nbsp;<input name='cphone1' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=cphone1%>" size='5' maxlength='3'> - 
		  <input name='cphone2' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=cphone2%>" size='5' maxlength='4'> - 
		  <input name='cphone3' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=cphone3%>" size='5' maxlength='4'>
		  <input name='phone' type='radio' value='2'>대표번호</td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 핸드폰번호</td>
          <td>&nbsp;<input name='hand1' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=hand1%>" size='5' maxlength='3'> - 
<input name='hand2' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'"value="<%=hand2%>" size='5' maxlength='4'> - 
		  <input name='hand3' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=hand3%>" size='5' maxlength='4'>
		  <input name='phone' type='radio' value='3'>대표번호</td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 팩스번호</td>
          <td>&nbsp;<input name='fax1' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=fax1%>" size='5' maxlength='3'> - 
		  <input name='fax2' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=fax2%>" size='5' maxlength='4'> - 
		  <input name='fax3' type='text'  class='dd1' onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=fax3%>" size='5' maxlength='4'>
		  <input name='phone' type='radio' value='4'>대표번호</td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 주소</td>
          <td><table width='350' border='0' cellspacing='0' cellpadding='0'>
                      <tr> 
                        <td height='20'>&nbsp;<input name='post1' type='text'  class='dd1' id="post1" onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=zip1%>" size='4' maxlength='3'>
                          - 
                          <input name='post2' type='text'  class='dd1' id="post2" onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=zip2%>" size='4' maxlength='3'> 
                          <img src='img/button16.gif' width="66" height="20" border='0' align="absmiddle" onClick="javascript:OpenZipcode()";></td>
                      </tr>
                    </table></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;</td>
          <td>&nbsp;<input name='addr1' type='text'  class='dd1' id="addr1" onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=addr1%>" size='26' maxlength='100'>
				<input name='addr2' type='text'  class='dd1' id="addr2" onfocus="this.style.backgroundColor='#E2F5FF'" onblur="this.style.backgroundColor='#F7F7F7'" value="<%=addr2%>" size='35' maxlength='100'></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 기타</td>
          <td>&nbsp;
                    <textarea name='memo' cols='62' rows='6'  class='dd1' onblur="this.style.backgroundColor='#F7F7F7'" onfocus="this.style.backgroundColor='#E2F5FF'"><%=memo%></textarea></td>
        </tr>
      </table>
	</td>
  </tr>
  <tr><td colspan='2' height='1'></td></tr>
  <tr align="center"> 
    <td colspan='2'>
	  <a href='javascript:sendit()'><img src='img/button12.gif' width="46" height="20" border='0'></a>
	  <a href='javascript:history.back()'><img src='img/button5.gif' width="46" height="20" border='0'></a>
	</td>
  </tr></form>
</table>
</td>
  </tr>
</table>
