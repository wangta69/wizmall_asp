<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim flag, form, zip1, zip2, firstaddress, secondaddress, searchmode, smode, keyword, searchziptype
Dim zipcode, zipArr, sido, gugun, dong, address1, address2
form			= Request("form")
zip1			= Request("zip1")
zip2			= Request("zip2")
firstaddress	= Request("firstaddress")
secondaddress	= Request("secondaddress")
searchmode		= Request("searchmode")
smode			= Request("smode")
''keyword			= util.secFilter(Request("keyword"))
keyword			= Request("keyword")
searchziptype	= Request("searchziptype")
''Response.Write(keyword)
%>
<!DOCTYPE html>
<html lang="kr">
	<head>
		<meta charset="euc-kr">
		<title>우편번호찾기</title>
		<script type="text/javascript" src="../../../js/jquery.min.js"></script>
		<script type="text/javascript" src="../../../js/jquery.plugins/selectboxes.js"></script>
		<script type="text/javascript" src="../../../js/pop_resize.js"></script>
		<link type="text/css" rel="stylesheet" href="../../../css/base.css" />
		<link type="text/css" rel="stylesheet" href="../../../js/bootstrap/css/bootstrap.min.css">	
		
		<script>
			$(function(){
				switchtype('<%=searchziptype%>');
				gotoPage();
				
				$(document).on("click", ".btn_street", function(){
					switchtype("street");
					$("#mode").val("");
					gotoPage();
				});
				$(document).on("click", ".btn_address", function(){
					switchtype("address");
					$("#mode").val("");
					gotoPage();
				});
			});
			
			//var zipcodeskin = "<?php echo $cfg["skin"]["ZipCodeSkin"]; ?>";
			//var zipcodeskin = "default_new/";
			var zipcodeskin = "";
			var search_url = zipcodeskin+"find_street.asp";
			function gotoPage(){
			//alert(search_url);
			//alert($("#inputkeyword").val());
			//var post_opt = "mode="+$("#mode").val()+"&searchziptype="+$("#searchziptype").val()+"&form="+$("#hidden_form").val()+"&zip1="+$("#hidden_zip1").val()+"&zip2="+$("#hidden_zip2").val()+"&firstaddress="+$("#hidden_firstaddress").val()+"&secondaddress="+$("#hidden_secondaddress").val()+"&sido="+$("#sido").val()+"&sigungu="+escape($("#sigungu").val())+"&keyword="+escape($("#inputkeyword").val())+"&sel_item="+escape($("#sel_item").val());
			//$("#msg").html(post_opt);
			
			//escape($("#inputkeyword").val())
				//$.post(search_url, $(".sform").serialize(), function(data){
//$(".sform").attr("action", search_url);
//$(".sform").submit();
				//alert(search_url);
				$.post(search_url, {mode:$("#mode").val(), searchziptype:$("#searchziptype").val(), form:$("#hidden_form").val(), zip1:$("#hidden_zip1").val(), zip2:$("#hidden_zip2").val(), firstaddress:$("#hidden_firstaddress").val(), secondaddress:$("#hidden_secondaddress").val(), sido:$("#sido").val(), sigungu:escape($("#sigungu").val()), keyword:escape($("#inputkeyword").val()),sel_item:escape($("#sel_item").val()),ch_item:escape($("#ch_item").val()) }, function(data){
						$("#bodyHTML").html(data);
				})
				
			}
			
			function switchtype(arg){
				switch(arg){
					case "address":
						search_url = zipcodeskin+"find_address.asp";
					break;
					default:
						search_url = zipcodeskin+"find_street.asp";
					break;
				}

				
				$("#searchziptype").val(arg);
			}
			
		</script>
	</head>

	<body>
<!--
<div id="msg"></div> 
-->
		<form method="post" class="sform">
				<input type="hidden" name="mode" id="mode" value="">
				<input type="hidden" name="searchziptype" id="searchziptype" value="<%=searchziptype%>">
				<input type="hidden" name="form" id="hidden_form" value="<%=form%>">
				<input type="hidden" name="zip1" id="hidden_zip1" value="<%=zip1%>">
				<input type="hidden" name="zip2" id="hidden_zip2" value="<%=zip2%>">
				<input type="hidden" name="firstaddress" id="hidden_firstaddress" value="<%=firstaddress%>">
				<input type="hidden" name="secondaddress" id="hidden_secondaddress" value="<%=secondaddress%>">
		</form>
		
		<div id="bodyHTML"></div>
	</body>
</html>
