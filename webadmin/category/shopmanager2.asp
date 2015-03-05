<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->
<%
Dim orderby,whereis,cat_len,limit_cat_len,cnt


Dim menushow,theme,category
Dim strSQL,objRs
Dim db,util,mall
Set util	= new utility	
Set db		= new database
Set mall	= new malls

menushow	= Request("menushow")
theme		= Request("theme")
category	= Request("category")
%>
<script language='JavaScript'>
<!--

function move_all( obj, smode )
{
        f_index = 0
        e_index = obj.length - 1
        select_index = obj.selectedIndex

        // 아래로 이동
        if( smode == "down" )
        {
                if( select_index < e_index )
                {
			target_index = obj.length-1

			select_obj = obj[select_index]
			dest_obj = obj[obj.length-1]

                        temp_value = select_obj.value
                        temp_text = select_obj.text

			for ( t=select_index; t < e_index ;t++)
			{
				obj[t].value = obj[t+1].value
				obj[t].text = obj[t+1].text
			}

			dest_obj.value = temp_value
			dest_obj.text = temp_text
                }
        }
        // 위로 이동
        else
        {
                if( select_index > f_index )
                {
			target_index = 0 

                        select_obj = obj[select_index]
                        dest_obj = obj[0]

                        temp_value = select_obj.value
                        temp_text = select_obj.text

			for ( t=select_index; t > f_index ;t--)
			{
				obj[t].value = obj[t-1].value
				obj[t].text = obj[t-1].text
			}
			dest_obj.value = temp_value
			dest_obj.text = temp_text
                }
        }
        dest_obj.selected = true

	for (i=0 ;i <= obj.length-1 ;i++)
	{
		display_box=obj[i]
		display_order = frm["display_order"][i]
		display_order.value=display_box.value
	}

} // end of move_all()

function move_one( obj, smode )
{
        f_index = 0
        e_index = obj.length - 1
        select_index = obj.selectedIndex

        // 아래로 이동
        if( smode == "down" )
        {
                if( select_index < e_index )
                {
			select_obj = obj[select_index]
			dest_obj = obj[select_index+1]
                        temp_value = select_obj.value
                        temp_text = select_obj.text

                        select_obj.value = dest_obj.value
                        select_obj.text = dest_obj.text
                        dest_obj.value = temp_value
                        dest_obj.text = temp_text

        		dest_obj.selected = true
                }
        }
        // 위로 이동
        else
        {
                if( select_index > f_index )
                {
                        select_obj = obj[select_index]
                        dest_obj = obj[select_index-1]
                        temp_value = select_obj.value
                        temp_text = select_obj.text

                        select_obj.value = dest_obj.value
                        select_obj.text = dest_obj.text
                        dest_obj.value = temp_value
                        dest_obj.text = temp_text

        		dest_obj.selected = true
                }
        }

	for (i=0 ;i <= obj.length-1 ;i++)
	{
		display_box=obj[i]
		display_order=frm["display_order"][i]
		display_order.value=display_box.value
	}

} // end of move_one()

function move_directs( obj, idx )
{
        f_index = 0
        e_index = obj.length - 1

        select_index = obj.selectedIndex
	target_index = idx - 1

	if( ( target_index < f_index ) || ( target_index > e_index ) )
	{
		alert("입력하신 값이 범위를 벗어납니다.");
		return false ;
	}

	if ( target_index == select_index )
	{
		alert("입력하신 값과 선택한 항목이 동일합니다.");
		return false ;
	}

	if ( select_index > target_index ) 
	{
		select_obj = obj[select_index]
		dest_obj = obj[target_index]

		temp_value = select_obj.value
		temp_text = select_obj.text

		for ( t=select_index; t > target_index ;t--)
		{
			obj[t].value = obj[t-1].value
			obj[t].text = obj[t-1].text
		}
		dest_obj.value = temp_value
		dest_obj.text = temp_text
        }
        // 위로 이동
        else
        {
		select_obj = obj[select_index]
		dest_obj = obj[target_index]

		temp_value = select_obj.value
		temp_text = select_obj.text

		for ( t=select_index; t < target_index ;t++)
		{
			obj[t].value = obj[t+1].value
			obj[t].text = obj[t+1].text
		}
		dest_obj.value = temp_value
		dest_obj.text = temp_text
        }
        dest_obj.selected = true

	for (i=0 ;i <= obj.length-1 ;i++)
	{
		display_box=obj[i]
		display_order=frm["display_order"][i]
		display_order.value=display_box.value
	}

} // end of move_direct()

function move_first()
{
	selected_idx = document.frm.product_list.selectedIndex  ;

	if ( selected_idx == "-1" )
	{
		alert( "목록이 선택되지 않았습니다." ) ;
		return false ; 
	}	

	move_all( frm.product_list, 'up' ) ;
}

function move_last()
{
	selected_idx = document.frm.product_list.selectedIndex  ;

	if ( selected_idx == "-1" )
	{
		alert( "목록이 선택되지 않았습니다." ) ;
		return false ; 
	}	

	move_all( frm.product_list, 'down' ) ;
}

function move_prev()
{	
	selected_idx = document.frm.product_list.selectedIndex  ;

	if ( selected_idx == "-1" )
	{
		alert( "목록이 선택되지 않았습니다." ) ;
		return false ; 
	}	

	ret = move_one( frm.product_list, 'up' ) ;

	if ( ret == false )
		return false ;
}

function move_next()
{	
	selected_idx = document.frm.product_list.selectedIndex  ;

	if ( selected_idx == "-1" )
	{
		alert( "목록이 선택되지 않았습니다." ) ;
		return false ; 
	}	

	ret = move_one( frm.product_list, 'down' ) ;

	if ( ret == false )
		return false ;
}

function move_direct()
{
	if ( document.frm.direct_idx.value == "" )
	{
		alert("값이 입력되지 않았습니다.");
		document.frm.direct_idx.focus();
		return false; 
	}

	selected_idx = document.frm.product_list.selectedIndex  ;

	if ( selected_idx == "-1" )
	{
		alert( "목록이 선택되지 않았습니다." ) ;
		return false ; 
	}	

	direct_idx = document.frm.direct_idx.value ;

	ret = move_directs( frm.product_list, direct_idx ) ;

	if ( ret == false )
		return false ;

	document.frm.direct_idx.value = "" ;
}

function form_submit()
{
	document.frm.action = "product_display_order_a.php" ;
	document.frm.submit();
}

function order_reload()
{
	document.frm.action = "product_display_order_f.php" ;
	document.frm.submit();
}

function SortbyCat(cat){
	var f = eval("document."+cat.form.name);
	f.category.value = cat.value;
	f.submit();
}
//-->
</script>
<table class="table_outline">
  <tr>
    <td>
	
	
<fieldset class="desc">
        <legend>카테고리 순서변경</legend>
        <div class="notice">[note]</div>
        <div class="comment">카테고리의 순서를 변경합니다.</div>
      </fieldset>
      <p></p>


<table class="table_blank">
                    <form action='./main.asp' method="post" name="SortForm">
                      <input type="hidden" name= menushow value=<%=menushow%>>
                      <input type="hidden" name="theme" value=<%=theme%>>
                      <input type="hidden" name="category" value="<%=category%>">

                        <tr><td><select onChange="SortbyCat(this)">
                            <option value="">대분류</option>
                            <option value="">-----------</option>
                            <% Call mall.getSelectCategory(1, category) %>
                          </select>
                        </td>
                                              <td> 
                          <select  onChange="SortbyCat(this)">
                            <option value="">중분류</option>
                            <option value="">-----------</option>
<% Call mall.getSelectCategory(2, category) %>                            
                          </select></td>
                                                <td><select  onChange="SortbyCat(this)">
                            <option value="">소분류</option>
                            <option value="">-----------</option>
<% 
Call mall.getSelectCategory(3, category) 
Set mall = Nothing
%>                          
                          </select></td>
                        <td>&nbsp;</td>
                      </tr>                      
                    </form>
                  </table>
<table class="table_title">
  <form  action='./category/shopmanager2_qry.asp' method='post' name="frm">
    <input type=hidden name='query' value='up'>
    <input type="hidden" name='menushow' value='<%=menushow%>'>
    <input type="hidden" name='theme' value='<%=theme%>'>
    <input type="hidden" name="category" value="<%=category%>">
                  <tr>
                    <td width="92%"><select name="product_list" size="15" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #D0D0D0 1 solid; font-family:돋움; font-size:12px; color:#5E5E5E; HEIGHT: 300px; width: 100%">
<%
orderby = " order by cat_order asc"
if category = "" then 
	whereis = " where len(cat_no) = 3 and cat_flag = 'wizmall' "
else 
	cat_len = len(category)
	limit_cat_len = cat_len+3
	whereis = " where len(cat_no) = "&limit_cat_len&" and RIGHT(cat_no, "&cat_len&") =  '"&category&"' and cat_flag='wizmall' "
end if

strSQL = "SELECT uid, cat_name FROM wizcategory " & whereis & orderby
Response.Write(strSQL)
cnt = 1
Set db = new database
Dim uid,cat_name
SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
	uid			= objRs("uid")
	cat_name	= objRs("cat_name")
	Response.Write( "<option value='" & uid & "'>" & cnt & " [" & cat_name & "] </option>"&Chr(13)&Chr(10))  
cnt = cnt+1
objRs.MOVENEXT
WEND
%>
                    </select></td>
                    <td width="8%"><table width="100%" border="0" cellspacing="5" cellpadding="0">
                        <tr>
                          <td><div align="center"><img src="./img/arrow_02.gif" width="19" height="19" alt="가장위로" style="cursor:pointer;" onClick="move_first();"></div></td>
                        </tr>
                        <tr>
                          <td><div align="center"><img src="./img/arrow_01.gif" width="19" height="19" alt="한칸위로" style="cursor:pointer;" onClick="move_prev();"></div></td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <input type="text" name="direct_idx" size="3">
                            </div></td>
                        </tr>
                        <tr>
                          <td><div align="center"><img src="./img/but_move.gif" width="32" height="21" alt="직접이동" style="cursor:pointer;" onClick="move_direct();"></div></td>
                        </tr>
                        <tr>
                          <td><div align="center"><img src="./img/arrow_03.gif" width="19" height="19" alt="한칸아래로" style="cursor:pointer;" onClick="move_next();"></div></td>
                        </tr>
                        <tr>
                          <td><div align="center"><img src="./img/arrow_04.gif" width="19" height="19" alt="가장아래로" style="cursor:pointer;" onClick="move_last();"></div></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center"><input type="image" src="img/sul.gif" width="68" height="20"></td>
          </tr>
<%
strSQL = "SELECT uid FROM wizcategory " & whereis & orderby
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
WHILE NOT objRs.EOF
	uid			= objRs("uid")
	Response.Write( "<input type='hidden' name='display_order' value='" & uid & "'>"&Chr(13)&Chr(10))  
cnt = cnt+1
objRs.MOVENEXT
WEND
%>
  </form>						
                </table>
      </td>
  </tr>
</table>
