<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "./lib/cfg.common.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<!-- #include file = "./config/db_connect.asp" -->
<!-- #include file = "./lib/class.database.asp" -->
<!-- #include file = "./lib/class.util.asp" -->
<%
Dim smode, skinmode, code, exe_file, CART_CODE
Dim db,util
Dim strSQL,objRs
''Set util = new utility	
''Set db = new database

smode		= Request("smode")
skinmode	= Request("skinmode")
code		= Request("code")
if smode = "step1" and user_id <> "" then
	smode = "step2"
end if
%>
<% 
	exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_start.asp"
	SERVER.EXECUTE(exe_file)
	%>
<!-- 카트 기본 js 입력 -->
<script language="javascript" src="./js/jquery-1.3.2.js"></script>
<script language="javascript" src="js/wizmall.js"></script>
<link href="./css/base.css" rel="stylesheet" type="text/css">
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
	CASE "cart_save"
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_save.asp"
	CASE "step1"
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_login.asp"
	CASE "step2","step3"
		''exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_select.asp"
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_write.asp"
	CASE "step3"
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_write.asp"
	CASE "step4"
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_confirm.asp"
		''주문 세션삭제
		CART_CODE				= ""
		SESSION("CART_CODE")    = CART_CODE 
	CASE "step5"
		''주문 세션삭제
		''CART_CODE				= ""
		''SESSION("CART_CODE")    = CART_CODE 
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_done.asp"
	CASE "execute"
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_qry.asp"		
	Case Else
		exe_file =  "./skinwiz/cart/" & CartSkin & "/" & "cart_save.asp"				
	end select
		''Response.Write("exe_file = "&exe_file)
	if exe_file <> "" THEN 
		SERVER.EXECUTE(exe_file)
	end if
%>
                </td>
              </tr>
            </table><!-- main menu end -->          </td>
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
SET UPLOAD = nothing
%>
