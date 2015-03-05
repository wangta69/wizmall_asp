<!-- #include file = "../../config/skin_info.asp" -->
<!--#include file="../../config/common_array.asp"-->
<!--#include file="../../config/membercheck_info.asp"-->
<script src="./js/wizmall.js"></script>
<script language="JavaScript">
<!--
function MemberCheckField(){
var f=document.FrmUserInfo;
	if (!TypeCheck(f.id.value, ALPHA+NUM)) {
		alert("ID는 영문자 및 숫자로만 사용할 수 있습니다. ");
		f.id.focus();
		return false;
	}else if ((f.id.value.length < 4) || (f.id.value.length > 12)) {
		alert("id는 4자 이상, 12자 이내이어야 합니다.");
		f.id.focus();
		return false;
	}else if (f.pwd.value.length < 4) {
		alert("비밀번호는 4자 이상이어야 합니다. ");
		f.pwd.focus();
		return false;
	}else if ((f.pwd.value) != (f.cpwd.value)) {
		alert("비밀번호재확인을 정확히 입력해 주세요. ");
		f.cpwd.focus();
		return false;
	}else if ((f.name.value.length < 2) || (f.name.value.length > 5)) {
		alert("이름을 정확히 적어주십시오.");
		f.name.focus();
		return false;
	}else if(!IsJuminChk(f.jumin1.value, f.jumin2.value)){
		f.jumin1.focus();
		return false;
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
//	}else if(f.tel2_1.value.length < 2 || f.tel2_2.value.length < 2 || f.tel2_3.value.length < 2) {
//		alert("휴대폰번호를 정확히 입력해 주세요 ");
//		f.tel2_1.focus();
//		return false;
	}else return true;
}

function OpenZipcode(flag){
	if(flag == 1){
		window.open("./util/zipcode/<%=ZipCodeSkin%>/index.asp?form=FrmUserInfo&zip1=zip1_1&zip2=zip1_2&firstaddress=address1&secondaddress=address2","ZipWin","width=367,height=300,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
	}
}

function IDcheck(){
var f=document.FrmUserInfo;
	winobject = window.open("","IDcheckPopupWindow","scrollbars=no,resizable=yes,width=367,height=300");
	winobject.document.location = "./wizmember/<%=MemberSkin%>/user_idcheck.asp?id=" + f.id.value;
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
<style type="text/css">
<!--
.style1 {color: #666666}
.textboxstyle {font: 9pt 굴림; border:1 solid #cccccc}
-->
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td> <table width="100%" height="18" border="0" cellpasdding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22">&nbsp;</td> 
          <td width="18" height="22" valign="middle"><img src="wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td> 
          <td height="22">Home &gt; <strong>회원가입</strong></td> 
        </tr> 
      </table></td> 
  </tr> 
  <tr> 
    <td align="center"> <br> </td> 
  </tr> 
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
        <tr> 
          <td bgcolor="#EEEEEE">- 아래의 내용을 정확히 입력하신 후 [확인]단추를 누르세요.<br> 
            - 개인정보는 절대 외부로 유출되지 않으니 안심하세요</td> 
        </tr> 
      </table></td> 
  </tr> 
  <form name="FrmUserInfo" method="post" OnSubmit="return MemberCheckField();" action="./wizmember/member_query.asp"> 
    <input type="hidden" name="qry" value="qin"> 
	<!--// <input type="hidden" name="gotosmode" value="regis_step3"> //-->
    <tr> 
      <td align="center"><br> 
        <table width="95%" border="0" cellpadding="0" cellspacing="0"> 
          <tr> 
            <td bgcolor="#cccccc" height="3"></td> 
          </tr> 
          <tr> 
            <td> <table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                <% if ERecID = "checked" then %> 
                <tr> 
                  <td align="right" bgcolor="#F5F5F5" width="130" height="30"><font color="#CC3333">*</font> 추천인
                    ID </td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td colspan="3" align="left" bgcolor="#FFFFFF"> <input type="text" name="RecID" size="15" maxlength="9" value="" class="textboxstyle" > </td> 
                </tr> 
                <% end if %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 회원
                    ID </td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td colspan="3" align="left" bgcolor="#FFFFFF"> <input name="id" type="text" id="id" class="textboxstyle" value="" size="15" maxlength="9" > 
                    <font color="#CC3333">&nbsp; </font><font color=darkred><a href="javascript:IDcheck();"><img src="wizmember/<%=MemberSkin%>/images/but_id.gif" width="78" height="18" border="0" align="absmiddle"></a></font> <font color="#CC3333">영(소문자)/숫자
                    4~9자 ID중복검사</font><font color=darkred>&nbsp; </font></td> 
                </tr> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 비밀번호</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="pwd" type="password" id="pwd" class="textboxstyle" size="15" maxlength="30" > </td> 
                </tr> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 비밀번호
                    확인</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="cpwd" type="password" id="cpwd" class="textboxstyle" size="15" maxlength="30" > </td> 
                </tr> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> <span class="style1">이름</span></td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="name" type="text" id="name" class="textboxstyle" size="20" maxlength="30" > </td> 
                </tr> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> <span class="style1">별명</span></td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="nickname" type="text" id="nickname" class="textboxstyle" size="20" maxlength="30" > </td> 
                </tr> 
                <% if ESex="checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><span class="style1">성
                      별</span></td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="gender" type="radio" value="1" checked> 
                    남자 &nbsp; 
                    <input type="radio" name="gender" value="2"> 
                    여자 </td> 
                </tr> 
                <% end if %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 주민등록번호</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="jumin1" type="text" id="jumin1" class="textboxstyle" onKeyup=moveFocus(6,this,this.form.jumin2); value="" size="10" maxlength="6" > 
                    -
                    <input name="jumin2" type="text" id="jumin2" class="textboxstyle" value="" size="10" maxlength="7"> </td> 
                </tr> 
                <%if EBirthDay="checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">생년월일</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3">
				  <select name="birthy" id="birthy">
          <% 
		  for i=1920 to Year(Date()) 
          	Response.Write("<option value=""" & i & """>" & i & "</option>" & Chr(13) & Chr(10))
          next 
		   %>
          </select>
                    년
          <select name="birthm" id="birthm">
          <% 
		  for i=1 to 12 
          	Response.Write("<option value=""" & i & """>" & i & "</option>" & Chr(13) & Chr(10))
          next 
		   %>
          </select>
                    월
          <select name="birthd" id="birthd">
          <% 
		  for i=1 to 31
          	Response.Write("<option value=""" & i & """>" & i & "</option>" & Chr(13) & Chr(10))
          next 
		   %>
          </select>&nbsp;&nbsp;&nbsp; 
                    <input type="radio" name="birthtype" value="2"> 
                    양력
                    <input type="radio" name="birthtype" value="1"> 
                    음력 </td> 
                </tr> 
                <% end if%> 
                <% if EMarrStatus="checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">결혼기념일</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <INPUT name=marry id="marry" class="textboxstyle" size=6 maxLength=6> 
                    년
                    <INPUT name=marrm id="marrm" class="textboxstyle" size=6 maxLength=6> 
                    월
                    <INPUT name=marrd id="marrd" class="textboxstyle" size=6 maxLength=6> 
                    일&nbsp;&nbsp;&nbsp; 
                    <input type="radio" name="marrstatus" value="0" /> 
                    미혼
                    <input type="radio" name="marrstatus" value="1"> 
                    기혼</td> 
                </tr> 
                <% end if%> 
                <% if EJob = "checked" then%> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">직업</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <select name="job">
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
                <% if EScholarship="checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">학력</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <select name="scholarship">
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
                <% end if%> 
                <% if ECompany="checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">회사명</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="companyname" type="text" id="companyname" class="textboxstyle" value="" size="20" maxlength="30" > </td> 
                </tr> 
                <% end if %> 
                <% if ECompnum="checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">사업자등록번호</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="companynum1" type="text" id="companynum1" class="textboxstyle" onKeyup=moveFocus(3,this,this.form.Compnum2); size="4" maxlength="3"> 
                    -
                    <input name="companynum2" type="text" id="companynum2" class="textboxstyle"  onKeyup=moveFocus(2,this,this.form.Compnum3); size="3" maxlength="2"> 
                    -
                    <input name="companynum3" type="text" id="companynum3" class="textboxstyle" size="5" maxlength="5"> </td> 
                </tr> 
                <% end if %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="80">자택주소</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' colspan="3" class="agn_l"> <input name="zip1_1" type="text" id="zip1_1" class="textboxstyle" size="3" maxlength="3" READONLY> 
                    -
                    <input name="zip1_2" type="text" id="zip1_2" class="textboxstyle" size="3" maxlength="3" READONLY> 
                    <a href="javascript:OpenZipcode('1');"><img src="wizmember/<%=MemberSkin%>/images/but_post.gif" width="91" height="18" border="0" align="absmiddle"></a> <br> 
                    <input name=address1 type=text id="address1" class="textboxstyle" size=48 READONLY> 
                    <br> 
                    <input name=address2 type=text id="address2" class="textboxstyle" size=48> 
                    (상세주소)<br> 
                    <font color="#CC3333"> 정확하게 기입해주세요</font> </td> 
                </tr> 
                <% if EAddress3 = "checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="80">직장주소</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' colspan="3"> <input name="zip2_1" type="text" id="zip2_1" class="textboxstyle" size="3" maxlength="3" READONLY> 
                    -
                    <input name="zip2_2" type="text" id="zip2_2" class="textboxstyle" size="3" maxlength="3" READONLY> 
                    <a href="javascript:OpenZipcode('1');"><img src="wizmember/<%=MemberSkin%>/images/but_post.gif" width="91" height="18" border="0" align="absmiddle"></a> <br> 
                    <input name=address3 type=text id="address3" class="textboxstyle" size=48 READONLY> 
                    <br> 
                    <input name=address4 type=text id="address4" class="textboxstyle" size=48> 
                    (상세주소)<br> 
                    <font color="#CC3333"> 정확하게 기입해주세요</font> </td> 
                </tr> 
                <% end if %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 전화번호</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> 
				   <select name="tel1_1">
				  <option value=''>국번</option>
				  <%
for loopcnt=1 to Ubound(PhoneArr)
	Response.Write "<option value='" & PhoneArr(loopcnt) & "'>" & PhoneArr(loopcnt) & "</option>" & Chr(13) & Chr(10)
next
%>></select>
                    -
                    <input name="tel1_2" type=text id="tel1_2" class="textboxstyle" size=4 maxlength=4 > 
                    -
                    <input name="tel1_3" type=text id="tel1_3" class="textboxstyle" size=4 maxlength=4 > 
&nbsp;</td> 
                </tr> 
                <% if ETel2 = "checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">이동전화</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3">
				   <select name="tel2_1">
				  <option value=''>국번</option>
 <%
for loopcnt=1 to Ubound(HandPhoneArr)
	Response.Write "<option value='" & HandPhoneArr(loopcnt) & "'>" & HandPhoneArr(loopcnt) & "</option>" & Chr(13) & Chr(10)
next
%></select>
                    -
                    <input name="tel2_2" type=text id="tel2_2" class="textboxstyle" size=4 maxlength=4 > 
                    -
                    <input name="tel2_3" type=text id="tel2_3" class="textboxstyle" size=4 maxlength=4 > </td> 
                </tr> 
                <% end if %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30"><font color="#CC3333">*</font> 전자우편</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"><input name=email_1 type=text id="email_1" class="textboxstyle" size=15 >
                    @  <input name=email_2 type=text id="email_2" class="textboxstyle" size=15 readonly>
                    <select name="tmpmail" onChange="email_chk(this)">
                      <option value=''>선택해주세요</option>
                      <%
for loopcnt=1 to Ubound(MailServerArr)
	Response.Write "<option value='"&MailServerArr(loopcnt)&"'>"&MailServerArr(loopcnt)&"</option>"&Chr(13)&Chr(10)
next
%>
                      <option value='etc'>수동입력</option>
                    </select>
                    </td> 
                </tr> 
                <%if EMailReceive = "checked" then %> 
                <tr> 
                  <td bgcolor="#F5F5F5" align="right" width="130" height="30">정기소식메일</td> 
                  <td align="center" bgcolor="#F5F5F5" width="9"></td> 
                  <td align="center" bgcolor="#CCCCCC" width="1"></td> 
                  <td align="center" width="9"></td> 
                  <td bgcolor='#FFFFFF' align='left' colspan="3"> <input name="emailenable" type="radio" value="1" checked> 
                    수신
                    <input type="radio" name="emailenable" value="0"> 
                    수신하지 않음</td> 
                </tr> 
                <% end if%> 
              </table></td> 
          </tr> 
          <tr> 
            <td bgcolor="#CCccccc" height="3"></td> 
          </tr> 
        </table></td> 
    </tr> 
    <tr> 
      <td align="center" height="40"> <table border="0" cellspacing="0" cellpadding="0"> 
          <tr> 
            <td><input type="image" src="wizmember/<%=MemberSkin%>/images/but_ok.gif" width="70" height="29"></td> 
            <td>&nbsp;</td> 
            <td><a href="javascript:history.go(-1);"><img src="wizmember/<%=MemberSkin%>/images/but_cancle.gif" width="70" height="29" border="0"></a></td> 
          </tr> 
        </table></td> 
    </tr> 
  </form> 
  <tr> 
    <td align="right">&nbsp;</td> 
  </tr> 
</table> 
