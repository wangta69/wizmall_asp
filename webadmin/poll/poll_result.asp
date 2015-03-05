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
Dim p_idx_no,menushow,theme
	
p_idx_no	= request("p_idx_no")
menushow	= request("menushow")
theme		= request("theme")
dim p_que,p_ans_qty,a(10),value(10),value_sum,Loopcnt,value_per,value_width


''현재설문조사중인 보기를 가져온다.....
strSQL = "select * from wizpoll where p_idx_no=" & p_idx_no
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	p_que 		= objRs("p_que")
	p_ans_qty	= objRs("p_ans_qty")
	a(0)  		= objRs("p_ans1")
	a(1) 		 = objRs("p_ans2")
	a(2)  		= objRs("p_ans3")
	a(3)  		= objRs("p_ans4")
	a(4)  		= objRs("p_ans5")
	a(5)  		= objRs("p_ans6")
	a(6)  		= objRs("p_ans7")
	a(7)  		= objRs("p_ans8")
	a(8)  		= objRs("p_ans9")
	a(9)  		= objRs("p_ans10")

''현재설문조사중인 결과치를 가져온다.....
strSQL = "select * from wizpoll_value where pv_p_no=" & p_idx_no 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
value_sum=0
if objRs.eof or objRs.bof then 
	
else
	value(0)  = int(objRs("pv_op_count1"))
	value(1)  = int(objRs("pv_op_count2"))
	value(2)  = int(objRs("pv_op_count3"))
	value(3)  = int(objRs("pv_op_count4"))
	value(4)  = int(objRs("pv_op_count5"))
	value(5)  = int(objRs("pv_op_count6"))
	value(6)  = int(objRs("pv_op_count7"))
	value(7)  = int(objRs("pv_op_count8"))
	value(8)  = int(objRs("pv_op_count9"))
	value(9)  = int(objRs("pv_op_count10"))

	for Loopcnt=0 to rs_p("p_ans_qty")-1 
		value_sum = value_sum + value(Loopcnt)	  
	next

end if       
%>

<table class="table_outline">
  <tr>
    <td>
	
	
<fieldset class="desc">
<legend>설문조사 결과보기</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>



      <table class="table_main w_default">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <%
' '지금의 투표기간은 현재 p_idx_no의 등록일 부터 이보다 큰 p_idx_no의 등록일 까지로 본다.
Dim min_no,p_regdate
strSQL		= "select min(p_idx_no) as min_no from wizpoll where p_idx_no > " & p_idx_no
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	min_no = objRs("min_no")
if min_no <> "" then
	strSQL = "select p_regdate from wizpoll where p_idx_no=" & min_no
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	p_regdate	= objRs("p_regdate")
	if objRs.eof or objRs.bof then p_regdate="" else p_regdate = left(p_regdate,10)
else 
	p_regdate = "continue"
end if 

%>
              <tr>
                <td width="100" height="25">&nbsp;투표기간 : </td>
                <td width="287" class="date"><%=left(objRs("p_regdate"),10)%> ~ <%=p_regdate%></td>
                <td width="70">참여자수 : </td>
                <td class="text"><%=value_sum%></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="30" class="txt1" style="padding-left:25px"><font color="#FF3300">Q. <%=p_que%></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <% if value_sum="0" then %>
              <% 
                 
                  for Loopcnt=0 to p_ans_qty-1 
                  
                  value_per   = 0
                  value_width = 0
                %>
              <tr>
                <td width="200" height="30" class="txt1"><%=a(Loopcnt)%></td>
                <td><img src="poll/images/bar.gif" width="<%=value_width%>" height="10"></td>
                <td width="100" align="right">0표 <font color="#FF3300">[<%=round(value_per,0)%>%]</td>
              </tr>
              <%    
                  
                  next 
                 
		%>
              <% else %>
              <% 
                 
                  for Loopcnt=0 to p_ans_qty-1 
                  
                  value_per   = int(value(i)*100/value_sum)
                  value_width = value_per*152/100
                %>
              <tr>
                <td width="200" height="30" class="txt1"><%=a(Loopcnt)%></td>
                <td><img src="poll/images/bar.gif" width="<%=value_width%>" height="10"></td>
                <td width="100" align="right"><%=value(Loopcnt)%>표<font color="#FF3300">[<%=round(value_per,0)%>%]</td>
              </tr>
              <%    
                  
                  next 
                 
		%>
              <% end if %>
            </table></td>
        </tr>
        <tr>
          <td height="65" align="center"><input type="button" name="b3" value="목 록" onClick="location.href='main.asp?theme=poll/poll_list&menushow=<%=menushow%>'"></td>
        </tr>
      </table>
      <br />
    </td>
  </tr>
</table>
