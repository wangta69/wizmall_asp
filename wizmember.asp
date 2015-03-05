<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "./lib/cfg.common.asp" -->
<!-- #include file = "./config/skin_info.asp" -->
<!-- #include file = "./config/db_connect.asp" -->
<!-- #include file = "./lib/class.database.asp" -->
<!-- #include file = "./lib/class.util.asp" -->
<%
dim smode, codevalue
Dim exe_file
Dim db,util
Set util = new utility	
''Set db = new database
smode		= request("smode")
codevalue	= request("codevalue")

exe_file =  "./skinwiz/layout/" & LayoutSkin & "/" & "layout_start.asp"
SERVER.EXECUTE(exe_file)
%>
<!-- 반드시 아래 자바스크립트 입력 -->
<script language="javascript" src="./js/jquery-1.3.2.js"></script>
<script language="javascript" src="./js/wizmall.js"></script>
<link rel="stylesheet" href="./css/base.css" type="text/css">

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
	if session("user_info") = "" then ''로그인해야만 가는 페이지
		select case smode
			case "point", "order", "info", "wish", "out", "mypage"
				Response.Redirect("./wizmember.asp?smode=login&fromlogin=wizmember.asp&loginflag1="&smode)
				Response.End()
			case "orderspec"
				if codevalue = "" then
					Response.Redirect("./wizmember.asp?smode=login&fromlogin=wizmember.asp&loginflag1="&smode)
					Response.End()
				end if
		end select
	end if	

	SELECT CASE smode
	CASE "point"
		Call util.denyAdmin(user_id)
		exe_file =  "wizmember/"&MemberSkin&"/user_point.asp"
	CASE "order"
		Call util.denyAdmin(user_id)
		exe_file =  "wizmember/"&MemberSkin&"/user_order.asp"
	CASE "orderspec"
		Call util.denyAdmin(user_id)
		exe_file =  "wizmember/"&MemberSkin&"/user_order_spec.asp"
	CASE "non_member_order"
		exe_file =  "wizmember/"&MemberSkin&"/user_order_spec.asp"
	CASE "info"
		Call util.denyAdmin(user_id)
		exe_file =  "wizmember/"&MemberSkin&"/user_info.asp"
	CASE "mypage"
		exe_file =  "wizmember/"&MemberSkin&"/mypage.asp"
	CASE "wish"
		Call util.denyAdmin(user_id)
		exe_file =  "skinwiz/wizwish/"&WishSkin&"/user_wish.asp"
	CASE "out"
		Call util.denyAdmin(user_id)
		exe_file =  "wizmember/"&MemberSkin&"/user_out.asp"
	CASE "logout"
		exe_file =  "wizmember/"&MemberSkin&"/logout.asp"
	CASE "passsearch"
		Call util.denyAdmin(user_id)
		exe_file =  "wizmember/"&MemberSkin&"/user_passsearch.asp"
	CASE "idpasssearch"
		exe_file =  "wizmember/"&MemberSkin&"/user_idpasssearch.asp"
	CASE "regis_step1"
		exe_file =  "wizmember/"&MemberSkin&"/user_regis_step1.asp"
	CASE "regis_step2"
		exe_file =  "wizmember/"&MemberSkin&"/user_regis_step2.asp"
	CASE "regis_step3"
		exe_file =  "wizmember/"&MemberSkin&"/user_regis_step3.asp"
	CASE "login"
		exe_file =  "wizmember/"&MemberSkin&"/user_login.asp"						
	end select
	Set util	= Nothing
''Response.Write("exe_file= " & exe_file)
''response.End()
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
