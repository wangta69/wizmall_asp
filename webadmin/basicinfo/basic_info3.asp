<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/cart_info.asp" -->
<!-- #include file = "../../config/bank_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim Loopcnt
Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database


%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$("#btn_save").click(function(){
		$("#s_form").submit();
	});
});
//-->
</script>

<table  class="table_outline">
	<tr>
		<td><fieldset class="desc">
			<legend>몰 결제환경 설정</legend>
			<div class="notice">[note]</div>
			<div class="comment"> 몰의 결제 환경설정을 하실 수 있습니다. 결제방법을 원하시면 각각의 결제방법 앞에 책크해 주시면됩니다.<br />
				결제종류 : 온라인무통장, 신용카드, 포인트(적립금), 다중결제(온라인+신용카드+포인트)<br />
				배송비선택 및 vat. 설정 그리고 카테고리별 카드가 차등적용등이 가능합니다.<br />
				기본제공외의 결제모듈에 관해서는 업체와 상담하시기 바랍니다.</div>
			</fieldset>
			<p></p>
			<form action='./basicinfo/basic_info3_1.asp' method="post" name="s_form" id="s_form">
				<input type=hidden name="qry" value="pay_write">
				<table class="table_main w_default">
					<tr>
						<td colspan=2 height=22>다음의 결제관련 설정을 정확히 지정하여 
							주십시오.</td>
					</tr>
					<tr>
						<td valign=top width=96><br />
							<br />
							shopwiz<br />
							결제형식 설정</td>
						<td><table class="table_sub">
								<tr>
									<td><input type="checkbox" value=checked name=online_enable  <%=online_enable%>>
										온라인무통장 결제(기본)</td>
								</tr>
								<tr>
									<td>온라인 결제계좌등록 :
										<textarea name=ziro_list rows=5 style="width:98%"><%
for loopcnt=1 to ubound(ziro_list)
	response.write ziro_list(loopcnt)&chr(13)&chr(10)
next				  
					  
					  %>
</textarea>
										<br />
										* 결제계좌 등록예제 : 한국은행 | 000-0000-00-000 
										| (주)회사 <br />
										* 한줄에 하나씩 입력해 주세요.</td>
								</tr>
							</table>
							<br />
							<table class="table_sub">
								<col width="250px" />
								<col width="*" />
								<tr>
									<td colspan="2"><input type="checkbox" value=checked name=card_enable  <%=card_enable%>>
										신용카드 결제</td>
								</tr>
								<tr>
									<th>결제시스템 업체</th>
									<td><select  name="pg_pack">
											<%=util.showfolderlist(path_system & "skinwiz\paymodule",pg_pack)%>
										</select>
									</td>
								</tr>
								<tr>
									<th>상점아이디</th>
									<td>
										<input  size=8 value="<%=card_id%>" name="card_id">
									</td>
								</tr>
								<tr>
									<th>상점키</th>
									<td><input  size=8 value="<%=card_pass%>" name="card_pass">
										pg관련 key값 입력<br />
									</td>
								</tr>
								<tr>
									<th>신용카드 최소 제품구매액</th>
									<td>
										<input  value="<%=card_enable_money%>" name="card_enable_money">
										원 이상</td>
								</tr>
								<tr>
									<td colspan="2"><input type="checkbox" value=checked name=phone_enable  <%=phone_enable%>>
										핸드폰결제 </td>
								</tr>
								<tr>
									<td colspan="2"><input type="checkbox" value=checked name=autobanking_enable  <%=autobanking_enable%>>
										실시간자동이체</td>
								</tr>
							</table>
							<br />
							<table class="table_sub">
								<tr>
									<td ><input type="checkbox" value=checked name="point_enable" <%=point_enable%>>
										포인트 결제</td>
								</tr>
								<tr>
									<td>* 
										최소 구매 허용 포인트 
										<input name="point_enable_money" value="<%=point_enable_money%>">
										포인트 이상<br />
										* , (컴마) 표시 없이 숫자로만 입력해 주시기 바랍니다. </td>
								</tr>
							</table>
							<br />
							<table class="table_sub">
								<tr>
									<td>배송비
										<input type=text name=tackbae_money value='<%=tackbae_money%>'>
										원(,(컴마)없이 숫자로만 입력)</td>
								</tr>
								<tr>
									<td><input type="radio" name="tackbae_all" value="disable" <% if tackbae_all = "disable" then response.write "checked"%>>
										배송비 미 적용.<br />
										<input type="radio" name="tackbae_all" value="enable" <%if tackbae_all = "enable" then response.write "checked"%>>
										상품구매액이
										<input type=text name=tackbae_cutline value='<%=tackbae_cutline%>' >
										미만일 경우 배송비 적용.<br />
										<input type="radio" name="tackbae_all" value="all" <%if tackbae_all = "all" then response.write "checked"%>>
										구매액에 관계없이 배송비적용 <br />
										<input type="radio" name="tackbae_all" value="each" <%if tackbae_all = "each" then response.write "checked"%>>
										제품당 적용된 배송비적용 <br />
										<input type="radio" name="tackbae_all" value="per" <%if tackbae_all = "per" then response.write "checked"%>>
										제품(수)당 배송비적용 </td>
								</tr>
							</table>
							<div class="agn_c"><span class="button bull" id="btn_save"><a>저장</a></span></div></td>
					</tr>
				</table>
			</form></td>
	</tr>
</table>
<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing
%>
