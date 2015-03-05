<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file="../../config/admin_info.asp" -->
<!-- #include file="../../config/common_array.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim theme, menushow
Dim MailSkin,maxseq,Loopcnt
Dim strSQL,objRs
Dim db,util
Set util = new utility : Set db = new database

theme			= Request("theme")
menushow		= Request("menushow")
%>
<link href="../js/Smart/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/Smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<script language="Javascript">
<!--
function display1(box){
	member1.style.display = 'block';
	indivisual1.style.display = 'none';
	mass1.style.display = 'none';
	var f= document.messageform;
	f.theme.value="mail/mailer2";
}

function display2(box){
	member1.style.display = 'none';
	indivisual1.style.display = 'block';
	mass1.style.display = 'none';
	var f= document.messageform;
	f.theme.value="mail/mailer2_1";
}


function display3(box){
	member1.style.display = 'none';
	indivisual1.style.display = 'none';
	mass1.style.display = 'block';
	var f= document.messageform;
	f.theme.value="mail/mailer2_2";
}

function checkForm(f){
	oEditors.getById["ir1"].exec("UPDATE_IR_FIELD", []);

}
//-->
</script>
<fieldset class="desc w_desc">
			<legend>메일발송하기</legend>
			<div class="notice">[note]</div>
			<div class="comment">메일발송옵션에서 선택된 회원에게 메일이 발송됩니다.<br />
											메일발송은 서버에 부하가 주어지므로 만단위 이상의 메일은 자제해 주시기 바랍니다.</div>
			</fieldset>
			<div class="space20"></div>

				<form name="messageform" method=post action="mail/mailer2.asp" enctype='multipart/form-data' onsubmit="return checkForm(this)">
					<INPUT type="hidden" NAME=menushow value=<%=menushow%>>
					<INPUT type="hidden" NAME=theme value="mail/mailer2">
					<input type="hidden" value=0 name=contenttype>
			<table class="table_main w_default">

					<tr>
						<th>보내는 분</td>
						<td align=left >
							<input size=50 name="FromName" value="<%=ADMIN_NAME%>">
							(예) 숍핑몰 관리자</td>
					</tr>
					<tr>
						<th>Email</td>
						<td align=left >
							<input name="FromEmail" value="<%=ADMIN_EMAIL%>" size="50">
							(예)master@shop-wiz.com</td>
					</tr>
					<tr>
						<th>Reply-To </td>
						<td align=left ><input name="reply" value="<%=ADMIN_EMAIL%>" size=50>
							 (예) master@shop-wiz.com</td>
					</tr>
					<tr>
						<th>제목</td>
						<td align=left >
							<input size=81 
                        name=subject>
							</td>
					</tr>
					<tr>
						<td class="t_head_l" height=27>스킨선택</td>
						<td align=left  height=27>
							<select name=MailSkin>
								<option value="">스킨없슴</option>
								<%=util.ShowFolderList(PATH_SYSTEM & "webadmin/mailskin",MailSkin)%>
							</select>
							</td>
					</tr>
					<tr>
						<th>내용</td>
						<td align=left ><textarea name="body_txt" id="ir1" rows=15 style="width:100%"></textarea>
						</td>
					</tr>
<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "../js/Smart/SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});

function insertIMG(irid,fileame)
{
 
    var sHTML = "<img src='" + fileame + "' border='0'>";
    oEditors.getById[irid].exec("PASTE_HTML", [sHTML]);
 
}

// 복수개의 에디터를 생성하고자 할 경우, 아래와 같은 방식으로 호출하고 oEditors.getById["ir2"]이나 oEditors[1]을 이용해 접근하면 됩니다.
/*

*/

function _onSubmit(elClicked){
	// 에디터의 내용을 에디터 생성시에 사용했던 textarea에 넣어 줍니다.
	oEditors.getById["ir1"].exec("UPDATE_IR_FIELD", []);
	oEditors.getById["ir2"].exec("UPDATE_IR_FIELD", []);
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.

	try{
		elClicked.form.submit();
	}catch(e){}
}
</script>					
					<tr>
						<th>파일첨부 </td>
						<td align=left >&nbsp; 
							<input name="attached" type="file" id="userfile"></td>
					</tr>
					<tr>
						<th>메일Table선택</td>
						<td align=left >
							<input name="radiobutton" type="radio" value="radiobutton" checked onClick="display1()">
							회원Table
							<input type="radio" name="radiobutton" value="radiobutton" onClick="display2()">
							주소록Table
							<input type="radio" name="radiobutton" value="radiobutton" onClick="display3()">
							단체개별메일 </td>
					</tr>
					<tr>
						<th>메일발송옵션</td>
						<td align=left ><table cellspacing=0 cellpadding=0 width="100%" border=0 id="member1">
								<tbody>
									<tr>
										<td>
											<input type=radio value="all" name="query">
											전체 &nbsp;&nbsp;&nbsp;
											<input type="checkbox" checked 
                              value=checked name=MailReceive>
											수신거부회원은 메일 발송안함</td>
									</tr>
									<tr>
										<td>
											<input type=radio value=seq name=query>
											번호순
											<input value=1 name=startseq>
											-
											<%
'strSQL = "select max(UID) from wizMembers order by UID desc";
'result = mysql_query(query) or die(mysql_error());
'@maxseq = mysql_result(result, 0, 0);
%>
											<input name=stopseq value="<%=maxseq%>">
											</td>
									</tr>
									<tr>
										<td>
											<input type=radio value=gender name=query>
											성별
											<select size=1 name=sex>
												<option value="1" selected="selected">남자</option>
												<option value="2">여자</option>
											</select>
											</td>
									</tr>
									<tr>
										<td>
											<input type=radio value=grade name=query>
											등급별메일보내기
											<select size=1 name=grade>
												<%
for Loopcnt=1 to Ubound(MemberGradeArr)
	if MemberGradeArr(Loopcnt) <> "" then  Response.Write("<option value='"&Loopcnt&"'>"&MemberGradeArr(Loopcnt)&"</option>"&Chr(13)&Chr(10))
next 
%>
											</select>
											</td>
									</tr>
									<tr>
										<td>
											<input type=radio checked value="amail" name="query">
											개인멜
											<input name="testMailAddress">
											(하나의 이멜을 적어주세요 - 테스트용)</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
								</tbody>
							</table>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="indivisual1" style="display:none">
								<tr>
									<td><input type="radio" value="all" name="queryind">
										전체 </td>
								</tr>
								<tr>
									<td>
										<input type=radio checked value=amail name=queryind>
										개인멜
										<input name=personalind id="personalind">
										(하나의 이멜을 적어주세요 - 테스트용)</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="mass1" style="display:none">
								<tr>
									<td><input type="radio" value="all" name="querymass">
										전체 </td>
								</tr>
								<tr>
									<td>
										<input type=radio checked value=amail name=querymass>
										개인멜
										<input name=personalmass>
										(하나의 이멜을 적어주세요 - 테스트용)</td>
								</tr>
								<tr>
									<td>&nbsp;
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td><textarea name="MailAddress" rows="20" id="MailAddress"></textarea></td>
												<td width="15">&nbsp;</td>
												<td><textarea name="textarea2" cols="50" rows="20" wrap="PHYSICAL" disabled>사용예
이메일주소를 아래와 같이 일련으로 카피합니다.

abc@abc.co.kr
xxx@ac.com
kor@korea.com
yyy@check.co.kr</textarea></td>
											</tr>
										</table></td>
								</tr>
							</table></td>
					</tr>

				
			</table>
			<div class="agn_c w_default"><input type="image" src="img/mail.gif" width="90" height="20"></div></form>

					
<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing
%>
