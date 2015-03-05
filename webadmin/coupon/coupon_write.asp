<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->
<%
Dim strSQL,objRs
Dim db,util, mall

Set util = new utility	
Set db = new database
Set mall	= new malls

Dim menushow, theme
Dim LoopCount, smode
Dim qry, ctermfdate, ctermedate,  couponid, category, e_refer, imgpath, value, rtn_hour, rtn_min
Dim ctermf_date, ctermfhour, ctermfmin, cterme_date, ctermehour, ctermemin
Dim uid, cname, cdesc, cpubtype, cpubdowncnt, cpubapplyall, cpubapplycontinue, edncnt, ctype, csaleprice, csaletype, capplytype, capplycategory, capplyproduct, cimg, ctermtype, cterm, ctermf, cterme, crestric, wdate
''Dim cname,cdesc,cpubtype,cpubdowncnt,cpubapplyall,cpubapplycontinue,edncnt,ctype,csaleprice,csaletype,capplytype,capplycategory,capplyproduct,cimg,ctermtype,cterm,ctermf,cterme,crestric,wdate
menushow	= Request("menushow")
theme		= Request("theme")
qry			= Request("qry")
uid			= Request("uid")


cname				= Request("cname")
cdesc				= Request("cdesc")
cpubtype			= Request("cpubtype")
cpubdowncnt			= Request("cpubdowncnt")
cpubapplyall		= Request("cpubapplyall")
cpubapplycontinue	= Request("cpubapplycontinue")
edncnt				= Request("edncnt")
ctype				= Request("ctype")
csaleprice			= Request("csaleprice")
csaletype			= Request("csaletype")
capplytype			= Request("capplytype")
capplycategory		= Request("capplycategory")
capplyproduct		= Request("capplyproduct")
cimg				= Request("cimg")
ctermtype			= Request("ctermtype")
cterm				= Request("cterm")
''ctermf				= Request("ctermf")
''cterme				= Request("cterme")
crestric			= Request("crestric")
wdate				= Request("wdate")

ctermf_date			= Request("ctermf_date")
ctermfhour			= Request("ctermfhour")
ctermfmin			= Request("ctermfmin")
cterme_date			= Request("cterme_date")
ctermehour			= Request("ctermehour")
ctermemin			= Request("ctermemin")
ctermf	= ctermf_date & " " & ctermfhour & ":" & ctermfmin
cterme	= cterme_date & " " & ctermehour & ":" & ctermemin
	
category			= Request("category")
e_refer				= Request("e_refer")

if qry = "qin" Then

	strSQL = "insert into wizcoupon (cname,cdesc,cpubtype,cpubdowncnt,cpubapplyall,cpubapplycontinue,edncnt,ctype,csaleprice,csaletype,capplytype,capplycategory,capplyproduct,cimg,ctermtype,cterm,ctermf,cterme,crestric,wdate) "
	strSQL = strSQL & " values "
	strSQL = strSQL & "('" & cname & "','" & cdesc & "','" & cpubtype & "','" & cpubdowncnt & "','" & cpubapplyall & "','" & cpubapplycontinue & "','" & edncnt & "','" & ctype & "','" & csaleprice & "','" & csaletype & "','" & capplytype & "','" & capplycategory & "','" & capplyproduct & "','" & cimg & "','" & ctermtype & "','" & cterm & "','" & ctermf & "','" & cterme & "','" & crestric & "',getdate())"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL	= "select max(uid) from wizcoupon"
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)  
	couponid = objRs(0)
	
	''카테고리적용
	Call insertcpcategory(couponid, category)
	
	''적용제품 입력
	''제품적용
	Call insertcpproduct(couponid, e_refer)
	
ElseIf qry = "qup" Then

	strSQL = "update wizcoupon set " 
	strSQL = strSQL & " cname = '" & cname &"', " 
	strSQL = strSQL & " cdesc = '" & cdesc &"', " 
	strSQL = strSQL & " cpubtype = '" & cpubtype &"', " 
	strSQL = strSQL & " cpubdowncnt = '" & cpubdowncnt &"', " 
	strSQL = strSQL & " cpubapplyall = '" & cpubapplyall &"', " 
	strSQL = strSQL & " cpubapplycontinue = '" & cpubapplycontinue &"', " 
	strSQL = strSQL & " edncnt = '" & edncnt &"', " 
	strSQL = strSQL & " ctype = '" & ctype &"', " 
	strSQL = strSQL & " csaleprice = '" & csaleprice &"', " 
	strSQL = strSQL & " csaletype = '" & csaletype &"', " 
	strSQL = strSQL & " capplytype = '" & capplytype &"', " 
	strSQL = strSQL & " capplycategory = '" & capplycategory &"', " 
	strSQL = strSQL & " capplyproduct = '" & capplyproduct &"', " 
	strSQL = strSQL & " cimg = '" & cimg &"', " 
	strSQL = strSQL & " ctermtype = '" & ctermtype &"', " 
	strSQL = strSQL & " cterm = '" & cterm &"', " 
	strSQL = strSQL & " ctermf = '" & ctermf &"', " 
	strSQL = strSQL & " cterme = '" & cterme &"', " 
	strSQL = strSQL & " crestric = '" & crestric &"'" 
	strSQL = strSQL & " where uid = " & uid

	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	''카테고리적용
	Call insertcpcategory(uid, category)
	''제품적용
	Call insertcpproduct(uid, e_refer)
	
	Response.Write("<script>location.href='main.asp?menushow=" & menushow & "&theme=" & theme & "&uid=" & uid & "';</script>")
End If

Sub insertcpcategory(uid, category)
   Dim insert_cat, subloop
	strSQL = "delete from wizcouponapply where couponid = " & uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)

	Dim categoryArr : categoryArr = split(category, ",")

	for subloop=0 to Ubound(categoryArr)
		insert_cat = trim(categoryArr(subloop))
		if insert_cat <> "" then 
			strSQL = "insert into  wizcouponapply (couponid,category) values (" & uid & ", '" & insert_cat & "')"
			''Response.Write(strSQL)
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		end if
	NEXT	     
End Sub 

Sub insertcpproduct(uid, refer)
	Dim insert_ref, subloop
	Dim referArr : referArr = split(refer, ",")

	for subloop=0 to Ubound(referArr)
		insert_ref = trim(referArr(subloop))
		if insert_ref <> "" then 
			strSQL = "insert into  wizcouponapply (couponid,pid) values (" & uid & ", '" & insert_ref & "')"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		end if
	NEXT	     
End Sub 


If uid <> "" Then
	'' 입력데이타 가져오기
	strSQL = "select * from wizcoupon where uid = " & uid
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)  

	''uid				= objRs("uid")
	cname				= objRs("cname")
	cdesc				= objRs("cdesc")
	cpubtype			= objRs("cpubtype")
	cpubdowncnt			= objRs("cpubdowncnt")
	cpubapplyall		= objRs("cpubapplyall")
	cpubapplycontinue	= objRs("cpubapplycontinue")
	edncnt				= objRs("edncnt")
	ctype				= objRs("ctype")
	csaleprice			= objRs("csaleprice")
	csaletype			= objRs("csaletype")
	capplytype			= objRs("capplytype")
	capplycategory		= objRs("capplycategory")
	capplyproduct		= objRs("capplyproduct")
	cimg				= objRs("cimg")
	ctermtype			= objRs("ctermtype")
	cterm				= objRs("cterm")
	ctermf_date			= FormatDateTime(objRs("ctermf"), 2)
	ctermfhour			= left(FormatDateTime(objRs("ctermf"), 4), 2)
	ctermfmin			= right(FormatDateTime(objRs("ctermf"), 4), 2)
	cterme_date			= FormatDateTime(objRs("cterme"), 2)
	ctermehour			= left(FormatDateTime(objRs("cterme"), 4), 2)
	ctermemin			= right(FormatDateTime(objRs("cterme"), 4), 2)
	crestric			= objRs("crestric")
	wdate				= objRs("wdate")
	''Response.Write(ctermf_date & ctermfhour & ctermfmin)
	smode	= "qup"

Else
	smode	= "qin"
	cpubdowncnt = 1
	edncnt = 0
End If
%>
<script type="text/javascript" src="../js/jquery.plugins/jquery.selectboxes.min.js"></script>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	// 대분류 검색
	$(".datepicker").datepicker({ dateFormat: 'yy-mm-dd' });//datepicker사용
	
	$("#category1").change(function(){
		var cate = this.value;
	//	alert(cate)
		$.post(
			"./product/multicategory.asp", 
			{ 
				'cate' : cate,
				'step' : '1'
			},
			function(data){
				eval("var obj = "+data);
				$("#category2").removeOption(/./);
				$.each(obj[0], function(index, value){
					$("#category2").addOption(index, value, false);
				});
			}
		);
	});
	
	//중분류검색
	$("#category2").change(function(){
		var cate = this.value;
		$.post(
			"./product/multicategory.asp", 
			{ 
				'cate' : cate,
				'step' : '2'
			},
			function(data){
				eval("var obj = "+data);
				$("#category3").removeOption(/./);
				$.each(obj[0], function(index, value){
					$("#category3").addOption(index, value, false);
				});
			}
		);
	});	
	
	
	// 서브 대분류 검색
	$("#pd_category1").change(function(){
		var cate = this.value;
	//	alert(cate)
		$.post(
			"./product/multicategory.asp", 
			{ 
				'cate' : cate,
				'step' : '1'
			},
			function(data){
				eval("var obj = "+data);
				$("#pd_category2").removeOption(/./);
				$.each(obj[0], function(index, value){
					$("#pd_category2").addOption(index, value, false);
				});
			}
		);
	});
	
	//서브 중분류검색
	$("#pd_category2").change(function(){
		var cate = this.value;
		$.post(
			"./product/multicategory.asp", 
			{ 
				'cate' : cate,
				'step' : '2'
			},
			function(data){
				eval("var obj = "+data);
				$("#pd_category3").removeOption(/./);
				$.each(obj[0], function(index, value){
					$("#pd_category3").addOption(index, value, false);
				});
			}
		);
	});		

	
	//var str = new array()
	$("#btn_add").click(function(){
		var ret;
		var str = new Array();
		$(".selectcategory").each(function(i){
			if($(this).val()){
				str[i] =  $(this).children("option:selected").text();
				ret = $(this).val();
				//alert($(option:selected, this).text());
			}
		});
		
		if (!ret){
			alert('카테고리를 선택해주세요');
			return;
		}	
		var rows = $("#objcategory  tr");
		var index	= rows.length;
		var add_str = "<tr id='currposition"+index+"'><td>"+str.join(" > ")+"</td><td><input type=hidden name=category value='" + ret + "'>";
		add_str = add_str + "</td><td><span class='cat_del button bull' indexval='"+index+"'><a>삭제</a></span></td></tr>";
		$("#objcategory").append(add_str)
				
	});
	
	$(".cat_del").live("click", function(){
		var index = $(this).attr("indexval");
		var row	= $("#currposition"+index);
		row.fadeOut("slow", function(){
			row.remove();
		});
	});
	
	$("#btn_save").click(function(){
		if(!$("#cname").val()){
			alert('쿠폰이름을 입력하세요');
			$("#cname").focus();
		}else if(!$("#csaleprice").val()){
			alert('쿠폰금액을 입력하세요');
			$("#csaleprice").focus();
		}else $("#s_form").submit();
	});
	
	$("#btn_list_product").click(function(){
		$("#obj_refer").show();
		$("#obj2_refer").show();
		$("#btn_view_goods a").html("닫음")
		
		var ret;
		$(".selectsubcategory").each(function(i){
			if($(this).val()){
				ret = $(this).val();
			}
		});
		
		var goodsnm = $("#search_refer").val();
				
				//var category = '';
		//open_box(name,true);	
		//var els = document.forms[0]['selectcategory2'];
		//for (i=0;i<els.length;i++){
		//	if (els[i].value) category = els[i].value;
		//}
		//var ifrm = eval("ifrm_" + name);
		//var goodsnm = eval("document.forms[0].search_" + name + ".value");
		$("#ifrm_refer").attr("src", "./coupon/product_list.asp?category=" + ret + "&goodsnm=" + goodsnm);
		//ifrm.location.href = "./coupon/product_list.asp?name=" + name + "&category=" + category + "&goodsnm=" + goodsnm;	
	});

	$("#btn_view_goods").click(function(){
		if($("#obj_refer").css("display") == "none"){
			$("#obj_refer").show();
			$("#obj2_refer").show();
			
			$("#btn_view_goods a").html("닫음")
		}else{
			$("#obj_refer").hide();
			$("#obj2_refer").hide();
			$("#btn_view_goods a").html("펼침")
		}
	});
	
	

	
	$(".remove_product").live("dblclick", function(){
		var index = $(this).attr("indexval");
		//alert('');

		//var index = $(this).attr("indexval");
		var row	= $("#remove_product"+index);
		row.fadeOut("slow", function(){
			row.remove();
		});

	});	
	
	$(".ctermtype").click(function(){
        $(".ctermtypesub").hide();
        $(".ctermtypesub").eq($(".ctermtype").index(this)).show(); //메서드
			
		//if($(this).val() == "1"){
		//	$(".ctermtypesub").hide()
		//}else{
		//	$(".ctermtypesub").show()
		//} 
	});
		
});

/*

function chk_cpubtype(v){
	if(v.value == "2"){
		box_cpubtype2.style.display = "block";
	}else{
		box_cpubtype2.style.display = "none";
	}
}

function chk_ctermtype(v){
	for(i=1; i<=2; i++){
		//alert(v.value);
		if(v.value == i){
			eval("ctermtype"+i+".style.display = 'block'");
		}else{
			eval("ctermtype"+i+".style.display = 'none'");
		}
	}
	
}

function getcategory(step,f,flag,target){
	form = f.form.name;
	//alert ("./product/search_category.php?step="+step+"&trigger="+f.value+"&form="+form+"&flag="+flag+"&target="+target);
	dynamic.src = "./product/search_category.php?step="+step+"&trigger="+f.value+"&form="+form+"&flag="+flag+"&target="+target;
	
}



function cate_del(el)
{
	idx = el.rowindex;
	var obj = document.getelementbyid('objcategory');
	obj.deleterow(idx);
}

function open_box(name,isopen)
{
	var mode;
	var isopen = (isopen || document.getelementbyid('obj_'+name).style.display!="block") ? true : false;
	mode = (isopen) ? "block" : "none";
	document.getelementbyid('obj_'+name).style.display = document.getelementbyid('obj2_'+name).style.display = mode;
}



function go_list_goods(name){
	if (event.keycode==13){
		list_goods(name);
		return false;
	}
}
function view_goods(name)
{
	open_box(name,false);
}

function remove(name,obj)
{
	var tb = document.getelementbyid('tb_'+name);
	tb.deleterow(obj.rowindex);
	react_goods(name);
}

function react_goods(name)
{
	var tmp = new Array();
	
	var obj = document.getelementbyid('tb_'+name);
	//alert(obj.rows.length);
	for (i=0;i<obj.rows.length;i++){
	//alert(obj.rows[i].cells[0].innerhtml);
		tmp[tmp.length] = "<div style='float:left;width:0;border:1 solid #cccccc;margin:1px;' title='" + obj.rows[i].cells[1].getelementsbytagname('div')[0].innertext + "'>" + obj.rows[i].cells[0].innerhtml + "</div>";
	}
	document.getelementbyid(name+'x').innerhtml = tmp.join("") + "<div style='clear:both'>";
}

var icirow, prerow, nameobj;
function spoit(name,obj)
{
	nameobj = name;
	icirow = obj;
	icihighlight();
}
function icihighlight()
{
	if (prerow) prerow.style.backgroundcolor = "";
	icirow.style.backgroundcolor = "#fff4e6";
	prerow = icirow;
}
*/
//-->	
</script>

<table class="table_outline">
	<tr>
		<td valign="top"><fieldset class="desc">
			<legend>쿠폰만들기</legend>
			<div class="notice">[note]</div>
			<div class="comment">쿠폰만들기 고객에게 발급할 쿠폰을 만듭니다.<br />
				회원직접다운로드쿠폰을 제외한 다른 쿠폰들은 발급받은 회원1명 당 쿠폰사용은 1회로 제한 됩니다.</div>
			</fieldset>
			<p></p>
			<table>
				<tr>
					<td align="center"><form method="post" name="s_form" id="s_form" action="main.asp">
							<input type="hidden" name="qry" value="<%=smode%>" />
							<input type="hidden" name="menushow" value="<%=menushow%>" />
							<input type="hidden" name="theme" value="<%=theme%>" />
							<input type="hidden" name="uid"	value="<%=uid%>" />
							<table class="table_main w_default">
								<tr>
									<td width="100" class="t_head_l">쿠폰이름</td>
									<td><input type=text name='cname' size=40 maxlength=30 value="<%=cname%>" required class=line id="cname"></td>
								</tr>
								<tr>
									<th>쿠폰설명</td>
									<td><input type=text name='cdesc' size=40 maxlength=70 value="<%=cdesc%>" class=line id="cdesc"></td>
								</tr>
								<tr>
									<th>쿠폰발급방식</td>
									<td><input type=radio name=cpubtype value='1' onclick="chk_cpubtype(this);"<% if cpubtype = "1" or  cpubtype = "" Then Response.Write(" checked='checked'")%>>
										운영자발급 <font class=extext>(쿠폰등록 후 쿠폰리스트에서 운영자가 특정회원에게 발급합니다) <br />
										<input type=radio name=cpubtype value='2' onclick="chk_cpubtype(this);"<% if cpubtype = "2" Then Response.Write(" checked='checked'")%>>
										회원직접다운로드 <font class=extext>(상품상세정보에서 회원이 직접 쿠폰을 다운로드받습니다)
										<table border=1 bordercolor=#cccccc style="border-collapse:collapse;display:none" width=635 id="box_cpubtype2">
											<tr>
												<td bgcolor=#e8e8e8 style="padding:5 0 7 2">이 쿠폰의 총 다운로드 횟수를
													<input type='text' style='text-align:right' name='cpubdowncnt' size=3 value='<%=cpubdowncnt%>' onkeydown='onlynumber()' maxlength='9' id="cpubdowncnt">
													회로 제한합니다 <font class=extext>(공란으로 두면  무제한) <br />
													<input type="checkbox" name='cpubapplyall' value='1'   id="cpubapplyall"<% if cpubapplyall = "1" Then Response.Write(" checked='checked'")%>>
													쿠폰이 적용된 하나의 상품을 한번에 여러개 주문할 때 쿠폰혜택을 모두 제공합니다<font class=extext><br />
													(체크안하면 같은 상품을 한번에 여러개 주문시 한개만 쿠폰혜택 제공)&nbsp; <br />
													<input type="checkbox" name='cpubapplycontinue' value='1' id="cpubapplycontinue"<% if cpubapplycontinue = "1" Then Response.Write(" checked='checked'")%>>
													쿠폰을 사용한 후 다음번 주문시에도 같은 상품의 쿠폰다운로드를 허용합니다<br />
													<font class=extext>(체크안하면 다음번 주문시 같은 상품의 쿠폰다운로드 허용안함)&nbsp;
													</div>
													<div id='goodsallid2'>
													<br />
													허용한다면, 다음번 주문시 같은 상품의 쿠폰 다운로드 횟수를
													<input type='text' style='text-align:right' name='edncnt' size=3 maxlength=9 value='<%=edncnt%>' onkeydown='onlynumber()'>
													회로 제한합니다 <font class=extext>(공란으로 두면  무제한)</td>
											</tr>
										</table>
										<% if cpubtype = "2" Then Response.Write("<script>chk_cpubtype(document.couponwriteform.cpubtype[1]);</script>")%>
										<br />
										<input type=radio name=cpubtype value='3' onclick="chk_cpubtype(this);"<% if cpubtype = "3" Then Response.Write(" checked='checked'")%> />
										회원가입자동발급 <font class=extext>(회원가입시 자동발급됩니다) <br />
										 <input type=radio name=cpubtype value='4' onclick="chk_cpubtype(this)"<% if cpubtype = "4" Then Response.Write(" checked='checked'")%> />
										구매후 자동발급 <font class=extext>(구매후 배송완료시에 자동발급됩니다)</td>
								</tr>
								<tr>
									<th>쿠폰기능</td>
									<td><input type=radio name=ctype value='1' onclick='chk_msg(this.value);'<% if ctype = "1" or ctype = "" Then Response.Write(" checked='checked'")%> />
										할인쿠폰을 발행합니다 <font class=extext>(구매시 바로 할인되는 쿠폰)&nbsp;&nbsp;<br />
										<input type=radio name=ctype value='2'   onclick='chk_msg(this.value);'<% if ctype = "2" Then Response.Write(" checked='checked'")%> />
										적립쿠폰을 발행합니다 <font class=extext>(구매 후(배송완료) 적립되는 쿠폰) </td>
								</tr>
								<tr>
									<th>쿠폰금액</td>
									<td> 총 구매금액 중
										<input type=text class=line name='csaleprice' style="text-align:right" maxlength=15 value="<%=csaleprice%>" onkeydown='onlynumber();' id="csaleprice">
										&nbsp;
										<select name='csaletype' id="csaletype">
											<%
											''=common->getselectfromarray(csaletypearr, csaletype"])
											%>
										</select>
										을 할인/적립해주는 쿠폰을 발행합니다</td>
								</tr>
								<tr>
									<th>쿠폰발급상품</td>
									<td><table width=100% cellpadding=0 cellspacing=0>
											<tr>
												<td><input type=radio name=capplytype value='1'<% if capplytype = "1" or ctype = "" Then Response.Write(" checked='checked'")%> />
													전체상품에 발급합니다</td>
											</tr>
											<tr>
												<td><input type=radio name=capplytype value='2'<% if capplytype = "2" Then Response.Write(" checked='checked'")%> />
													특정 상품 및 특정 카테고리에 발급합니다 <font class=extext>(아래에서 검색후 선정)</td>
											</tr>
											<tr>
												<td><font class=small1 color=ff0066>카테고리 선정 (카테고리선택 후 오른쪽 선정버튼클릭)<br />
													<select name="category1" id="category1" class="selectcategory">
														<option value="" selected>대분류 </option>
														<option value="">----------------</option>
<% Call mall.getSelectCategory(1, "") %>
													</select>
													<select name="category2" id="category2" class="selectcategory">
														<option value="" selected>중분류</option>
														<option value="">----------------</option>
													</select>
													<select name="category3" id="category3" class="selectcategory">
														<option value="" selected>소분류</option>
													</select>
													<span id="btn_add" class="button bull"><a>카테고리설정</a></span>
													<div class="box" style="padding:10 0 0 10">
														<table  cellpadding=8 cellspacing=0 id="objcategory" bgcolor=f3f3f3 border=0 bordercolor=#cccccc style="border-collapse:collapse">
															<%
if smode = "qup" Then
	''등록 카테고리/상품가져오기
	Set db = new database
	strSQL = "select category from wizcouponapply where category is not null and couponid = "& uid
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	LoopCount = 0
	Dim strlen, strDisplay
	WHILE NOT objRs.EOF
	category = objRs("category")
	strlen	= Len(category)
	strSQL = " select tb1.cat_name, tb2.cat_name, tb3.cat_name from " & _  
	" (select cat_name from wizcategory where cat_no = substring('" & category & "', 1, 3)) as tb1, " & _  
	" (select cat_name from wizcategory where cat_no = substring('" & category & "', 1, 6)) as tb2, " & _  
	" (select cat_name from wizcategory where cat_no = substring('" & category & "', 1, 9)) as tb3; "
	Dim objRs1 : Set objRs1 = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if	strlen = 9 Then strDisplay = objRs1(0) & " &gt " &  objRs1(1) & " &gt " &  objRs1(2)
	if	strlen = 6 Then strDisplay = objRs1(0) & " &gt " &  objRs1(1)
	if	strlen = 3 Then strDisplay = objRs1(0)
	
	
%>
<tr id='currposition<%=LoopCount%>'><td><%=strDisplay%></td><td><input type=hidden name=category value='<%=category%>'>
</td><td><span class='cat_del button bull' indexval='<%=LoopCount%>'><a>삭제</a></span></td></tr>
<%	
	LoopCount = LoopCount + 1
	objRs.MOVENEXT
	WEND
End If															
%>
														</table>
													</div>
													<font class=small1 color=ff0066>상품 선정 (상품검색 후 선정)<br />
<select name="pd_category1" id="pd_category1" class="selectsubcategory">
														<option value="" selected>대분류 </option>
														<option value="">----------------</option>
<% Call mall.getSelectCategory(1, "") %>
													</select>
													<select name="pd_category2" id="pd_category2" class="selectsubcategory">
														<option value="" selected>중분류</option>
														<option value="">----------------</option>
													</select>
													<select name="pd_category3" id="pd_category3" class="selectsubcategory">
														<option value="" selected>소분류</option>
													</select>
													<!-- <input type=text name=search_refer onkeydown="return go_list_goods('refer')"> -->
													<input type=text name="search_refer">
													<span id="btn_list_product" class="button bull"><a>검색</a></span>
													<span id="btn_view_goods" class="button bull"><a>펼침</a></span>

													<div id=divrefer style="position:relative;z-index:99;padding-left:8">
														<div id="obj_refer" class=box1>
															<iframe id="ifrm_refer" style="width:100%;height:100%" frameborder=0></iframe>
														</div>
														<div id="obj2_refer" class="box2 scroll" onselectstart="return false" onmousewheel="return iciscroll(this)">
															<div class=boxtitle>- 등록된 상품 (삭제하려면 더블클릭)</div>
															<table id="tb_refer" class=tb>
																<col width=50>
<%
if smode = "qup" Then
	''등록 카테고리/상품가져오기
	Set db = new database
	Dim p_picture,p_picture_2, p_category,p_uid,p_pname,p_price,cnt
	strSQL = "select c.pid, m.picture, m.category, m.uid, m.pname, m.price from wizcouponapply c " & _ 
	" left join wizmall m on m.uid = c.pid " & _
	" where c.pid is not null and c.couponid = "& uid
	
	 
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	LoopCount = 0
	WHILE NOT objRs.EOF
	p_picture 	= split(objRs("picture"),"|")
	if Ubound(p_picture) > 1 Then p_picture_2 = p_picture(2)
	p_category	= objRs("category")
	p_uid		= objRs("uid")
	p_pname		= objRs("pname")
	p_price		= objRs("price")
	
	
%>
         <tr class='remove_product' id='remove_product" & LoopCount & "' indexval='" & LoopCount & "'>
            <td width="50"><IMG SRC='../../config/wizstock/<%=p_picture_2%>' WIDTH='50' HEIGHT='50' BORDER=0></td>
            <td><div style="overflow:hidden;"><%=p_pname%></div>
	<%=p_price%></b>
	<input type="hidden" name="e_refer" value="<%=p_uid%>"></td>
          </tr>
<%	
	LoopCount = LoopCount + 1
	objRs.MOVENEXT
	WEND
End If															
%>
															</table>
														</div>
														<div id=referx style="font:0"></div>
													</div>
													<div>
														<script>//react_goods('refer');</script>
													</div></td>
											</tr>
										</table></td>
								</tr>
								<tr>
									<th>쿠폰이미지</td>
									<td><table cellpadding=0 cellspacing=0>
											<tr>
												<td align="center"><img src="../../data/skin/easy/img/common/coupon01.gif">
													<input type=radio  name=cimg value=1<% if cimg = "1" or ctype = "" Then Response.Write(" checked='checked'")%> /> </td>
												<td width=5></td>
												<td align="center"><img src="../../data/skin/easy/img/common/coupon02.gif">
													<input type=radio  name=cimg value=2<% if cimg = "2" Then Response.Write(" checked='checked'")%> /> </td>
												<td width=5></td>
												<td align="center"><img src="../../data/skin/easy/img/common/coupon03.gif">
													<input type=radio  name=cimg value=3<% if cimg = "3" Then Response.Write(" checked='checked'")%> /></td>
												<td width=5></td>
												<td align="center"><img src="../../data/skin/easy/img/common/coupon04.gif">
													<input type=radio  name=cimg value=4<% if cimg = "4" Then Response.Write(" checked='checked'")%> /></td>
											</tr>
										</table></td>
								</tr>
								<tr>
									<th>적용기간</td>
									<td><input type=radio  name="ctermtype" value="1" class="ctermtype" <% if ctermtype = "1" or ctype = "" Then Response.Write(" checked='checked'")%> />
										시작일, 종료일 선택&nbsp;&nbsp; <br />
										<input type=radio  name="ctermtype" class="ctermtype" value="2" <% if ctermtype = "2" Then Response.Write(" checked='checked'")%> />
										발급일로부터 기간 제한<br />
<span class="ctermtypesub" style="display:">
										<input type="text" name="ctermf_date" class="datepicker inputBox" style="width:80px" id="ctermf_date" value="<%=ctermf_date%> "/> 
										
										<select name="ctermfhour" id="ctermfhour">
											<option value="">시간</option>
											
                      <%=util.getSelectdate("hour",ctermfhour)%>
										</select>
										<select name="ctermfmin" id="ctermfmin">
											<option value="">분</option>
											
                     <%=util.getSelectdate("minute",ctermfmin)%>
										</select>
										 -
										<input type="text" name="cterme_date" class="datepicker inputBox" style="width:80px" id="cterme_date" value="<%=cterme_date%> "/> 
										<select name="ctermehour" id="ctermehour">
											<option value="">시간</option>
											
                      <%=util.getSelectdate("hour",ctermehour)%>
										</select>
										<select name="ctermemin" id="ctermemin">
											<option value="">분</option>
											
                     <%=util.getSelectdate("minute",ctermemin)%>
										</select>
										</span> <span class="ctermtypesub" style="display:none"> &nbsp; 쿠폰발급일로부터
										<input type=text name=cterm value="<%=cterm%>" size=5 maxlength=3 onkeydown='onlynumber()'>
										일까지 사용기간을 제한합니다. </span> </td>
								</tr>
								<tr>
									<th>쿠폰사용제한</td>
									<td><input type=text name=crestric style="text-align:right" maxlength=10 value="<%=crestric%>" class=line id="crestric">
										원 이상 구매시에만 사용가능 <font class=extext>(공란으로 두면 구매금액에 상관없이 사용이 가능합니다)</td>
								</tr>
							</table>
							<span id="btn_save" class="button bull"><a>확인</a></span>
							<span id="btn_add" class="button bull"><a href="./main.asp?menushow=menu13&theme=coupon/coupon_list">취소</a></span>
						</form></td>
				</tr>
			</table>
			<br />
			</b> </td>
	</tr>
</table>
