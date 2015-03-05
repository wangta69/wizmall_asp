<% Option Explicit %>
<!-- #include file = "../lib/cfg.board.asp" -->
<%
Dim name,contents, subject,filename
Dim Reple_Icon, New_Icon, Attached_Icon,Reple_count, regdate, count
Dim tmporder
Dim qry, Loopcnt
''Dim ,email,homepage,Reple_count,filenameArr,op_flag_value,option_notice,option_html,,option_secret

qry = Request("qry")

if qry = "qde" then
	Set board	= new boards : Set db = new database : Set util = new utility
	for Loopcnt = 1 to Request("multiselect").COUNT  
		uid = Request("multiselect")(Loopcnt)
		''Response.Write(uid&","&table_name)
		''Response.End()
		if uid <> "" and table_name <> "" then Call board.BOARD_DELETE_DONE
	next
	Call util.js_alert("성공적으로 삭제되었습니다.","./boardlist.asp?bid=" & bid & "&gid=" & gid)
	Set board	= Nothing : db.Dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
end if


Set db = new database : set board	= new boards
' // 게시글 토탈 카운팅
if search_title <> "" and search_keyword <> "" then
	whereis = " WHERE " & search_title & " like '%" & search_keyword & "%'"
else
	'whereis = " WHERE intNotice = 0"
end if
	strSQL = "SELECT COUNT(uid) FROM " & table_name & whereis & " "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	TotalCount = objRs(0)
%>
<html>
<head>
<title>관리자님을 환영합니다.위즈보드 관리자모드</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="style.css" type="text/css">
<script language=javascript src="../js/wizmall.js"></script>
<SCRIPT>
<!--
function delete_board(bid, gid){
	if(confirm("" + bid + " 게시판을 삭제하시겠습니까?\n\n게시판을 삭제하시면 영구적으로 복구가 불가능하며,\n\n업로드된 모든 파일또한 삭제가 됩니다.")){
		location.href="admin.asp?bid=" + bid + "&gid=" + gid + "&smode=board_delete";
	}
}


function really(){
con = confirm("그룹을 삭제합니다. \n\n 그룹삭제전 테이블을 먼저 삭제하셔야 합니다.. \n\n 그룹을 삭제하시겠습니까?")
if (con==true) return true;
else return false;
}

function downforExel(){
location.href="downforexcel.php?DownForExel=yes";
}

function gotoURL(url){
window.open(url,'','')
}

function group_delete(num, gname){
	if(confirm('삭제된 그룹은 복구되지 않습니다.\n\n삭제하시겠습니까?\n\n')){
		location.href = "admin.asp?smode=delete&gid="+gname;
	}else return false
}
//-->
</SCRIPT>
<SCRIPT LANGUAGE=javascript>
<!--
function deletefnc(f){
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
                alert('삭제하고자 하는 게시물을 하나 이상 선택해 주세요.');
                return false;
        }
        if (confirm('\n\n삭제하는 게시물은 복구가 불가능합니다!!! \n\n정말로 삭제하시겠습니까?\n\n')) return true;
        return false;
}

function modify_colum(bid,uid,columname){
window.open('./colum_mod.php?bid='+bid+'&uid='+uid+'&colum='+columname,'ColumModifyWindow','width=500, height=500');
}
//-->
</SCRIPT>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s1">
  <tr>
    <td> 테이블 리스트입니다. </td>
  </tr>
</table>
<table cellspacing=1 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=0 class="s1">
  <form action="./boardlist.asp" Name="BrdList" onsubmit='return deletefnc(this)'>
    <input type="hidden" name="qry" value="qde">
    <input type="hidden" name="bid" value="<%=bid%>">
    <input type="hidden" name="gid" value="<%=gid%>">
    <tr bgcolor="F2F2F2">
      <td align="center" bgcolor="E0E4E8"></td>
      <td align="center" bgcolor="#B9C2CC">NO.</td>
      <td align="center" bgcolor="E0E4E8">제목</td>
      <td align="center" bgcolor="#B9C2CC">글쓴이</td>
      <td align="center" bgcolor="E0E4E8">등록일</td>
      <td align="center" bgcolor="#B9C2CC">조회수</td>
      <td align="center" bgcolor="E0E4E8">추천수</td>
      <td align="center" bgcolor="#B9C2CC">수정</td>
    </tr>
    <%
Dim orderby, ListNum, selectfield, ListFile1, cnt, reccount

''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if setlistorder <> "" And  not isnull(setlistorder) then 
	tmporder = split(setlistorder, "@")
	orderby = " ORDER BY "& tmporder(0) & " " &tmporder(1)
else
	orderby = " ORDER BY bd_idx_num desc"
end If

Call board.getList(table_name,setPageSize,whereis,page,orderby,selectfield)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 	
if objRs.EOF then

%>
    <tr bgcolor="#FFFFFF">
      <td colspan="8" align="center">등록된 글이 없습니다.</td>
    </tr>
    <%
else WHILE NOT objRs.EOF
	Call board.boardlist()
%>
    <tr bgcolor="#FFFFFF">
      <td align="center"><input type="checkbox" name="multiselect" value="<%=uid%>">
      </td>
      <td align="center"><%=ListNum%></td>
      <td><a href="javascript:void(window.open('../wizboard.asp?bid=<%=bid%>&gid=<%=gid%>&bmode=view&uid=<%=uid%>','BoardViewWindow',''))"> <font color="#000000"><%=subject%></font> </a></td>
      <td align="center">&nbsp;<%=name%></td>
      <td align="center">&nbsp;<%=FormatDateTime(regdate,2)%></td>
      <td align="center">&nbsp;<%=count%></td>
      <td align="center"><%=reccount%></td>
      <td align="center"><button name="modify" onClick="wizwindow('../wizboard.asp?bid=<%=bid%>&gid=<%=gid%>&bmode=write&smode=edit&uid=<%=uid%>','WRITEMODE','');" title="수정">수정</button></td>
    </tr>
    <%
	cnt = cnt + 1
	ListNum = ListNum -1
	objRs.MOVENEXT
	WEND
end if	
%>
    <tr bgcolor="F2F2F2">
      <td colspan="8"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5%" align="center"><button name="del_btn" type="submit" title="삭제">삭제</button></td>
            <td width="5%" align="center">&nbsp;</td>
            <td width="95%" bgcolor="E0E4E8"><button name="reg" onClick="wizwindow('../wizboard.asp?bid=<%=bid%>&gid=<%=gid%>&bmode=write','WRITEMODE','');" title="등록">등록</button></td>
          </tr>
        </table></td>
    </tr>
  </form>
</table>
</td>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s1">
  <tr>
    <td align="center"><%
Dim preimg : preimg = skin_path & "icon/prev_btn.gif"
Dim nextimg : nextimg = skin_path & "icon/next_btn.gif"	
Dim design
Dim linkurl : linkurl = "boardlist.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&search_title=" & search_title & "&search_keyword=" & search_keyword & "&adminmode=" & adminmode & "&category=" & category
Call board.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set board = Nothing
%></td>
  </tr>
</table>
</body>
</html>
