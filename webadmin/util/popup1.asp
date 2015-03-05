<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim query, theme, menushow, page, multiselect,multicnt,Loopcnt,Loopcnt1
Dim pattached,attachedfile,path,filename,keyvalue
Dim setPageSize,setPageLink,whereis,orderby,TotalCount,ListNum,searchField,searchKeyword
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

query			= Request("query")
theme			= Request("theme")
menushow		= Request("menushow")
page			= Request("page")	: If page = "" then page = 1
multiselect		= Request("multiselect")
multicnt		= split(multiselect, ",")

setPageSize = 20
setPageLink = 10

if query = "qde" then
	for Loopcnt = 0 to Ubound(multicnt)  
		keyvalue = trim(multicnt(Loopcnt))
		strSQL = "select pattached from wizpopup where uid='"&keyvalue&"'"
		Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		pattached		= objRs("pattached")
		attachedfile	= split("|", pattached)

		for Loopcnt1 = 0 to Ubound(attachedfile)
				path = PATH_SYSTEM&"config\wizpopup\"
				filename  = attachedfile(Loopcnt1)
				call util.FileDelete(path, filename)
		next
		
		strSQL = "delete from wizpopup where uid = '" & keyvalue & "'"
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
		Call util.js_alert("성공적으로 삭제되었습니다.","./main.asp?theme="&theme&"&menushow="&menushow)
	next
end if
%>
<script language="javascript">
<!--
function popupview(uid, pleft, ptop, pwidth, pheight){
window.open('../util/wizpopup/index.asp?uid='+uid,'PopUpWindow','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+pleft+',top='+ptop+',width='+pwidth+',height='+pheight);

}

function deletefnc(){

}
//-->
</script>

<fieldset class="desc w_desc">
<legend>팝업창 관리</legend>
<div class="notice">[note]</div>
<div class="comment">
  <!-- 만약 index.asp에 아래코드가 없을 경우 아래 코드를 넣어 준다.<br />
                    &lt;!-- # include file=&quot;./util/wizpopup/popinsert.asp&quot; --&gt; -->
</div>
</fieldset>
<div class="space20"></div>
<form action="./main.asp" Name="BrdList" onsubmit='return deletefnc()'>
  <input type='hidden' name='menushow' value='<%=menushow%>'>
  <input type="hidden" name="theme" value="<%=theme%>">
  <input type="hidden" name="page" value="<%=page%>">
  <input type="hidden" name="query" value="qde">
  <table class="table_main w_default altern list">
    <col width="50px" title="삭제"/>
    <col width="80px" title="사용여부"/>
    <col width="*" title="제목"/>
    <col width="70px" title="보기"/>
    <col width="70px" title="수정"/>
    <tr>
      <th class="agn_c">삭제</th>
      <th class="agn_c">사용여부</th>
      <th class="agn_c">제목</th>
      <th class="agn_c">보기</th>
      <th class="agn_c">수정</th>
    </tr>
    <%

''총개수 구하기
''strSQL = "select count(uid) from wizpopup"
''Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
''realtotal = objRs(0)
	
whereis = " where uid is not null "	

''if targetgrade <> "" then whereis = whereis & " and m.mgrade = "& targetgrade
if searchField <> "" and searchKeyword <> "" then whereis = whereis & searchField & " like '%" & searchKeyword & "%' and " 

''총개수 구하기
strSQL = "select count(uid) from wizpopup " & whereis 
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)


Dim uid,pskinname,pwidth,pheight,ptop,pleft,psubject,pcontents,pattache,popupenable,options

ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1))
strSQL = "select TOP " & setPageSize & " * from wizpopup " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizpopup ORDER BY uid desc) ORDER BY uid desc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

WHILE NOT objRs.EOF
uid			= objRs("uid")
pskinname	= objRs("pskinname")
pwidth		= objRs("pwidth")
pheight		= objRs("pheight")
ptop		= objRs("ptop")
pleft		= objRs("pleft")
psubject	= objRs("psubject")
pcontents	= objRs("pcontents")
pattached	= objRs("pattached")
popupenable	= objRs("popupenable")
options		= objRs("options")
%>
    <tr>
      <td><input type="checkbox" name="multiselect" value="<%=uid%>">
      </td>
      <td class="agn_c"><% if popupenable="1" then
				Response.Write ("보임")
				else
				Response.Write ("숨김")
				end if
				%>
      </td>
      <td><%=psubject%> </td>
      <td class="agn_c"><span class="button bull"><a href="javascript:popupview('<%=uid%>', '<%=pleft%>', '<%=ptop%>', '<%=pwidth%>', '<%=pheight%>')">보기</a></span></td>
      <td class="agn_c"><a href="./main.asp?menushow=<%=menushow%>&theme=util/popup1_write&smode=qup&uid=<%=uid%>"><img src="img/su.gif" width="53" height="20" border="0"></a> </td>
    </tr>
    <%
	ListNum = ListNum - 1
	objRs.MOVENEXT
	WEND
%>
    <tr>
      <td colspan="5"><input type="image" src="img/del02.gif" align="middle" width="53" height="20">
        <a href="main.asp?menushow=<%=menushow%>&theme=util/popup1_write&smode=qin"><img src="img/dung.gif" width="55" height="20" border="0" align="absmiddle"></a></td>
    </tr>
  </table>
</form>
<div class="agn_c w_default">
  <%
Set util = new utility
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&searchField="&searchField&"&searchKeyword="&searchKeyword
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing : db.Dispose : Set db = Nothing : Set objRs = Nothing
%>
</div>
