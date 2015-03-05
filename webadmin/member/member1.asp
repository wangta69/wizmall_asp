<% Option Explicit %>
<!-- #include file="../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file="../../lib/class.util.asp" -->
<!-- #include file="../../lib/class.database.asp" -->
<!-- #include file="../../lib/class.member.asp" -->
<!-- #include file = "../../config/common_array.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim theme, menushow, qry, targtgrade, value, searchField, searchKeyword,  multiselect
Dim Loopcnt
Dim mid,mpwd, mname, mregdate, mloginnum, companyname, mgrantsta
Dim targetgrade, mgrade, str_member, str_mgrade
Dim strSQL, objRs, params, whereis, joinon, sqlcountstr, counting
Dim setPageSize, setPageLink, page, realtotal, TotalCount, TotalPage, LoopNum, ListNum
Dim db, util, member
Set db		= new database : Set util	= new utility : Set member	= new members

qry				= Request("qry")
mid				= Request("mid")
theme			= Request("theme")
menushow		= Request("menushow")
targetgrade		= Request("targetgrade")
value			= Request("value")
searchField		= Request("searchField")
searchKeyword	= Request("searchKeyword")
multiselect		= Request("multiselect")
page			= Request("page") : if page = "" then page = 1
setPageSize		= 20
setPageLink		= 10


if mgrade = "" then 
	str_member = "전체"
else
	targetgrade = int("targetgrade")
	str_member = MemberGradeArr(targetgrade)
end if

if qry = "qup" then
        strSQL = "UPDATE wizmembers SET mgrantsta = '"&value&"' WHERE mid='"&mid&"'"
        Call db.ExecSQL(strSQL, Nothing, DbConnect)
		db.Dispose : Set db = Nothing
elseif qry = "qde" then
	for Loopcnt = 1 to Request("multiselect").COUNT  
		mid = Request("multiselect")(Loopcnt)
		''Response.Write(mid&"<br />")
		Call member.DeleteMember(mid)
	Next
	Call util.js_alert("성공적으로 삭제되었습니다.","./main.asp?theme="&theme&"&menushow="&menushow)
	Set util = Nothing : Set member = Nothing
end if
%>
<script language=JavaScript>
<!--
$(function(){
	$("#btn_downexcel").click(function(){
		$("#s_form").attr("action", "./member/member1_excel.asp");
		$("#s_form").submit();
		$("#s_form").attr("action", "");
	});

});


function really(){
var f = document.forms.memberlist;
var i = 0;
var chked = 0;
for(i = 0; i < f.length; i++ ) {
		if(f[i].type == 'checkbox') {
				if(f[i].checked) {
						chked++;
				}
		}
}
if( chked < 1 ) {
		alert('삭제하고자 하는 회원을 체크해주세요.');
		return false;
}
	if (confirm('\n정말로 삭제하시겠습니까? 삭제는 복구가 불가능합니다.   \n')){
	f.qry.value = "qde"
	 return true;
	}
	return false;
}

function ch_sta(id, value){
	var str
	switch(value){
		case "00": str = "승인상태로 변경하시겠습니까?"; value="03"; break;
		case "03":	str = "보류상태로 변경하시겠습니까?"; value="04"; break;
		default: str = "승인상태로 변경하시겠습니까?"; value="03"; break;
	}
	if (confirm('\n'+str+'  \n')){
		location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&qry=qup&mid="+id+"&page=<%=page%>&value="+value
	}else return false;
}


//-->		
</script>
<fieldset class="desc w_desc">
			<legend><%=str_member%></legend>
			<div class="notice">[note]</div>
			<div class="comment">전체 회원정보 리스트 입니다. </div>
			</fieldset>
			<div class="space20"></div>
            
			<span class="button bull" id="btn_downexcel"><a>엑셀다운</a></span> 
			<form method="post" action="" id="s_form"></form>            
		<table class="table_main w_default list">

        <form action="./main.asp" NAME='memberlist'>
          <input type=hidden name="theme" value='<%=theme%>'>
          <input type=hidden name="menushow" value='<%=menushow%>'>
          <input type=hidden name="qry" value='qde'>
          <input type=hidden name="page" value='<%=page%>'>
          <input type=hidden name="searchField" value='<%=searchField%>'>
          <input type=hidden name=" searchKeyword" value='<%=searchKeyword%>'>
          <input type=hidden name="SELECT_SORT" value=''>
          <col width="60px" title="번호"/>
          <col width="90px" title="성명"/>
          <col width="90px" title="아이디"/>
          <col width="90px" title="패스워드"/>
          <col width="70px" title="등급"/>
          <col width="90px" title="가입일"/>
          <col width="60px" title="승인"/>
          <col width="60px" title="로긴수"/>
          <col width="90px" title=""/>

          <tr class="altern">
            <th>번호</th>
            <th>성명</th>
            <th>아이디</th>
            <th>패스워드</th>
            <th>등급</th>
            <th>가입일</th>
            <th>승인</th>
            <th>로긴수</th>
            <th>
              <input type="image" src="img/whe.gif" width="75" height="20"></th>
          </tr>
          <%

''총회원수 구하기
Set db		= new database
strSQL = "select count(uid) from wizmembers"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
realtotal = objRs(0)
	
whereis = " where m.uid is not null "	
joinon = " on m.mid = i.mid "
if targetgrade <> "" then whereis = whereis & " and m.mgrade = "& targetgrade
if searchField <> "" and searchKeyword <> "" then whereis = whereis & " and " & searchField & " like '%" & searchKeyword & "%'" 

strSQL = "select count(m.uid) from wizmembers m left join wizmembers_ind i " & joinon & whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)


ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1))

strSQL = "select TOP " & setPageSize & " m.mgrade, m.mid, m.mpwd, m.mname, m.mregdate, m.mloginnum, m.mgrantsta from wizmembers m left join wizmembers_ind i " & joinon & whereis & " and m.uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " m.uid from wizmembers m left join wizmembers_ind i " & joinon & whereis & " ORDER BY m.uid desc) ORDER BY m.uid desc " 

Set objRs = db.ExecSQLReturnRS(strSQL, params, DbConnect)
If objRs.BOF or objRs.EOF Then %>
          <tr>
            <td colspan="9">가입된 회원이 없습니다.</td>
          </tr>
          <%
      Else
        Do Until objRs.EOF

mgrade		= int(objRs("mgrade"))
mid			= objRs("mid")
mpwd		= objRs("mpwd")
mname		= objRs("mname")
mregdate	= objRs("mregdate")
mloginnum	= objRs("mloginnum")
''companyname	= objRs("companyname")
mgrantsta	= objRs("mgrantsta")
if mgrade <> "" then str_mgrade = MemberGradeArr(mgrade)
%>
          <tr>
            <td><%=ListNum%></td>
            <td><a href="javascript:gotoInfo('<%=mid%>')"> <%=mname%></a></td>
            <td ><a href="javascript:gotoInfo('<%=mid%>')"> <%=mid%></a></td>
            <td><%=mpwd%></td>
            <td><%=str_mgrade%></td>
            <td><%=mregdate%></td>
            <td><%		
'' 승인 상태일 경우'
if mgrantsta = "03" then
		Response.Write "<img src='./img/icon_accept.gif' BORDER='0' alt='승인상태' onClick=""ch_sta('"&mid&"', '"&mgrantsta&"')"" style='cursor:pointer'>"
''미승인 상태일 경우'		
elseif mgrantsta = "04"  then
        Response.Write"<img src='./img/icon_refuse.gif' BORDER='0' alt='보류상태' onClick=""ch_sta('"&mid&"', '"&mgrantsta&"')"" style='cursor:pointer'>"
''탈퇴회원일경우'
else 
		Response.Write "<img src='./img/icon_out.gif' BORDER='0' alt='탈퇴상태'  onClick=""ch_sta('"&mid&"', '"&mgrantsta&"')"" style='cursor:pointer'>"
end if
%></td>
            <td><%=mloginnum%></td>
            <td><INPUT TYPE=CHECKBOX NAME='multiselect' value='<%=mid%>'>
            </td>
          </tr>
          <%
		  	ListNum = ListNum - 1
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>
        </form>

      </table>
      <table class="w_default">
                <col width="500px"/>
          <col width="*"/>
              <tr>
                <td><table width="100%" border="0">
                    <script language="javascript">
<!--
function checkForm(f){
	if(f.searchField.value == ""){
		alert('검색영역을 선택하세요');
		return false;
	}else if(f.searchKeyword.value == ""){
		alert('검색키워드를 입력하세요');
		return false;	
	}else return true;
}
//-->
</script>
                    <form ACTION='./main.asp' method=post onsubmit="return checkForm(this)">
                      <INPUT type="hidden" NAME="menushow"  value='<%=menushow%>'>
                      <INPUT type="hidden" NAME="theme" value='<%=theme%>'>
                      <INPUT type="hidden" NAME=targetgrade value='<%=targetgrade%>'>
                      <tr>
                        <td width="20%"><select name=searchField>
                            <option value=''>검색영역</option>
                            <option value=''>----------</option>
                            <option value='m.mid'>아이디</option>
                            <option value='m.mname'>성명</option>
                          </select>                        </td>
                        <td width="15%"><input 
                                name=searchKeyword>                        </td>
                        <td width="15%"><input type="image" src="img/se.gif" width="66" height="20"></td>
                        <td><!--<select 
                                onChange=this.form.submit() name='SELECT_SORT'>
                            <option value=''>선택부분별 정렬</option>
                            <option value=''>-------------------</option>
                            <option value='RegDate'>등록날짜순 정렬</option>
                            <option value='ID'>아이디순 정렬</option>
                            <option value='Name'>이름순 정렬</option>
                            <option value='LoginNum'>접속순 정렬</option>
                          </select> -->                        </td>
                      </tr>
                    </form>
                  </table></td>
                <td><table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right">검색된회원수 : </td>
                      <td width="5">&nbsp;</td>
                      <td><%=TotalCount%>명</td>
                    </tr>
                    <tr>
                      <td align="right">총회원수 : </td>
                      <td>&nbsp;</td>
                      <td><%=realtotal%>명</td>
                    </tr>
                </table></td>
              </tr>
          </table>
      <div class="agn_c w_default">
<%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&searchField="&searchField&"&searchKeyword="&searchKeyword&"&targetgrade="&targetgrade
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%>
</div>
