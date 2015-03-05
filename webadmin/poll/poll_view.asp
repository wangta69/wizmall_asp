<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim p_idx_no,menushow,theme
	
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

	p_idx_no	= request("p_idx_no")
	menushow	= request("menushow")
	theme		= request("theme")
	strSQL = "select * from wizpoll where p_idx_no=" & p_idx_no 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

	
%>
<script>
<!--

function rset(){
	var f = document.ff;
	f.reset()
	f.strque.focus()
}

function listit(){
	location.href="main.asp?menushow=<%=menushow%>&theme=poll/poll_list"
}
function result(){
	location.href="main.asp?menushow=<%=menushow%>&theme=poll/poll_result&p_idx_no=<%=p_idx_no%>"
}
function editit(){
	var f = document.ff;
	f.theme.value = "poll/poll_write"
	f.submit();
}

function toggle(count){
    for(i=1; i <=10; i++){
        if(i <= count){
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
<legend>설문조사 상세보기</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>


      <form method="post" name="ff" action="main.asp">
        <input type="hidden" name="p_idx_no" value="<%=p_idx_no%>">
        <input type="hidden" name="menushow" value="<%=menushow%>">
        <input type="hidden" name="theme" value="<%=theme%>">
        <input type="hidden" name="smode" value="qup">
        <table class="table_main w_default">
          <tr>
            <td>QUESTION</td>
            <td width="450" height="25" colspan="2" class="admintd">&nbsp;<%=objRs("p_que")%> </td>
          </tr>
          <tr>
            <td>type</td>
            <td width="450" height="25" colspan="2" class="admintd">&nbsp;
              <% if objRs("flag") = "0" then
				Response.Write("일반")
			elseif objRs("flag") = "1" then
				Response.Write("회원")
			end if
			%>
            </td>
          </tr>
          <tr>
            <td>ANSWER
              QTY</td>
            <td width="450" height="25" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans_qty" value="<%=objRs("p_ans_qty")%>" size="55" readonly >
            </td>
          </tr>
          <tr id="answer1" style="display:none">
            <td width="150" align="center">ANSWER 1</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(0)" value="<%=objRs("p_ans1")%>" size="55" readonly ></td>
          </tr>
          <tr id="answer2" style="display:none">
            <td width="150" align="center">ANSWER 2</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(1)" value="<%=objRs("p_ans2")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer3" style="display:none">
            <td width="150" align="center">ANSWER 3</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(2)" value="<%=objRs("p_ans3")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer4" style="display:none">
            <td width="150" align="center">ANSWER 4</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(3)" value="<%=objRs("p_ans4")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer5" style="display:none">
            <td width="150" align="center">ANSWER 5</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(4)" value="<%=objRs("p_ans5")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer6" style="display:none">
            <td width="150" align="center">ANSWER 6<</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(5)" value="<%=objRs("p_ans6")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer7" style="display:none">
            <td width="150" align="center">ANSWER 7</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(6)" value="<%=objRs("p_ans7")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer8" style="display:none">
            <td width="150" align="center">ANSWER 8</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(7)" value="<%=objRs("p_ans8")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer9" style="display:none">
            <td width="150" align="center">ANSWER 9</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(8)" value="<%=objRs("p_ans9")%>" size="55"  readonly ></td>
          </tr>
          <tr id="answer10" style="display:none">
            <td width="150" align="center">ANSWER 10</td>
            <td width="450" colspan="2" class="admintd">&nbsp;
              <input type="text" name="p_ans(9)" value="<%=objRs("p_ans10")%>" size="55"  readonly ></td>
          </tr>
        </table>
      </form>
      <table class="table_main w_default">
        <tr>
          <td align="center">
            <input type="button" name="b1" value="수정" onClick="javascript:editit();">
            <input type="button" name="b3" value="목록" onClick="javascript:listit();">
            <input type="button" name="b4" value="결과" onClick="javascript:result();">
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
toggle('<%=objRs("p_ans_qty")%>');
//-->
</script>
