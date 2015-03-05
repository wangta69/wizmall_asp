<%@ CodePage="949"%>
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


Dim sido, sigungu, mode, keyword, ch_item, sel_item
Dim zip1, zip2, firstaddress, secondaddress
sido			= Request("sido")
sigungu			= unescape(Request("sigungu"))
mode			= Request("mode")
keyword			= unescape(Request("keyword"))
If keyword = "undefined" Then keyword = ""
''keyword			= unescape(Request("keyword"))
ch_item			= Request("ch_item")
sel_item		= unescape(Request("sel_item"))

zip1			= Request("zip1")
zip2			= Request("zip2")
firstaddress	= Request("firstaddress")
secondaddress	= Request("secondaddress")

%>
<style type="text/css">
.box {width:550px; height:250px;overflow:auto;padding:0px;border:1 solid;
}
</style>
		<div class="row">
			<div class="col-md-1">
				
				<ul class="nav nav-tabs">
					<li class="btn_street"><a href="#">도로명주소</a></li>
					<li class="active"><a href="#">지번주소</a></li>
				</ul>
			</div>
			<div class="col-md-1">
<% 
If mode = "" OR mode ="search" Then
%>
				<div class="well well-lg">

					<!-- 도로명 주소 폼 -->
					찾고자  하는 주소의 동(읍/면/리)를 입력해주세요 </br>예) 역삼2동, 서초동, 송파동 </br>

					
					<form class="sform" method="post">
						<div class="form-group">
							<label for="inputkeyword">검색어</label>
							<input type="text" name="keyword" class="form-control" id="inputkeyword" value="<%=keyword%>" placeholder="동(읍/면/리)를 입력">
						</div>
						
						<button type="submit" class="btn btn-default">검색</button>
						<button type="button" class="btn btn-default" onclick = "self.close();">닫기</button>
					</form>
					<script>
						setWindowResize(600,280);
						$("#inputkeyword").focus();
						$(".sform").submit(function() {
							if ($("#inputkeyword").val() == "") {
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
	keyword = trim(keyword)
	strSQL = "select * from zipcode where dong like '%" & keyword & "%' order by sido asc, gugun asc"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

%>
		<div class="well well-lg">
		 검색결과
		<br>
		<br>
		
		
		
		
		<form class="sform" method="post" role="form">	
			<input type="hidden" name="sel_item" id="sel_item">
			<input type="hidden" name="ch_item" id="ch_item">
		</form>
					

	<div class="box">
				<table class="table">
					<col width="*" />
					<col width="120px" />
					<%
				Dim dp_zip1, dp_zip2
				while not objRs.eof
				dp_zip1 = Left(objRs("zipcode"), 3)
				dp_zip2 = Right(objRs("zipcode"), 3)
				%>
					<tr user-data-add="<% Response.Write (dp_zip1 & "-" & dp_zip2 & "^" & objRs("sido") & " " & objRs("gugun") & " " & objRs("dong"))%>">
						<td>(<% Response.Write (dp_zip1 & "-" & dp_zip2 & ")" & objRs("sido") & " " & objRs("gugun") & " " & objRs("dong") & " " & objRs("bunji"))%></td>
						<td>
							<button type="button" class="btn btn-default btn-xs btn_sel">선택</button>
							<button type="button" class="btn btn-default btn-xs btn_goto">신주소</button>
						</td>
					</tr>
					<%
				objRs.MOVENEXT
				flag = 1
Wend
SET objRs =Nothing
if flag <> 1 then
%>		<tr>
						<td colspan="2">데이타 없음</td>
						<td></td>
					</tr>
<%
End If''if flag <> 1 then
%>
					
				</table>
		</div>

				
				
				
		

		
		<!--
		<form class="sform" method="post" role="form">			

					<select name='sel_item' class="form-control" size='6' onDblClick='javascript:GotoStep3(this.form);'>

				</select>
				
				
		</form>
		-->
		</div>
		<script>
			setWindowResize(600,650);
			$(function(){
				$(".btn_sel").click(function(){
					var sel_item = $(this).parents("tr").attr("user-data-add");
					//alert(sel_item);
					$("#sel_item").val(sel_item);
					$("#mode").val("search_detail");
					gotoPage();
				});
				
				$(".btn_goto").click(function(){
					var ch_item = $(this).parents("tr").attr("user-data-add");
					$("#ch_item").val(ch_item);
					switchtype("street");
					$("#mode").val("search");
					gotoPage();
				});
			});

		</script>
<%
ElseIf mode = "search_detail" Then
Dim TmpAddr, TmpZipcode
	TmpAddr	= split(sel_item, "^")
	TmpZipcode	= split(TmpAddr(0), "-")
%>
		<div class="well well-lg">
		<form name = "ThirdFrm" id="ThirdFrm" method = "post" class="form-horizontal" role="form">
			<input type = "hidden" name = "address1" id="address1" value = "<%=TmpAddr(1)%>">
								나머지
								주소를 입력하시고, '주소입력'을 <b><font color="#CC3399">클릭</b>하세요.</br>
							
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

