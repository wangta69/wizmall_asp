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

Dim p_idx_no,menushow,theme,smode
Dim flag,p_que,p_ans_qty,p_ans1,p_ans2,p_ans3,p_ans4,p_ans5,p_ans6,p_ans7,p_ans8,p_ans9,p_ans10,p_regdate,p_count

p_idx_no	= request("p_idx_no")
menushow	= request("menushow")
theme		= request("theme")
smode		= request("smode")

if smode = "qup" then	
	strSQL = "select * from wizpoll where p_idx_no=" & p_idx_no 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	p_idx_no	= objRs("p_idx_no")
	flag		= objRs("flag")
	p_que		= objRs("p_que")
	p_ans_qty	= objRs("p_ans_qty")
	p_ans1		= objRs("p_ans1")
	p_ans2		= objRs("p_ans2")
	p_ans3		= objRs("p_ans3")
	p_ans4		= objRs("p_ans4")
	p_ans5		= objRs("p_ans5")
	p_ans6		= objRs("p_ans6")
	p_ans7		= objRs("p_ans7")
	p_ans8		= objRs("p_ans8")
	p_ans9		= objRs("p_ans9")
	p_ans10		= objRs("p_ans10")
	p_regdate	= objRs("p_regdate")
	p_count		= objRs("p_count")
else 
	smode = "qin"	
end if
	
%>
<script>
<!--

function sendit(){
   var f = document.ff;
   	if(f.p_que.value==""){
   		alert("'QUESTION'을 입력하세요!!!")
   		f.p_que.focus()
   		return 
  	}   
  	
    	document.ff.submit();
}

function rset(){
	var f = document.ff;
	f.reset()
	f.p_que.focus()
}

function listit(){
	location.href="main.asp?menushow=<%=menushow%>&theme=poll/poll_list"
}



function toggle(f){
    for(i=1; i <=10; i++){
        if(i <= f.value){
			eval("answer"+i+".style.display = 'block'");
		}else{
			eval("answer"+i+".style.display = 'none'");
		}
    }
}


//-->
</script>

<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>설문조사 등록하기</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>


      <form method="post" action="poll/poll_writecon.asp" name="ff">
        <input type="hidden" name="menushow" value="<%=menushow%>">
        <input type="hidden" name="theme" value="<%=theme%>">
        <input type="hidden" name="query" value="<%=smode%>">
        <input type="hidden" name="p_idx_no" value="<%=p_idx_no%>">
        <table class="table_main w_default">
          <tr>
            <td>QUESTION</td>
            <td width="450" height="25" colspan="2" class="admintd">&nbsp;
              <input name="p_que" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 400px" value="<%=p_que%>">
            </td>
          </tr>
          <tr>
            <td>type</td>
            <td width="450" height="25" colspan="2" class="admintd">&nbsp;
              <select name="flag">
                <option value="0" <% if flag="0" then Response.Write("selected") %>>일반</option>
                <option value="1" <% if flag="1" then Response.Write("selected") %>>회원</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>ANSWER
              QTY</td>
            <td width="450" height="25" colspan="2" class="admintd">&nbsp;
              <select name="p_ans_qty" onChange="toggle(this)">
                <option value="0" selected>선택</option>
                <option value="1" <% if p_ans_qty=1 then Response.Write("selected") %>>1</option>
                <option value="2" <% if p_ans_qty=2 then Response.Write("selected") %>>2</option>
                <option value="3" <% if p_ans_qty=3 then Response.Write("selected") %>>3</option>
                <option value="4" <% if p_ans_qty=4 then Response.Write("selected") %>>4</option>
                <option value="5" <% if p_ans_qty=5 then Response.Write("selected") %>>5</option>
                <option value="6" <% if p_ans_qty=6 then Response.Write("selected") %>>6</option>
                <option value="7" <% if p_ans_qty=7 then Response.Write("selected") %>>7</option>
                <option value="8" <% if p_ans_qty=8 then Response.Write("selected") %>>8</option>
                <option value="9" <% if p_ans_qty=9 then Response.Write("selected") %>>9</option>
                <option value="10" <% if p_ans_qty=10 then Response.Write("selected") %>>10</option>
              </select>
            </td>
          </tr>
          <tr id="answer1" style="display:none">
            <td width="150" align="center">ANSWER 1</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(0)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans1%>"></td>
          </tr>
          <tr id="answer2" style="display:none">
            <td width="150" align="center">ANSWER 2</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(1)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans2%>"></td>
          </tr>
          <tr id="answer3" style="display:none">
            <td width="150" align="center">ANSWER 3</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(2)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans3%>"></td>
          </tr>
          <tr id="answer4" style="display:none">
            <td width="150" align="center">ANSWER 4</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(3)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans4%>"></td>
          </tr>
          <tr id="answer5" style="display:none">
            <td width="150" align="center">ANSWER 5</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(4)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans5%>"></td>
          </tr>
          <tr id="answer6" style="display:none">
            <td width="150" align="center">ANSWER 6</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(5)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans6%>"></td>
          </tr>
          <tr id="answer7" style="display:none">
            <td width="150" align="center">ANSWER 7</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(6)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans7%>"></td>
          </tr>
          <tr id="answer8" style="display:none">
            <td width="150" align="center">ANSWER 8</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(7)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans8%>"></td>
          </tr>
          <tr id="answer9" style="display:none">
            <td width="150" align="center">ANSWER 9</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(8)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans9%>"></td>
          </tr>
          <tr id="answer10" style="display:none">
            <td width="150" align="center">ANSWER 10</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input name="p_ans(9)" type="text" style="BACKGROUND-COLOR: white; BORDER: #AABABE 1 solid; HEIGHT: 18px; width: 300px" value="<%=p_ans10%>"></td>
          </tr>
        </table>
      </form>
      <table class="table_main w_default">
        <tr>
          <td align="center">
            <input type="button" name="b1" value="등록" onClick="javascript:sendit();">
            <input type="button" name="b3" value="목록" onClick="javascript:listit();">
             </td>
        </tr>
        <!--관리자 버튼 끝-->
      </table>
      <br />
    </td>
  </tr>
</table>
<script language="javascript">
<!--		
toggle(document.ff.p_ans_qty);
//-->
</script>
