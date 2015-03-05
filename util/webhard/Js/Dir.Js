if (document.layers)
    window.setResizable(false);
var c = 0;
function addTextArea (objForm) {
  // 인터넷 익스플로러 4 이상
  if (document.all) {
    var strHtml = '<br><input type="file" name="attached" size="40" class=LINE_B_A onChange="javascript:addTextArea(this.form);">';
    objForm.insertAdjacentHTML('beforeEnd', strHtml)
  }
  // 넷스케이프 6 이상
  else if (document.getElementById) {
    var objTextarea = document.createElement('TEXTAREA');
    objTextarea.name = 'nameTextArea' + c++;
    objTextarea.rows = 5;
    objTextarea.cols = 40;
    objForm.appendChild(document.createElement('BR'));
    objForm.appendChild(objTextarea);
  }
  // 넷스케이프 4
  else if (document.layers) {
    var objLayer = new Layer (window.innerWidth);
    var strHtml = '';
    strHtml += '<HTML><BODY><FORM NAME="myForm">';
    strHtml += '<TEXTAREA NAME="nameTextArea" ROWS="5" COLS="40"><\/TEXTAREA>';
    strHtml += '<\/FORM><\/BODY><\/HTML>';
    objLayer.document.open();
    objLayer.document.write(strHtml);
    objLayer.document.close();
    objLayer.top = document.height;
    document.height += objLayer.document.height;
    objLayer.visibility = 'show';
  }
}



function check(mode)
{
		for( var i=0; i<document.dir_List.length; i++)	
		{
			var ele=document.dir_List.elements[i];
			if (ele.name=="select_item")
			{
			if (ele.checked==true)
				{
					var acc=true;
				}
			}
		}
		if (acc)
		{
			check_ok(mode)
		}
}

function check_ok(mode)
{
if (confirm("선택된 목록을 "+mode+" 하시겠습니까?\n\n "+mode+"명령을 실행한 후에는 복구하실 수 없습니다."))
	document.dir_List.action = mode+'.asp';
	document.dir_List.submit();
}

function make_file(path)
{
new_win("makeFile.asp?path="+path,600,500)

}
function new_folder(path)
{
	valfolder = prompt("새로 만들 폴더의 이름을 넣어주세요.폴더 제목의 글자수는 30자 이내입니다.\n", "")
	if (!(valfolder =="" || valfolder == null || valfolder.length >= 30))
	{
	location.href = "CreateFolder.asp?path="+path+"&folderName=" + valfolder;
	}
	else
	{
	alert("저장목록 폴더 제목의 글자수는 30자 이내입니다.")
	return false;
	}
}

function new_win(url,wi,hi)
{
window.open(url,'Dir','resizable=1,width='+wi+',height='+hi+',toolbars=0');
}

function reload_close()
{
opener.location.reload();
window.close();
}

function Keypad()
{
	if(window.event.keyCode==13)
	check();
	return false;
}



function ck_form(the_form)
{

	for( var i=0; i<the_form.elements.length; i++) 
	{
	var el = the_form.elements[i];
	if ((el.className=='ck')&&(el.value==''))
		{
		el.className='er';
		alert('경고!! '+el.name+'값이 없습니다.\n\nKhaki색으로 표시된 ' + el.name +'을 채우셔야 합니다.');
		return false;
		}
	else
		{
		el.className='ck';
		}

	}
the_form.submit();
}//-->
