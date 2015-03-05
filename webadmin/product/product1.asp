<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util,mall
''Set util = new utility	
Set db		= new database
Set mall	= new malls

dim htmleditimgfolder : htmleditimgfolder	= session.SessionID
Dim uid,theme,qry,menushow,idx, smode
Dim page, s_category ''수정에서 넘어온 경우
Dim pictureArr, productImgDir
Dim i, j, addcomma, checked
Dim pid,pname,brand,deliveryfee,compname,price,price1,wongaprice,point,unit,model,porigin,psize,color
Dim option1,option2,option3,option4,option5,pnone,pdisplay,pinput,poutput,stock,wdate,description1
Dim description2,description3,category,texttype,hit,getcomp,tmppicture,picture0
Dim picture1,picture2,big_category,mid_category,small_category
Dim Loopcnt, selected,cnt

uid			= Request("uid")
theme		= Request("theme")
page		= Request("page")
s_category	= Request("s_category")
qry			= Request("qry")
menushow	= Request("menushow")
idx			= Request("idx")

if qry = "qde" then   '개별 파일 삭제옵션시 실행				
	strSQL			= "SELECT picture FROM wizMall WHERE UID='"&uid&"'"
	Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	pictureArr		= split(objRs("Picture"),"|")
	productImgDir	= SYSTEM_URL&"config\wizstock\"
	CALL FileDelete(productImgDir, del_Picture)		
	
	rePicture = ""
	for i=0 to Ubound(pictureArr)
		idx = int(idx)
		if i <> idx and pictureArr(i) <> "" then
			rePicture = rePicture & pictureArr(i) &  "|"
		end if	
	next		 		
	
	strSQL = "update wizMall set Picture='"&rePicture&"' where uid='"&uid&"' "
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Set objRs	= Nothing : db.Dispose : Set db	= Nothing
	Response.Write "<script>location.href='main.asp?menushow="&menushow&"&theme="&theme&"&uid="&uid&"&page="&page&"';</script>"
	Response.End()			
end if

if uid <> "" then  ' 상품 목록을 wizMall Table에서 가져옮 
	strSQL = "SELECT * FROM wizMall WHERE uid='"&uid&"'"
	''Response.Write(strSQL)
	Set objRs		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	pid				= objRs("pid")
	pname			= objRs("pname")
	brand			= objRs("brand")
	deliveryfee		= objRs("deliveryfee")
	compname		= objRs("compname")
	price			= objRs("price")
	price1			= objRs("price1")
	wongaprice		= objRs("wongaprice")
	point			= objRs("point")
	unit			= objRs("unit")
	model			= objRs("model")
	porigin			= objRs("porigin")
	
	psize			= objRs("psize")
	color			= objRs("color")
	option1			= objRs("option1")
	option2			= objRs("option2")
	option3			= split(objRs("option3"), "|")
	option4			= objRs("option4")
	option5			= objRs("option5")
	pnone			= objRs("pnone")
	pdisplay		= objRs("pdisplay")
	pinput			= objRs("pinput")
	poutput			= objRs("poutput")
	stock			= objRs("stock")
	wdate			= objRs("wdate")
	description1	= objRs("description1")
	description2	= objRs("description2")
	description3	= objRs("description3")
	category		= objRs("category")		
	texttype		= objRs("texttype")
	hit				= objRs("hit")		
	getcomp			= objRs("getcomp")
	tmppicture		= objRs("Picture")
	if tmppicture = "" or isnull(tmppicture) then	tmppicture = "|"
	//ReDim pictureArr(3)
	pictureArr = split(tmppicture,"|")'' picture = "a|b|c"
	for i=0 to Ubound(pictureArr)''수동으로 처리할 경우에 대비해..
		if i = 0 then 
			picture0 = pictureArr(i)
		elseif i = 1 then 
			picture1 = pictureArr(i)
		elseif i = 2 then
			picture2 = pictureArr(i)
		end if
	next
	big_category	= right(category, 3)
	mid_category	= right(category, 6)
	small_category	= right(category, 9)
	Set objRs	= Nothing : db.Dispose : Set db	= Nothing
	smode = "qup"
else
	smode = "qin"
end if
%>
<link href="../js/Smart/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/Smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="../js/jquery.plugins/jquery.selectboxes.min.js"></script>
<script type="text/javascript">
<!--
$(function(){
	// 대분류 검색
	$("#multicat1").change(function(){
		var cate = this.value;
		$.post(
			"./product/multicategory.asp", 
			{ 
				'cate' : cate,
				'step' : '1'
			},
			function(data){
				eval("var obj = "+data);
				$("#multicat2").removeOption(/./);
				
				$.each(obj[0], function(index, value){
					$("#multicat2").addOption(index, value, false);
				});
			}
		);
	});
	
	//중분류검색
	$("#multicat2").change(function(){
		var cate = this.value;
		$.post(
			"./product/multicategory.asp", 
			{ 
				'cate' : cate,
				'step' : '2'
			},
			function(data){
				eval("var obj = "+data);
				$("#multicat3").removeOption(/./);
				$.each(obj[0], function(index, value){
					$("#multicat3").addOption(index, value, false);
				});
			}
		);
	});	
	
	$("#multicat3").change(function(){
		setmulti();
	});
	
	// 다중카테고리 등록
	var setmulti = function(){
		var index = $("#multicat3 > option:selected").val()
		var value = $("#multicat3 > option:selected").text()
		$("#tmp_multi").addOption(index, value, false);
	}
	
	//다중카테고리에서 삭제
	$("#btn_del_tmpmulti").click(function(){
		var value = $("#tmp_multi > option:selected").val()
		$("#tmp_multi").removeOption(value); 
	});
	
	$(".btn_submit").click(function(){
		$("#tmp_multi > option").attr("selected", "selected")
		if ( !$("#category").val()) {
			alert( '등록할 카테고리를 선택해주세요' );
			$("#category").focus();
			//return false;
		}else if ( !$("#pname").val()) {
			alert( '상품의 이름을 입력해주세요' );
			$("#pname").focus();
			//return false;
		}else if ( $("#price").val() == 0 ) {
			alert( '상품의 판매가를 입력해주세요' );
			$("#price").focus();
			//return false;
		}else{
			oEditors.getById["ir1"].exec("UPDATE_IR_FIELD", []);
			$("#s_form").submit();
		}
	});

});
//-->
</script>

<script language=javascript>
<!--

function checkPdForm(){
	var f = document.writeForm
	
	//멀티카테고리 전체 선택하기

	$("#tmp_multi").selectOptions(/^val/i);
	return false;
	/*
	if ( f.category.value == "" ) {
		alert( '등록할 카테고리를 선택해주세요' );
		f.category1.focus();
		return false;
	}else if ( f.pname.value.length == 0 ) {
		alert( '상품의 이름을 입력해주세요' );
		f.pname.focus();
		return false;
	}else if ( f.price.value.length == 0 ) {
		alert( '상품의 판매가를 입력해주세요' );
		f.price.focus();
		return false;
	}else return true;
	*/
}
//-->
</script>
<script>
<!--
function addToPIC()
{
 var oID = document.getElementById('nameToDiv');

  var item = document.createElement("input");
  item.setAttribute('type','file');
  item.setAttribute('name','attached');
  item.setAttribute('class','dd1');
  oID.appendChild(item);
  
/*
기존 IE 용
	nameToDiv.insertAdjacentElement("BeforeEnd",document.createElement("<br />"));
	nameToDiv.insertAdjacentElement("BeforeEnd",document.createElement("<input type='file' name='attached' class='dd1'>"));
	*/
}

function getValue(targ,selObj,restore,cat,targi,targv){ //v3.0
if(targv) {
var preval = targv.options[targv.selectedIndex].value;
}
else var preval = "";
  eval(targ+".location='./subcategory1.asp?keyword='+selObj.options[selObj.selectedIndex].value+'&targi='+targi+'&preval='+preval+'&cat="+cat+"'");
  if (restore) selObj.selectedIndex=0;
}




function DeleteMultiCat(sel){
	var f=document.goods_modify
	var selectedIndexNo = sel.selectedIndex;
	sel.options[sel.selectedIndex]=null;
}


function del(obj,no,idx){
	location.href = "./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&uid="+no+"&qry=qde"+ "&del_Picture=" + obj+"&idx="+idx;    	 
}

//옵션관련 자바스크립트 시작
function listOptionCnt(v, inicnt){
	var f = document.writeForm;
	var cnt = parseInt(v.value);
	//alert(cnt);
	var data = "";
	for (i=1+parseInt(inicnt); i <= cnt; i++)    { 
		tmpno = "0"+i;
		var k = i-1;

		data = data +
		"<table  cellpadding=8 cellspacing=0 id='objOption' bgcolor=f3f3f3 border=0 bordercolor=#cccccc style='border-collapse:collapse' class='s1'>"+
		"<tr>"+
		"<td valign='top' id=currPosition>옵션명 : <input name='opname' class='dd1' value=''> "+
		"<select name='opcnt' onChange='listeachOptionCnt(this, "+k+", 0)'>"+
		"<option value='0'>갯수</option>"+
		"<option value='1'>1</option>"+
		"<option value='2'>2</option>"+
		"<option value='3'>3</option>"+
		"<option value='4'>4</option>"+
		"<option value='5'>5</option>"+
		"<option value='6'>6</option>"+
		"<option value='7'>7</option>"+
		"<option value='8'>8</option>"+
		"<option value='9'>9</option>"+
		"<option value='10'>10</option>"+
		"<option value='11'>11</option>"+
		"<option value='12'>12</option>"+
		"<option value='13'>13</option>"+
		"<option value='14'>14</option>"+
		"<option value='15'>15</option>"+
		"</select> "+
		"<select name='opflag'> "+
		"<option value='0' selected='selected'>기본</option> "+
		"<option value='1'>가격추가</option>"+
		"<option value='2'>원가격변경</option>"+
		"</select></td>"+
		"<td valign='middle'><span id='add_optioneach_"+k+"'></span></td>"+
		"</tr>"+
		"</table>";
		
	}
	if (document.layers){  
		document.layers.add_option.document.write(data);  
		document.layers.add_option.document.close();  
	}else{  
		if (document.all){  
			add_option.innerHTML = data;
			
		}  
	}

}


function listeachOptionCnt(v, uid, inicnt){
	var f = document.writeForm;
	var cnt = v.value;
	var data = "";
	//uid = uid + parseInt(f.optioncntadd.value);
	for (i=1+parseInt(inicnt); i <= cnt; i++)    { 
		tmpno = "0"+i;
		var k = i-1;
		//var k = i-1 + parseInt(f.optioncntadd.value);
		data = data +
		"<table border='0' cellspacing='0' cellpadding='0' class='s1'>"+
		"<tr>"+
		"<td >옵션값:"+
		"<input name='optioneachname_"+uid+"' class='dd1' size='10' /> "+
		"가격:"+
		"<input name='optioneachprice_"+uid+"' class='dd1' size='5' value='0'> "+
		"재고: "+
		"<input name='optioneachqty_"+uid+"' class='dd1' size='3' value='0'></td>"+
		"</tr>"+
		"</table>";
		
	}
	
	if (document.layers){  
		eval("document.layers.add_optioneach_"+uid+".document.write(data)");  
		eval("document.layers.add_optioneach_"+uid+".document.close()");  
	}else{  //if (document.all){ 
	 
		eval("add_optioneach_"+uid+".innerHTML = data");
	}

}

function option_del(el)
{
	idx = el.rowIndex;
	obj = el.parentNode
	obj.deleteRow(idx);
	//deleteRow(idx);
	//deleteRow(el);

}

//옵션관련 자바스크립트 끝

-->
</script>
<script id="dynamic"></script>
<script language=javascript>
<!--
function getCategory(step,v,flag){
	form = v.form.name;
	var f = eval("document."+form)
	f.category.value = v.value
	if (step != 3){	
		dynamic.src = "./product/subcategory1.asp?step="+step+"&trigger="+v.value+"&form="+form+"&flag="+flag;
	}
}
//-->
</script>
<table class="table_outline">
	<tr>
		<td>
		
<fieldset class="desc">
<legend>제품 등록</legend>
<div class="notice">[note]</div>
<div class="comment">제품을 카테고리에 맞게 분류하여 등록하십시오.<br />
									등록카테고리를 지정하실 때에는 가장 하위 카테고리에 등록해 주시기 바랍니다. <br />
									스킨마다 약간식의 적용 옵션이 달라 질 수 도 있습니다. </div>
</fieldset>
<div class="space20"></div>

			<form  action="./product/product1_qry.asp" method='post' name="writeForm" id="s_form" enctype='multipart/form-data'>
				<input type="hidden" name="qry" value="<%=smode%>">
				<input type="hidden" name=menushow value=<%=menushow%>>
				<input type="hidden" name="theme" value="<%=theme%>">
				<input type="hidden" name='uid' value='<%=uid%>'>
				<input type="hidden" name="category" id="category" value="<%=category%>">
				<input type="hidden" name="s_category" id="s_category" value="<%=s_category%>">
				<input type="hidden" name='page' value='<%=page%>'>
				<input type="hidden" name='htmleditimgfolder' value='<%=htmleditimgfolder%>'>
				<!-- 다중카테고리용으로 히든 값을 보낸다. 5개 이상 보내고 싶을 경우 이 부분의 hindden 값을 조정 -->
				<input type="hidden" id=TmpMultiCategoryvalue name='TmpMultiCategoryvalue' value=''>
				<table class="table_main w_default">
					<col width="100px">
					<col width="*">
					<tr>
						<th>등록카테고리</th>
						<td>
							<select name="category1"  onChange="getCategory('1', this, 'wizmall');">
								<option value="" selected>대분류 </option>
								<option value="">----------------</option>
								<% Call mall.getSelectCategory(1, category) %>
							</select>
							<select name="category2" onChange="getCategory('2', this, 'wizmall');">
								<option value="" selected>중분류</option>
								<option value="">----------------</option>
								<% if smode="qup" then Call mall.getSelectCategory(2, category) %>
							</select>
							<select name="category3" onChange="getCategory('3', this, 'wizmall');">
								<option value="" selected>소분류</option>
								<option value="">----------------</option>
								<% if smode="qup" then Call mall.getSelectCategory(3, category) %>
							</select>
							(등록카테고리가 없을시 카테고리를 <a href="./main.asp?menushow=menu3&theme=category/shopmanager1">등록</a> 하세요)</td>
					</tr>
					<tr>
						<th>다중카테고리</th>
						<td ><table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="top">
										<select id="multicat1">
											<option value="" selected>대분류 </option>
											<option value="">----------------</option>
											<% Call mall.getSelectCategory(1, "") %>
										</select>
										<select name="multicat" id="multicat2">
											<option value="" selected>중분류</option>
											<option value="">----------------</option>
										</select>
										<select id="multicat3">
											<option value="" selected>소분류</option>
											<option value="">----------------</option>
										</select></td>
									<td valign="top"><select name="tmp_multi" id="tmp_multi" size="5" multiple>
<%
''다중카테고리에 등록된 제품가져오기
if uid <> "" then
	Set db		= new database
	strSQL = "SELECT m.category, c.cat_name FROM wizMall m  left join wizCategory c on m.category = c.cat_no WHERE m.uid <>" & uid & " and m.pid = " & uid
	Response.Write(strSQL)
	Set objRs1		= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	Dim cat_name
	while not objRs1.eof
		category = objRs1("category")
		cat_name = objRs1("cat_name")
%>									
										<option value="<%=category%>"><%=cat_name%></option>
<%
		objRs1.movenext
	wend
	Set objRs1	= Nothing : db.Dispose : Set db	= Nothing
end if
%>										
										</select><span class="button bull" id="btn_del_tmpmulti"><a >제거</a></span></td>
								</tr>
						</table></td>
					</tr>
					<tr>
						<th>상품명</th>
						<td>
							<input type="text" name="pname" id="pname" value="<%=pname%>">
							</td>
					</tr>
					<tr>
						<th>상품모델명</th>
						<td >
							<input type="text" name="model" value="<%=model%>">
							- 사용하지 않을경우 공백처리</td>
					</tr>
					<tr>
						<th>원산지</th>
						<td >
							<input type="text" name=porigin value="<%=porigin%>" size=26>
							- 사용하지 않을경우 공백처리</td>
					</tr>
					<tr>
						<th>판매가</th>
						<td >
							<input type="text" name="price" id="price" value="<% if price = "" then 
							Response.Write("0")
							else 
							Response.Write price
							End if%>" size=26>
							콤마(,)없이 숫자로만 입력(보기:10000)</td>
					</tr>
					<tr>
						<th>시중가</th>
						<td>
							<input type="text" name=price1 value="<%=price1%>" maxLength=30>
							콤마(,)없이 숫자로만 입력(보기:10000)- 사용하지 않을경우 공백처리</td>
					</tr>
					<tr>
						<th>부가 포인트</th>
						<td >
							<input type="text" name=point value="<%=point%>" size=26>
							이 상품에 부가할 마일리지포인트. </td>
					</tr>
					<tr>
						<th>큰그림<br />
							<input name="copyenable" type="checkbox" id="copyenable" value="1" />
								이미지copy</th>
						<td ><table width="583" border="0" cellpadding="0" cellspacing="0" height="18">
								<tr>
									<td >
										<input type='file' name='attached'></td>
									<td>
										<%if picture0 <> "" then%>
										<a href='../config/wizstock/<%=picture0%>' target=_blank><img src ='../config/wizstock/<%=picture0%>' width = 30 border="0"></a> <%=picture0%>
										<% end if%>
										(권장사이즈 : 500 x 500)</td>
								</tr>
							</table>
							(그림파일의 이름은 영문으로 표기하시기를 권장합니다.)</td>
					</tr>
					<tr>
						<th>중간그림</th>
						<td ><table class="table_blank">
								<tr>
									<td width="285">
										<input type='file' name='attached' class='dd1'></td>
									<td width="262"><%if picture1 <> "" then%>
										<a href='../config/wizstock/<%=picture1%>' target=_blank><img src ='../config/wizstock/<%=picture1%>' width = 30 border="0"></a> <%=picture1%>
										<% end if%>
										
										<input type="button" value="삭제" onClick = "del('<%=picture1%>','<%=uid%>','1');"></td>
								</tr>
							</table>
							<!--<table class="table_blank">
                <tr>
                  <td width="256">
                    <div id='nameToDiv'></div>
                    </td>
                  <td valign="bottom"><img src="img/chu.gif" width="68" height="20" value="추가하기" onClick="javascript:addToPIC() ;return false";> </td>
                  <td > (권장사이즈 
                    : 500 x 500) </td>
                </tr>
              </table>//--></td>
					</tr>
					<tr>
						<th>작은그림</th>
						<td ><table class="table_blank">
								<tr>
									<td width="285">
										<input type='file' name='attached' class='dd1'></td>
									<td width="262"><%if picture2 <> "" then%>
										<a href='../config/wizstock/<%=picture2%>' target=_blank><img src ='../config/wizstock/<%=picture2%>' width = 30 border="0"></a> <%=picture2%>
										<% end if%>
										
										<input type="button" value="삭제" onClick = "del('<%=picture2%>','<%=uid%>','2');"></td>
								</tr>
							</table>
							<!--<table class="table_blank">
                <tr>
                  <td width="256">
                    <div id='nameToDiv'></div>
                    </td>
                  <td valign="bottom"><img src="img/chu.gif" width="68" height="20" value="추가하기" onClick="javascript:addToPIC() ;return false";> </td>
                  <td > (권장사이즈 
                    : 500 x 500) </td>
                </tr>
              </table>//--></td>
					</tr>
					<%
''##옵션관련 정보를 불러온다
Dim optioncnt : optioncnt = 0
Dim oname, oflag, ouid, objRs1, valuecnt, subcnt
Set db = new database
if uid <> "" then 
	strSQL = "select count(*) from wizMalloptioncfg where opid = '" & uid & "'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	optioncnt	= objRs(0)
else
	optioncnt	= 0
end If

%>
					<input type="hidden" name="optioncntadd" value="<%=optioncnt%>" />
					<th>옵션설정</th>
						<td>
							<select name="optioncnt" id="optioncnt" onchange="listOptionCnt(this, '<%=optioncnt%>')">
								<option value="0">갯수</option>
								<%
				For Loopcnt=1 to 5
					if optioncnt = Loopcnt then  selected = "selected" else selected = ""
					Response.Write( "<option value='" & Loopcnt & "' "& selected & ">" & Loopcnt & "</option>" & Chr(13) & Chr(10))
				Next
				%>
							</select>
							(옵션필드갯수:색상, 사이즈, 인치...) <br />
							가격추가나 원가격변동은 택1하여 사용해 주시기 바랍니다.<br />
							옵션당 한개의 값만 입력하시면 단일 텍스트가 출력됩니다.
							<%
if uid <> "" then 
	strSQL = "select * from wizMalloptioncfg where opid = '" & uid & "' order by oorder asc"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	cnt=0
	WHILE NOT objRs.EOF
		oname	= objRs("oname")
		oflag	= objRs("oflag")
		ouid	= objRs("uid")
		
		''옵션값갯수구하기
		strSQL = "select count(*) from wizMalloption where ouid = '" & ouid & "'"
		Set objRs1	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		''if NOT objRs1.EOF then 
		valuecnt	= objRs1(0)
		''Response.Write("strSQL:" & strSQL & "<br />")
		''Response.Write("valuecnt:" & valuecnt & "<br />")
		''End If
%>
							<table  cellpadding=8 cellspacing=0 id='objOption' bgcolor=f3f3f3 border=0 bordercolor=#cccccc style='border-collapse:collapse' class='s1'>
								<tr>
									<td valign='top' id=currPosition>옵션명 :
										<input name='opname' class='dd1' value='<%=oname%>'>
										<select name='opcnt' onChange="listeachOptionCnt(this, <%=cnt%>, '<%=valuecnt%>')" style="width:50px">
											<option value='0'>갯수</option>
											<%
				For Loopcnt=1 to 15
					if valuecnt = Loopcnt then  selected = "selected" else selected = ""
					Response.Write( "<option value='" & Loopcnt & "' "& selected & ">" & Loopcnt & "</option>"&Chr(13)&Chr(10))
				Next
				%>
										</select>
										<select name='opflag' style="width:90px">
											<option value='0' selected='selected'>기본</option>
											<option value='1'<% If oflag = "1" then Response.Write( " selected") %>>가격추가</option>
											<option value='2'<% If oflag = "2" then Response.Write( " selected")%>>원가격변경</option>
										</select>
										<input type="button" name="button2" id="button" value="del" onClick="option_del(this.parentNode.parentNode)"style='cursor:pointer'></td>
									<td valign='middle'><%
	strSQL = "select * from wizMalloption where ouid = '" & ouid & "' order by uid asc"
	Set objRs1	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs1.EOF
%>
										<table border='0' cellspacing='0' cellpadding='0' class='s1'>
											<tr>
												<td >옵션값:
													<input name='optioneachname_<%=cnt%>' class='dd1' size='9' value='<%=objRs1("oname")%>'>
													가격:
													<input name='optioneachprice_<%=cnt%>' class='dd1' size='5' value='<%=objRs1("oprice")%>'>
													재고:
													<input name='optioneachqty_<%=cnt%>' class='dd1' size='3' value='<%=objRs1("oqty")%>'>
													<input type="button" name="button2" id="button" value="del" onClick="option_del(this.parentNode.parentNode)"style='cursor:pointer'></td>
											</tr>
										</table>
										<%
	objRs1.MOVENEXT
	WEND
%>
										<span id='add_optioneach_<%=cnt%>'></span> </td>
								</tr>
							</table>
							<%
	cnt = cnt + 1
	objRs.MOVENEXT
	WEND
End If
%>
							<span id="add_option"> </span> </td>
					<tr>
						<th>자세한설명
							<input type="hidden" value="1" name="texttype1">
						</th>
						<td >
							<textarea name="description1" rows="15" id="ir1" style="width:98%;"><%=description1%></textarea>
</td>
					</tr>
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
</script>
					<tr>
						<th>배송정보<br />
							<input type="checkbox" 
                        value="1" name="texttype2">
							HTML사용
							<div align="center"></div></th>
						<td ><P>
								<textarea id="Description3" name="description3" rows=6  style="width:98%"><%=description3%></textarea>
								
								</P></td>
					</tr>
					<tr>
						<th>간단한 설명</th>
						<td >
							<textarea name="description2" rows=3  style="width:98%"><%=description2%></textarea>
							<br />
							<br />
							상품에 대한 간단한 설명을 넣는 곳입니다. 스킨에 따라 적용되지 않을 수도 있습니다.<br />
							</td>
					</tr>
				</table>
				<br />
				<table width="750" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td ><div align="center">
								<span class="btn_submit button bull"><a >등록</a></span>
							</div>
							<!--<a href="javascript:checkPdForm()">afasdf</a>--></td>
					</tr>
				</table>
				<br />
				<br />
				<span>  옵션 입력사항</span>
				<table class="table_main w_default">
					<tr>
						<th>제조사</th>
						<td>
							<input type="text" name="compname" value="<%=compname%>" maxLength=30></td>
					</tr>
					<!--<tr>
						<td width=100>브랜드</td>
						<td>
							<input name="brand" value="<%=brand%>" size=26 maxLength=30></td>
					</tr>//-->					
					
					<tr>
						<th>공급사</th>
						<td>
							<select name="getcomp" id="getcomp">
								<option value="">공급사선택</option>
<%
Set db = new database
strSQL = "select uid, compname from wizcom ORDER BY uid desc " 
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
If objRs.BOF or objRs.EOF Then
      Else
        Do Until objRs.EOF
			
			if objRs("uid") = getcomp Then 
				selected = " selected='selected'"
			Else
				selected = ""
			End If
			Response.Write("<option value='" & objRs("uid") & "'" & selected & ">" & objRs("compname") & "</option>")
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>							
							</select>
							<span class="button bull"><a href="./main.asp?menushow=menu6&theme=member/member_com">공급사등록</a></span></td>
					</tr>
					<tr>
						<th>등록옵션</th>
						<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td > 
										<%
''Response.Write ubound(option3)
for i=1 to Ubound(DisplayOptionArr)
	if i <> 1 then addcomma = "," else  addcomma = ""
	j = i-1
	if isArray(option3) then
		if ubound(option3) >= j then 
			if option3(j) = "1" then 
				checked = "checked"
			else
				checked = ""
			end if 
		else 
			checked = ""
		end if
	end if
	Response.Write addcomma&"<input type=""checkbox"" name=""option3_"&i&""" value=""1"" "&checked&">"&DisplayOptionArr(i)&Chr(13)&Chr(10)
next
%>
										 </td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<th>배송비</th>
						<td><input name="deliveryfee" value="<%=deliveryfee%>" size=26 maxlength=30>
						* 결제환경&gt;배송비 &gt;   제품당 적용된 배송비적용시 적용</td>
					</tr>					
					<tr>
						<th>비교상품</th>
						<td>
							<input name="option5" value="<%=option5%>">
							<input type="button" name="Button" value="찾기" onClick="wizwindow('product/product1_1search.asp?smode=compare&tmpsort='+document.writeForm.category.value+'&smode=modify','Product_Search_Window','width=620, height=650, scrollbars=yes')";></td>
					</tr>
					<!--<tr> 
                      <td width=100> 관련상품</td>
                      <td> 
                        
                <TEXTAREA name=PID rows=4 cols=5><%=PID%></TEXTAREA>
                         
                        <TEXTAREA name=textarea rows=4 cols=5>125
160
180 </TEXTAREA>
                        <br />
                        상품상세보기에서 관련상품을 디스플레이할 때 사용(관련상품 no를 상기 좌측처럼입력 )</td>
                    </tr> -->
					<%
if uid <> "" then
%>
					<tr>
						<th>등록일</th>
						<td><%=FormatDateTime(wdate,2)%></td>
					</tr>
					<%
end if
%>
				</table>
				<br />
				<table class="table_main w_default">
					<tr>
						<th>품절</th>
						<td>
							<select name="pnone" id="pnone">
								<option value="0"<% if pnone = "0" then Response.Write(" selected='selected'") %>>정상판매</option>
								<option value="1"<% if pnone = "1" then Response.Write(" selected='selected'") %>>일시품절</option>
								<option value="2"<% if pnone = "2" then Response.Write(" selected='selected'") %>>생산단종</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>상품진열</th>
						<td>
							<select name="pdisplay" id="pdisplay">
								<option value="0"<% if pdisplay = "0" then Response.Write(" selected='selected'") %>>상품진열</option>
								<option value="1"<% if pdisplay = "1" then Response.Write(" selected='selected'") %>>상품감춤</option>
							</select></td>
					</tr>
					
					<tr>
						<th>구매가 </th>
						<td>
							<input type="text" name="wongaprice" value="<%=wongaprice%>">
							콤마(,)없이 숫자로만 입력(보기:10000) - 원 상품가</td>
					</tr>
					<!--<tr>
						<td width=100 height="25">단위</td>
						<td>
							<input size=5 name="unit" value = "<%=unit%>">
							(입하량의 추가/변경 일경우 <a href="#" onClick="window.open('./product2_2.asp?uid=<%=uid%>&Name=<%=pName%>&Output=<%=pOutput%>&Icomid=<%=getcomp%>','InputChangeWindow','width=300,0')";>이곳을 
							눌러</a> 변경해 주세요)</td>
					</tr>//-->
				</table>
				<br />
				<table width="760" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td ><div align="center">
								<span class="btn_submit button bull"><a >등록</a></span>
							</div></td>
					</tr>
				</table>
			</form></td>
	</tr>
</table>
