<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
Dim option4Arr
%>
<script type="text/javascript" src="/js/jquery.plugins/jquery.wizimageoverlap-1.0.1.js"></script>
<script type="text/javascript" src="/js/jquery.plugins/jquery.validator-1.0.1.js"></script> 
<script  language="javascript" src="/js/jquery.plugins/jquery.form.js"></script>
<script language="JavaScript">
<!--
$(function(){
	//로드시 초기 이미지 설정
	var iniImg = $(".thumimg:first").attr("src")
	$("#bigImg img").attr("src", iniImg) ; 

	$(".thumimg").mouseover(function(){
	//alert('thumimg');
		$(this).wizimagech();
	});
	
	loadReviewHTML();
	loadQnaHTML(1);

	$(".btn_review_write").click(function(){
		$.post("./skinwiz/viewer/sungwonmall/product_review_write.asp", {no:<%=no%>}, function(data){
			$("#reviewWriteHTML").html(data);
		});		
	});
	

	$(".btn_qna_write").click(function(){
		$.post("./skinwiz/viewer/sungwonmall/product_qna_write.asp", {no:<%=no%>}, function(data){
			$("#qnaWriteHTML").html(data);
		});		
	});
	
	/*
	$("#savacart").click(function(){
		var f = document.view_form;
		var flag = "c";
		
		if(autoCheckForm(f)){
			if(flag == "c"){//장바구니 담기
				return true;
			}else if(flag == "b"){//바로구매
				f.sub_query.value = "baro";
				f.submit();
			}
		}
		else return false;
	});
	*/
});

function loadReviewHTML(){
	$.post("./skinwiz/viewer/sungwonmall/product_review_list.asp", {no:<%=no%>}, function(data){
		$("#reviewHTML").html(data);
	});
}

function loadQnaHTML(page){
	//alert(page)
	$.post("./skinwiz/viewer/sungwonmall/product_qna_list.asp", {no:<%=no%>, page:page}, function(data){
		$("#qnaHTML").html(data);
	});
}
	
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
			f.submit();
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
	window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview_one.asp?no=<%=uid%>', 'BICIMAGEWINDOW','width=750,height=592,statusbar=no,scrollbars=no,toolbar=no,resizable=no');
}
//-->
</script> <form id="view_form"  name='view_form' action='./skinwiz/cart/cart_query.asp?smode=cart_save' method="post" enctype="multipart/form-data">
					<INPUT TYPE=HIDDEN NAME='no' VALUE='<%=no%>'>
					<INPUT TYPE=HIDDEN NAME='sub_query' VALUE= ''> <div id="viewProduct">
    <div class="imgBig" id="bigImg" style="position:relative;"> <img src="./config/wizstock/<%=picture0%>" width="650" height="486" /></div>
    <div class="productSpec">
      <div class="imgSmall">
        <ul>
         <% if picture0 <> "" then%> <li><img src="./config/wizstock/<%=picture0%>" width="86" height="60" class="thumimg hand" /></li><% end if %>
         <% if picture3 <> "" then%> <li><img src="./config/wizstock/<%=picture3%>" width="86" height="60" class="thumimg hand" /></li><% end if %>
         <% if picture4 <> "" then%> <li><img src="./config/wizstock/<%=picture4%>" width="86" height="60" class="thumimg hand" /></li><% end if %>
        </ul>
      </div>
      <div class="specBox"> <img src="img/titView1.gif" />
        <p><%=pname%></p>
      </div>
      <div class="specBox"> <img src="img/titView2.gif" />
        <p><%=model%></p>
      </div>
      <div class="specBox"> <img src="img/titView3.gif" />
        <p><%=description2%></p>
      </div>
      <div class="specBox"> <img src="img/titView4.gif" />
        <p><%
		if price = 0 then 
			Response.Write("가격은 문의해 주세요")
		else 
			Response.Write(FormatNumber(price, 0))
		end if
		%>
        <input type='hidden' name='goodsprice' value='<%=price %>'></p>
      </div>
      <div class="specNum"> <img src="img/titView5.gif" /> 
        <p>
           <table>
														<tr>
															<td rowspan=2><input type=TEXT size=2 name="buynum" maxlength=5 value="1" onKeyPress="is_number()">
															</td>
															<td><a href="javascript:num_plus(document.view_form);"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/num_plus.gif" border=0></a></td>
															<td rowspan=2>&nbsp;&nbsp;EA</td>
														</tr>
														<tr>
															<td><a href="javascript:num_minus(document.view_form);"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/num_minus.gif" border=0></a></td>
														</tr>
													</table></p>
      </div>
      <div class="viewBtn">
      <% if price <> 0 then %>
      <a href="javascript:checkForm(document.view_form,'b');"><img src="img/btnBuy.gif" /></a>
      <a  href="javascript:checkForm(document.view_form,'c');"><img src="img/btnWish.gif" /></a>
      <% end if %>
      <a href="javascript:history.back(-1);"><img src="img/btnContinue.gif" /></a></div>
    </div>
  </div>
  </form>
  <div id="productDetail">
    <h2><img src="img/tit_ProductDetail.gif" /></h2>
    <div class="detailBox"><%=description1%></div>
  </div>
  
  <div id="productDetail">
    <h2><img src="img/p_review.gif" /></h2>
    <div class="agn_r w_default"><span class="btn_review_write button bull"><a>이용후기작성</a></span></div>
    <div class="detailBox" id="reviewWriteHTML"></div>
    <div class="detailBox" id="reviewHTML"></div>
  </div>  
  
  <div id="productDetail">
    <h2><img src="img/p_qna.gif" /></h2>
    <div class="agn_r w_default"><span class="btn_qna_write button bull"><a>상품문의작성</a></span></div>
    <div class="detailBox" id="qnaWriteHTML"></div>
    <div class="detailBox" id="qnaHTML"></div>
  </div> 
<%
'카테고리 매장 분류에서 사용자 정의가 되어있어면 아래와 같이 실행된다.
''Response.Write codeobjRs("cat_bottom")
'카테고리 매장 분류에서 사용자 정의가 되어있어면 상기와 같이 실행된다.
%>
