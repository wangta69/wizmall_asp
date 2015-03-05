<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim menushow,theme,smode,sehkey,searchkey,searchkeyword,segroup,searchField
Dim segroupname, whereis, tablename, setPageSize, setPageLink, TotalCount,page
Dim orderby, ListNum

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

menushow		= Request("menushow")
theme			= Request("theme")
smode			= Request("smode")
page			= Request("page") : If page = "" then page = 1

sehkey			= Request("sehkey")
searchkey		= Request("searchkey")
searchkeyword	= Request("searchkeyword")
segroup			= Request("segroup")

if smode = "addrmove" then
		''while(list(key,value) = each(_GET)) 
		''{
			if  value = "wizMail" then

				''key = ereg_replace("_",".",key)
				sql_update = "update wizMailAddressBook set grp='movebox' where userid='WIZMAIL_USER_ID' and idx=key"
				''mysql_smode(sql_update) or die(mysql_error())
			end if
		''}
elseif  smode = "addrdelete" then
		''while(list(key,value) = each(_GET)) 
		''{
			if  value = "wizMail" then
				''key = ereg_replace("_",".",key)
			
				sql_delete = "delete from wizMailAddressBook where userid='WIZMAIL_USER_ID' and idx=key"
				''sth = mysql_smode(sql_delete) or die(mysql_error())
 			end if
		''}
elseif smode="groupedit" then
		if  groupcode <> "all" then 

			sql_update = "update wizmailaddressbook_g set subject='groupname' where userid='WIZMAIL_USER_ID' and code='groupcode'"
			''mysql_smode(sql_update) or die(mysql_error())
			segroup = groupcode
			segroupname = groupname
		end if
elseif smode = "groupdatadelete" then
		if segroup <> "all" then

			sql_delete = "delete from wizMailAddressBook where userid='WIZMAIL_USER_ID' and grp='segroup'"
			''mysql_smode(sql_delete) or die(mysql_error())
		end if
elseif smode = "groupdelete" then 
		if segroup = "all" then
			sql_delete = "delete from wizmailaddressbook_g where userid='WIZMAIL_USER_ID' and code='segroup'"
			''mysql_smode(sql_delete) or die(mysql_error())

			segroup="all"
			segroupname="전체그룹"
		end if
end if
%>
<table class="table_outline">
  <tr>
    <td><table class="table_title">
        <tbody>
          <tr>
            <td><font color="#FF6600">메일발송하기</b></td>
          </tr>
          <tr>
            <td><table cellspacing=0 cellpadding=0 width="100%" border=0>
                <tbody>
                  <tr>
                    <td align="center" width=57 valign="top"><font 
                              color=#ff6600>[note] </td>
                    <td>메일발송옵션에서 선택된 회원에게 메일이 발송됩니다.<br />
                      메일발송은 서버에 부하가 주어지므로 만단위 이상의 메일은 자제해 주시기 바랍니다.</td>
                  </tr>
                </tbody>
              </table></td>
          </tr>
        </tbody>
      </table>
      <br />
      <table class="table_main w_default">
        <tr>
          <td colspan='2'><table cellpadding='0' cellspacing='0' border='0' width='100%'>
              <tr height='20'>
                <td colspan='3'></td>
              </tr>
              <tr height='30'>
                <td width='5%'>&nbsp;</td>
                <td width='75%'> 주소록 관리 </b> >
                  <%If segroupname<> "" Then Response.Write "segroupname" else Response.Write "전체그룹"%></td>
                <td width='20%'></td>
              </tr>
            </table></td>
        </tr>
        <tr valign='top'>
          <td width='150'><table cellpadding='0' cellspacing='0' border='0' width='100%'>
              <tr height='19'> </tr>
              <tr height='2'> </tr>
              <tr>
                <td><table cellpadding='0' cellspacing='1' border='0' width='100%' bgcolor='#AFC6E9'>
                    <tr>
                      <td><table cellpadding='0' cellspacing='0' border='0' width='100%' bgcolor='#F9FBFF'>
                          <tr height='25' valign='middle'>
                            <td width='10' align='center'>&nbsp;</td>
                            <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&segroup=all&segroupname=전체그룹'>전체그룹</a> </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
              <%
whereis		= " where userid='"&user_id&"'"
strSQL		= "select * from wizmailaddressbook_g "&whereis &" order by idx desc"
set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
%>
              <tr height='1'> </tr>
              <tr>
                <td><table cellpadding='0' cellspacing='1' border='0' width='100%' bgcolor='#AFC6E9'>
                    <tr>
                      <td><table cellpadding='0' cellspacing='0' border='0' width='100%' bgcolor='#F9FBFF'>
                          <tr height='25' valign='middle'>
                            <td width='10' align='center'>&nbsp;</td>
                            <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&segroup=<%=dbcode%>&segroupname=<%=dbsubject%>'> <%=dbsubject%> </a> </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
              <%
	objRs.MOVENEXT
	WEND
%>
            </table></td>
          <td><%
tablename = "wizMailAddressBook"
whereis = " where idx <> '' "
setPageSize	= 10
setPageLink	= 10

If segroup = "" then  segroup = "all"
If segroup <>  "all"  Then whereis = whereis & " and grp='"&segroup&"' "
if sehkey = "" then sehkey = "all"
If sehkey <> "all" Then 
	''whereis = whereis & " and name LIKE '"&sehkey&"%'"
	whereis = whereis & " and CAST ( name AS binary ) LIKE 'CAST ( "&sehkey&" AS binary )%'"

End if

If searchkeyword <> "" Then 
	segroup = "all"
	sehkey = "all"
	whereis = whereis & " and userid='"&user_id&"' and "&searchkey&" like '%"&searchkeyword&"%' "
End if


'' 총 갯수 구하기
''Response.Write(whereis)
strSQL = "select count(idx) from "&tablename&" "&whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)
if page = 0 or page = "" then page = 1
%>
            <script language='JavaScript'>
<!--

function reverse()
{
  var i;

  for(i=0; i<document.addrbook.elements.length; i++)
    if (document.addrbook.elements[i].name.indexOf('@'))
	  if(document.addrbook.chkboxse.value=='1')
        document.addrbook.elements[i].checked=true;
      else
        document.addrbook.elements[i].checked=false;

  if(document.addrbook.chkboxse.value=='1') 
  {
	document.addrbook.chkboxse.value = '0';
    btn1.innerHTML = "<img src='./img/button2.gif' border=0>";
  }
  else
  {
	document.addrbook.chkboxse.value='1';
    btn1.innerHTML = "<img src='./img/button1.gif' border=0>";
  }
}

function addrbook_move()
{
    var boxselectedval = document.addrbook.movebox.value;
	var	i;
	
	if(boxselectedval == 0)
		return;

    if(document.addrbook.elements.length == 0)
	{
        alert('\n이동할 사람을 선택해 주세요!\n\n');
		return;
    }
	document.addrbook.smode.value='addrmove';
	document.addrbook.submit();    
}

function selected_addrbook_delete()
{
    if(document.addrbook.elements.length == 0)
	{
        alert('\n삭제할 사람을 선택해 주세요!\n\n');
		return;
    }

	if(confirm('\n선택한 사람들을 삭제합니다\n\n삭제작업을 진행하실려면 확인을 클릭하세요\n\n'))
	{
		document.addrbook.smode.value='addrdelete';
		document.addrbook.submit();    
	}
}

function search()
{
	document.addrbook.smode.value='';
	document.addrbook.submit();    
}

// -->

</script>
            <table width='99%' border='0' align='center' cellpadding='0' cellspacing='0'>
              <form action='./main.asp' name='addrbook' method='get'>
                <input type='hidden' name='menushow' value='<%=menushow%>'>
                <input type='hidden' name='theme' value='<%=theme%>'>
                <input type='hidden' name='smode' value=''>
                <input type='hidden' name='chkboxse' value='1'>
                <input type='hidden' name='segroup' value='<%=segroup%>'>
                <input type='hidden' name='sehkey' value='<%=sehkey%>'>
                <input type='hidden' name='searchKeyword' value='<%=searchKeyword%>'>
                <!-- 주소록 본문시작 -->
                <tr>
                  <td width='330'><!-- <table cellpadding='0' cellspacing='0' border='0'>
                <tr> 
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=all'><img src='./img/all.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㄱ'><img src='./img/kor01.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㄴ'><img src='./img/kor02.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㄷ'><img src='./img/kor03.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㄹ'><img src='./img/kor04.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅁ'><img src='./img/kor05.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅂ'><img src='./img/kor06.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅅ'><img src='./img/kor07.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅇ'><img src='./img/kor08.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅈ'><img src='./img/kor09.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅊ'><img src='./img/kor10.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅋ'><img src='./img/kor11.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅌ'><img src='./img/kor12.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅍ'><img src='./img/kor13.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=ㅎ'><img src='./img/kor14.gif' border='0'></a></td>
                  <td><a href='./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&sehkey=eng'><img src='img/eng.gif' width="42" height="18" border='0'></a></td>
                </tr>
              </table> --></td>
                  <td width='220'><table cellpadding='0' cellspacing='0' border='0' align='right'>
                      <tr>
                        <td><select name='searchkey' class='select'>
                            <option value='name' selected>이름</option>
                            <option value='company'>회사명</option>
                            <option value='hphone'>전화번호</option>
                            <option value='hand'>전화번호</option>
                          </select>
                        </td>
                        <td><input name='searchkeyword' type='text' size='12' class='input'></td>
                        <td><a href='javascript:search();'><img src='img/button8.gif' width="46" height="20" border='0' align='absmiddle'></a> </td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan='2'><table cellpadding='0' cellspacing='0' border='0' width='100%'>
                      <tr height='2'> </tr>
                      <tr>
                        <td> <table class="table_main w_default">
                            <tr align='center' valign='middle' height='23'>
                              <td width='30'>선택</td>
                              <td width='90'>이름</td>
                              <td width='130'>직장명</td>
                              <td width='131'>전화번호</td>
                              <td>전자우편</td>
                            </tr>
                            <% 
Dim idx,name,company,cphone,email
								
orderby = " order by name asc "				  
strSQL = "select TOP " & setPageSize & " * from " & tablename & whereis & " and idx not in (SELECT TOP " & ((page - 1) * setPageSize) & " idx from " & tablename & whereis & orderby & ") " & orderby 
''Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 
if objRs.EOF then
%>
                            <tr align='center' valign='middle' height='23'>
                              <td colspan="9">검색된 데이타가 없습니다.</td>
                            </tr>
                            <%
else WHILE NOT objRs.EOF
	idx		= objRs("idx")
	name	= objRs("name")
	company	= objRs("company")
	cphone	= objRs("cphone")
	email	= objRs("email")
%>
                            <tr align='center' valign='middle' height='23' onMouseOver="this.style.backgroundColor='#FBFDFF';" onMouseOut="this.style.backgroundColor='';">
                              <td width="30" height="23"><input type='checkbox' name='<%=idx%>' value='wizMail'></td>
                              <td width="90">&nbsp; <a href="./main.asp?menushow=<%=menushow%>&theme=mail/address5&smode=qup&idx=<%=idx%>"><%=name%></a> </td>
                              <td width="130">&nbsp; <%=company%> </td>
                              <td width="131">&nbsp; <%=cphone%> </td>
                              <td>&nbsp; <%=email%> </td>
                            </tr>
                            <%
	ListNum = ListNum -1
	objRs.MOVENEXT
	WEND
end if	
%>
                          </table></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan='2' height='1'></td>
                </tr>
                <tr>
                  <td colspan='2'><table cellpadding='0' cellspacing='0' border='0' width='100%'>
                      <tr>
                        <td width='70%'><table border='0' cellpadding='0' cellspacing='0' width='100%'>
                            <tr>
                              <td width='70'><a href='javascript:reverse()'>
                                <div id='btn1'><img src='img/button1.gif' width="66" height="20" border='0'></div>
                                </a></td>
                              <td width='80'>선택한 사람을</td>
                              <td width='45'><a href='javascript:selected_addrbook_delete()'><img src='img/button3.gif' width="46" height="20" border='0'></a></td>
                              <td width='145'><select name='movebox' sytle='width:134' onChange='addrbook_move()'>
                                  <option value='0' selected>다른 그룹으로 이동</option>
                                  <%

strSQL = "select * from wizmailaddressbook_g where userid='" & user_id & "' order by idx asc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
	code = objRs("code")
	subject = objRs("subject")
	Response.Write("<option value='"&code&"'>"&subject&"</option>"&chr(13)&chr(10))
objRs.MOVENEXT
WEND

%>
                                </select>
                              </td>
                              <td><img src='./img/blank.gif' border='0'></td>
                            </tr>
                          </table></td>
                        <td width='30%' align='right'><a href='./main.asp?menushow=<%=menushow%>&theme=mail/address5'><img src='img/button9.gif' width="66" height="20" border='0'></a>
                          <!--<a href="#" onClick="window.open('./address1_1.php','GroupAddWindwo','')"><img src='img/button10.gif' width="66" height="20" border='0'></a> -->
                        </td>
                      </tr>
                    </table></td>
                </tr>
              </form>
            </table>
            <!-- 주소록 본문종료 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
            </table></td>
        </tr>
      </table>
      <br />
      </b> </td>
  </tr>
</table>
