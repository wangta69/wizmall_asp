<% Option Explicit %>
<%
''Session.CodePage = 949
'''Response.CharSet = "euc-kr"
''Response.AddHeader "Pragma","no-chche"
''Response.AddHeader "Expires", "0"
''Response.AddHeader "cache-control","no-staff"
''Response.Expires = -1
%>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database


Dim zipDic, zipPrevDic
Set zipDic = Server.CreateObject("Scripting.Dictionary")
zipDic.Add "db_zip_seoul","서울특별시"
zipDic.Add "db_zip_busan","부산광역시"
zipDic.Add "db_zip_daegu","대구광역시"
zipDic.Add "db_zip_incheon","인천광역시"
zipDic.Add "db_zip_gwangju","광주광역시"
zipDic.Add "db_zip_daejeon","대전광역시"
zipDic.Add "db_zip_ulsan","울산광역시"
zipDic.Add "db_zip_sejong","세종특별자치시"
zipDic.Add "db_zip_gangwon","강원도"
zipDic.Add "db_zip_gyeonggi","경기도"
zipDic.Add "db_zip_gyeongsang_s","경상남도"
zipDic.Add "db_zip_gyeongsang_n","경상북도"
zipDic.Add "db_zip_jeolla_s","전라남도"
zipDic.Add "db_zip_jeolla_n","전라북도"
zipDic.Add "db_zip_jeju","제주특별자치도"
zipDic.Add "db_zip_chungcheong_s","충청남도"
zipDic.Add "db_zip_chungcheong_n","충청북도"

Set zipPrevDic = Server.CreateObject("Scripting.Dictionary")
zipPrevDic.Add "서울","db_zip_seoul"
zipPrevDic.Add "부산","db_zip_busan"
zipPrevDic.Add "대구","db_zip_daegu"
zipPrevDic.Add "인천","db_zip_incheon"
zipPrevDic.Add "광주","db_zip_gwangju"
zipPrevDic.Add "대전","db_zip_daejeon"
zipPrevDic.Add "울산","db_zip_ulsan"
zipPrevDic.Add "세종","db_zip_sejong"
zipPrevDic.Add "강원","db_zip_gangwon"
zipPrevDic.Add "경기","db_zip_gyeonggi"
zipPrevDic.Add "경남","db_zip_gyeongsang_s"
zipPrevDic.Add "경북","db_zip_gyeongsang_n"
zipPrevDic.Add "전남","db_zip_jeolla_s"
zipPrevDic.Add "전북","db_zip_jeolla_n"
zipPrevDic.Add "제주","db_zip_jeju"
zipPrevDic.Add "충남","db_zip_chungcheong_s"
zipPrevDic.Add "충북","db_zip_chungcheong_n"


Dim sido, sigungu, mode, keyword, ch_item, sel_item
Dim zip1, zip2, firstaddress, secondaddress
sido			= Request("sido")
sigungu			= unescape(Request("sigungu"))
mode			= Request("mode")
keyword			= unescape(Request("keyword"))
If keyword = "undefined" Then keyword = ""
''keyword			= unescape(Request("keyword"))
ch_item			= unescape(Request("ch_item"))
If ch_item = "undefined" Then ch_item = ""
sel_item		= unescape(Request("sel_item"))
If sel_item = "undefined" Then sel_item = ""
zip1			= Request("zip1")
zip2			= Request("zip2")
firstaddress	= Request("firstaddress")
secondaddress	= Request("secondaddress")

''Dim flag, form, zip1, zip2, firstaddress, secondaddress, searchmode, smode, keyword, searchziptype
''Dim zipcode, zipArr, sido, gugun, dong, address1, address2
''form			= Request("form")
''zip1			= Request("zip1")
''zip2			= Request("zip2")
''firstaddress	= Request("firstaddress")
''secondaddress	= Request("secondaddress")
''searchmode		= Request("searchmode")
''smode			= Request("smode")
''keyword			= util.secFilter(Request("keyword"))
''keyword			= Request("keyword")
''searchziptype	= Request("searchziptype")
''Response.Write(unescape(keyword))
''Response.Write("</br>")
''Response.Write(unescape(sigungu))
''Response.Write("</br>")
''Response.Write(unescape(sel_item))
''Response.End()
%>
<style type="text/css">
.box {width:550px; height:250px;overflow:auto;padding:0px;border:1 solid;}
</style>
<script>

	
	var _sido = "<%=sido%>";
	var _sigungu = "<%=sigungu%>";
	function getsigungu(sido){
		if(sido != ''){
				$("#sigungu").removeOption(/./);
				//alert(sido);
				$.post("./api.asp", {sido:sido}, function(data){
				//alert(data);
					eval("var obj="+data);

					$.each(obj[0], function(index, value){
					$("#sigungu").addOption(index, value, false);
					});
					/*
					alert(obj[0]);
					for (var k in obj) {
						//console.log(k+':'+obj[k]["sigungu"]);
						alert(k);
						$("#sigungu").addOption(obj[k]["sigungu"], obj[k]["sigungu"], false);
					}*/
					if(_sigungu != ""){//post로 넘어 온 경우
						$("#sigungu").selectOptions(_sigungu);
					}
					
					
				});
				
			}
	}
	
	$(function(){
		$("#sido").change(function(){
			var sido = $(this).val();
			//alert("ch sido:"+sido);
			getsigungu(sido);
			
		});

		if(_sido != ""){//post로 넘어 온 경우
			getsigungu(_sido);
			
		}
	});
</script>

		<div class="row">
			<div class="col-md-1">
				
				<ul class="nav nav-tabs">
					<li class="active"><a href="#">도로명주소</a></li>
					<li class="btn_address"><a href="#">지번주소</a></li>
				</ul>
			</div>
			<div class="col-md-1">
<% 
If mode = "" OR mode ="search" Then
%>
	<!--			<? if(!$mode || $mode == "search"){?> -->
				<div class="well well-lg">

					<!-- 도로명 주소 폼 -->
					검색방법 : 예)서울시 중구 소공로</br>

					
					<form class="sform"  class="form-horizontal" method="post">
						<table class="table add_list">
				<tr>
					<th>시도</th>
					<th><select id="sido" name="sido" class="form-control" title="시도 선택">
					          <option value="" selected="selected">전체</option>
<%
Dim allKeys, allItems, i, myKey, myItem, selected
allKeys = zipDic.Keys   'Get all the keys into an array
allItems = zipDic.Items 'Get all the items into an array 
For i = 0 To zipDic.Count - 1 'Iterate through the array
myKey = allKeys(i)   'This is the key value
myItem = allItems(i) 'This is the item value
''Response.Write("The " & i & " value in the Dictionary is " & myItem & "<br />")
If sido = myKey Then 
	selected = " selected"
Else 
	selected = ""
End If
Response.Write("<option value='" & myKey & "'" & selected & ">" & myItem & "</option>")
Next
%>
<!--
					          <?php
					          foreach($sidoarr	as $key=>$val){
					          	$selected = $sido == $key ? " selected":"";
					          	echo '<option value="'.$key.'"'.$selected.'>'.$val.'</option>\n';
					          }
							  ?>	
							  -->
							</select></th>
				</tr>
				<tr>
					<th>시군구</th>
					<th><select id="sigungu" name="sigungu" class="form-control" title="시군구 선택"><option value="">전체</option></select></th>
				</tr>
				<tr>
					<th>도로명</th>
					<th><input type="text" name="keyword" class="form-control" id="inputkeyword" placeholder="도로명" value="<%=keyword%>"></th>
				</tr>
				</table>
						
						<button type="submit" class="btn btn-default">검색</button>
						<button type="button" class="btn btn-default" onclick = "self.close();">닫기</button>
					</form>
					<script>
						setWindowResize(600,380);
						$("#inputkeyword").focus();
						$(".sform").submit(function() {
							if ($("#sido").val() == "") {
								alert("시도를 선택해주세요");
							}else if ($("#sigungu").val() == "") {
								alert("시군구를 선택해주세요");
							}else if ($("#inputkeyword").val() == "") {
								alert("동(읍면리)를 입력해 주세요");
							}else{
								$("#mode").val("search");
								gotoPage();
							}
							return false;

						});
					</script>
				</div>
<%
End If ''If mode = "" OR mode ="search" Then
%>
			</div>
			
			
			



<%
	Dim sel_db, zip, sp_item,  add, flag
	If mode = "search" Then
	If keyword <> "" Or ch_item <> "" Then
		If ch_item <> "" Then
			''138-130^서울 송파구 오금동 서울송파우체국
			sp_item	= split(ch_item, "^")
			zip		= Replace(trim(sp_item("0")), "-", "")
			add		= Split(sp_item(1), " ")
			sel_db		= zipPrevDic(add(0))
			strSQL = "select zipcode, sido, sigungu, street, buildingno, dongname, sigungubuildingname, ri, san, areano from " & sel_db & " where zipcode='" & zip & "'"
		Else
			strSQL = "select zipcode, sido, sigungu, street, buildingno, dongname, sigungubuildingname, ri, san, areano from " & sido & " where sigungu = '" & sigungu & "' and street like '%" & keyword & "%'"
		End If
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		''Response.Write(strSQL)


	

	End If''If keyword <> "" Or ch_item <> "" Then
%>
		<div class="well well-lg">
		검색결과
		<br>
		<br>
		<form class="sform" method="post" role="form">	
			<input type="hidden" name="sel_item" id="sel_item">
		</form>	
		<div class="box">
			<table class="table add_list">
				<col width="80px"/>
				<col width="*"/>
				<col width="40px"/>
				<tr>
					<th>우편번호</th>
					<th>주소</th>
					<th></th>
				</tr>
				<%
				Dim dp_zip1, dp_zip2
				while not objRs.eof
				dp_zip1 = Left(objRs("zipcode"), 3)
				dp_zip2 = Right(objRs("zipcode"), 3)
				%>
				
				<tr user-data-add="<% Response.Write dp_zip1 & "-" & dp_zip2 & "^" & objRs("sido") & " " & objRs("sigungu") & " " & objRs("street") & " " & objRs("buildingno")%>">
					<td><%=dp_zip1%>-<%=dp_zip2%></td>
					<td><% Response.Write objRs("sido") & " " & objRs("sigungu") & " " & objRs("street") & " " & objRs("buildingno")%>
					</br>
					<% Response.Write objRs("sido") & " " & objRs("sigungu") & " " & objRs("dongname") & " " & objRs("sigungubuildingname") & " " & objRs("ri") & " " & objRs("areano")%></td>
					<td><button type="button" class="btn btn-default btn-xs btn_sel">선택</button></td>
				</tr>
				<%
				objRs.MOVENEXT
				flag = 1
Wend
SET objRs =Nothing
if flag <> 1 then
%>
				<tr>
					<td></td>
					<td>검색결과가 없습니다.</td>
					<td></td>
				</tr>
<%
End If''if flag <> 1 then
%>
			</table>	
		</div>
				
	
		</div>
		<script>
			setWindowResize(600,700);
			$(".btn_sel").click(function(){
					var sel_item = $(this).parents("tr").attr("user-data-add");
					$("#sel_item").val(sel_item);
					$("#mode").val("search_detail");
					gotoPage();
			});
		</script>
<%
ElseIf mode = "search_detail" Then
Dim TmpAddr, TmpZipcode
	TmpAddr	= split(sel_item, "^")
	TmpZipcode	= split(TmpAddr(0), "-")
	''$TmpAddr = explode("^", $sel_item);
	''$TmpZipcode = explode("-" , $TmpAddr[0]);
%>

		<div class="well well-lg">
		<form name = "ThirdFrm" id="ThirdFrm" method = "post" class="form-horizontal" role="form">
			<input type = "hidden" name = "address1" id="address1" value = "<%=TmpAddr(1)%>">
								나머지
								주소를 입력하시고, '적용'을 <b><font color="#CC3399">클릭</b>하세요.</br>
							
			<div class="form-group">
				<label for="inputkeyword">우편 번호</label>
				<input type='text' name='zip1' id="zip1" value='<%=TmpZipcode(0)%>' readonly  class="form-control w50" style="display: inline" >
				-
				<input type='text' name='zip2' id="zip2" value='<%=TmpZipcode(1)%>' readonly  class="form-control w50"  style="display: inline">
			</div>
			<div class="form-group">
				<label>주소</label>
				<label><%=TmpAddr(1)%></label>
			</div>
			<div class="form-group">
				<label for="inputkeyword">상세주소</label>
				<input name="address2" id="address2" type="text" class="form-control" >
			</div>
			

			<div class="form-group">
				<button type="submit" class="btn btn-default">적용</button>
				<button type="button" class="btn btn-default"  onclick = "location.reload()">이전</button>
				<button type="button" class="btn btn-default" onclick = "self.close();">닫기</button>
			</div>
						
		</form>
			<script>
			setWindowResize(600,350);
				document.ThirdFrm.address2.focus();
				
				$("#ThirdFrm").submit(function(e){
					e.preventDefault();
					if($("#address2").val() == ""){
						alert("상세주소를 입력하여 주세요");
						$("#address2").focus();
						return false;
					}else{
						$("#<%=zip1 %>",opener.document).val($("#zip1").val());
						$("#<%=zip2 %>",opener.document).val($("#zip2").val());
						$("#<%=firstaddress %>",opener.document).val($("#address1").val());
						$("#<%=secondaddress %>",opener.document).val($("#address2").val());
						$("#<%=secondaddress %>",opener.document).focus();
						window.close();
						return false;
					}
				});
				//function checkThirdFrm(f){
					
				//}
		</script>
		</div>
	

<%
End If
%>
			
			
			
		</div>