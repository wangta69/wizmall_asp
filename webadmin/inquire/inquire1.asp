<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim setPageSize,setPageLink,whereis,orderby,TotalCount,ListNum,searchField,searchKeyword
Dim tablename, menushow, theme, iid, page
Dim setSubjectCut,cnt
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

tablename		= "wizinquire"
menushow		= Request("menushow")
theme			= Request("theme")
iid				= Request("iid")
page			= Request("page")	: If page = "" then page = 1
setPageSize		= 10
setSubjectCut	= 20
setPageLink		= 10

whereis = "iid = '"& iid &"'"

'' // 게시글 토탈 카운팅
strSQL = "SELECT COUNT(uid) FROM " & tablename & " WHERE " & whereis & " "
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)
%>
<SCRIPT>
<!--
function DELETE_THIS(UID,page,iid,theme,menushow){
window.open("./inquire/inquire_del.asp?UID="+UID+"&page="+page+"&iid="+iid+"&theme="+theme+"&menushow="+menushow,"","scrollbars=no, toolbar=no, width=340, height=150, top=220, left=350")
}

function gotoUrl(uid, iid){
	location.href="main.asp?menushow=<%=menushow%>&theme=inquire/inquire1_1&UID="+uid+"&page=<%=page%>&iid="+iid;
}
//-->
</script>
<table class="table_outline">
  <tr>
    <td> 
	
<fieldset class="desc">
        <legend>견적요청 관리</legend>
        <div class="notice">[note]</div>
        <div class="comment">견적요청된 내용입니다.<br />
                  클릭하시면 상세내용을 보실 수 있습니다.</div>
      </fieldset>
      <p></p>

      <table class="table_main w_default">
        <tr align="center"> 
          <th>NO.</th>
          <th>문의영역</th>
          <th>이름</th>
          <th>회사명</th>
          <th>전화번호</th>
          <th>의뢰일</th>
          <th>삭제</th>
        </tr>
        <%
Dim uid,option1,name,subject,wdate,contents1,compname,tel
			
strSQL = "select TOP " & setPageSize & " * from " & tablename & " Where " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from " & tablename & " ORDER BY uid desc) ORDER BY uid desc " 
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
cnt=0
if objRs.EOF then
	''없을 경우 처리
else WHILE NOT objRs.EOF
	uid			= objRs("uid")	
	option1		= objRs("option1")
	name		= objRs("name")
	subject		= objRs("subject")
	wdate		= objRs("wdate")
	contents1	= objRs("contents1")
	compname	= objRs("compname")
	tel			= objRs("tel")
%>
        <tr> 
          <td align="center">  
            <%=ListNum %>
            </td>
          <td align="center"><a href="javascript:gotoUrl('<%=uid%>', '<%=iid%>');"><%=contents1%></a>&nbsp;</td>
          <td align="center"><a href="javascript:gotoUrl('<%=uid%>', '<%=iid%>');"><%=name%></a>&nbsp;</td>
          <td align="center"><a href="javascript:gotoUrl('<%=uid%>', '<%=iid%>');"><%=compname%></a>&nbsp;</td>
          <td align="center"><a href="javascript:gotoUrl('<%=uid%>', '<%=iid%>');"><%=tel%></a>&nbsp;</td>
          <td align="center"> <%=FormatDateTime(wdate,2)%> </td>
          <td align="center">
            <input type="button" value="삭제" onClick="javascript:DELETE_THIS('<%=uid%>','<%=page%>','<%=iid%>','<%=theme%>','<%=menushow%>')">
            </td>
        </tr>
        <%
ListNum = ListNum - 1
cnt = cnt + 1
objRs.MOVENEXT
WEND
end if	
%>
      </table>
      <table width="760" border="0">
        <tr> 
          <td align="center"> 
<table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td>
<%
Set util = new utility
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&iid="&iid&"&searchField="&searchField&"&searchKeyword="&searchKeyword
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%>
</td>
              </tr>
            </table>          </td>
        </tr>
      </table></td>
  </tr>
</table>
