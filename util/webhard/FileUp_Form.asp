<script language="javascript">
<!--
function file_ck()
{
	if (document.upload.attached.value!='')
	{
		ShowProgress();
	}
}

function ShowProgress() 
{ 
   strAppVersion = navigator.appVersion; 
   if (document.upload.attached.value != "") {
      if (strAppVersion.indexOf('MSIE')!=-1 && 
          strAppVersion.substr(strAppVersion.indexOf('MSIE')+5,1) > 4) { 

          winstyle = "dialogWidth=385px; dialogHeight:150px; center:yes"; 
          window.showModelessDialog("show_progress.asp?nav=ie", null, winstyle); 
		  document.upload.submit();
      } 
      else { 
          winpos = "left=" + ((window.screen.width-380)/2)+",top=" +
               ((window.screen.height-110)/2); winstyle="width=380,height=110,status=no,toolbar=no,menubar=no," + 
               "location=no, resizable=no,scrollbars=no,copyhistory=no," + winpos; 
          window.open("show_progress.asp",null,winstyle); 
		  document.upload.submit();
      } 
   }

   return true; 
} 

//--> 
</SCRIPT> 

<table width=100% border=0 align=center>
	<tr>
		<td width="60%">
		<p align=right>
		<!-- UpFile attached -->
<form name="upload" method="post" action="UpLoad.asp" enctype="multipart/form-data">
		<!--<input type=hidden size="50" name="file_up_path" value="..<%=mid(CurrentFolder,21)%>">-->
		<input type=hidden size="50" name="file_up_path" value="<%=CurrentFolder%>">
		<input type="file" name="attached" size="40" class="submit" name="b1" style="CURSOR: hand" value='' onChange="javascript:addTextArea(this.form);">
</form>
		</p>
	</td>
	<td>
	<input type="button" value="파일업로드" style="CURSOR: hand" class="submit" name=b1  border="0" onClick='javascript:file_ck();'>
	</td>
	</tr>
</table>