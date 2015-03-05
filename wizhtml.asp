<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "./lib/cfg.common.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<%
Dim html, exe_file
Dim db,util
''Set util = new utility	
'Set db = new database
html = Request("html")
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
		exe_file =  "./skinwiz/html/" & HtmlSkin & "/" & html &".asp"
''		Response.Write exe_file
		SERVER.EXECUTE(exe_file)

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
