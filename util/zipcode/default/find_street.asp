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
zipDic.Add "db_zip_seoul","����Ư����"
zipDic.Add "db_zip_busan","�λ걤����"
zipDic.Add "db_zip_daegu","�뱸������"
zipDic.Add "db_zip_incheon","��õ������"
zipDic.Add "db_zip_gwangju","���ֱ�����"
zipDic.Add "db_zip_daejeon","����������"
zipDic.Add "db_zip_ulsan","��걤����"
zipDic.Add "db_zip_sejong","����Ư����ġ��"
zipDic.Add "db_zip_gangwon","������"
zipDic.Add "db_zip_gyeonggi","��⵵"
zipDic.Add "db_zip_gyeongsang_s","��󳲵�"
zipDic.Add "db_zip_gyeongsang_n","���ϵ�"
zipDic.Add "db_zip_jeolla_s","���󳲵�"
zipDic.Add "db_zip_jeolla_n","����ϵ�"
zipDic.Add "db_zip_jeju","����Ư����ġ��"
zipDic.Add "db_zip_chungcheong_s","��û����"
zipDic.Add "db_zip_chungcheong_n","��û�ϵ�"

Set zipPrevDic = Server.CreateObject("Scripting.Dictionary")
zipPrevDic.Add "����","db_zip_seoul"
zipPrevDic.Add "�λ�","db_zip_busan"
zipPrevDic.Add "�뱸","db_zip_daegu"
zipPrevDic.Add "��õ","db_zip_incheon"
zipPrevDic.Add "����","db_zip_gwangju"
zipPrevDic.Add "����","db_zip_daejeon"
zipPrevDic.Add "���","db_zip_ulsan"
zipPrevDic.Add "����","db_zip_sejong"
zipPrevDic.Add "����","db_zip_gangwon"
zipPrevDic.Add "���","db_zip_gyeonggi"
zipPrevDic.Add "�泲","db_zip_gyeongsang_s"
zipPrevDic.Add "���","db_zip_gyeongsang_n"
zipPrevDic.Add "����","db_zip_jeolla_s"
zipPrevDic.Add "����","db_zip_jeolla_n"
zipPrevDic.Add "����","db_zip_jeju"
zipPrevDic.Add "�泲","db_zip_chungcheong_s"
zipPrevDic.Add "���","db_zip_chungcheong_n"


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
					if(_sigungu != ""){//post�� �Ѿ� �� ���
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

		if(_sido != ""){//post�� �Ѿ� �� ���
			getsigungu(_sido);
			
		}
	});
</script>

		<div class="row">
			<div class="col-md-1">
				
				<ul class="nav nav-tabs">
					<li class="active"><a href="#">���θ��ּ�</a></li>
					<li class="btn_address"><a href="#">�����ּ�</a></li>
				</ul>
			</div>
			<div class="col-md-1">
<% 
If mode = "" OR mode ="search" Then
%>
	<!--			<? if(!$mode || $mode == "search"){?> -->
				<div class="well well-lg">

					<!-- ���θ� �ּ� �� -->
					�˻���� : ��)����� �߱� �Ұ���</br>

					
					<form class="sform"  class="form-horizontal" method="post">
						<table class="table add_list">
				<tr>
					<th>�õ�</th>
					<th><select id="sido" name="sido" class="form-control" title="�õ� ����">
					          <option value="" selected="selected">��ü</option>
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
					<th>�ñ���</th>
					<th><select id="sigungu" name="sigungu" class="form-control" title="�ñ��� ����"><option value="">��ü</option></select></th>
				</tr>
				<tr>
					<th>���θ�</th>
					<th><input type="text" name="keyword" class="form-control" id="inputkeyword" placeholder="���θ�" value="<%=keyword%>"></th>
				</tr>
				</table>
						
						<button type="submit" class="btn btn-default">�˻�</button>
						<button type="button" class="btn btn-default" onclick = "self.close();">�ݱ�</button>
					</form>
					<script>
						setWindowResize(600,380);
						$("#inputkeyword").focus();
						$(".sform").submit(function() {
							if ($("#sido").val() == "") {
								alert("�õ��� �������ּ���");
							}else if ($("#sigungu").val() == "") {
								alert("�ñ����� �������ּ���");
							}else if ($("#inputkeyword").val() == "") {
								alert("��(���鸮)�� �Է��� �ּ���");
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
			''138-130^���� ���ı� ���ݵ� ������Ŀ�ü��
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
		�˻����
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
					<th>�����ȣ</th>
					<th>�ּ�</th>
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
					<td><button type="button" class="btn btn-default btn-xs btn_sel">����</button></td>
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
					<td>�˻������ �����ϴ�.</td>
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
								������
								�ּҸ� �Է��Ͻð�, '����'�� <b><font color="#CC3399">Ŭ��</b>�ϼ���.</br>
							
			<div class="form-group">
				<label for="inputkeyword">���� ��ȣ</label>
				<input type='text' name='zip1' id="zip1" value='<%=TmpZipcode(0)%>' readonly  class="form-control w50" style="display: inline" >
				-
				<input type='text' name='zip2' id="zip2" value='<%=TmpZipcode(1)%>' readonly  class="form-control w50"  style="display: inline">
			</div>
			<div class="form-group">
				<label>�ּ�</label>
				<label><%=TmpAddr(1)%></label>
			</div>
			<div class="form-group">
				<label for="inputkeyword">���ּ�</label>
				<input name="address2" id="address2" type="text" class="form-control" >
			</div>
			

			<div class="form-group">
				<button type="submit" class="btn btn-default">����</button>
				<button type="button" class="btn btn-default"  onclick = "location.reload()">����</button>
				<button type="button" class="btn btn-default" onclick = "self.close();">�ݱ�</button>
			</div>
						
		</form>
			<script>
			setWindowResize(600,350);
				document.ThirdFrm.address2.focus();
				
				$("#ThirdFrm").submit(function(e){
					e.preventDefault();
					if($("#address2").val() == ""){
						alert("���ּҸ� �Է��Ͽ� �ּ���");
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