<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
Dim option4Arr
%>
<script language="JavaScript">
<!--
function num_plus(num){
	gnum = parseInt(num.buynum.value);
	num.buynum.value = gnum + 1;
	return;
}
function num_minus(num){
	gnum = parseInt(num.buynum.value);
if( gnum > 1 ){
	num.buynum.value = gnum - 1;
	}	
	return;
}
function is_number(){
 	if ((event.keyCode<48)||(event.keyCode>57)){
  		alert("\n\n수량은 숫자만 입력하셔야 합니다.\n\n");
  		event.returnValue=false;
 	}
}
function wishreally(){
if (confirm('\n\n정말로 본 제품을 위시리스트에 담으시겠습니까?\n\n')) return true;
return false;
}

function checkForm(f,flag){
	if(autoCheckForm(f)){
		if(flag == "c"){//장바구니 담기
			return true;
		}else if(flag == "b"){//바로구매
			f.sub_query.value = "baro";
			f.submit();
		}
	}
	else return false;
}

function checkthis(v){

	var i,currEl,splitvalue,commanewprice;
	var f = eval("document."+v.form.name);
	var currPrice = parseInt(f.goodsprice.value);
	var newprice = 0;
	
	
    for(i = 0; i < f.elements.length; i++){ 
		currEl = f.elements[i]; 
		if (currEl.getAttribute("oflag") != null) { 
			if(currEl.value){
				if(currEl.oflag == "1"){//가격추가
					splitvalue = currEl.value.split('|');
					newprice += parseInt(splitvalue[1]);
				}else if(currEl.oflag == "1"){//상품가격변경
					currPrice = parseInt(splitvalue[1]);
				}
			}
		}
	}
	
	newprice = currPrice + newprice; 
	commanewprice = SetComma1(newprice);	
	if (document.layers) { 
		document.layers.item_price.document.write(commanewprice); 
		document.layers.item_price.document.close(); 
	}else if (document.all) item_price.innerHTML = commanewprice;	
}

function ProductPopImg(){
	//window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview.asp?no=<%=uid%>', 'BICIMAGEWINDOW','width=750,height=592,statusbar=no,scrollbars=no,toolbar=no,resizable=no');
	window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview_one.asp?no=<%=uid%>', 'BICIMAGEWINDOW','width=500,height=500,statusbar=no,scrollbars=no,toolbar=no,resizable=no');
}
//-->
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="40" valign="top"><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
				<tr bgcolor="#F6F6F6">
					<td width="15" height="22">&nbsp;</td>
					<td width="18" height="22" valign="middle"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
					<td height="22">Home <%=route%> </td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td align="center"><table width="98%" border="0" cellspacing="0" cellpadding="0">
				<FORM NAME='view_form' ACTION='./skinwiz/cart/cart_query.asp?smode=cart_save' method="post" onsubmit='return checkForm(this);' enctype="multipart/form-data">
					<INPUT TYPE=HIDDEN NAME='no' VALUE='<%=no%>'>
					<INPUT TYPE=HIDDEN NAME='sub_query' VALUE= ''>
					<tr>
						<td align="center"><A HREF="javascript:ProductPopImg();"><IMG SRC='./config/wizstock/<%=picture1%>' BORDER=0 width="230"></A></td>
						<td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
								<tr>
									<td height="25" colspan="3" style="font-family: '굴림', '돋움','Arial';font-size: 14px; color:#333333;line-height:140%"><strong><%=pname%> </strong> <%=dpIcon%></td>
								</tr>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td width="90" height="24" align="left">&nbsp;가격</td>
									<td width="9" height="24">:</td>
									<td width="226" height="24" align="left"><font color="#2266BB"><strong><SPAN id=item_price><%=FormatNumber(price, 0)%>원 </SPAN></strong></font>
										<input type='hidden' name='goodsprice' value='<%=price %>'></td>
								</tr>
								<tr>
									<td height="1" background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" colspan="3"></td>
								</tr>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td width="90" height="24" align="left">&nbsp;시중가격</td>
									<td width="9" height="24">:</td>
									<td width="226" height="24" align="left"><font color="#2266BB"><s> <%=FormatNumber(price1, 0)%> 원</s><strong><s> </s></strong></font></td>
								</tr>
								<tr>
									<td height="1" background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" colspan="3"></td>
								</tr>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td width="90" height="24" align="left">&nbsp;원산지</td>
									<td width="9" height="24">:</td>
									<td width="226" height="24" align="left"><%=porigin%></td>
								</tr>
								<tr>
									<td height="1" background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" colspan="3"></td>
								</tr>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td width="90" height="24" align="left">&nbsp;제조사</td>
									<td width="9" height="24">:</td>
									<td width="226" height="24" align="left"><%=compname%></td>
								</tr>
								<tr>
									<td height="1" background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" colspan="3"></td>
								</tr>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td height="24" align="left">&nbsp; 적립포인트</td>
									<td height="24">:</td>
									<td height="24" align="left"><%=point%></td>
								</tr>
								<tr>
									<td height="1" background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" colspan="3"></td>
								</tr>
								<% ''옵션설정값 디스플레이
Set db = new database
Dim oname, oflag, ouid, objRs1, valuecnt, checkstr, subcnt, oprice, displayoprice
''Dim, uid
''Dim , 
strSQL = "select * from wizMalloptioncfg where opid = '" & no & "' order by oorder asc"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.EOF
	oname	= objRs("oname")
	oflag	= objRs("oflag")
	ouid	= objRs("uid")
	
	//옵션값갯수구하기
	strSQL = "select count(1) from wizMalloption where ouid = '" & ouid &"'"
	Set objRs1 = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	valuecnt = objRs1(0)
	if valuecnt > 0  then 
%>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td height="24" align="left">&nbsp; <%=oname%></td>
									<td height="24">:</td>
									<td height="24" align="left"><%
	if valuecnt = 1 then ''옵션등록갯수가 하나이면 일반 텍스트 디스플레이
		Response.Write(oname)
	else ''실렉트 박스 출력
		if oflag = 0 then checkstr =  "checkenable msg='" & oname & "를 선택해 주세요'" else checkstr = ""
	end if
%>
										<select name="optionfield" class="formline" <%=checkstr%> oflag="<%=oflag%>" onchange="checkthis(this)">
											<OPTION VALUE=''> <%=oname%> 선택</OPTION>
											<%
						strSQL = "select uid, oname, oprice from wizMalloption where ouid = '" & ouid & "' order by uid asc"
						Set objRs1 = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
						subcnt=0
						while not objRs1.EOF
							uid		= objRs1("uid")
							oname	= objRs1("oname")
							oprice	= objRs1("oprice")
							if oprice <> 0 then displayoprice = "("& oprice &")"
							Response.Write( "<OPTION VALUE='"& uid & "|" & oprice & "|" & ouid & "'>"&oname&""&displayoprice&"</OPTION>"&chr(13)&chr(10))
						objRs1.MOVENEXT
						WEND
%>
										</select>
										<%
		end if
%>
									</td>
								</tr>
								<tr>
									<td height="1" background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" colspan="3"></td>
								</tr>
								<% 
	objRs.MOVENEXT
	WEND
%>
								<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
									<td height="24" align="left">&nbsp; 주문수량</td>
									<td height="24">:</td>
									<td height="24"><table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="left"><table cellpadding=0 cellspacing=0 border=0  style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
														<tr>
															<td rowspan=2><input type=TEXT size=3 name="buynum" maxlength=5 value="1" onKeyPress="is_number()">
															</td>
															<td><a href="javascript:num_plus(document.view_form);"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/num_plus.gif" border=0></a></td>
															<td rowspan=2>&nbsp;&nbsp;EA</td>
														</tr>
														<tr>
															<td><a href="javascript:num_minus(document.view_form);"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/num_minus.gif" border=0></a></td>
														</tr>
													</table></td>
											</tr>
										</table></td>
								</tr>
								<tr>
									<td height="1"  colspan="3" bgcolor="#999999"></td>
								</tr>
								<tr>
									<td height="3" colspan="3" bgcolor="#CCCCCC"></td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td height="40" align="center"><A HREF="javascript:ProductPopImg();"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/but_zoom.gif" width="83" height="27" border="0"></a></td>
						<td height="40"><table width="318" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input type="image" src="./skinwiz/viewer/<%=ViewerSkin%>/images/but_jbgn.gif" width="117" height="29"></td>
									<td><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/but_brgm.gif" width="117" height="29" onclick=checkForm(document.view_form,'b'); style=cursor:pointer></td>
									<td><a href="./wizmart.asp?code=<%=code%>"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/but_liest.gif" width="70" height="29" border="0"></a></td>
								</tr>
							</table></td>
					</tr>
				</form>
			</table></td>
	</tr>
	<tr>
		<td align="center"><table width="98%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
				<tr bgcolor="#EBEBEB">
					<td height="24">&nbsp; →&nbsp; 상품상세정보</td>
					<td height="24">&nbsp;</td>
				</tr>
				<tr>
					<td height="1"  colspan="2" bgcolor="#cccccc"></td>
				</tr>
				<tr>
					<td height="3" colspan="2" bgcolor="#E8E8E8"></td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td align="center"><table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr align="center" valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td colspan="2"><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
							<tr>
								<td align="left" valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"><font color ="#000000"><%=description1%></font>
									<p>&nbsp;</p></td>
							</tr>
						</table>
						<br>
					</td>
				</tr>
				<tr>
					<td background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" height="1" colspan="2"></td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td align="center"><table width="98%" border="0" cellpadding="0" cellspacing="0">
				<tr bgcolor="#EBEBEB" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td height="24">&nbsp; →&nbsp; 배송관련정보</td>
					<td height="24">&nbsp;</td>
				</tr>
				<tr>
					<td height="1"  colspan="2" bgcolor="#cccccc"></td>
				</tr>
				<tr>
					<td height="3" colspan="2" bgcolor="#E8E8E8"></td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td align="center"><table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr align="center" valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td colspan="2"><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"><font color ="#000000"><%=description3%></font>
									<p>&nbsp;</p></td>
							</tr>
						</table>
						<br>
					</td>
				</tr>
				<tr>
					<td background="skinwiz/viewer/<%=ViewerSkin%>/images/bg_w.gif" height="1" colspan="2"></td>
				</tr>
			</table></td>
	</tr>
	<!-- 인기 판매 제품 시작 -->
	<tr>
		<td align="center"><table width="98%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/shop_text_04.gif" width="129" height="22"></td>
				</tr>
				<tr>
					<td bgcolor="#C4C4C4" height="1"></td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
<%
if isNull(option5) = False Then  
Dim op5split : 	op5split = split(option5, "|")
Dim Loopcnt, inStr, tmpcnt
subcnt = 0
inStr = "("
For Loopcnt = 0 To Ubound(op5split)
	If op5split(Loopcnt) <> "" Then
		If subcnt = 0 Then
			inStr = inStr & "'" & op5split(Loopcnt) & "'"
		Else
			inStr = inStr & ",'" & op5split(Loopcnt) & "'"
		End If
	subcnt = subcnt + 1
	End If
Next

If subcnt <> 0 Then 
inStr = inStr & ")"
Dim whereis : whereis = " where m1.uid in " & inStr
Dim orderby : orderby = " order by uid desc"
strSQL = "select TOP 4 m1.uid, m1.category, m2.pname, m2.picture, m2.option3, m2.pnone, m2.stock, m2.stockouttype, m2.pinput, m2.poutput, m2.model, m2.Price, m2.Price1 from wizMall m1 left join wizMall m2 on m1.pid = m2.uid " & whereis & orderby 

subcnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
Dim setImgWidth : setImgWidth = 120
while not objRs.eof
    PictureArr = split(objRs("Picture"), "|")
	if ubound(PictureArr) > 0 then Picture0 = PictureArr(0) end if
	if ubound(PictureArr) > 0 then Picture1 = PictureArr(1) end if
	if ubound(PictureArr) > 1 then Picture2 = PictureArr(2) end if
	Model		= objRs("Model")
	Price		= objRs("Price")
	pname		= objRs("pname")
	stockstate	= objRs("stockstate")
	Category	= objRs("Category")
	uid			= objRs("uid")
	if stockstate = false  then 
		VIEW_LINK = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
		''stockouticon = "<img src='./skinwiz/common_icon/"&iconskin&"/icon_soldout.gif'>"
		
	else 
		VIEW_LINK = "'./wizmart.asp?smode=view&code=" & Category & "&no=" & uid & "'"
		''stockouticon = ""
	end if	
%>				
					<td height="190"><table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="80" align="center"><table border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
              <tr>
                <td width="80" align="center"><table width="120" height="120" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%" bordercolor="#bababa">
                    <tr>
                      <td align="center" bgcolor="#FFFFFF"><A HREF=<%=VIEW_LINK%>> <%=mall.getGoodsImg(Picture2, setImgWidth) %></A> </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td align="center" class="company"><A HREF=<%=VIEW_LINK%>> <%=pname%></a>
                  <% 
						if Model <> "" then  
							Response.Write("<br>" & Model)
						end if
						%>
                  <br>
                  <font color="#006699"><strong> <%=FormatNumber(Price, 0)%> 원</strong></font></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
<%
subcnt = subcnt + 1
if cnt mod 4 = 0 then Response.Write "</tr><tr align='center'>"
bjRs.movenext
wend
tmpcnt = subcnt mod 4
if tmpcnt <> 0 then
	for Loopcnt = tmpcnt to 3
		Response.Write("<td width='190'></td>")
	next
end if
End If

End If ''If subcnt <> 0 Then 
%>					
				</tr>
			</table></td>
	</tr>
	<!-- 인기 판매 제품 끝 -->
	<!-- 상품 평가 시작 -->
	<tr>
		<td align="center"><table width="98%" border="0" cellpadding="0" cellspacing="0">
				<tr bgcolor="#EBEBEB" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td height="24"><table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left">&nbsp; →&nbsp; 상품평 </td>
								<td align="right"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/but_ww2.gif" width="69" height="19" border="0" onClick="wizwindow('./skinwiz/viewer/<%=ViewerSkin%>/estimatepopup.asp?no=<%=no%>','','width=554,height=450')" style="cursor:pointer"></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="1" bgcolor="#cccccc"></td>
				</tr>
				<tr>
					<td height="3" bgcolor="#E8E8E8"></td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td align="center"><br>
			<script language="JavaScript">
<!--
function check_reple_Form(){
	var f=document.estimat;
	if(f.Name.value == ''){
		alert('성함을 입력해주세요');
		f.Name.focus();
		return false;
	} else if(f.Contents.value == ''){
		alert('상품사용후기를 입력해주세요');
		f.Contents.focus();
		return false;
	}
}

function reple_delete(uid){
var f=document.estimat;
	f.repleqry.value = "insert";
	f.mode.value = "";
	f.repleuid.value = uid;
	f.submit();

}
//-->
</script>
			<form name="estimat" action="wizboard.asp" onsubmit='return check_reple_Form();'>
				<input type="hidden" name="smode" value="qin">
				<input type="hidden" name="code" value="<%=code%>">
				<input type="hidden" name="no" value="<%=no%>">
				<input type="hidden" name="repleqry" value="insert">
				<input type="hidden" name="Name" value="<%=user_name%>">
				<input type="hidden" name="repleuid" value="">
				<!--<% if Session("user_info") <> "" then %>
                                <input name="image2" type="image" src="img/main/btn_sub.gif" width="51" height="21"> 
                                <% else %>
                                <a href="javascript:window.alert('로그인후 사용가능합니다.')"><img src="img/main/btn_sub.gif" width="51" height="21" border="0"></a> 
                                <% end if%>-->
			</form>
			<% 
Set db	= new database	  
Dim c_uid,c_name,c_id,c_coment,c_subject,c_grade
strSQL = "select * from wizmall_comment where pid = '"&no&"' ORDER BY c_wdate desc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
if objRs.EOF then
%>
			<table width="100%" height="80" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" bordercolor="#bababa">
				<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td align="left">등록된 품평이 없습니다.<br />
						품평을 쓰기 위해서는 로그인 해 주시기 바랍니다.</td>
				</tr>
			</table>
			<%
else WHILE NOT objRs.EOF
c_uid		= objRs("uid")
c_name		= objRs("c_name")
c_id		= objRs("c_id")
c_coment	= objRs("c_comment")
c_subject	= objRs("c_subject")
c_grade		= objRs("c_grade")
%>
			<table width="100%" height="80" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" bordercolor="#bababa">
				<tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td width="150" align="left">글쓴이</td>
					<td align="left"><%=c_name%>
						<% if user_id = c_id then%>
						&nbsp;&nbsp;&nbsp;<a href="javascript:reple_delete('<%=c_uid%>');" >x</a>
						<% end if%></td>
					<td width="150" align="left">고객선호도 </td>
					<td align="left"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/star<%=c_grade%>.gif" width="88" height="15"></td>
				</tr>
				<tr bgcolor="#E6E6E6" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td colspan="4"><%=c_subject%></td>
				</tr>
				<tr valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td colspan="4" bgcolor="#FFFFFF" style="word-break:break-all;"><%=c_coment%></td>
				</tr>
				<tr valign="top" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
					<td height="1" colspan="4" bgcolor="#F0F0F0" style="word-break:break-all;"></td>
				</tr>
			</table>
			<%
	objRs.MOVENEXT
	WEND
end if
db.dispose : Set db = Nothing : Set util = Nothing : Set mall = Nothing
%>
			<br>
			<table width="98%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="28" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"><font color="#006699">≡</font> </td>
					<td style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">상품평은 개인의 체험을 바탕으로 한 주관적인 의견으로 사실과 다르거나,보는 사람에 따라 
						차이가 있을 수 있습니다.</td>
				</tr>
			</table></td>
	</tr>
	<!-- 상품 평가 끝 -->
</table>
<%
'카테고리 매장 분류에서 사용자 정의가 되어있어면 아래와 같이 실행된다.
''Response.Write codeobjRs("cat_bottom")
'카테고리 매장 분류에서 사용자 정의가 되어있어면 상기와 같이 실행된다.
%>
