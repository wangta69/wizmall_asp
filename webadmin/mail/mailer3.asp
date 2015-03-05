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

Dim theme,menushow,qry,page,searchField,searchKeyword
Dim uid,sendername,senderemail,reply,subject,contenttype,mailskin,body_txt,userfile,addsource
Dim soption,mailreject,startseq,stopseq,genderselect,gradeselect,testmailaddress,usermaillist,sdate
Dim strgender, strgrade
Dim tablename, Loopcnt
Dim strSQL,objRs
Dim db,util
Dim realtotal, whereis, TotalCount, setPageSize, setPageLink

Set util = new utility : Set db = new database

setPageSize = 10
setPageLink = 10
tablename = "wizsendmaillist"

theme			= Request("theme")
menushow		= Request("menushow")
qry				= Request("qry")
page			= Request("page") : If page = "" then page = 1
searchField		= Request("searchField")
searchKeyword	= Request("searchKeyword")


'' 회원삭제하기
if qry = "qde" then
	For Loopcnt = 1 to Request("del_check").COUNT  
		uid = Request("del_check")(Loopcnt)
		strSQL = "DELETE FROM " & tablename & " WHERE uid=" & uid
		Call db.ExecSQL(strSQL, null, DbConnect)
	Next
End If
'' 회원 삭제 하기 끝
%>
<script language=JavaScript>
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
                alert('삭제하고자 하는 메일을 체크해주세요.');
                return false;
        }
        if (confirm('\n정말로 삭제하시겠습니까? 삭제는 복구가 불가능합니다.   \n')) return true;
        return false;
        }
</script>
<table class="table_outline">
  <tr>
    <td>
                  <table class="table_main w_default">
                     
                    <tr> 
                      
            <td><font color="#FF6600">발송된 메일링 리스트</b></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table cellspacing=0 cellpadding=0 width="100%" border=0>
                           
                          <tr> 
                            <td width=57><font color=#ff6600>[note] </td>
                            
                    <td width="697">현재까지 발송된 메일링 리스트 입니다.</td>
                          </tr>
                          
                        </table>
                      </td>
                    </tr>
                    
                  </table>
                  <br />
                  <table class="table_main w_default">
        <form action='main.asp' name='memberlist' onSubmit="return really()">
          <input type=hidden name="theme" value='<%=theme%>'>
          <input type=hidden name=menushow value='<%=menushow%>'>
          <input type=hidden name=qry value='qde'>
          <input type=hidden name=page value='<%=page%>'>
          <tr> 
            <td width="30" align="center">번호</td>
            <td align="center">메일제목</td>
            <td align="center">회원등급</td>
            <td align="center">성별</td>
            <td align="center">날짜</td>
            <td align="center"><button name="" type="submit" title="메일삭제">메일삭제</button></td>
          </tr>
          <%

''총회원수 구하기

strSQL = "select count(uid) from " & tablename
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
realtotal = objRs(0)
	
whereis = " where uid is not null "	


''if targetgrade <> "" then whereis = whereis & " and m.mgrade = "& targetgrade
''if searchField <> "" and searchKeyword <> "" then whereis = whereis & " and " & searchField & " like '%" & searchKeyword & "%'" 

strSQL = "select count(*) from " & tablename  &  whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)

Dim ListNum
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1))

strSQL = "select TOP " & setPageSize & " uid,sendername,senderemail,subject,genderselect,gradeselect,sdate from "  & tablename & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from "  & tablename &  whereis & " ORDER BY uid desc) ORDER BY uid desc " 

Set objRs = db.ExecSQLReturnRS(strSQL, null, DbConnect)
If objRs.BOF or objRs.EOF Then %>
          <tr> 
            <td colspan="6" align="center">발송된 메일이 없습니다.</td>
          </tr>
          <%
Else
Do Until objRs.EOF
uid				= objRs("uid")		
sendername		= objRs("sendername")
senderemail		= objRs("senderemail")
''reply			= objRs("reply")
subject			= objRs("subject")
''contenttype		= objRs("contenttype")
''mailskin		= objRs("mailskin")
''body_txt		= objRs("body_txt")
''userfile		= objRs("userfile")
''addsource		= objRs("addsource")
''soption			= objRs("soption")
''mailreject		= objRs("mailreject")
''startseq		= objRs("startseq")
''stopseq			= objRs("stopseq")
genderselect	= objRs("genderselect")
gradeselect		= objRs("gradeselect")
''testmailaddress	= objRs("testmailaddress")
''usermaillist	= objRs("usermaillist")
sdate			= objRs("sdate")

If genderselect = "1" Then
	strgender = "남성"
ElseIf genderselect = "2" Then
	strgender = "여성"
Else
	strgender = "전체"	
End If
	
If gradeselect = "0" Then
	strgrade = "전체"
Else
	strgrade = gradeselect
End If
%>          
          <tr> 
            <td align="center">
              <%=ListNum%></td>
            <td><a HREF=' main.asp?menushow=<%=menushow%>&theme=mail/mailer3_1&uid=<%=uid%>'><font color = 'black'> 
               <%=subject%></a></td>
            <td align="center">
              <%=strgrade %></td>
            <td align="center">
              <%=strgender%>
              </td>
            <td align="center">
              <%=sdate%></td>
            <td align="center"><input TYPE=CHECKBOX name='del_check' value='<%=uid%>'>            </td>
          </tr>
          <%
		  	ListNum = ListNum - 1
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>
        </form>      </table>
<br />
                  <table cellspacing=0 cellpadding=0 width="760" 
border=0>
                     
                    <tr> 
                      <td align="center"><table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td>
<%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&searchField="&searchField&"&searchKeyword="&searchKeyword
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%>
</td>
              </tr>
            </table></td>
                    </tr>
                     
                  </table>
                  <br />
                  </b> </td>
              </tr>
            </table>
