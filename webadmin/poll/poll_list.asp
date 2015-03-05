<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim citem,cdata,menushow,theme,board_name,page
Dim setPageSize,setPageLink,whereis,orderby,TotalCount,ListNum,searchField,searchKeyword

page		= request("page")	: If page = "" then page = 1
citem		= request("citem")
cdata		= request("cdata")
menushow	= request("menushow")
theme		= request("theme")
		
board_name	= "wizpoll"

setPageSize	= 10
setPageLink	= 10

strSQL = "select count(*) from " & board_name
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)

objRs.close
set objRs =nothing
%>
<script>
<!--
//검색데이터의 입력을 해야 검색 버튼을 누를 권한이 있다
function viewPic(img){ 
  foto1= new Image(); 
  foto1.src=(img); 
  contImg(img); 
} 
function contImg(img){ 
  if((foto1.width!=0)&&(foto1.height!=0)){ 
    viewImg(img); 
  } 
  else{ 
    funzione="contImg('"+img+"')"; 
    intervallo=setTimeout(funzione,20); 
  } 
} 
function viewImg(img){ 
  largh=foto1.width+20; 
  altez=foto1.height+20; 
  stringa="width="+largh+",height="+altez; 
  finestra=window.open(img,"",stringa); 
}

function allcheck(theform)
{
  for(var i=0; i<theform.elements.length; i++){
  	 var ele = theform.elements[i];
  	 if(ele.name == 'chk')	
	 ele.checked = true;
  }
  return;	
}
function discheck(theform)
{
  for(var i=0; i<document.ff.elements.length; i++){
    var ele = document.ff.elements[i];
    if(ele.name == 'chk')
    ele.checked = false;
  }
  return;
}

//체크박스한것만 삭제하기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function chkdel(){
	var f = document.ff
	f.theme.value="poll/chkdelete"
	f.submit();
}
function listit(){
	var f = document.ff
	f.theme.value="poll/poll_list"
	f.submit();
}
function writeit(){
	var f = document.ff
	f.theme.value="poll/poll_write"
	f.submit();
}
function sendit(){
	var f = document.ff
   	if(f.cdata.value==''){
   	
   		alert('검색할 데이터를 입력하세요!')
   		f.cdata.focus()   
   		return
   	
   	}
 	
 	f.submit()
 	
}
//-->
</script>

<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>투표관리</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>


      
        <form method="post" action="main.asp" name="ff">
          <input type="hidden" name="page" value="<%=page%>">
          <input type="hidden" name="menushow" value="<%=menushow%>">
          <input type="hidden" name="theme" value="<%=theme%>">
		  <table class="table_main w_default">
			<col width="50px" />
			<col width="50px" />
			<col width="*" />
			<col width="120px" />
			<col width="80px" />
          <tr>

                    <th>번호</th>
                    <th>type</th>
                    <th>제목</th>
                    <th>시작일</th>
                    <th>참여자수</th>
                  </tr>
         <% 
strSQL = "select TOP " & setPageSize & " p_idx_no,p_que,p_regdate,p_count, flag from " & board_name & " where p_idx_no not in (select TOP " & ((page-1) * setPageSize) & " p_idx_no from " & board_name & " order by p_regdate DESC) order by p_regdate DESC;" 

Dim p_idx_no,p_que,p_regdate,p_count,flag,flag_txt
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 
WHILE NOT objRs.EOF
p_idx_no	= objRs("p_idx_no")
p_que		= objRs("p_que")
p_regdate	= objRs("p_regdate")
p_count		= objRs("p_count")
flag		= objRs("flag")
if flag = 0 then 
	flag_txt = "일반"
elseif flag = 1 then
	flag_txt = "회원"
end if
%>

                  <tr>
                    <td><input type="checkbox" name="chk" value="<%=p_idx_no%>"> <%=ListNum%></td>
                    <td><%=flag_txt%></td>
                    <td><a href="main.asp?menushow=<%=menushow%>&theme=poll/poll_view&smode=qup&p_idx_no=<%=p_idx_no%>"><%=p_que%></a></td>
                    <td><%=left(p_regdate,10)%></td>
                    <td><%=p_count%></td>
                  </tr>
              <%
	ListNum = ListNum - 1
	objRs.MOVENEXT
	WEND
%>

          <tr>
            <td colspan="5" class="agn_c"><%
Set util = new utility
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&searchField="&searchField&"&searchKeyword="&searchKeyword
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%>
                   </td>
          </tr>
          <tr>
            <td align="center" colspan="5">
              <input type="button" name="b1" value="전체선택" onClick="javascript:allcheck(this.form);" style="cursor:pointer;">
              &nbsp;
              <input type="button" name="b2" value="선택해제" onClick="javascript:discheck(this.form);" style="cursor:pointer;">
              &nbsp;
              <input type="button" name="b3" value="삭제" onClick="chkdel()" style="cursor:pointer;">
              &nbsp;
              <input type="button" name="b4" value="전체목록" onClick="listit()" style="cursor:pointer;">
              <input type="button" name="b5" value="글쓰기" onClick="writeit()" style="cursor:pointer;">
            </td>
          </tr>
      
      </table>  </form>
      <br />
    </td>
  </tr>
</table>
