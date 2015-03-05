<% Option Explicit %>
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
''Set util = new utility	
Set db = new database

tablename = "sendmail"

menushow = Request("menushow")
theme = Request("theme")
page =  Request("page")


			

if page = "" then page = 1
setPageSize = 10
setSubjectCut = 20
setPageLink = 10

strSQL = "SELECT COUNT(uid) FROM " & tablename 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	TotalCount = objRs(0)
	TotalPage = TotalCount / setPageSize
	IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
		TotalPage = int(TotalPage) + 1
	Else
		TotalPage = int(TotalPage)
	End if
%>
<SCRIPT>
function DELETE_THIS(UID,page,theme,menushow){
window.open("./email_send_del.asp?UID="+UID+"&page="+page+"&theme="+theme+"&menushow="+menushow,"","scrollbars=no, toolbar=no, width=340, height=150, top=220, left=350")
}
</script>
<table class="table_outline">
  <tr>
    <td><table class="table_title">
        <tr> 
          <td><font color="#FF6600">메일발송리스트</b></td>
        </tr>
        <tr> 
          <td height="53"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="70" align="center" valign="top"><font color=#ff6600>[note]</td>
                <td>발송된 메일 리스트를 보실 수 있습니다. </td>
              </tr>
            </table></td>
        </tr>
      </table>
	  
      <br />
      <table class="table_main w_default">
        <tr>
          <td width="70" align="center">NO.</td>
          <td align="center">제목</td>
          <td width="50" align="center">종류</td>
          <td width="150" align="center">읽은갯수/총갯수</td>
          <td width="70" align="center">등록일</td>
          <td width="50" align="center">삭제</td>
        </tr>
        <%
strSQL = "select TOP " & setPageSize & " m.*, (select count(*) from sendmailcount c where c.mid = m.uid) as readcount from " & tablename  & " m  where m.uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " m.uid from " & tablename & " m ORDER BY m.uid desc) ORDER BY m.uid desc " 

'Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
subject = objRs("subject")
' // 글자 길이 제한
	'IF INT(getLenSubject(cc_title)) > INT(setSubjectCut) THEN cc_title = LEFT(cc_title, INT(setSubjectCut) - 3) & "..."
	'subject = getSearchFontChange(isSearch, search_category, search_word, subject)
	


		LoopNum = LoopNum + 1
		ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - LoopNum + 1

			
Select Case objRs("flag")
    Case "t"
        flag_name = "회원전체"

    Case "a"
        flag_name = "조찬회원"

    Case "b"
        flag_name = "회원"

    Case "c"
        flag_name = "개인"
End Select 
%>
        <tr>
          <td align="center">
            <% Response.Write ListNum %>
          </td>
          <td><%=objRs("subject")%></td>
          <td align="center"><%=flag_name%></td>
          <td align="center">
            <% Response.Write(objRs("readcount")&"/"&objRs("total"))%>
          </td>
          <td align="center"><%=FormatDateTime(objRs("wdate"),2)%> </td>
          <td align="center">
            <input name="button" type="button" onclick="javascript:DELETE_THIS('<%=objRs("uid")%>','<%=page%>','<%=theme%>','<%=menushow%>')" value="삭제" />
          </td>
        </tr>
        <%
	objRs.MOVENEXT
	WEND
	
SET objRs =NOTHING

%>
      </table>
      <table width="760" border="0">
        <tr> 
          <td align="center"> 
<%
Dim TransDate
TransData = "&menushow="&menushow&"&theme=" & theme & "&kkind=" & kkind
%>
<table width="155" height="30" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center"> <%
	IntStart = INT((((page - 1) \ setPageLink)) * setPageLink + 1)
	IntEnd = INT(((((page - 1) + setPageLink) \ setPageLink)) * setPageLink)
	
	
	
	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(page) > INT(setPageLink) THEN
			RESPONSE.WRITE "<a href='main.asp?page=" & int(page - setPageLink) & TransData & "'>◀"
			RESPONSE.WRITE "<a href='main.asp?page=1" & TransData & "'></a>.. &nbsp"
		END IF
%> </td>
    <td align="center"><%


		FOR I = IntStart TO IntEnd 
			IF I = IntStart THEN
				'TMPSPLIT = ""
			ELSE 
				'TMPSPLIT = "/"
			END IF 
			
			IF INT(I) = INT(page) THEN
				RESPONSE.WRITE "&nbsp"&i&"</b>&nbsp"
			ELSE
				RESPONSE.WRITE "<a href='main.asp?page=" & I & TransData & "'>&nbsp"& I & "&nbsp</a>"
			END IF
		NEXT
%></td>
    <td align="center"> <%
		IF INT(TotalPage - IntStart + 1) > INT(setPageLink) THEN RESPONSE.WRITE "<a href='main.asp?page=" & TotalPage & TransData & "'></a>"

		IF INT(page) + setPageLink > TotalPage + 1 THEN
		ELSEIF INT(page) + setPageLink < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href='main.asp?page=" & INT(page + setPageLink) & TransData & "'>▶"
		END IF
%> </td>
  </tr>
</table>         </td>
        </tr>
      </table></td>
  </tr>
</table>
<script>
	function goUrl(f){
		//alert("dsfsdf");
		location.href = "./main.asp?menushow=menu10&theme=inquire1&kkind=" + f.kkind.value ; 
	}
</script>
