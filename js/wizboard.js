$(function(){
	//저장
	$(".btn_save").click(function(){

		if($("#sethtmleditor").val() == "1") oEditors.getById["board_content"].exec("UPDATE_IR_FIELD", []);
		if($('#board_write_form').formvalidate()){
			//다중파일 전송(리스트 쌓아두고 처리할 경우
			if($("#multi_file_list")){
				var multi_file_len = $("#multi_file_list").length;
				var TmpMultiFileValue = '';		
				var tmparr = "";
				for(var i=0; i< multi_file_len; i++){
					if($("#multi_file_list").options[i]) TmpMultiFileValue += $("#multi_file_list").options[i].value + '|';
				}
				$("#multifilevalue").val(TmpMultiFileValue);
			}
			//자동쓰기 방지
			$("#spamfree").val($("#hidden_tmp_spamfree").val());
			
			$("#board_write_form_trans_div").show();
			$("#board_write_form").hide();
			$('#board_write_form').submit();



		}else{
			//alert('');	
		}
	});
});


function b_search_check(f){
	if(f.search_keyword.value==""){
		alert('키워드를 입력해 주세요');
		f.search_keyword.focus();
		return false; 
	}else return true;
}

function closeImgLayer(){
	imgLayer.style.display = "none";
}

function openImgLayer(src){
	//imgLayer.style.posLeft = event.clientX
   // imgLayer.style.posTop = event.clientY
   imgLayer.style.posLeft = 0
   imgLayer.style.posTop = 0
	imgLayer.style.display = "block";
	popLayerImg.src = src;
}
