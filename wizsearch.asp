<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "./lib/cfg.common.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<!-- #include file = "./config/db_connect.asp" -->
<!-- #include file = "./lib/class.database.asp" -->
<!-- #include file = "./lib/class.util.asp" -->
<%
dim smode, exe_file
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
''Set db = new database
smode = request("smode")
%>
<% 
	exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_start.asp"
	SERVER.EXECUTE(exe_file)
	%>
<!-- 기본 js 입력 -->
<script language="javascript" src="./js/jquery-1.3.2.js"></script>
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
          <!-- main menu start --><table width="720" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <%

	SELECT CASE smode
	CASE "search", "natural"
		exe_file =  "skinwiz/search/"&SearchSkin&"/result.asp"
	CASE "alpha"
		exe_file =  "skinwiz/search/"&SearchSkin&"/alpha.asp"
	CASE Else
		exe_file =  "skinwiz/search/"&SearchSkin&"/search.asp"
	end select
	if exe_file <> "" THEN SERVER.EXECUTE(exe_file)
%>
                </td>
              </tr>
            </table><!-- main menu end -->          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td> 
      <!-- bottom menu start --><!-- bottom menu end -->    </td>
  </tr>
</table>
<% 
exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_close.asp"
SERVER.EXECUTE(exe_file)
%>
