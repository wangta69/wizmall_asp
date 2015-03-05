<%

' // 리스팅 제한 체크
	IF checkAccess(session("user_grade"), memberonly_listmode) = FALSE Then call ExecLogin(bid, gid, category, adminmode)

' // 검색 모드시 isSearch 변수에 1을 넣음
	Dim isSearch, TotalCount, TotalPage, whereis, table_name, search_title, search_keyword, SecretImg
	IF LEN(search_word) <> 0 THEN isSearch = 1 ELSE isSearch = 0
	
table_name = "wizboard_" & bid & "_" & gid & "_reply"
puid = Request("uid")
subpage = Request("subpage")
if subpage = "" then subpage = 1
setPageSize = 9
whereis = " WHERE ( uid is not null )"
' // 게시글 토탈 카운팅
if search_title <> "" and search_keyword <> "" then whereis = whereis & "  and " & search_title & " like '%" & search_keyword & "%'"

	strSQL = "SELECT COUNT(uid) FROM " & table_name & whereis & " "
	'Response.Write(strSQL)
	objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
' // 전체 게시물 및 전체 페이지

	TotalCount = objRs(0)
	TotalPage = TotalCount / setPageSize
	IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
		TotalPage = int(TotalPage) + 1
	Else
		TotalPage = int(TotalPage)
	End if

' // 루프 기본 변수
	Dim LoopCount
	LoopCount = 0
	read_uid = uid
	
%>
<script language="JavaScript">
<!--
function reple_check(){
	var f = document.RepleWriteForm;
	if(f.name.value == ""){
		alert('성함을 넣어주세요');
		return false;	
	}else if(f.pass.value == ""){
		alert('패스워드를 넣어주세요');
		return false;	
	}else if(f.subject.value == ""){
		alert('제목을 넣어주세요');
		return false;	
	}
}

function reple_del(bid, gid, uid, reple_uid){
window.open('<%=skin_path%>reple_del.asp?bid='+bid+'&gid='+gid+'&uid='+uid+'&reple_uid='+reple_uid,'RepleDelForm','width=300, height=150')

}

function getPhoto(imgname){
 window.open("<%=skin_path%>photoWindow.asp?bid=<%=bid%>&gid=<%=gid%>&filename="+imgname,"window","width=600,height=400,toolbar=no,location=no,directorys=no,status=no,menubar=no,scrollbars=no,resizable=no,top=0,left=0");
}
//-->
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="center"> 
      <!-- ##################board list 테이블시작입니다##########################-->
      <!-- Image Table Start -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="center" valign="top">
<%
strSQL = "select TOP " & setPageSize & " * from " & table_name & whereis & " and uid not in (SELECT TOP " & ((subpage - 1) * setPageSize) & " uid from " & table_name & whereis & " ORDER BY uid desc) ORDER BY uid desc " 
'Response.Write(strSQL)
cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
	uid 			= objRs("uid")
	name			= objRs("name")
	name			= util.ReplaceHtmlText("1", name)
	contents		= util.ReplaceHtmlText(enable_html, objRs("content"))
	subject			= objRs("subject")
	filenameArr	= SPLIT(objRs("filename"), "|") 
	
'' // 글자 길이 제한
	IF INT(getLenStr(subject)) > INT(setSubjectCut) THEN subject = LEFT(subject, INT(setSubjectCut) - 3) & "..."
	subject = getSearchFontChange(isSearch, search_category, search_word, subject)
	
'' 신규 글 아이콘 등록		
difftime = DateDiff("h",objRs("regdate"),now())
if difftime <= 24 then
	New_Icon =  "<img src=" & skin_path & "icon/new_btn.gif align=absmiddle>"
else
	New_Icon = ""
end if

		LoopNum = LoopNum + 1
		ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(subpage)-1)) - LoopNum + 1
		'end if
%>    
	<td width="176"><table width="160" height="119" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" class="bd1" style="padding:3px;"><%
if filenameArr(0) <> "" then
%>				
            <a href="javascript:getPhoto('<%=filenameArr(0)%>')" class="no0"><img src="<%=getAttachedIcon(filenameArr(0), attached_dir, "default")%>" width="150" height="113" border="0"></a>
<%
end if
%>	</td>
        </tr>
      </table>
      <table width="160" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td height="10" colspan="2"></td>
        </tr>
        <tr class="ft2">
          <td width="40" height="25" align="center" bgcolor="#E8E8E8" class="ft2 style3">제목</td>
          <td height="25"  width="115" bgcolor="#F3F3F3" class="dot"><%=subject%></td>
        </tr>
      </table></td>
<%	cnt = cnt + 1
	if cnt mod 3 = 0 then Response.Write "</tr><tr align='center' valign='top'><td colspan='3'>&nbsp;</td></tr></table><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr align='center' valign='top'>"
	objRs.MOVENEXT
	WEND
	tmpcnt = cnt mod 3
	if tmpcnt <> 0 then
		for i = tmpcnt to 2
			Response.Write("<td width='176'></td>")
		next
	end if
%>	  
  </tr>

</table>
<!-- Img Table End --></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><!--#include file = "sub_pagesetup.asp"--></td>
  </tr>
</table>
<% 
if adminmode = "true" or session("admin") = "super" then
%>	  
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="RepleWriteForm" method="post" onSubmit="return reple_check();" action="./wizboard/reple_ok.asp?bid=<%=bid%>&gid=<%=gid%>" enctype="multipart/form-data">
<input type="hidden" name="id" value="<%=Session("id")%>">
<input type="hidden" name="bid" value="<%=bid%>">
<input type="hidden" name="gid" value="<%=gid%>">
<input type="hidden" name="uid" value="<%=puid%>"> 
<input type="hidden" name="adminmode" value="true">	  
<input type="hidden" name="name" value="관리자">  
<input type="hidden" name="pass" value="yodelclub"> 
        <!--===============코멘트 쓰기 폼 시작=================================================================-->

          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">글제목</td>
          <td bgcolor="#F9F9F9" style="padding-left:5"><input name="subject" type="text" id="subject" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:11px; color:#5E5E5E; HEIGHT: 18px; width:99%">
          </td>
        </tr>
        <tr>
          <td height="1" colspan="2"bgcolor="#DDDDDD"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" height="26" align="center" bgcolor="#EFEFEF" class="ft1">첨부파일</td>
          <td bgcolor="#F9F9F9" style="padding-left:5"><input name="attached" type="file" style="width:350px; border: 1px CCCCCC solid;background-color: #F7F7F7;font-family: '굴림';font-size: 12px;line-height: 18px;color: #333333;" id="attached" maxlength="80">
            
          </td>
        </tr>
        <tr>
          <td height="1" colspan="2" bgcolor="#DDDDDD"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="img/blank.gif" width="1" height="7"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td align="right"><input type="image" src="<%=skin_path%>images/co_submit.gif" width="51" height="15" border="0"  style="cursor:pointer;"></td>
          </tr>
      </table></td>
  </tr>
</table></td>
          </tr></form>
</table>
<%
end if
%>
