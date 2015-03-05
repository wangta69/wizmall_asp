<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.member.asp" -->
<!-- #include file = "../../config/common_array.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim theme, menushow, qry, targtgrade, value, searchField, searchKeyword,  multiselect
Dim Loopcnt
Dim mid,mpwd, mname, mregdate, mloginnum, companyname, mgrantsta, email, tel1, tel2, zip1, address1, address2

Dim targetgrade, mgrade, str_member, str_mgrade
Dim strSQL, objRs, params, whereis, joinon, sqlcountstr, counting
Dim setPageSize, setPageLink, page, realtotal, TotalCount, TotalPage, LoopNum, ListNum
Dim db, util, member
Set db		= new database : Set util	= new utility : Set member	= new members

qry				= Request("qry")
mid				= Request("mid")
theme			= Request("theme")
menushow		= Request("menushow")
targetgrade		= Request("targetgrade")
value			= Request("value")
searchField		= Request("searchField")
searchKeyword	= Request("searchKeyword")
multiselect		= Request("multiselect")
page			= Request("page") : if page = "" then page = 1
setPageSize		= 20
setPageLink		= 10

''keyword		=  Request("keyword")
''whereis		=  Request("whereis")
Dim ExcelFileName
response.buffer				= true
Response.Expires			= 0
Response.ContentType		= "application/vnd.ms-excel; name='My_Excel'"
''Response.Charset			= " "
''Response.Charset			= cfg.Item("lan") 
Response.CacheControl		= "public"
ExcelFileName				= "memberList_[" & Date & "]"
Response.AddHeader "Content-Disposition","attachment;filename=" & ExcelFileName & ".xls"

'' // 전체 게시물 및 전체 페이지
%>
<meta http-equiv="content-type" content="text/html; charset=<%=cfg.Item("lan")%>">

<style>
br{mso-data-placement:same-cell;}
</style>
		<table class="table_main w_default list">

          <col width="60px" title="번호"/>
          <col width="90px" title="성명"/>
          <col width="90px" title="아이디"/>
          <col width="90px" title="패스워드"/>
		  <col width="90px" title="이메일"/>
		  <col width="90px" title="전화번호1"/>
		  <col width="90px" title="전화번호2"/>
		  <col width="90px" title="주소"/>
          <col width="70px" title="등급"/>
          <col width="90px" title="가입일"/>
          <col width="60px" title="승인"/>
          <col width="60px" title="로긴수"/>
          <col width="90px" title=""/>

          <tr class="altern">
            <th>번호</th>
            <th>성명</th>
            <th>아이디</th>
            <th>패스워드</th>
			<th>이메일</th>
			<th>전화번호1</th>
			<th>전화번호2</th>
			<th>주소</th>
            <th>등급</th>
            <th>가입일</th>
            <th>승인</th>
            <th>로긴수</th>
          </tr>
<%
ListNum		= 1
whereis = " where m.uid is not null "	
joinon = " on m.mid = i.mid "
if targetgrade <> "" then whereis = whereis & " and m.mgrade = "& targetgrade
if searchField <> "" and searchKeyword <> "" then whereis = whereis & " and " & searchField & " like '%" & searchKeyword & "%'" 

strSQL = "select count(m.uid) from wizmembers m left join wizmembers_ind i " & joinon & whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)

strSQL = "select m.mgrade, m.mid, m.mpwd, m.mname, m.mregdate, m.mloginnum, m.mgrantsta, i.email, i.tel1, i.tel2, i.zip1, i.address1, i.address2 from wizmembers m left join wizmembers_ind i " & joinon & whereis & " ORDER BY m.uid desc " 

Set objRs = db.ExecSQLReturnRS(strSQL, params, DbConnect)
If objRs.BOF or objRs.EOF Then %>
          <tr>
            <td colspan="8">가입된 회원이 없습니다.</td>
          </tr>
          <%
      Else
        Do Until objRs.EOF

mgrade		= int(objRs("mgrade"))
mid			= objRs("mid")
mpwd		= objRs("mpwd")
mname		= objRs("mname")
mregdate	= objRs("mregdate")
mloginnum	= objRs("mloginnum")
''companyname	= objRs("companyname")
mgrantsta	= objRs("mgrantsta")
email		= objRs("email")
tel1		= objRs("tel1")
tel2		= objRs("tel2")
zip1		= objRs("zip1")
address1	= objRs("address1")
address2	= objRs("address2")
if mgrade <> "" then str_mgrade = MemberGradeArr(mgrade)

%>
          <tr>
            <td><%=ListNum%></td>
            <td><%=mname%></td>
            <td><%=mid%></td>
            <td><%=mpwd%></td>
			<td><%=email%></td>
			<td><%=tel1%></td>
			<td><%=tel2%></td>
			<td>(<%=zip1%>)<%=address1%> <%=address2%></td>
            <td><%=str_mgrade%></td>
            <td><%=mregdate%></td>
            <td><%		
'' 승인 상태일 경우'
if mgrantsta = "03" then
		Response.Write "승인"
''미승인 상태일 경우'		
elseif mgrantsta = "04"  then
        Response.Write"보류"
''탈퇴회원일경우'
else 
		Response.Write "탈퇴"
end if
%></td>
            <td><%=mloginnum%></td>
          </tr>
          <%
		  	ListNum = ListNum + 1
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>
      </table>