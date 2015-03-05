<%
Dim id : id = Request("id")
''Response.Write(id)
%>
<html>
<head>
<meta http-equiv='Content-type' content='text/html; charset=utf-8'>
<meta http-equiv="cache-control" content="no-cache, must-revalidate">
<meta http-equiv="pragma" content="no-cache">
<title>이미지삽입</title>
<link rel="stylesheet" type="text/css" href="css/editor.css" />
<link href="css/imgupload.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body { margin:0; padding:0; }
</style>
<script language="javascript">
//parent.parent.parent.document.getElementById('kkkk').innerHTML += "<input type=text name='test'>";
var capaHTML = 0;
var isGecko = 0;

if ( navigator.product == "Gecko" ) {
  capaHTML = 1;
  isGecko = 1;
}

function fileCheck( target, obj) {
    pathpoint = obj.lastIndexOf('.');
    filepoint = obj.substring(pathpoint+1,obj.length);
    filetype = filepoint.toLowerCase();
    if(filetype=='jpg' || filetype=='gif' || filetype=='png' || filetype=='jpeg' || filetype=='bmp') {
        if( !isGecko ) {
        brower = navigator.userAgent.toUpperCase();
      if (brower.indexOf('MSIE 7') != -1 || brower.indexOf('MSIE 8') != -1 ) {
        target.innerHTML = '<font color=\"B0B0B0\">미리보기는 MS IE 6.0 이하에서만<br>가능합니다.</font>';
      } else {
        target.innerHTML = "<img src='" + obj + "' width='220' height='143'>";
      }
    } else {
            target.innerHTML = '<font color=\"B0B0B0\">미리보기는 MS IE계열만<br>가능합니다.</font>';
    }
    } else {
        alert('이미지 파일만 선택할 수 있습니다.');
        target.innerHTML = '';
        return false;
    }
    if(filetype=='bmp') {
        upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지 포맷이 아닙니다.\n그래도 계속 하시겠습니까?');
        if(!upload) return false;
    }
}

function submitImageUploadForm(uploadForm)
{
  var theFrm = document.editor_upimage;

  fileName = theFrm.attached.value;
  if (fileName == "") {
    alert('본문에 삽입할 이미지를 선택해주세요.');
    return;
  }
    pathpoint = fileName.lastIndexOf('.');
    filepoint = fileName.substring(pathpoint+1,fileName.length);
    filetype = filepoint.toLowerCase();
    if (filetype != 'jpg' && filetype != 'gif' && filetype != 'png' && filetype != 'jpeg' && filetype !='bmp') {
        alert('이미지 파일만 선택할 수 있습니다.');
        self.close();
        return;
    }

    theFrm.imagepath.value = parent.parent.imagepath;
  try {
      theFrm.submit();
  } catch (e) {
    theFrm.reset();
    alert('파일을 업로드할 수 없습니다.');
    return;
  }
}

function closeWin() {
  parent.parent.oEditors.getById["<%=id%>"].exec("SE_TOGGLE_IMAGEUPLOAD_LAYER");  
  return false;
}

</script>
</head>
<body>
<div id="naver_common_editor">
  <form id="editor_upimage" name="editor_upimage" action="imgupload_exec.asp?id=<%=id%>" method="post" enctype="multipart/form-data">
  <input type="hidden" name="imagepath">
  <div class="pic_content" style="border:0;">
    <p class="search"><input type="file" name="attached" style="width:222px;ime-mode:disabled" onChange="fileCheck(document.getElementById('update_image_view'), this.value);" onKeyDown="return false"></p>
    <div class="pic_area" id="update_image_view"></div>
    <div class="btn_box">
      <a href="javascript:submitImageUploadForm(document.getElementById('editor_upimage'));"><img src="img/btn_layer_confirm.gif" alt="확인" width="38" height="21"></a>
      <a href="javascript:closeWin()"><img src="img/btn_layer_cancel.gif" alt="취소" width="38" height="21" border="0"></a>
    </div>
  </div>
  </form>
</div>
</body>
</html>
