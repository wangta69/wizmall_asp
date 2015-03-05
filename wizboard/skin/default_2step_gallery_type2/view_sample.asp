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

	strSQL = "SELECT COUNT(uid) FROM " & table_name & whereis
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
		<td align="center"><table width="135" border="0" cellspacing="0" cellpadding="0">
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
	filenameArr	= SPLIT(objRs("filename"), "|") 

		LoopNum = LoopNum + 1
		ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(subpage)-1)) - LoopNum + 1
		'end if
%> 							
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><%
if filenameArr(0) <> "" then
%>				
           <img src="<%=getAttachedIcon(filenameArr(0), attached_dir, "default")%>" width="58" height="38" border="0" onMouseOver="ChangeImage('<%=value%>')" style="cursor:pointer">
<%
end if
%></td>
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
%>									<td width="7"></td>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/11-1.jpg" width="58" height="38" style="CURSOR: hand" name="img97"  id="img97"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/11.jpg',1)" ></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="8"></td>
				</tr>
				<tr>
					<td><table width="135" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/9-1.jpg" width="58" height="38" style="CURSOR: hand" name="img96"  id="img96"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/9.jpg',1)" ></td>
								<td width="7"></td>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/2-1.jpg" width="58" height="38" style="CURSOR: hand" name="img95"  id="img95"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/2.jpg',1)" ></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="8"></td>
				</tr>
				<tr>
					<td><table width="135" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/10-1.jpg" width="58" height="38" style="CURSOR: hand" name="img94"  id="img94"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/10.jpg',1)" ></td>
								<td width="7"></td>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/3-1.jpg" width="58" height="38" style="CURSOR: hand" name="img93"  id="img93"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/3.jpg',1)" ></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="8"></td>
				</tr>
				<tr>
					<td><table width="135" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/4-1.jpg" width="58" height="38" style="CURSOR: hand" name="img92"  id="img92"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/4.jpg',1)" ></td>
								<td width="7"></td>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/5-1.jpg" width="58" height="38" style="CURSOR: hand" name="img91"  id="img91"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/5.jpg',1)" ></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="8"></td>
				</tr>
				<tr>
					<td><table width="135" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/6-1.jpg" width="58" height="38" style="CURSOR: hand" name="img90"  id="img90"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/6.jpg',1)" ></td>
								<td width="7"></td>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/7-1.jpg" width="58" height="38" style="CURSOR: hand" name="img89"  id="img89"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/7.jpg',1)" ></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="8"></td>
				</tr>
				<tr>
					<td><table width="135" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/12-1.jpg" width="58" height="38" style="CURSOR: hand" name="img88"  id="img88"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/12.jpg',1)" ></td>
								<td width="7"></td>
								<td width="64" height="44" align="center" background="/admin/kor_board/images/view_s_bg.gif"><img src="/download/Album02_DtPhoto/8-1.jpg" width="58" height="38" style="CURSOR: hand" name="img87"  id="img87"  border="0" onMouseOver="MM_swapImage('b_img','','/download/Album02_DtPhoto/8.jpg',1)" ></td>
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
					<td height="313" align="center"><img src="/download/Album02_DtPhoto/1.jpg" name="GoodsBigPic" width="411" height="287" style="filter:blendTrans(duration=0.5)"></td>
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
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" height="75" align="center"><a href="/board/album.asp?page_code=1&seq=4"> <img src="/admin/kor_board/images/btn_objRs.gif" width="70" height="27" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
