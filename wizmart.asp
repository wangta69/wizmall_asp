<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "./lib/cfg.common.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<!-- #include file = "./config/db_connect.asp" -->
<!-- #include file = "./lib/class.database.asp" -->
<!-- #include file = "./lib/class.util.asp" -->
<%
Dim query, smode, code, big_code
Dim exe_file
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database

query		= Request("query")
smode		= Request("smode")
code		= Request("code")

if code <> "" then
	big_code	= right(code, 3)
	strSQL		= "select cat_skin, cat_skin_viewer from wizcategory where cat_no = " & big_code
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	if not isnull(objRs("cat_skin")) and objRs("cat_skin") <> "" then  ShopSkin = objRs("cat_skin")
	if not isnull(objRs("cat_skin_viewer")) and objRs("cat_skin_viewer") <> "" then  ViewerSkin = objRs("cat_skin_viewer")
end if
if smode = "" then smode = "finallist"
%>
<% 
	exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_start.asp"
	SERVER.EXECUTE(exe_file)
%>
<!-- 기본 js 입력 -->
<script language="javascript" src="./js/jquery-1.3.2.js"></script>
<script language="javascript" src="js/wizmall.js"></script>

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
          <!-- main body start --><table width="720" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <%							

	SELECT CASE smode
	CASE "view"
		exe_file =  "./skinwiz/viewer/" & ViewerSkin & "/" & "view.asp"
	CASE "compare"
		exe_file =  "./skinwiz/shop/" & ShopSkin & "/" & "compare.asp"
	CASE "option"
		exe_file =  "./skinwiz/shop/" & ShopSkin & "/" & "optionlist.asp"
	CASE "finallist"
		exe_file =  "./skinwiz/shop/" & ShopSkin & "/" & "list_3.asp"
	CASE "martmain"
		exe_file =  "./skinwiz/shop/" & ShopSkin & "/" & "martmain.asp"
	end select
	
	''Response.Write(exe_file)
	''Response.End()
	if exe_file <> "" THEN 
		SERVER.EXECUTE(exe_file)
	end if
%>
                </td>
              </tr>
            </table><!-- main body end -->          </td>
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
exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_close.asp"
SERVER.EXECUTE(exe_file)
%>
