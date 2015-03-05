<% Option Explicit %>
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database

gubun = request("gubun")
seq = request("seq")
menushow = Request("menushow")
theme = Request("theme")
str = "입력"
startdate = ""
enddate = ""

if gubun = "edit" then
	str = "수정"
	strSQL = "select * from popup where seq="&seq
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	

	if not objRs.eof then
		title = objRs("title")
		startdate = objRs("startdate")
		enddate = objRs("enddate")
		wdate = objRs("wdate")
		memo = objRs("memo")
		htm = objRs("htm")
		isuse = objRs("isuse")
		strWid = objRs("strWid")
		strHeight = objRs("strHeight")
		intscroll = objRs("intscroll")
		intcookie = objRs("intcookie")

		if htm="1" then
			memo = replace(memo,"<br />",chr(13))
		end if

		year1 = left(startdate,4)
		month1 = mid(startdate,6,2)
		day1 = right(startdate,2)

		year2 = left(enddate,4)
		month2 = mid(enddate,6,2)
		day2 = right(enddate,2)
	end if
	
	objRs.close
	set objRs=nothing
end if
%>  

<script language="javascript">
function check(){
	if(af.strWid.value==''){
		alert("팝업 가로 사이즈를 입력하세요.");
		af.strWid.focus();
		return false;
	}
	if(af.strHeight.value==''){
		alert("팝업 세로 사이즈를 입력하세요.");
		af.strHeight.focus();
		return false;
	}
	//if(af.title.value==''){
	//	alert("제목을 입력하세요.");
	//	af.title.focus();
	//	return false;
	//}
	if(af.memo.value==''){
		alert("내용을 입력하세요.");
		af.memo.focus();
		return false;
	}
	else
	af.submit();
}

function settoday()
{	
	var Now = new Date();
	document.af.year1.value =Now.getYear();
	document.af.month1.value  = Now.getMonth()+1;
	document.af.day1.value = Now.getDate();
		
	document.af.year2.value = Now.getYear();
	document.af.month2.value  = Now.getMonth()+1;
	document.af.day2.value = Now.getDate();
		
}



function dayCalc(d2,flag){ 
	var year2 = document.af.year2.value;
	var month2 = document.af.month2.value;
	var day2 = document.af.day2.value;		
		
	if(gv_date_check(year2,month2,day2)==false)
	{
		alert("잘못된 형식의 날짜입니다.\n\n다시 한번 기입해주세요");
		return;
	}

	var date1 = new Date(year2,month2,day2)

	var newdate = new Date();
        var newtime = date1.getTime() - (d2*24*60*60*1000); 
	newdate.setTime(newtime); 
		
		

	if(newdate.getMonth() <=0)
	{
		document.af.month1.value = newdate.getMonth()+12;
		document.af.year1.value= newdate.getFullYear()-1;
	}
	else
	{

		document.af.year1.value=newdate.getFullYear() ;
		document.af.month1.value=newdate.getMonth();
	}

	document.af.day1.value=newdate.getDate() ;

	var year1 = document.af.year1.value;
	var month1 = document.af.month1.value;
	var day1 = document.af.day1.value;
	
	if(flag=="m")
	{				
		day1 = parseInt(day2) + 1;		
		document.af.day1.value = day1;
	}
	
	while(gv_date_check(year1,month1,day1)==false && day1>1)
	{
		day1 = day1 - 1;
		document.af.day1.value = day1;
	}	
}

function calc(gap,flag)
{            
	dayCalc(gap,flag);
}

function gn_ArrayOfDay(l_sLeapYear)
{
   	this[0]=0;  // <- 아무런 의미가 없는 것임. 무시해도 좋음.
   	this[1]=31;
   	this[2]=28;
   	
   	if (l_sLeapYear) // 윤달이 아니면...
       		this[2]=29;
   	this[3]=31;
   	this[4]=30;
   	this[5]=31;
   	this[6]=30;
   	this[7]=31;
   	this[8]=31;
   	this[9]=30;
   	this[10]=31;
   	this[11]=30;
   	this[12]=31;
}

function gv_date_check(l_iYear,l_iMonth,l_iDay)
{                   
   	var l_sLeapYear = (((l_iYear%4 == 0) && (l_iYear%100 != 0)) || (l_iYear%400 == 0));
   	var monthDays  = new gn_ArrayOfDay(l_sLeapYear);
	
   	if (l_iYear < 1900)
   	{
     		return false;
   	}
   	else if (l_iMonth > 12) // 달수가 12월 보다 크면...
   	{            
      		return false;
   	}
   	else if((parseInt(l_iDay) < 1) || (l_iDay > monthDays[l_iMonth])) // 그 달의 마지막 날 보다 크다면...
   	{  
      		return false;
   	}
   
   	return true;
}

function sendit()
{
	var form = document.af;
	form.submit();
}

function isNumber(obj) {
    if (isNaN(obj.value)) {
        alert("숫자만 입력할 수 있습니다.");
        obj.focus();
        obj.value="";
    }
}

function del_seq(seq)
{
	if(confirm("데이터를 삭제하시겠습니까?"))
	{
		location.href="./popup/write_ok.asp?gubun=del&menushow=<%=menushow%>&seq="+seq
	}
}

</script> 
<br />

<fieldset class="desc">
<legend>팝업관리</legend>
<div class="notice">[note]</div>
<div class="comment">순서가 작을 수록 상단에 위치 합니다. </div>
</fieldset>
<div class="space20"></div>



<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<form name="af" method="post" action="popup/write_ok.asp" onsubmit="return check();">  <!--enctype="multipart/form-data"-->
<input type="hidden" name="gubun" value="<%=gubun%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="theme" value="<%=theme%>">
<input type="hidden" name="menushow" value="<%=menushow%>">
  <tr>
    <td><table width="920" border="0" cellspacing="0" cellpadding="0">        
        <tr> 
          <td align="left" valign="top"><table width="708" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="5"></td>
              </tr>
              <tr> 
                <td height="650" align="left" valign="top">
					<table width="592" border="0" cellspacing="2" cellpadding="0" >
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">사이즈</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp;<input type="text" size="3" name="strWid" maxlength="3" value="<%=strWid%>">
                          * 
                          <input type="text" size="3" name="strHeight" maxlength="3" value="<%=strHeight%>">
                          [단위 pixel]</td>
                      </tr>
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">기간설정</td>
                        <td width="485" height="30" bgcolor="F5F5F5"> <div align="left">&nbsp;&nbsp;&nbsp; 
                            <select name="year1">
                              <option value=2003 <%if year1 = "2003" then%>selected<%end if%>>2003</option>
                              <option value=2004 <%if year1 = "2004" then%>selected<%end if%>>2004</option>
                              <option value=2005 <%if year1 = "2005" then%>selected<%end if%>>2005</option>
                              <option value=2006 <%if year1 = "2006" then%>selected<%end if%>>2006</option>
                              <option value=2007 <%if year1 = "2007" then%>selected<%end if%>>2007</option>
                              <option value=2008 <%if year1 = "2008" then%>selected<%end if%>>2008</option>
                              <option value=2009 <%if year1 = "2009" then%>selected<%end if%>>2009</option>
                              <option value=2010 <%if year1 = "2010" then%>selected<%end if%>>2010</option>
                              <option value=2011 <%if year1 = "2011" then%>selected<%end if%>>2011</option>
                              <option value=2012 <%if year1 = "2012" then%>selected<%end if%>>2012</option>
                              <option value=2013 <%if year1 = "2013" then%>selected<%end if%>>2013</option>
                              <option value=2014 <%if year1 = "2014" then%>selected<%end if%>>2014</option>
                              <option value=2015 <%if year1 = "2015" then%>selected<%end if%>>2015</option>
                            </select>
                            년 
                            <select name="month1">
                              <option value=01 <%if month1 = "01" then%>selected<%end if%>>1</option>
                              <option value=02 <%if month1 = "02" then%>selected<%end if%>>2</option>
                              <option value=03 <%if month1 = "03" then%>selected<%end if%>>3</option>
                              <option value=04 <%if month1 = "04" then%>selected<%end if%>>4</option>
                              <option value=05 <%if month1 = "05" then%>selected<%end if%>>5</option>
                              <option value=06 <%if month1 = "06" then%>selected<%end if%>>6</option>
                              <option value=07 <%if month1 = "07" then%>selected<%end if%>>7</option>
                              <option value=08 <%if month1 = "08" then%>selected<%end if%>>8</option>
                              <option value=09 <%if month1 = "09" then%>selected<%end if%>>9</option>
                              <option value=10 <%if month1 = "10" then%>selected<%end if%>>10</option>
                              <option value=11 <%if month1 = "11" then%>selected<%end if%>>11</option>
                              <option value=12 <%if month1 = "12" then%>selected<%end if%>>12</option>
                            </select>
                            월 
                            <select name="day1">
                              <option value=01 <%if day1 = "01" then%>selected<%end if%>>1</option>
                              <option value=02 <%if day1 = "02" then%>selected<%end if%>>2</option>
                              <option value=03 <%if day1 = "03" then%>selected<%end if%>>3</option>
                              <option value=04 <%if day1 = "04" then%>selected<%end if%>>4</option>
                              <option value=05 <%if day1 = "05" then%>selected<%end if%>>5</option>
                              <option value=06 <%if day1 = "06" then%>selected<%end if%>>6</option>
                              <option value=07 <%if day1 = "07" then%>selected<%end if%>>7</option>
                              <option value=08 <%if day1 = "08" then%>selected<%end if%>>8</option>
                              <option value=09 <%if day1 = "09" then%>selected<%end if%>>9</option>
                              <option value=10 <%if day1 = "10" then%>selected<%end if%>>10</option>
                              <option value=11 <%if day1 = "11" then%>selected<%end if%>>11</option>
                              <option value=12 <%if day1 = "12" then%>selected<%end if%>>12</option>
                              <option value=13 <%if day1 = "13" then%>selected<%end if%>>13</option>
                              <option value=14 <%if day1 = "14" then%>selected<%end if%>>14</option>
                              <option value=15 <%if day1 = "15" then%>selected<%end if%>>15</option>
                              <option value=16 <%if day1 = "16" then%>selected<%end if%>>16</option>
                              <option value=17 <%if day1 = "17" then%>selected<%end if%>>17</option>
                              <option value=18 <%if day1 = "18" then%>selected<%end if%>>18</option>
                              <option value=19 <%if day1 = "19" then%>selected<%end if%>>19</option>
                              <option value=20 <%if day1 = "20" then%>selected<%end if%>>20</option>
                              <option value=21 <%if day1 = "21" then%>selected<%end if%>>21</option>
                              <option value=22 <%if day1 = "22" then%>selected<%end if%>>22</option>
                              <option value=23 <%if day1 = "23" then%>selected<%end if%>>23</option>
                              <option value=24 <%if day1 = "24" then%>selected<%end if%>>24</option>
                              <option value=25 <%if day1 = "25" then%>selected<%end if%>>25</option>
                              <option value=26 <%if day1 = "26" then%>selected<%end if%>>26</option>
                              <option value=27 <%if day1 = "27" then%>selected<%end if%>>27</option>
                              <option value=28 <%if day1 = "28" then%>selected<%end if%>>28</option>
                              <option value=29 <%if day1 = "29" then%>selected<%end if%>>29</option>
                              <option value=30 <%if day1 = "30" then%>selected<%end if%>>30</option>
                              <option value=31 <%if day1 = "31" then%>selected<%end if%>>31</option>
                            </select>
                            일 ~ 
                            <select name="year2">
                              <option value=2003 <%if year2 = "2003" then%>selected<%end if%>>2003</option>
                              <option value=2004 <%if year2 = "2004" then%>selected<%end if%>>2004</option>
                              <option value=2005 <%if year2 = "2005" then%>selected<%end if%>>2005</option>
                              <option value=2006 <%if year2 = "2006" then%>selected<%end if%>>2006</option>
                              <option value=2007 <%if year2 = "2007" then%>selected<%end if%>>2007</option>
                              <option value=2008 <%if year2 = "2008" then%>selected<%end if%>>2008</option>
                              <option value=2009 <%if year2 = "2009" then%>selected<%end if%>>2009</option>
                              <option value=2010 <%if year2 = "2010" then%>selected<%end if%>>2010</option>
                              <option value=2011 <%if year2 = "2011" then%>selected<%end if%>>2011</option>
                              <option value=2012 <%if year2 = "2012" then%>selected<%end if%>>2012</option>
                              <option value=2013 <%if year2 = "2013" then%>selected<%end if%>>2013</option>
                              <option value=2014 <%if year2 = "2014" then%>selected<%end if%>>2014</option>
                              <option value=2015 <%if year2 = "2015" then%>selected<%end if%>>2015</option>
                            </select>
                            년 
                            <select name="month2">
                              <option value=01 <%if month2 = "01" then%>selected<%end if%>>1</option>
                              <option value=02 <%if month2 = "02" then%>selected<%end if%>>2</option>
                              <option value=03 <%if month2 = "03" then%>selected<%end if%>>3</option>
                              <option value=04 <%if month2 = "04" then%>selected<%end if%>>4</option>
                              <option value=05 <%if month2 = "05" then%>selected<%end if%>>5</option>
                              <option value=06 <%if month2 = "06" then%>selected<%end if%>>6</option>
                              <option value=07 <%if month2 = "07" then%>selected<%end if%>>7</option>
                              <option value=08 <%if month2 = "08" then%>selected<%end if%>>8</option>
                              <option value=09 <%if month2 = "09" then%>selected<%end if%>>9</option>
                              <option value=10 <%if month2 = "10" then%>selected<%end if%>>10</option>
                              <option value=11 <%if month2 = "11" then%>selected<%end if%>>11</option>
                              <option value=12 <%if month2 = "12" then%>selected<%end if%>>12</option>
                            </select>
                            월 
                            <select name="day2">
                              <option value=01 <%if day2 = "01" then%>selected<%end if%>>1</option>
                              <option value=02 <%if day2 = "02" then%>selected<%end if%>>2</option>
                              <option value=03 <%if day2 = "03" then%>selected<%end if%>>3</option>
                              <option value=04 <%if day2 = "04" then%>selected<%end if%>>4</option>
                              <option value=05 <%if day2 = "05" then%>selected<%end if%>>5</option>
                              <option value=06 <%if day2 = "06" then%>selected<%end if%>>6</option>
                              <option value=07 <%if day2 = "07" then%>selected<%end if%>>7</option>
                              <option value=08 <%if day2 = "08" then%>selected<%end if%>>8</option>
                              <option value=09 <%if day2 = "09" then%>selected<%end if%>>9</option>
                              <option value=10 <%if day2 = "10" then%>selected<%end if%>>10</option>
                              <option value=11 <%if day2 = "11" then%>selected<%end if%>>11</option>
                              <option value=12 <%if day2 = "12" then%>selected<%end if%>>12</option>
                              <option value=13 <%if day2 = "13" then%>selected<%end if%>>13</option>
                              <option value=14 <%if day2 = "14" then%>selected<%end if%>>14</option>
                              <option value=15 <%if day2 = "15" then%>selected<%end if%>>15</option>
                              <option value=16 <%if day2 = "16" then%>selected<%end if%>>16</option>
                              <option value=17 <%if day2 = "17" then%>selected<%end if%>>17</option>
                              <option value=18 <%if day2 = "18" then%>selected<%end if%>>18</option>
                              <option value=19 <%if day2 = "19" then%>selected<%end if%>>19</option>
                              <option value=20 <%if day2 = "20" then%>selected<%end if%>>20</option>
                              <option value=21 <%if day2 = "21" then%>selected<%end if%>>21</option>
                              <option value=22 <%if day2 = "22" then%>selected<%end if%>>22</option>
                              <option value=23 <%if day2 = "23" then%>selected<%end if%>>23</option>
                              <option value=24 <%if day2 = "24" then%>selected<%end if%>>24</option>
                              <option value=25 <%if day2 = "25" then%>selected<%end if%>>25</option>
                              <option value=26 <%if day2 = "26" then%>selected<%end if%>>26</option>
                              <option value=27 <%if day2 = "27" then%>selected<%end if%>>27</option>
                              <option value=28 <%if day2 = "28" then%>selected<%end if%>>28</option>
                              <option value=29 <%if day2 = "29" then%>selected<%end if%>>29</option>
                              <option value=30 <%if day2 = "30" then%>selected<%end if%>>30</option>
                              <option value=31 <%if day2 = "31" then%>selected<%end if%>>31</option>
                            </select>
                          </div></td>
                      </tr>
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">사용여부</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp; <input type="radio" name="isuse" value="0" <%if isuse="0" or isuse="" then%>checked<%end if%>>
                          사용함 
                          <input type="radio" name="isuse" value="1" <%if isuse="1" then%>checked<%end if%>>
                          사용안함</td>
                      </tr>
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">스크롤생성</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp; 
                          <input type="radio" name="intscroll" value="1" <%if intscroll="1" then%>checked<%end if%>>
                          Y 
                          <input type="radio" name="intscroll" value="0" <%if intscroll="0" or intscroll="" then%>checked<%end if%>>
                          N </td>
                      </tr>
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">쿠키생성</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp; 
                          <input type="radio" name="intcookie" value="1" <%if intcookie="1" then%>checked<%end if%>>
                          Y 
                          <input type="radio" name="intcookie" value="0" <%if intcookie="0" or intcookie="" then%>checked<%end if%>>
                          N (하루동안 안띄우기 메시지 표시)</td>
                      </tr>					  					  
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">제목</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp; <input type="text" size="60" name="title" maxlength="60" value="<%=title%>"> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">내용</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp; <textarea cols="60" rows="17" name="memo" wrap="VIRTUAL"><%=memo%></textarea> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="101" height="30" align="center" bgcolor="E3EFF7">형식</td>
                        <td width="485" height="30" bgcolor="F5F5F5">&nbsp;&nbsp;&nbsp; <input type="radio" name="htm" value="0" <%if htm="0" or htm="" then%>checked<%end if%>>
                          text 
                          <input type="radio" name="htm" value="1" <%if htm="1" then%>checked<%end if%>>
                          html </td>
                      </tr>
                      <tr> 
                        <td width="101" align="center" height="30">&nbsp;</td>
                        <td width="485" height="40" align="center">
						
							<table width="485" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td align="right" width="200"><button name="" onClick="check();" title="<%=str%>"><%=str%></button></td>
									<td width="20"></td>
<%if gubun="edit" then%>									<td width="70"><button name="" onClick="del_seq('<%=seq%>');" title="삭제">삭제</button></td>
<%end if%>			<td width="200"><button name="" onClick="history.back();" title="취소">취소</button></td>
								</tr>
							</table>
							<!--
						 <input type="submit" value="<%=str%>" name="submit"> 
                          <%if gubun="edit" then%>
                          <input type="button" value="삭제" name="del" onclick="javascript:del_seq('<%=seq%>');"> 
                          <%end if%>
                          <input type="button" onclick="javascript:history.back();" value="취소"> 
						  //-->
                        </td>
                      </tr>
                    </table>
				  </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</form>
</table>
<%if startdate="" or enddate="" then%>
<Script language="JavaScript">
<!--
settoday();
//-->
</script>
<%end if%>
