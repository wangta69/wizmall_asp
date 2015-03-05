<% Option Explicit %>
<!-- #include file = "./lib/cfg.common.asp" -->
<!-- #include file = "./config/db_connect.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<!-- #include file = "./config/mall_config.asp" -->
<!-- #include file = "./lib/class.database.asp" -->
<!-- #include file = "./lib/class.util.asp" -->
<!-- #include file = "./util/wizpopup/popinsert.asp" -->
<%
Dim query, code
Dim exe_file
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
query	= Request("query")
code	= Request("code")
if code <> "" then
	big_code = right(code, 2)
	strSQL = "select cat_skin, cat_skin_viewer from wizcategory where cat_no like '%"&big_code&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

	if not isnull(objRs("cat_skin")) and objRs("cat_skin") <> "" then  ShopSkin = objRs("cat_skin")
	if not isnull(objRs("cat_skin_viewer")) and objRs("cat_skin_viewer") <> "" then  ViewerSkin = objRs("cat_skin_viewer")
	if query = "" then query = "finallist"
end if


%>
<% 
	exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_start.asp"
	''Response.Write(exe_file)
	SERVER.EXECUTE(exe_file)
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
          <!-- main menu start --><%							


		exe_file =  "./skinwiz/index/" & MainSkin & "/" & "index.asp"

	
	if exe_file <> "" THEN 
		SERVER.EXECUTE(exe_file)
	end if
	

%><!-- main menu end -->          </td>
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
