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
setPageSize = 12
whereis = " WHERE ( uid is not null )"
' // 게시글 토탈 카운팅
if search_title <> "" and search_keyword <> "" then whereis = whereis & "  and " & search_title & " like '%" & search_keyword & "%'"

	strSQL = "SELECT COUNT(uid) FROM " & table_name & whereis
	'Response.Write(strSQL)
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
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

function ChangeImage(ImgName) { 
	PathImg = "../../../config/wizboard_group/<%=gid%>/<%=bid%>/attached/"+ImgName;
    if(ImgName != ""){
		document.all.GoodsBigPic.filters.blendTrans.stop();
		document.all.GoodsBigPic.filters.blendTrans.Apply();
		document.all.GoodsBigPic.src=PathImg;
		document.all.GoodsBigPic.filters.blendTrans.Play();
	}  
	document['GoodsBigPic'].src = PathImg; 
}

//-->
</script>
<table width="580" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="30" valign="top" class="ap3"><strong><img src="/admin/kor_board/images/ico01.gif" width="10" height="10" hspace="5" align="absmiddle"></strong><font color="#669399">좌측사진에 
			마우스를 올리시면 큰이미지를 보실 수 있습니다.</font></td>
	</tr>
</table>
<table width="570" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	
	<td align="center" valign="top"><table width="135" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><table width="135" border="0" cellspacing="0" cellpadding="0">
						<tr>
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
							<td width="64" height="44" align="center"><%
if filenameArr(0) <> "" then
if cnt=0 then filename_row1 = filenameArr(0)''우측 초기 빅이미지
%>				
            <img src="<%=getAttachedIcon(filenameArr(0), attached_dir, "default")%>" width="58" height="38" border="0" onMouseOver="ChangeImage('<%=picturesplit(i)%>')" style="cursor:pointer">
<%
end if
%>	</td>
<%	cnt = cnt + 1
	if cnt mod 2 = 0 then Response.Write "</tr></table></td></tr><tr><td height='8'></td></tr><tr><td><table width='135' border='0' cellspacing='0' cellpadding='0'><tr>"
	objRs.MOVENEXT
	WEND
	tmpcnt = cnt mod 2
	if tmpcnt <> 0 then
		for i = tmpcnt to 1
			Response.Write("<td width='7'></td><td width='64'></td>")
		next
	end if
%>							
						</tr>
					</table></td>
			</tr>
			<tr>
				<td height="8"></td>
			</tr>
			<tr>
				<td><table width="135" border="0" cellspacing="0" cellpadding="0">
						<tr> </tr>
					</table></td>
			</tr>
			<tr>
				<td height="8"></td>
			</tr>
		</table></td>
	<td width="466" valign="top" style="padding-left:10pt;"><table width="420" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="313" align="center"><img name="GoodsBigPic" src="<%=getAttachedIcon(filename_row1, attached_dir, "default")%> style="filter:blendTrans(duration=0.5)" width="411" height="287"></td>
			</tr>
			<tr>
				<Td height="6"></Td>
			</tr>
			<tr>
			
			<td align="right"><!--#include file = "sub_pagesetup.asp"--></td>
			</tr>
			
		</table></td>
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
<input type="hidden" name="name" value="관리자">  
<input type="hidden" name="pass" value="yodelclub"> 
        <!--===============코멘트 쓰기 폼 시작=================================================================-->

          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
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

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" height="75" align="center"><a href="/board/album.asp?page_code=1&seq=4"> <img src="/admin/kor_board/images/btn_objRs.gif" width="70" height="27" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</td>
</tr>
</table>
<!-------------- list end----------->
