<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim qry, theme, menushow, page, smode, uid, multiselect
Dim options,phtmlenable,pshtmlenable,pbgenable,pskinname,pwidth,pheight
Dim ptop,pleft,psubject,click_url,pcontents,pattached,imgposition,popupenable
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database


qry				= Request("qry")
theme			= Request("theme")
menushow		= Request("menushow")
page			= Request("page")
smode			= Request("smode")
uid				= Request("uid")

if smode = "qup" then
	strSQL			= "select * from wizpopup where uid = " & uid & ""
	Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	options			= split(objRs("options"), "|")
	phtmlenable		= options(0)
	pshtmlenable	= options(1)
	pbgenable		= options(2)

	uid				= objRs("uid")
	pskinname		= objRs("pskinname")
	pwidth			= objRs("pwidth")
	pheight			= objRs("pheight")
	ptop			= objRs("ptop")
	pleft			= objRs("pleft")
	psubject		= objRs("psubject")
	click_url		= objRs("click_url")
	
	pcontents		= objRs("pcontents")
	pattached		= objRs("pattached")
	imgposition		= objRs("imgposition")
	popupenable		= objRs("popupenable")
else
	smode = "qin"
end if
%>
<script language="javascript">
<!--
$(function(){
	$(".btn_save").click(function(){
		oEditors.getById["ir1"].exec("UPDATE_IR_FIELD", []);
		$("#s_form").submit();
	});
});

//-->
</script>
<link href="../js/Smart/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/Smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<fieldset class="desc w_desc">
			<legend>팝업창 관리</legend>
			<div class="notice">[note]</div>
			<div class="comment"> </div>
			</fieldset>
			<div class="space20"></div>

 <form action='./util/popup1_qry.asp' id="s_form" method='post' enctype="multipart/form-data">
        <input type='hidden' name='menushow' value='<%=menushow%>'>
        <input type='hidden' name='theme' value='<%=theme%>'>
        <input type="hidden" name="qry" value="<%=smode%>">
        <input type='hidden' name='uid' value='<%=uid%>'>
        <input type="hidden" name="phtmlenable" value="1">
        <table class="table_main w_default">
          <col width="150px" />
          <col width="*" />
          <tr>
            <th>스킨선택</th>
            <td><select name=pskinname>
                <%=util.ShowFolderList(PATH_SYSTEM & "\util\wizpopup",pskinname)%>
              </select>
              &nbsp; </td>
          </tr>
          <tr>
            <th>팝업창 크기</th>
            <td>가로
              <input name='pwidth' type='text' value ="<%=pwidth%>" class='dd1' size="5" >
              pixels X 세로
              <input name='pheight' type='text' value ="<%=pheight%>" class='dd1' size="5">
              pixels </td>
          </tr>
          <tr>
            <th>팝업창 위치</th>
            <td>상단
              <input name='ptop' type='text' value ="<%=ptop%>" class='dd1' size="5" >
              pixels , 좌측
              <input name='pleft' type='text' value ="<%=pleft%>" class='dd1' size="5">
              pixels (브라우저로부터 디스플레이 위치)</td>
          </tr>
          <tr>
            <th>공지제목<br />
              <input type="checkbox" name="pshtmlenable" value="checkbox" <% if pshtmlenable="1" then
			  Response.Write "checked"
			  else
			  Response.Write""
			  end if%>>
              HTML 사용</th>
            <td><input name="psubject" type="text" value="<%=psubject%>" size="40" class='dd1'>
              (일부스킨에 따라 적용가능)</td>
          </tr>
          <tr>
            <th>공지내용</th>
            <td><textarea name="pcontents" id="ir1" rows="20" style="width:100%"><%=pcontents%></textarea>
<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "../js/Smart/SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});

function insertIMG(irid,fileame)
{
 
    var sHTML = "<img src='" + fileame + "' border='0'>";
    oEditors.getById[irid].exec("PASTE_HTML", [sHTML]);
 
}
</script></td>
          </tr>
          <tr>
            <th>이미지업로딩</th>
            <td><input type="file" name="attached" class='dd1'>
              <input name="file_del" type="checkbox" value="1">
              이미지삭제</td>
          </tr>
          <tr>
            <th>자세히보기</th>
            <td><input name="click_url" type="text" value="<%=click_url%>" size="40" class='dd1'>(url 입력시 자동설정)</td>
          </tr>          
          <tr>
            <th>이미지위치</th>
            <td><select name="imgposition">
                <option value="top" <% if imgposition = "top" then
				Response.Write ("selected")
				else Response.Write ("")
				end if%>>상</option>
                <option value="bottom" <% if imgposition = "bottom" then
				Response.Write ("selected")
				else 
				Response.Write("")
				end if%>>하</option>
              </select></td>
          </tr>
          <tr>
            <th>PopUp Enable</th>
            <td><input name="popupenable" type="checkbox" value="1" <% if popupenable="1" then
			  Response.Write ("checked")
			  else
			  Response.Write ("")
			  end if%>>
              (팝업창을 띄우시려면 이곳에 책크가 되어있어야 합니다.)</td>
          </tr>
        </table>
        <div class="agn_c w_default"><span class="button bull btn_save"><a>적용</a></span></div>
      </form>
<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing
%>
