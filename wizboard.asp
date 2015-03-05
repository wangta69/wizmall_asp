<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "./lib/cfg.board.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<%
Dim redirection
''Dim db,util
Set util = new utility : Set db = new database : Set board = new boards

redirection = request("redirection")
%>
<%
if adminmode = "true" then ''admin mode 가 true 이면 기본적인 style sheet를 이곳에서 입력한다.
	setBoardWidth		= 750
	setBoardWidthStep	= "px"
	Response.Write("<link href=""wizboard/style.css"" rel=""stylesheet"" type=""text/css"">")
else
	if setmallinclude = 1 then
		exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_start.asp"
		SERVER.EXECUTE(exe_file)
	else
		IF setHeadFile <> "" AND isNULL(setHeadFile) = False THEN 	SERVER.EXECUTE(setHeadFile)
		IF setHeadMsg <> "" AND isNULL(setHeadMsg) = False THEN RESPONSE.WRITE(setHeadMsg)	
	end if
end if
%>
<!--//보드 기본 js 입력 //-->
<script language="javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" src="js/jquery.plugins/jquery.validator-1.0.1.js"></script>
<script type="text/javascript" language="javascript" src="./js/jquery.plugins/colorbox/jquery.colorbox-min.js"></script>
<link type="text/css" media="screen" rel="stylesheet" href="./js/jquery.plugins/colorbox/colorbox.css" /> 
<script language="javascript" src="js/wizmall.js"></script>
<script language="javascript" src="js/wizboard.js"></script>
<script type="text/javascript" src="js/Smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="stylesheet" href="css/board.css" type="text/css" />
<link rel="stylesheet" href="css/base.css" type="text/css" />
<!-- color picker -->
<link rel="stylesheet" media="screen" type="text/css" href="./js/jquery.plugins/colorpicker/css/colorpicker.css" />
<script type="text/javascript" src="./js/jquery.plugins/colorpicker/js/colorpicker.js"></script>


<%
if setmallinclude = 1 and adminmode <> "true" then '' 몰인클루드 옵션 실행시 몰을 인클루드 시킨다.
	setBoardWidth		= 760
	setBoardWidthStep	= "px"
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <!-- top menu start --><% 
	exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "menu_top.asp"
	SERVER.EXECUTE(exe_file)
	%><!-- top menu end -->    </td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="170" valign="top"> 
            <!-- left menu start --><% 
	exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "menu_left.asp"
	SERVER.EXECUTE(exe_file)
	%><!-- left menu end -->          </td>
          <td width="10">&nbsp;</td>
          <td valign="top"><table width="2" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="1"> </td>
                    </tr>
                  </table>
<table width="720" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 				  
<% 
end if ''if setmallinclude = 1 then
	if adminmode <> "true" and setmallinclude = 1 then
		IF setHeadFile <> "" AND isNULL(setHeadFile) = False THEN 	SERVER.EXECUTE(setHeadFile)
		IF setHeadMsg <> "" AND isNULL(setHeadMsg) = False THEN RESPONSE.WRITE(setHeadMsg)
	end if
%>				  
          <!-- main menu start --><table width="<%=setBoardWidth&setBoardWidthStep%>" border="0" cellpadding="0" cellspacing="0" align="<%=setBoardAlign%>">
<tr>
<td valign="top"  align="<%=setBoardAlign%>">
<%							
	SELECT CASE bmode
	CASE "list"
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "list.asp"
	CASE "write"
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "write.asp"
	CASE "view"
		
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "view.asp"
		'' 
		option_secret = board.getContentOptionSecret(table_name)
		bd_num = board.getParentbdnum(uid)
		if option_secret = 1 and SESSION("secret_session") <> bid & "_" & gid & "_" & bd_num and util.is_Admin() = False then
			exe_file =  "./wizboard/userlogin.asp"
		end if
	CASE "qde"
		exe_file =  "./wizboard/delete.asp"
	CASE "deleteaddimg"
		exe_file =  "./wizboard/deleteaddimg.asp"	
	CASE "check_pwd"
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "check_pwd.asp"
	CASE "login"''수정/삭제시 로그인
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "login.asp"
	CASE "memlogin"''일반적인 회원권한 관련 로그인
		exe_file =  "./wizmember/"&MemberSkin&"/user_login.asp"	
	CASE "logout"
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "logout.asp"
	CASE "comment_delete"
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "comment_delete.asp"
	CASE "error"
		exe_file =  "./wizboard/error.asp"
	CASE "scrap"
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "scrap.asp"
	end select

	SELECT CASE smode
	CASE "edit"

		if session("bid") <> bid&"_"&gid&"_"&uid and util.is_admin() = False Then

			''사용자와 동일 아이디 인지 체크
			strSQL = "select id from wizboard_" & bid & "_" & gid & " where uid=" & uid
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			''if objRs("id") = "" or session("user_id") <> objRs("id") Then
			if objRs("id") = "" or IsNull(objRs("id")) or user_id <> objRs("id") then
				exe_file =  "./wizboard/userlogin.asp"
			end if
		end if
	END SELECT
	
	''Response.Write exe_file
	if exe_file <> "" THEN 
		SERVER.EXECUTE(exe_file)
	end if
	
	IF bmode = "view" and setlistinview = 1 THEN ''리스트 포함이 책크된경우 리스트를 뿌려준다.
	''현재  exe.board.asp파일을 각각의 스킨에 대해서 분리하여 처리할 예정.(exe.board.list.asp)
		exe_file =  "./wizboard/skin/" & setSkin & "/" & "list.asp"
		SERVER.EXECUTE(exe_file)
	END If
	Set util = Nothing
%>	
</td>
</tr>
</table><!-- main menu end -->
<%
if setmallinclude = 1  and adminmode <> "true" then '' 몰인클루드 옵션 실행시 몰을 인클루드 시킨다.
%></td></tr></table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td> 
      <!-- bottom menu start --><% 
exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "menu_bottom.asp"
SERVER.EXECUTE(exe_file)
%><!-- bottom menu end -->    </td>
  </tr>
</table>
<%
end if ''if setmallinclude = 1 then
	
	if adminmode <> "true" then					
		IF setFootMsg <> "" AND isNULL(setFootMsg) = False THEN RESPONSE.WRITE(setFootMsg)
		IF setFootFile <> "" AND isNULL(setFootFile) = False THEN SERVER.EXECUTE(setFootFile)
	end if
	
%>
<% 
exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_close.asp"
if setmallinclude = 1 and adminmode <> "true" then SERVER.EXECUTE(exe_file)
%>
