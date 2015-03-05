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
Set util = new utility	
Set db = new database

if(query == "groupedit" && groupcode != "all"){
			sql_update = "update wizMailAddressBookG set subject='groupname' where userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]' and code='groupcode'";
			mysql_query(sql_update);
			segroup = groupcode;
			segroupname = groupname;
		}
if(query =="groupdatadelete" && segroup != "all"){
			sql_delete = "delete from wizMailAddressBook where userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]' and grp='segroup'";
			mysql_query(sql_delete);
		}
if(query == "groupdelete" && segroup != "all"){
			sql_delete = "delete from wizMailAddressBookG where userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]' and code='segroup'";
			mysql_query(sql_delete);

			segroup="all";
			segroupname="전체그룹";
		}				
%>
<table cellspacing=0 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1>
  <tr> 
    <td colspan='2'>
	  <table cellpadding='0' cellspacing='0' border='0' width='100%'>
        <tr height='20'><td colspan='3'></td></tr>
        <tr height='30'> 
          <td width='5%'>&nbsp;</td>
          <td width='75%'> 그룹관리</b></td>
          <td width='20%'></td>
        </tr>
      </table>
	</td>
  </tr>
  <tr valign='top'>
    <td width='150'> <table cellpadding='0' cellspacing='0' border='0' width='100%'>
        <tr height='19'> 
          <td></td>
        </tr>
        <tr height='2'> 
          <td></td>
        </tr>
        <tr> 
          <td> <table cellpadding='0' cellspacing='1' border='0' width='100%' bgcolor='#AFC6E9'>
              <tr> 
                <td> <table cellpadding='0' cellspacing='0' border='0' width='100%' bgcolor='#F9FBFF'>
                    <tr height='25' valign='middle'> 
                      <td width='10' align='center'>&nbsp;</td>
                      <td><a href='<%=PHP_SELF%>?menu2=show&theme=<%=theme%>&segroup=all&segroupname=전체그룹'>전체그룹</a> 
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <%

SQL = "select * from wizMailAddressBookG where userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]' order by idx asc";
Rs=mysql_query(SQL);
Total=mysql_num_rows(Rs);

if(Total)
{
	cnts = 0;
	while(cnts < Total)
	{
		dbcode = mysql_result(Rs,cnts,"code");
		dbsubject = mysql_result(Rs,cnts,"subject");
%>
        <tr height='1'> 
          <td></td>
        </tr>
        <tr> 
          <td> <table cellpadding='0' cellspacing='1' border='0' width='100%' bgcolor='#AFC6E9'>
              <tr> 
                <td> <table cellpadding='0' cellspacing='0' border='0' width='100%' bgcolor='#F9FBFF'>
                    <tr height='25' valign='middle'> 
                      <td width='10' align='center'>&nbsp;</td>
                      <td><a href='<%=PHP_SELF%>?menu2=show&theme=<%=theme%>&segroup=<%=dbcode%>&segroupname=<%=dbsubject%>'> 
                        <%=dbsubject%>
                        </a> </td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <%

		cnts = cnts + 1;
	}
}

%>
      </table></td>
    <td>

<script language='javascript'>

function sendit() 
{

        if (document.WizMailFrm.groupname.value == '') {
            alert('\n그룹명을 입력해 주세요!\n\n');
			document.WizMailFrm.groupname.focus();
            return;
        }
		document.WizMailFrm.submit();
        
}

</script>

<table width='98%' border='0' align='center' cellpadding='0' cellspacing='0'>

  <tr> 
    <td width='300'>
	  <table cellpadding='0' cellspacing='0' border='0'>
        <tr height='20'> 
                <td width='13'>&nbsp;</td>
		  <td>그룹 등록정보</td>
        </tr>
      </table>
	</td>
    <td width='250' align='right'>
	  (<font color='red'>*)는 필수 입력 사항입니다.
	</td>
  </tr>
  <tr> 
    <td colspan='2'> 
	  <table cellpadding='0' cellspacing='0' border='0' width='100%'>
<form action='<%=PHP_SELF%>' name='WizMailFrm' method='get'>
	  <input type='hidden' name='menu2' value='show'>
	  <input type='hidden' name='theme' value='<%=theme%>'>
      <input name='query' type='hidden' value='groupedit'>
	  <input name='groupcode' type='hidden' value='<%=segroup%>'>  
        <tr height='2'><td></td></tr>
        <tr height='23'> 
                  <td width='150' bgcolor='E0E4E8'>&nbsp;&nbsp; 코드</td>
          <td width='400'>&nbsp;
<%		  
		  if(segroup != "all") echo("segroup");
		  else echo("none");
%></td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 이름<font color='red'>*</td>
          <td width='400'>
		    <table cellpadding='0' cellspacing='0' border='0' width='380'>
			  <tr>
			    <td width='262'>
		          &nbsp;<input type='text' name='groupname' size='35' maxlength='10' class='input' onblur="this.style.backgroundColor='#F7F7F7'" onfocus="this.style.backgroundColor='#E2F5FF'" value='<%=segroupname%>'>
			    </td>
			    <td width='118'>
<%
if(segroup != "all"):
%>
<a href='javascript:sendit();'><img src='img/button11.gif' width="46" height="20" border='0'></a>
<%
endif;
%>
</td>
			  </tr>
			</table>
		  </td>
        </tr>
<%

qureystr = "userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]' ";

if(segroup != "all")
	qureystr .= "and grp='segroup' ";

SQL_cnt = "select count(*) as addrcnt from wizMailAddressBook where qureystr";
Rs_cnt = mysql_query(SQL_cnt);
list(addrcnt) = mysql_fetch_row(Rs_cnt);
%>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 등록된사람</td>
          <td>&nbsp;<%=addrcnt%> 명</td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 데이타삭제</td>
          <td>
<%
if(segroup != "all"):
%>		  
		    <table cellpadding='0' cellspacing='0' border='0' width='380'>
			  <tr>
			    <td width='50'>&nbsp;<a href="javascript:if(confirm('\n데이타를 삭제합니다.\n\n그룹에 등록된 모든 데이타가 영구히 삭제됩니다\n\n')){location.href='<%=PHP_SELF%>?menu2=show&theme=<%=theme%>&query=groupdatadelete&segroup=<%=segroup%>&segroupname=<%=segroupname%>';}"><img src='img/button3.gif' width="46" height="20" border='0'></a></td>
			    <td width='330'>(그룹에 등록된 모든 데이타가 영구히 삭제됩니다)</td>
			  </tr>
			</table>
<%
endif;
%>			
		  </td>
        </tr>
        <tr height='23'> 
                  <td bgcolor='E0E4E8'>&nbsp;&nbsp; 그룹삭제</td>
          <td>
<%
if(segroup != "all"):
%>
		    <table cellpadding='0' cellspacing='0' border='0' width='380'>
			  <tr>
			    <td width='50'>&nbsp;<a href="javascript:if(confirm('\n그룹을 삭제합니다.\n\n그룹과 그룹에 등록된 모든 데이타가 영구히 삭제됩니다\n\n')){location.href='<%=PHP_SELF%>?menu2=show&theme=<%=theme%>&query=groupdelete&segroup=<%=segroup%>&segroupname=<%=segroupname%>';}"><img src='img/button3.gif' width="46" height="20" border='0'></a></td>
			    <td width='330'>(그룹과 그룹에 등록된 모든 데이타가 영구히 삭제됩니다)</td>
			  </tr>
			</table>
<% endif; %>			
		  </td>
        </tr>
        <tr height='2'><td></td></tr></form>
      </table>
	</td>
  </tr>

</table>

	</td>
  </tr>
</table>
