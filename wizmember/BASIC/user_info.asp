<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/membercheck_info.asp" -->
<!-- #include file ="../../config/mall_config.asp" -->
<!-- #include file = "../../config/common_array.asp"-->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim mname,mgrade,mpwd,zipcode,nickname,jumin1,jumin2,zip1,address1,address2,email,email_1,email_2
Dim birthtype,gender,tel1,tel2,birthdate,companynum,companyname,president,emailenable
Dim loopcnt,selected,status
Dim strSQL,objRs
Dim db, util
''Set util = new utility	
Set db = new database
%>
<%
If user_id <> "admin" Then 
	strSQL		= "select m.*, i.* from wizmembers m "
	strSQL		= strSQL & " left join wizmembers_ind i on m.mid = i.mid "
	strSQL		= strSQL & " where m.mid = '" & user_id & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	mname		= objRs("mname")
	mgrade		= objRs("mgrade")
	mpwd		= objRs("mpwd")
	zipcode		= split(objRs("zip1"), "-")
	nickname	= objRs("nickname")
	jumin1		= objRs("jumin1")
	jumin2		= objRs("jumin2")
	zip1		= split(objRs("zip1"), "-")
	address1	= objRs("address1")
	address2	= objRs("address2")
	email		= split(objRs("email"),"@")
	email_1		= email(0)
	email_2		= email(1)
	birthdate	= split(objRs("birthdate"), "/")
	birthtype	= objRs("birthtype")
	gender		= objRs("gender")
	tel1		= split(objRs("tel1"), "-")
	tel2		= split(objRs("tel2"), "-")
	companynum	= split(objRs("companynum"), "-")
	companyname	= objRs("companyname")
	president	= objRs("president")
	emailenable	= objRs("emailenable")
Else 
	ReDim zipcode(1),tel1(2),tel2(2)
End if
%>
<script language="JavaScript">
<!--
function MemberCheckField(){
var f=document.FrmUserInfo;
	if (f.cpw.value.length < 4) {
		alert("현재 비밀번호를 한번더 입력해 주세요. ");
		f.cpw.focus();
		return false;
	}else if ( f.pwd.value && f.cpwd.value && (f.pwd.value) != (f.cpwd.value)) {
		alert("비밀번호재확인을 정확히 입력해 주세요. ");
		f.cpwd.focus();
		return false;
	}else if ((f.name.value.length < 2) || (f.name.value.length > 5)) {
		alert("이름을 정확히 적어주십시오.");
		f.name.focus();
		return false;
	//}else if(!IsJuminChk(f.jumin1.value, f.jumin2.value)){
	//	f.jumin1.focus();
	//	return false;
	}else if(f.address1.value.length < 5) {
		alert("주소를 정확히 입력해 주세요.");
		f.address1.focus();
		return false;
	}else if(f.address2.value.length < 2) {
		alert("번지수/통/반을 정확히 입력해 주세요.[예:123번지] ");
		f.address2.focus();
		return false;
	}else if(f.tel1_1.value.length < 2 || f.tel1_2.value.length < 2 || f.tel1_3.value.length < 2) {
		alert("전화번호를 정확히 입력해 주세요 ");
		f.tel1_1.focus();
		return false;
	//}else if(f.tel2_1.value.length < 2 || f.tel2_2.value.length < 2 || f.tel2_3.value.length < 2) {
	//	alert("휴대폰번호를 정확히 입력해 주세요 ");
	//	f.tel2_1.focus();
	//	return false;
	}else return true;
}

function OpenZipcode(flag){
	if(flag == 1){
	window.open("./util/zipcode/<%=ZipCodeSkin%>/index.asp?form=FrmUserInfo&zip1=zip1&zip2=zip2&firstaddress=address1&secondaddress=address2","ZipWin","width=367,height=300,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
	}
}

function IDcheck()
{
var f=document.FrmUserInfo;
	winobject = window.open("","IDcheckPopupWindow","scrollbars=no,resizable=yes,width=367,height=300");
	winobject.document.location = "./wizmember/basic2/user_idcheck.asp?id=" + f.id.value;
	winobject.focus();
}

function email_chk(v){
	var f=document.FrmUserInfo;
	if(v.value == "etc"){
		f.email_2.value = "";	
		f.email_2.readOnly = false;
		f.email_2.focus();
	}else{
		f.email_2.value = v.value;
		f.email_2.readOnly = true;
	}
}
//-->
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22" class="company">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22" class="company">Home &gt; 회원정보변경 및 탈퇴</td>
        </tr>
      </table>
      <br> </td>
  </tr>
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr> 
          <td bgcolor="#EEEEEE">- 회원정보를 수정하는 란입니다.<br>
            - 아래의 내용중 수정을 원하시는 부분을 입력하신 후 [확인]단추를 누르세요</td>
        </tr>
      </table></td>
  </tr>
  <FORM name="FrmUserInfo" method="post" OnSubmit="return MemberCheckField();" action="./wizmember/member_query.asp">
     <input type="hidden" name="qry" value="qup">
    <tr> 
      <td align="center"><br> <table width="95%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
          <tr> 
            <td width="615" height="3" bgcolor="#cccccc"></td>
          </tr>
          <tr> 
            <td> <table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                <tr> 
                  <td align="right" bgcolor="#F5F5F5" width="130" height="30"><font color="#CC3333">*</font> 
                    회원 ID </td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor="#FFFFFF"> 
                    <%=user_id%><input name="id" type="hidden" value="<%=user_id%>">
                    </td>
                </tr>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">현재 비밀번호</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="cpw" type="password" id="cpw" class="textboxstyle" > 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">새 비밀번호</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="pwd" type="password" id="pwd" class="textboxstyle" ></td>
                </tr>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">비밀번호 확인</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="cpwd" type="password" id="cpwd" class="textboxstyle" > 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 
                    이름</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> 
                    <%=mname%>
                    <input type="hidden" name="name" value="<%=mname%>"> 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">별명</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> 
                    <input name="nickname" type="text" id="nickname" class="textboxstyle" value="<%=nickname%>" size="20" maxlength="30" ></td>
                </tr>				
<% if ESex = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">성 
                    별</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>

                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="gender" type="radio" value="1" <% if gender = "1" then  Response.Write ("checked") %>>
                    남자 &nbsp; <input type="radio" name="gender" value="2" <% if gender = "2" then  Response.Write ("checked") %>>
                    여자</td>
                </tr>
<% end if %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30"><font color="#CC3333">*</font> 
                    주민등록번호</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> 
                    <%=jumin1%>
                    - 
                    <%=jumin2%><input name="jumin1" type="hidden" value="<%=jumin1%>"><input name="jumin2" type="hidden" value="<%=jumin2%>">
                  </td>
                </tr>
<% if EBirthDay = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">생년월일</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <INPUT name=birthy id="birthy" class="textboxstyle" value="<%=birthdate(0)%>" size=6 maxLength=6>
                    년 
                    <INPUT name=birthm id="birthm" class="textboxstyle" value="<%=birthdate(1)%>" size=6 maxLength=6>
                    월 
                    <INPUT name=birthd id="birthd" class="textboxstyle" value="<%=birthdate(2)%>" size=6 maxLength=6>
                    일&nbsp;&nbsp;&nbsp; <input type="radio" name="birthtype" value="2" <% if birthtype = "2" then Response.Write ("checked")%>>
                    양력 
                    <input type="radio" name="BirthType" value="1" <% if birthtype = "1" then Response.Write ("checked")%>>
                    음력 </td>
                </tr>
<% end if %>
<% if EMarrStatus = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">결혼여부</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'><INPUT name=marry id="marry" class="textboxstyle" size=6 maxLength=6> 
                    년
                    <INPUT name=marrm id="marrm" class="textboxstyle" size=6 maxLength=6> 
                    월
                    <INPUT name=marrd id="marrd" class="textboxstyle" size=6 maxLength=6> 
                    일&nbsp;&nbsp;  
                    <input type="radio" name="marrstatus" value="미혼" <% if MarrStatus = "미혼" then Response.Write ("checked") %>>
                    미혼 
                    <input type="radio" name="marrstatus" value="기혼" <% if MarrStatus = "기혼" then Response.Write ("checked") %>>
                    기혼 </td>
                </tr>
<% end if %>
<% if EJob = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">직업</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <select name="job">
<%
for i=1 to ubound(JobArr)
	if job = JobArr(i) then 
		selected = "selected"
	else
		selected = ""
	end if
	Response.Write "<option value = '"&JobArr(i)&"' "&selected&">"&JobArr(i)&"</option>"&Chr(13)&Chr(10)
next
%>				  

                    </select> </td>
                </tr>
<% end if %>
<% if EScholarship = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">학력</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <select name="scholarship">
<%
for i=1 to ubound(ScholarshipArr)
	if Scholarship = ScholarshipArr(i) then 
		selected = "selected"
	else
		selected = ""
	end if
	Response.Write "<option value = '"&ScholarshipArr(i)&"' "&selected&">"&ScholarshipArr(i)&"</option>"&Chr(13)&Chr(10)
next
%>	
                    </select> </td>
                </tr>
<% end if %>
<% if ECompany = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">회사명</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="companyname" type="text" id="companyname" class="textboxstyle" value="<%=companyname%>" size="20" maxlength="30" > 
                  </td>
                </tr>
<% end if %>
<% if ECompnum = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">사업자등록번호</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> 
                    <%=companynum(0)%>
                    - 
                    <%=companynum(1)%>
                    - 
                    <%=companynum(2)%>
                  </td>
                </tr>
<% end if %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="60">자택주소</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="zip1_1" type="text" id="zip1_1" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=zipcode(0)%>" size="3" maxlength="3" READONLY>
                    - 
                    <input name="zip1_2" type="text" id="zip1_2" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=zipcode(1)%>" size="3" maxlength="3" READONLY> 
                    <a href="javascript:OpenZipcode('1');" onFocus='this.blur()'><img src="wizmember/<%=MemberSkin%>/images/but_post.gif" width="91" height="18" border="0" align="absmiddle"></a> 
                    <br>                    <input name=address1 type=text id="address1" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=address1%>" size=48 READONLY> 
                    <br> <input name=address2 type=text id="address2" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=address2%>" size=48>
                    (상세주소)</td>
                </tr>
<% if EAddress3 = "checked" then %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="60">직장주소</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="zip2_1" type="text" id="zip2_1" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=Zip2(0)%>" size="3" maxlength="3" READONLY>
                    - 
                    <input name="zip2_2" type="text" id="zip2_2" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=Zip2(1)%>" size="3" maxlength="3" READONLY> 
                    <img src="wizmember/<%=MemberSkin%>/images/but_post.gif" width="91" height="18" align="absmiddle" onClick="javascript:OpenZipcode1()" style="cursor:pointer";> 
                    <br> <input name=address3 type=text id="address3" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=address3%>" size=48 READONLY> 
                    <br> <input name=address4 type=text id="address4" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=address4%>" size=48>
                    (상세주소)</td>
                </tr>
<% end if %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="25"><font color="#CC3333">*</font> 
                    전화번호</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <select name="tel1_1" id="tel1_1">
 <%
for loopcnt=1 to Ubound(PhoneArr)
	if tel1(0) = PhoneArr(loopcnt) then
		selected = "selected"
		status = "on"
	else
		selected = ""
	end if
	Response.Write "<option value='" & PhoneArr(loopcnt) & "'" & selected & ">" & PhoneArr(loopcnt) & "</option>" & Chr(13) & Chr(10)
next
%>
          </select>
                    - 
                    <input name=tel1_2 type=text id="tel1_2" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=tel1(1)%>" size=4 maxlength=4 >
                    - 
                    <input name=tel1_3 type=text id="tel1_3" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=tel1(2)%>" size=4 maxlength=4 >
</td>
                </tr>
<% if ETel2 = "checked" then %>				
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">이동전화</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <select name="tel2_1">
 <%
for loopcnt=1 to Ubound(HandPhoneArr)
	if tel2(0) = HandPhoneArr(loopcnt) then
		selected = "selected"
		status = "on"
	else
		selected = ""
	end if
	Response.Write "<option value='" & HandPhoneArr(loopcnt) & "'" & selected & ">" & HandPhoneArr(loopcnt) & "</option>" & Chr(13) & Chr(10)
next
%>
          </select>
                    - 
                    <input name=tel2_2 type=text id="tel2_2" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=tel2(1)%>" size=4 maxlength=4 >
                    - 
                    <input name=tel2_3 type=text id="tel2_3" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=tel2(2)%>" size=4 maxlength=4 > 
                  </td>
                </tr>
<% end if %>
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30"><font color="#CC3333">*</font> 
                    전자우편</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'><input name=email_1 type=text id="email_1" style="font: 9pt 굴림; border:1 solid #cccccc;" value="<%=email_1%>" size=15 >
                    @<input name=email_2 type=text id="email_2" style="font: 9pt 굴림; border:1 solid #cccccc;" size=15 value="<%=email_2%>" readonly>
                    <select name="tmpmail" onChange="email_chk(this)">
                      <option value=''>선택해주세요</option>
<%
for loopcnt=1 to Ubound(MailServerArr)
	if email_2 = MailServerArr(loopcnt) then
		selected = "selected"
		status = "on"
	else
		selected = ""
	end if
	Response.Write "<option value='"&MailServerArr(loopcnt)&"' "&selected&">"&MailServerArr(loopcnt)&"</option>"&Chr(13)&Chr(10)
next
%>
                      <option value='etc' <% if status <> "on" then Response.Write("selected") %>>기타</option>
                    </select></td>
                </tr>
<% if EMailReceive = "checked" then %>	
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" height="30">정기소식메일</td>
                  <td align="center" bgcolor="#F5F5F5" width="9"></td>
                  <td align="center" bgcolor="#CCCCCC" width="1"></td>
                  <td align="center" width="9"></td>
                  <td bgcolor='#FFFFFF'> <input name="emailenable" type="radio" value="1" <% if emailenable= "1" then  Response.Write ("checked")%>>
                    수신 
                    <input type="radio" name="emailenable" value="0" <% if emailenable= "0" then Response.Write ("checked") %>>
                    수신하지 않음</td>
                </tr>
<% end if %>
              </table></td>
          </tr>
          <tr> 
            <td bgcolor="#CCccccc" height="3"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td align="center" height="40"> <table width="154" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="43"><input type="image" src="wizmember/<%=MemberSkin%>/images/but_ok.gif" width="70" height="29"></td>
            <td>&nbsp;</td>
            <td width="43"><img src="wizmember/<%=MemberSkin%>/images/but_cancle.gif" width="70" height="29" ONCLICK="javascript:history.go(-1)"; style="cursor:pointer"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td align="center" height="40">&nbsp;</td>
    </tr>
  </form>
</table>
