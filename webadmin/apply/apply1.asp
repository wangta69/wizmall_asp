<% Option Explicit %>
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
	Dim db,strSQL,objRs
	''Dim util
	''Set util = new utility	
	Set db = new database

Dim query, theme, multiselect, uid
query = Request("query")
if query = "qde" then
	for i = 1 to Request("multiselect").COUNT  
		uid = Request("multiselect")(i)
		strSQL = "delete from wizapply where uid = '" & uid & "'"
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
		Response.Write("<script>window.alert('성공적으로 삭제되었습니다.');location.replace('./main.asp?theme=apply1&menu13=show')</script>")
	next
end if
%>
<script language=JavaScript>
<!--
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
	f.query.value = "qde"
	 return true;
	}
	return false;
}
function really1(){
	if (confirm('\n보류상태로 되돌리겠습니까?  \n')) return true;
	return false;
}
function really2(){
	if (confirm('\n정말로 승인하시겠습니까?  \n')) return true;
	return false;
}
//-->		
</script>
<table  border="0" cellpadding="0" cellspacing="0"> <tr>
                <td height="8"></td>
                <td height="8"></td>
              </tr>
              <tr>
                <td> </td>
                <td valign="top"> 
                  <table class="table_main w_default">
                     
                    <tr> 
                      
            
          <td><font color="#FF6600">입학신청</b></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table cellspacing=0 cellpadding=0 width="100%" border=0 class="s1">
                           
                          <tr> 
                            <td align=middle width=57><font color=#ff6600>[note] </td>
                            
                <td width="697">신청된 입학리스트입니다.</td>
                          </tr>
                          
                        </table>
                      </td>
                    </tr>
                    
                  </table>
                  <br />
      <table class="table_main w_default">
        <form action='./main.asp' name='memberlist'>
          <input type=hidden name=theme value='apply1'>
          <input type=hidden name=menu13 value='show'>
          <input type=hidden name=query value='qde'>
          <input type=hidden name=page value=''>
          <input type=hidden name=WHERE value=''>
          <input type=hidden name=keyword value=''>
          <input type=hidden name=SELECT_SORT value=''>
          <tr align=center> 
            <td width="90">번호</td>
            <td width="90" bgcolor=#B9C2CC>이름<br />
              </td>
            <td width="90">전화번호</td>
            <td width="90" bgcolor=#B9C2CC>핸드폰번호</td>
            <td width="90">성별</td>
            <td width="90" bgcolor=#B9C2CC>등록일</td>
            <td width="90" bgcolor=#B9C2CC> <input type="submit" name="Submit" value="삭제"></td>
          </tr>
          <%
setPageSize = 20
if page = "" then page = 1
setPageLink = 10
strSQL = "select count(uid) from wizapply"
set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)
	
strSQL = "select TOP " & setPageSize & " * from wizapply Where uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizapply ORDER BY uid desc) ORDER BY uid desc " 
'Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
LoopNum = LoopNum + 1
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - LoopNum + 1
if objRs("gender") = 1 then 
gender = "남"
else gender = "여"
end if
%>
          <tr align=center> 
            <td width="90"> <%=ListNum%>&nbsp;</td>
            <td width="90"><A HREF='#' onclick="javascript:window.open('./apply1_1.asp?uid=<%=objRs("uid")%>', 'regisform','width=650,height=650,statusbar=no,scrollbars=yes,toolbar=no')"><font color = 'black'> 
              <%=objRs("name")%></a>&nbsp;</td>
            <td width="90"><A HREF='#' onclick="javascript:window.open('./apply1_1.asp?uid=<%=objRs("uid")%>', 'regisform','width=650,height=600,statusbar=no,scrollbars=yes,toolbar=no')"><font color = 'black'> 
              <%=objRs("tel1")%></a>&nbsp;</td>
            <td width="90">&nbsp;<font color = 'black'><%=objRs("tel2")%></td>
            <td width="90">&nbsp;<%=gender%></td>
            <td width="90">&nbsp;<font color = 'black'><%=objRs("wdate")%></td>
            <td width="90"><input TYPE=CHECKBOX name='multiselect' VALUE='<%=objRs("uid")%>'> 
            </td>
          </tr>
          <%
	objRs.MOVENEXT
	WEND
%>
        </form>
        <tr align=middle> 
          <td bgcolor=white colspan=7> <table cellspacing=0 cellpadding=0 width="100%" 
border=0>
              <tr> 
                <td width="499">&nbsp; </td>
                <td width=9 rowspan="2">&nbsp;</td>
                <td width=10 rowspan="2"></td>
                <td width=236 rowspan="2"> <div align="center"><span class="s1"></span></b></div></td>
              </tr>
            </table></td>
        </tr>
      </table>
                  <br />
                  <table cellspacing=0 cellpadding=0 width="760" 
border=0 class="s1">
                     
                    <tr> 
                      <td align=middle>&nbsp; 
                        <div align="center"><table border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="56">
<%
	IntStart = INT((((page - 1) \ setPageLink)) * setPageLink + 1)
	IntEnd = INT(((((page - 1) + setPageLink) \ setPageLink)) * setPageLink)

	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(page) > INT(setPageLink) THEN
			RESPONSE.WRITE "<a href=wizboard.asp?bmode=list&page=" & int(page - setPageLink) & "&bid=" & bid & "&gid=" & gid & "&category=" & category & "&search_category=" & search_category & "&search_word=" & search_word & "&order_c=" & order_c & "&order_da=" & order_da & "><img src='" & skin_path &"images/bt_prev.gif' width='56' height='9'>"
			RESPONSE.WRITE "<a href=wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&page=1&num=" & num & "&category=" & category & "&search_category=" & search_category & "&search_word=" & search_word & "&order_c=" & order_c & "&order_da=" & order_da & ">[o]</a>.. &nbsp;"
		END IF

		FOR I = IntStart TO IntEnd 
			IF I = IntStart THEN
				TMPSPLIT = ""
			ELSE 
				TMPSPLIT = "/"
			END IF 
			
			IF INT(I) = INT(page) THEN
				RESPONSE.WRITE "&nbsp;"&TMPSPLIT&i&"</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href=wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&page=" & I & "&category=" & category & "&search_category=" & search_category & "&search_word=" & search_word & "&order_c=" & order_c & "&order_da=" & order_da & ">"& TMPSPLIT & I & "</a>"
			END IF
		NEXT

		IF INT(TotalPage - IntStart + 1) > INT(setPageLink) THEN RESPONSE.WRITE "&nbsp; ..<a href='wizboard.asp?bmode=list&bid=" & bid & "&gid=" & gid & "&page=" & TotalPage & "&category=" & category & "&search=" & search & "&b_cat=" & b_cat & "&order_c=" & order_c & "&order_da=" & order_da & "'>[" & TotalPage & "]</a>"

		IF INT(page) + setPageLink > TotalPage + 1 THEN
		ELSEIF INT(page) + setPageLink < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href=wizboard.asp?bmode=list&page=" & INT(page + setPageLink) & "&bid=" & bid & "&gid=" & gid & "&category=" & category & "&search_category=" & search_category & "&search_word=" & search_word & "&order_c=" & order_c & "&order_da=" & order_da & "><img src='" & skin_path & "images/bt_next.gif' width='56' height='9'>"
		END IF
%>
</td>
                          </tr>
                        </table></div>
                      </td>
                    </tr>
                     
                  </table>
                  <br />
                  </b> </td>
              </tr>
            </table>
