
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WizMall_Admin Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> 


<SCRIPT LANGUAGE=javascript>
<!--
function actionqry(f,val){
	f.qry.value = val;
	f.submit();
}

function cat_manage(code,flag){
	switch(flag){
		case "de":
			location.href = "main.asp?menushow=menu3&theme=category/shopmanager1&cat_flag=wizmall&ccode="+code+"&qry="+flag;
		break;
		case "coding":
			location.href = "main.asp?menushow=menu3&theme=category/shopmanager1&cat_flag=wizmall&ccode="+code+"&qry="+flag;
			location.href = "main.asp?menushow=menu3&theme=category/shopmanager1&cat_flag=wizmall&ccode="+code+"&qry="+flag;
		break;		
		default:
			location.href = "main.asp?menushow=menu3&theme=category/shopmanager1&cat_flag=wizmall&ccode="+code;
		break;
	}
	
}
//-->
</SCRIPT>
<link href="../js/Smart/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./js/HuskyEZCreator.js" charset="utf-8"></script>
<form name = "SaveCatCoding" action="./main.asp" method="post">
					<input type="hidden" name="cat_no" value = "001">
					<input type="hidden" name="theme" value = "category/shopmanager1">
					<input type="hidden" name="menushow" value = "menu3">
					<input type="hidden" name="qry" value = "codewrite">
					<input type="hidden" name="where" value = "coding">
					<input type="hidden" name="ccode" value="001">
					<tr>
						<td colspan="3" align=middle bgcolor="#ffffff"><table cellspacing=0 cellpadding=0 width="100%" bgcolor=#ffffff border=0>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<!--매장카테고리 코딩 시작 -->
								<tr>
									<td bgcolor="E0E4E8" class="s1 agn_l">숖 페이지 
										html 삽입 : html로 등록해 주시고 등록시 &lt;table&gt;테크를 만들어 넣어 주시기를 추천합니다</td>
								</tr>
							</table>
							<br>
							<span class="agn_l s1"><font color="#000000"><b>상단코딩</b></font></span><br>
							<textarea name="cat_top" cols=106 rows=5 id="cat_top" style="display:none"></textarea>
							<textarea name="ir1" id="ir1" style="width:725px; height:300px; display:none;"><p>에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 값을 지정하지 않으시면 됩니다.</p></textarea>
<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});

function insertIMG(irid,fileame)
{
 
    var sHTML = "<img src='" + fileame + "' border='0'>";
    oEditors.getById[irid].exec("PASTE_HTML", [sHTML]);
 
}

// 복수개의 에디터를 생성하고자 할 경우, 아래와 같은 방식으로 호출하고 oEditors.getById["ir2"]이나 oEditors[1]을 이용해 접근하면 됩니다.
/*
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir2",
	sSkinURI: "SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});
*/

function pasteHTMLDemo(){
	sHTML = "<span style='color:#FF0000'>이미지 등도 이렇게 삽입하면 됩니다.</span>";
	oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
}

function showHTML(){
	alert(oEditors.getById["ir1"].getIR());
}

function _onSubmit(elClicked){
	// 에디터의 내용을 에디터 생성시에 사용했던 textarea에 넣어 줍니다.
	oEditors.getById["ir1"].exec("UPDATE_IR_FIELD", []);
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.

	try{
		elClicked.form.submit();
	}catch(e){}
}
</script>

							<span class="s1"><font color="#000000"><b><br>
							하단코딩</b></font></span><br>
							<textarea name="cat_bottom" cols=106 rows=5 class="dd1" id="cat_bottom">
</textarea>
						</td>
					</tr>
					<!--매장 카테고리 코딩 끝 -->
					<br>
					<tr>
						<td  colspan=3 bgcolor="#ffffff"><div align="center">
								<input name="image" type="image" src="img/sul.gif" width="68" height="20">
							</div></td>
					</tr>
				</form>
</body>
</html>
