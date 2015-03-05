<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="admin.css" type="text/css">
<script language=javascript src="../js/SelectBox.js"></script>
<script language=javascript src="../js/wizmall.js"></script>
<script language="javascript">
function deletefnc(){
        var f = document.forms.BrdList;
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
</script>
</head>
<body>
<table width="760" border="0" cellpadding="0" cellspacing="0" class="s1">
  <tr> 
    <td>
      <%=AdminBID;%>
      </b> 테이블 리스트입니다. </td>
  </tr>
</table>
<table cellspacing=1 bordercolordark=white width="760" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=0 class="s1">
  <form action="<%=PHP_SELF%>" Name="BrdList" onsubmit='return deletefnc()'>
    <input type="hidden" name="AdminBID" value="<%=AdminBID%>">
    <input type="hidden" name="menu7" value="show">
    <input type="hidden" name="theme" value="boardadmin">
    <input type="hidden" name="page" value="<%=page%>">
    <input type="hidden" name="SUB_page" value="<%=SUB_page%>">
    <input type="hidden" name="query" value="qde">
    <tr align="center"> 
      <td> </td>
      <td>NO.</td>
      <td>제목</td>
      <td>글쓴이</td>
      <td>등록일</td>
      <td>조회수</td>
      <td>추천수</td>
      <td>수정</td>
    </tr>
    <tr> 
      <td align="center"><input type="checkbox" name="deleteItem" value=""> </td>
      <td align="center"> </td>
      <td> t</td>
      <td align="center">&nbsp; </td>
      <td align="center">&nbsp; </td>
      <td align="center">&nbsp; </td>
      <td align="center">&nbsp; </td>
      <td align="center"> <img src="img/su.gif" width="53" height="20" border="0" onClick="javascript:window.open('../wizboard.php?BID=<%=AdminBID%>&smode=modify&UID=<%=LIST[UID];%>&SUB_page=<%=SUB_page;%>','수정모드','');";> 
      </td>
    </tr>
    <tr align="center"> 
      <td colspan="8"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="5%" align="center"> <input type="image" src="img/del02.gif" align="middle" width="53" height="20"> 
            </td>
            <td width="95%"><img src="img/dung.gif" width="55" height="20" align="absmiddle" onClick="javascript:window.open('../wizboard.php?BID=<%=AdminBID%>&smode=write','WRITEMODE','');";></td>
          </tr>
        </table></td>
    </tr>
  </form>
</table></td>
</body>
</html>
