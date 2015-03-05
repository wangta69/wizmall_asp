<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim menushow, theme
menushow	= Request("menushow")
theme		= Request("theme")
%>
if (action == 'wizCom_write') :
/* 현재 wizMembers 와 아이디를 비교하여 동일 아이디가 존재할 경우 아이디를 사용할 수 없게 한다. */
strSQL = "select count(UID) from wizMembers where ID = 'CompID'";
sqlqry = mysql_query(strSQL) or die(mysql_error());
result = @mysql_result(sqlqry);
if(result){ echo "<script>window.alert('현재 동일 아이디가 사용중입니다. \\n\\n 아이디를 새로 변경해 주세요'); history.go(-1); </script>";
exit;
}

CompZip1 = zip1."-".zip2; 
RegDate = time();
        QUERY1 = "INSERT INTO wizCom
        (
        CompSort,CompID,CompName,CompPass,CompNum,CompKind,CompType,CompZip1,CompAddress1,CompAddress2,
        CompPreName,CompPreTel,CompChaName,CompChaTel,CompTel,CompFax,CompChaEmail,CompUrl,CompContents
        )
        VALUES
        (
        'CompSort','CompID','CompName','CompPass','CompNum','CompKind','CompType','CompZip1','CompAddress1','CompAddress2',
		'CompPreName','CompPreTel','CompChaName','CompChaTel','CompTel','CompFax','CompChaEmail','CompUrl','CompContents'
        )";
        mysql_query(QUERY1,DB_CONNECT) or die(mysql_error());
/* 만약 CompSort >= 50 (판매처) 일경우 wizMembers 에도 일부정보를 입력하여 공유하도록 한다. */
		if(CompSort >= 50 ) {
      	  QUERY1 = "INSERT INTO wizMembers
      	  (ID,PWD,Name,Zip1,Address1,Address2,Grade,RegDate)
      	  VALUES('CompID','CompPass','Name','CompZip1','CompAddress1','CompAddress2','5','RegDate')";
      	  mysql_query(QUERY1,DB_CONNECT) or die(mysql_error());
		  }


        echo "<HTML>
        <META http-equiv=\"refresh\" content =\"0;url=PHP_SELF?menu6=show&theme=basic_info5\">
       </HTML>";
        exit;
endif;


if (action == 'wizCom_modify') :
CompZip1 = zip1."-".zip2; 
strSQL = "UPDATE wizCom SET 
CompSort = 'CompSort',
CompName = 'CompName',
CompID = 'CompID',
CompPass = 'CompPass',
CompNum = 'CompNum',
CompKind = 'CompKind',
CompType = 'CompType',
CompZip1 = 'CompZip1',
CompAddress1 = 'CompAddress1',
CompAddress2 = 'CompAddress2',
CompPreName = 'CompPreName',
CompPreTel = 'CompPreTel',
CompChaName = 'CompChaName',
CompChaTel = 'CompChaTel',
CompTel = 'CompTel',
CompFax = 'CompFax',
CompChaEmail = 'CompChaEmail',
CompUrl = 'CompUrl',
CompContents = 'CompContents'
WHERE UID='uid'";
//echo "\strSQL = strSQL <br />";

result = mysql_query(strSQL,DB_CONNECT) or die(mysql_error());
//exit;
if(result){ echo "<HTML>
        <META http-equiv=\"refresh\" content =\"0;url=PHP_SELF?menu6=show&theme=basic_info5\">
       </HTML>";
        exit;
}		
endif;
%>
<script language=javascript>
function checkForm() {
        var f=document.FrmUserInfo;
        if ( !f.CompName.value.length ) {
                alert( '거래처의 상호를 입력해 주세요' );
                f.CompName.focus();
                return false;
        }
        if ( !f.CompSort.value.length ) {
                alert( '거래처의 분류를 선택해 주세요' );
                f.CompSort.focus();
                return false;
        }
        if ( !f.CompID.value.length ) {
                alert( '거래처의  아이디를 입력해 주세요' );
                f.CompID.focus();
                return false;
        }				
        if ( !f.CompPass.value.length ) {
                alert( '거래처의 접속을 위한 패스워드를 입력해 주세요' );
                f.CompPass.focus();
                return false;
        }
        if ( !f.CompNum.value.length ) {
                alert( '거래처의 사업자등록번호를 입력해 주세요' );
                f.CompNum.focus();
                return false;
        }
        if ( !f.CompKind.value.length ) {
                alert( '거래처의 업태를 입력해 주세요' );
                f.CompKind.focus();
                return false;
        }
        if ( !f.CompType.value.length ) {
                alert( '거래처의 종목을 입력해 주세요' );
                f.CompType.focus();
                return false;
        }
        if ( !f.zip1.value.length || !f.zip2.value.length) {
                alert( '우편번호를 입력해 주세요' );
                f.zip1.focus();
                return false;
        }
        if ( !f.CompAddress1.value.length ) {
                alert( '거래처의 주소를 입력해 주세요' );
                f.CompAddress1.focus();
                return false;
        }
        if ( !f.CompPreName.value.length ) {
                alert( '대표자의 성명을 입력해 주세요' );
                f.CompPreName.focus();
                return false;
        }
        if ( !f.CompChaName.value.length ) {
                alert( '담당자의 성명을 입력해 주세요' );
                f.CompChaName.focus();
                return false;
        }
}
function OpenZipcode(){
window.open("../util/zipcode/zipcode.php?form=FrmUserInfo&zip1=zip1&zip2=zip2&firstaddress=CompAddress1&secondaddress=CompAddress2","ZipWin","width=490,height=250,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
}
</script>
<table class="table_outline">
  <tr>
    <td>
<table class="table_title">
        <tr> 
                  
                <td><font color="#FF6600"><%if(smode=="modify") echo"거래처 수정"; else echo"거래처 등록";%></b></td>
        </tr>
        <tr> 
          <td height="52"> 
                  <table cellspacing=0 cellpadding=0 width="100%" border=0 class="s1">
                    <tr> 
                      <td width="70" height="48" align="center" valign="top"><font color=#ff6600>[note]</td>
                      
                <td>제품공급 거래처 및 판매처를 등록합니다. 등록된 거래처는 제품등록시에 선택할 수 있으며 제품공급 거래처를 
                  등록하면 공급 거래처별로 매출통계를 낼 수 있습니다. </td>
              </tr>
            </table></td>
        </tr>
      </table><br />

<form action='<%=PHP_SELF%>' METHOD=POST name='FrmUserInfo' onsubmit='return checkForm()'> 
<input type="hidden" name="menu6" value="show">
<input type="hidden" name="theme" value="<%=theme%>"> 
        <table class="table_main w_default">
<% 
if(!strcmp(smode,"modify")){
	if(uid){
	strSQL = "select * from wizCom where UID ='uid'";
	sqlqry = mysql_query(strSQL, DB_CONNECT) or die(mysql_error());
	list = mysql_fetch_array(sqlqry);
	Zip =  split("\-", list[CompZip1]);
	}
	echo "<input type="hidden" name='action' value='wizCom_modify'> ";
	echo "<input type="hidden" name='uid' value='uid'> ";
}else  echo "<input type="hidden" name='action' value='wizCom_write'> ";
%>
          <tr> 
            <td width="94" height="25" colspan=1><FONT COLOR="#000000">* 
              상호</td>
            <td><input name="CompName" type="text" value="<%=list[CompName]%>" size="25"></td>
            <!-- 
기업회원 구분(wizCom.CompSort)은 크게 공급처( <50 ) 과 소매처(50 <=, <100) 로 분류된다. 
01 : 도매공급자, 02 : 소매공급자, 03 : 생산자), 50 : 쇼핑몰(온라인)기업고객고객, 51 : 도매판매처, 52, 소매판매처 .. 경우에따라 이곳은 자유롭게 프로그램가능)
-->
            <td width="117" colspan=-1>* 
              거래처분류</td>
            <td><select name="CompSort">
                <option value="01" <% if(list[CompSort] == "01") echo "selected";%>>도매공급자</option>
                <option value="02" <% if(list[CompSort] == "02") echo "selected";%>>소매공급자</option>
                <option value="03" <% if(list[CompSort] == "03") echo "selected";%>>생산자</option>
                <option value="51" <% if(list[CompSort] == "51") echo "selected";%>>도매판매처</option>
                <option value="52" <% if(list[CompSort] == "52") echo "selected";%>>소매판매처</option>
              </select></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              거래처아이디</td>
            <td><input name="CompID" type="text" id="CompID" value="<%=list[CompID]%>" size="25" <% if(!strcmp(smode,"modify")) echo "readonly";%>></td>
            <td colspan=-1>* 거래처패스워드</td>
            <td><input name="CompPass" type="text" value="<%=list[CompPass]%>" size="15"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              사업자등록번호</td>
            <td colspan="3"><input name="CompNum" type="text" value="<%=list[CompNum]%>" size="25"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              업태</td>
            <td><input name="CompKind" type="text" value="<%=list[CompKind]%>" size="15"></td>
            <td colspan=-1>* 종목 </td>
            <td><input name="CompType" type="text" value="<%=list[CompType]%>" size="25"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              사업장 주소</td>
            <td colspan=3> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="25"> <input name=zip1 type=TEXT value="<%=Zip[0]%>" size=4 maxlength=3>
                    - 
                    <input name=zip2 type=TEXT value="<%=Zip[1]%>" size=4 maxlength=3> 
                    <img src="img/util_icon8.gif" width="86" height="20" onClick='OpenZipcode()'></td>
                </tr>
                <tr> 
                  <td height="25"> <input name="CompAddress1" type="text" value="<%=list[CompAddress1]%>" size="55"> 
                    <input name="CompAddress2" type="text" value="<%=list[CompAddress2]%>" size="55"> 
                  </td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              전화</td>
            <td><input name="CompTel" type="text" value="<%=list[CompTel]%>" size="15"></td>
            <td colspan=-1><FONT COLOR="#000000">* 팩스</td>
            <td><input name="CompFax" type="text" value="<%=list[CompFax]%>" size="15"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              대표자명</td>
            <td><input name="CompPreName" type="text" value="<%=list[CompPreName]%>" size="15"> 
            </td>
            <td colspan=-1>* 대표자 연락처</td>
            <td><input name="CompPreTel" type="text" value="<%=list[CompPreTel]%>" size="15"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              담당자명</td>
            <td><input name="CompChaName" type="text" value="<%=list[CompChaName]%>" size="15"> 
            </td>
            <td colspan=-1>* 담당자 연락처</td>
            <td><input name="CompChaTel" type="text" value="<%=list[CompChaTel]%>" size="15"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              담당자이메일</td>
            <td colspan=3><input name="CompChaEmail" type="text" value="<%=list[CompChaEmail]%>" size="55"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              홈페이지</td>
            <td colspan=3><input name="CompUrl" type="text" size="55" value="<%=list[CompUrl]%>"></td>
          </tr>
          <tr> 
            <td height="25" colspan=1><FONT COLOR="#000000">* 
              기타</td>
            <td colspan=3><textarea name="CompContents" cols="55" rows="6" id="CompContents"><%=list[CompContents]%></textarea></td>
          </tr>
        </table>
        <br /> <CENTER><input type="image" src="img/dung.gif" width="55" height="20"></CENTER></form>
                </td>
              </tr>
            </table>
