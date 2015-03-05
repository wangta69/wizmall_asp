<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%

	Dim bid, gid, categoryname, intCategoryNum, intCategoryCount,setcategoryenable
	Dim db, strSQL, strSQL1,objRs,objRs1, cmd, params, result, sqlsubcount
	Dim util
	Set util		= new utility	
	Set db			= new database
	
	bid				= Request("bid")
	gid				= Request("gid")
	categoryname	= util.getReplaceInput(Request("categoryname"), "")
	
	IF util.is_Admin = False then Call util.js_close("등급이 맞지 않습니다.","")

		SELECT CASE Request("query")
		CASE "qin"
			
			strSQL = "SELECT MAX([intcategorynum]) FROM [wiztable_category] WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' "
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			intCategoryNum = objRs(0) + 1
			
			strSQL = "INSERT INTO [wiztable_category] ([bid], [gid], [intCategoryNum], [intCategoryCount], [CategoryName]) VALUES ('" & bid & "', '" & gid & "', '" & intCategoryNum & "', '0', '" & categoryname & "') "
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			Response.Redirect("admin3.asp?bid=" & bid & "&gid=" & gid)
	
		CASE "qup"
	
			MultiSelect = Request("MultiSelect")
			strSQL = "UPDATE [wiztable_category] SET [categoryname] = '" & categoryname & "' WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '" & MultiSelect & "' "
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			Response.Redirect("admin3.asp?bid=" & bid & "&gid=" & gid)
	
		CASE "move"
		
			Dim I
			FOR I = 1 TO Request("MultiSelect").COUNT
				strSQL = "UPDATE [wizboard_" & bid & "_" & gid & "] SET [category] = '" & Request("moveCategory") & "' WHERE [category] = '" & Request("MultiSelect")(I) & "' "
				Call db.ExecSQL(strSQL, Nothing, DbConnect)
				
				strSQL = "SELECT [intCategoryCount] FROM [wiztable_category] WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '" & Request("MultiSelect")(I) & "' "
				Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				intCategoryCount = objRs(0)
				
				strSQL = "UPDATE [wiztable_category] SET [intCategoryCount] = 0 WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '" & Request("MultiSelect")(I) & "' "
				Call db.ExecSQL(strSQL, Nothing, DbConnect)

				strSQL = "UPDATE [wiztable_category] SET [intCategoryCount] = [intCategoryCount] + " & intCategoryCount & " WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '" & Request("moveCategory") & "' "
				Call db.ExecSQL(strSQL, Nothing, DbConnect)
			NEXT
			Response.Redirect("admin3.asp?bid=" & bid & "&gid=" & gid)
		
		CASE "qde"

			intCategoryNum = Request("intCategoryNum")
			strSQL = "UPDATE [wizboard_" & bid & "_" & gid & "] SET [category] = '0' WHERE [category] = '" & intCategoryNum & "' "
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			
			strSQL = "SELECT [intCategoryCount] FROM [wiztable_category] WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '" & intCategoryNum & "' "
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			intCategoryCount = objRs(0)
			
			strSQL = "UPDATE [wiztable_category] SET [intCategoryCount] = [intCategoryCount] + " & intCategoryCount & " WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '0' "
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			
			strSQL = "DELETE FROM [wiztable_category] WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' AND [intCategoryNum] = '" & intCategoryNum & "' "
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			
			Response.Redirect ("admin3.asp?bid=" & bid & "&gid=" & gid)
			
			
		CASE "set"

			strSQL = "update wiztable_board_config set setcategoryenable = '" & Request("setcategoryenable") & "' where bid = '" & Request("bid") & "' and gid = '" & Request("gid") & "'"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			
			Response.Redirect("admin3.asp?bid=" & bid & "&gid=" & gid)			
	
		CASE ELSE
			'setUseCategory = Request("setUseCategory")   : IF setUseCategory = "" THEN setUseCategory = "0"
			'strSQL = "UPDATE [wiztable_board_config] SET [setUseCategory] = '" & setUseCategory & "' WHERE [bid] = '" & bid & "' AND [gid] = '" & gid & "' ")
			'Call db.ExecSQL(strSQL, Nothing, DbConnect)
			'RESPONSE.WRITE htmlFromSubmit("저장되었습니다.", "board1.asp?bid=" & bid & "&gid=" & gid)
		END SELECT


	strSQL = "select setcategoryenable, settitle from wiztable_board_config where bid = '" & bid & "' and gid = '" & gid & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	setcategoryenable = objRs("setcategoryenable")
	settitle			= objRs("settitle")

%>
<html>
<head>
<title>관리자님을 환영합니다.[위즈보드 관리자모드]</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript">
<!--
function categorymanager(flag){
	var f = document.CategoryForm;
	if(flag == "qin"){
		f.query.value = flag;
		f.submit();
	}else if(flag == "qup"){
		if(CheckElement() == false){
			return false;
		}else{		
			f.query.value = flag;
			f.submit();
		}
	}else if(flag == "move"){
		if(CheckElement1() == false){
			return false;
		}else{		
			f.query.value = flag;
			f.submit();
		}
	}
}

function categorydelete(no){
	var f = document.CategoryForm;
	f.query.value = "qde";
	f.intCategoryNum.value = no;
	//alert(f.intCategoryNum.value);
	f.submit();
}

function CheckElement() {
	var f = document.CategoryForm;
    var nChecked
    var c = f.MultiSelect

    for( i = 0, nChecked = 0; i < c.length; i++) if( c[i].checked) nChecked++
	
    if( nChecked < 1) {
        alert( "책크를 한개이상  해주시기 바랍니다.")
        return false;
    }
}

function CheckElement1() {
	var f = document.CategoryForm;
    var nChecked
    var c = f.MultiSelect

    for( i = 0, nChecked = 0; i < c.length; i++) if( c[i].checked) nChecked++

    if( nChecked > 1) {
        alert( "1 개만 선택할 수 있습니다.")
		return false;
    }
	
    if( nChecked < 1) {
        alert( "책크를 한개해 주시기 바랍니다.")
        return false;
    }
}
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellspacing=0 bordercolordark=white width="607" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
  <form method="post" action="admin3.asp" name="BoardSelectForm">
    <tr>
      <td bgcolor="#FFFFFF"><font color="#FF6600"><strong>아이디&nbsp; :
        <select name="bid" id="bid" style="font-size:9pt" onChange="document.BoardSelectForm.submit();">
          <%	
	strSQL = "SELECT bid FROM wiztable_board_config WHERE gid = '" & gid &"'  ORDER BY bid asc "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not(objRs.eof)
		IF bid = objRs("bid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("bid") & "'" & SELECT_VALUE & ">" & objRs("bid") & vbcrlf	
	objRs.movenext
	wend
%>
        </select>
        &nbsp;&nbsp;&nbsp;그룹명 : </strong>
        <select name="gid" id="gid" style="font-size:9pt" onChange="document.BoardSelectForm.submit();">
          <%	
	strSQL = "select [gid] from [wiztable_group_config]"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not(objRs.eof)
		IF gid = objRs("gid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("gid") & "'" & SELECT_VALUE & ">" & objRs("gid") & vbcrlf	
	objRs.movenext
	wend
%>
        </select>
       [<%=settitle%>] </font></td>
    </tr>
  </form>
</table>
<table cellspacing=0 bordercolordark=white width="607" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
  <tr>
    <td><table width="600" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="12" bgcolor="#B9C2CC"><a href="./admin1.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFFFF">&nbsp;LayOut</font></a> | <a href="./admin2.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFFFF">제한설정</font></a> | <a href="./admin3.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFF00">카테고리설정</font></a> </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30">&nbsp;</td>
        </tr>
        <tr>
          <td align="center"><table width="97%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="23" colspan="2">현재위치 : Home &gt; 게시판관리 &gt; <span style="color: #ff6600; font-weight: bold">게시판 
                  카테고리 </span></td>
              </tr>
              <tr>
                <td width="39%" height="4" bgcolor="B0C7C7"></td>
                <td width="61%" height="4" bgcolor="EBEFEF"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td align="right" style="padding:5 15 0 0">&nbsp;</td>
        </tr>
       
        <tr>
          <td style="padding:10 15 10 15"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <form name="CategorySetForm" method="post" action="admin3.asp">
                <input type="hidden" name="bid" value="<%=Request("bid")%>">
                <input type="hidden" name="gid" value="<%=Request("gid")%>">
                <input type="hidden" name="query" value="set">
                <tr>
                  <td height="25"><img src="../images/icon01.gif" width="9" height="9" align="absmiddle"> 게시판 카테고리 설정 </td>
                </tr>
                <tr>
                  <td><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="DBDBDB">
                      <tr>
                        <td width="120" bgcolor="F7F7ED">카테고리 사용 </td>
                        <td bgcolor="F7F7F7"><table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><input name="setcategoryenable" type="checkbox"  value="1" <% IF setcategoryenable = 1 THEN %>CHECKED<% END IF %>>
                                게시판 카테고리 기능을 사용합니다.</td>
                              <td>&nbsp;</td>
                              <td><button name="변경" type="submit" title="변경">변경</button></td>
                            </tr>
                          </table></td>
                      </tr>
                    </table></td>
                </tr>
              </form>
            </table></td>
        </tr>
        <tr>
          <td style="padding:10 15 10 15"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <form name="CategoryForm" method="post" action="admin3.asp">
                <input type="hidden" name="bid" value="<%=Request("bid")%>">
                <input type="hidden" name="gid" value="<%=Request("gid")%>">
                <input type="hidden" name="query" value="qin">
                <input type="hidden" name="intCategoryNum" value="">
                <tr>
                  <td height="25"><img src="../images/icon01.gif" width="9" height="9" align="absmiddle"> 게시판 등록 카테고리 리스트 </td>
                </tr>
                <%
	Dim TotalCount
	strSQL = "select count([bid]) from wiztable_category where bid = '" & Request("bid") & "' and gid = '" & Request("gid") & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

	TotalCount = objRs(0)
%>
                <tr>
                  <td height="25" colspan="9">전체 <font color="#b02832"><%=TotalCount%></font> 개의 카테고리가 등록되어 있습니다.</td>
                </tr>
                <tr>
                  <td><table width="100%"  border="0" cellspacing="1" cellpadding="6" bgcolor="DBDBDB">
                      <tr align="center" bgcolor="F7F7ED">
                        <td>선택</td>
                        <td>번호</td>
                        <td>카테고리명</td>
                        <td>게시글수</td>
                        <td>삭제</td>
                      </tr>
                      <%

	strSQL = "select c.*, (select count(*) from wizboard_" & bid & "_" & gid & " where category=c.intCategoryNum) as regcount from wiztable_category c where c.bid = '" & bid & "' and c.gid = '" & gid & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	IF objRs.eof THEN
%>
                      <tr align="center" bgcolor="F7F7F7">
                        <td colspan="5">등록된 카테고리가 없습니다. </td>
                      </tr>
                      <%
	ELSE
		Dim iCount, moveCategory
		moveCategory = "<select name=moveCategory id=moveCategory style='font-size:9pt'>" & vbcrlf
		WHILE NOT(objRs.EOF)
			iCount = iCount + 1
			moveCategory = moveCategory & "<option value='" & objRs("intcategorynum") & "'>" & objRs("CategoryName") & "</option>" & vbcrlf
%>
                      <tr align="center" bgcolor="F7F7F7">
                        <td><input name="MultiSelect" type="checkbox" value="<%=objRs("intCategoryNum")%>"></td>
                        <td><%=iCount%></td>
                        <td><%=objRs("CategoryName")%></td>
                        <td><%=objRs("regcount")%></td>
                        <td><% IF iCount <> 1 THEN %>
                          <button name="" onClick="categorydelete('<%=objRs("intCategoryNum")%>');" title="삭제">삭제</button>
                          <% END IF %></td>
                      </tr>
                      <%
		objRs.MOVENEXT
		WEND
		moveCategory = moveCategory & "</select>" & vbcrlf
	END IF
%>
                    </table></td>
                </tr>
                <tr>
                  <td height="35" colspan="9"><table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><span style="color: #1e87b2">카테고리명 : </span>
                          <input name="categoryname" type="text" class="input" id="categoryname" size="18"></td>
                        <td>&nbsp;</td>
                        <td><button name="reg" onClick="categorymanager('qin');" title="등록">등록</button></td>
                        <td>&nbsp;</td>
                        <td><button name="modify" onClick="categorymanager('qup');" title="수정">수정</button></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="35" colspan="9"><table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>선택 카테고리의 게시글을 <%=moveCategory%> 의 카테고리로 </td>
                        <td><button name="change" onClick="categorymanager('move');" title="변경">변경</button></td>
                        <td>합니다.</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan="9" align="center"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="1" bgcolor="C6C6C6"></td>
                      </tr>
                      <tr>
                        <td height="2" bgcolor="EFEFEF"></td>
                      </tr>
                    </table></td>
                </tr>
              </form>
            </table></td>
        </tr>
        <tr>
          <td height="50" align="center" style="padding:10 15 10 15">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
</table>
</body>
</html>
<%
SET objRs = NOTHING
SET util = NOTHING   
%>
