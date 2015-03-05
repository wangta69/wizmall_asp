<%
Set db = new database
''strSQL = strSQL & "USE [winkzone]" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf

''strSQL = "if exists (select * from dbo.sysobjects where id = object_id(N'" & Db_Owner & "[getPointList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbcrlf
''strSQL = strSQL & " drop table " & Db_Owner & "[getPointList]" & vbcrlf
''Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('getPointList') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC getPointList" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "	SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "	GO" & vbcrlf
''strSQL = strSQL & "	SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "	GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	포인트 리스트 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	CREATE  Proc " & Db_Owner & "[getPointList]" & vbcrlf
strSQL = strSQL & "		@PageNo           int" & vbcrlf
strSQL = strSQL & "		,@PageSize        int" & vbcrlf
strSQL = strSQL & "		,@SelectList   nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		,@PKField   nvarchar(100)" & vbcrlf
strSQL = strSQL & "		,@FilterString    nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		,@SortString           nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		As" & vbcrlf
strSQL = strSQL & "		Begin" & vbcrlf
strSQL = strSQL & "		Set nocount on" & vbcrlf
strSQL = strSQL & "		set transaction isolation level read uncommitted" & vbcrlf
strSQL = strSQL & "		Set ansi_warnings off" & vbcrlf
strSQL = strSQL & "		 Declare    @top    int" & vbcrlf
strSQL = strSQL & "		,@sql             nvarchar(2000)" & vbcrlf
strSQL = strSQL & "		,@AFilterStrings nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		,@BFilterStrings nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		,@owner nvarchar(10)" & vbcrlf
strSQL = strSQL & "		IF @FilterString = '' or @FilterString = null " & vbcrlf
strSQL = strSQL & "		Begin" & vbcrlf
strSQL = strSQL & "		Set @AFilterStrings = ''" & vbcrlf
strSQL = strSQL & "		Set @BFilterStrings = ''" & vbcrlf
strSQL = strSQL & "		End" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "		Begin" & vbcrlf
strSQL = strSQL & "		Set @AFilterStrings = 'Where ' + @FilterString" & vbcrlf
strSQL = strSQL & "		Set @BFilterStrings = 'And ' + @FilterString" & vbcrlf
strSQL = strSQL & "		End" & vbcrlf
strSQL = strSQL & "		Set @sql = N'Select Top ' + Cast(@PageSize as nvarchar) + ' ' + @SelectList" & vbcrlf
strSQL = strSQL & "		+    N' From wizpoint  '" & vbcrlf
strSQL = strSQL & "		+    N' Where ' + @PKField + ' Not In '" & vbcrlf
strSQL = strSQL & "		+    N'  (Select Top ' + Cast(@PageSize * (@PageNo-1)  As nvarchar)+ ' ' + @PKField + ' ' " & vbcrlf
strSQL = strSQL & "		+    N' From wizpoint'" & vbcrlf
strSQL = strSQL & "		+    N'   ' + @AFilterStrings + ' Order By ' + @SortString + ')'" & vbcrlf
strSQL = strSQL & "		+    @BFilterStrings + N' Order By ' + @SortString" & vbcrlf
strSQL = strSQL & "		Exec Sp_ExecuteSQL @sql" & vbcrlf
strSQL = strSQL & "		Set nocount off" & vbcrlf
strSQL = strSQL & "		Return " & vbcrlf
strSQL = strSQL & "		End" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('getLogininfo') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC getLogininfo" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	로그인 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	CREATE  Proc " & Db_Owner & "[getLogininfo]" & vbcrlf
strSQL = strSQL & "		@member varchar(10)," & vbcrlf
strSQL = strSQL & "		@id varchar(30)," & vbcrlf
strSQL = strSQL & "		@pwd varchar(30)," & vbcrlf
strSQL = strSQL & "		@return_out int OUTPUT" & vbcrlf
strSQL = strSQL & "	As" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	DECLARE" & vbcrlf
strSQL = strSQL & "		@r_mpwd varchar(30)," & vbcrlf
strSQL = strSQL & "		@r_mgrantsta varchar(2)" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "		if (@member = 'root') -- 관리자 로그인시" & vbcrlf
strSQL = strSQL & "			BEGIN" & vbcrlf
strSQL = strSQL & "				SELECT adminid as mid, adminpwd as mpwd, adminname as manme " & vbcrlf
strSQL = strSQL & "				FROM wiztable_main " & vbcrlf
strSQL = strSQL & "				WHERE AdminID = @id" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				SELECT @r_mpwd = adminpwd " & vbcrlf
strSQL = strSQL & "				FROM wiztable_main " & vbcrlf
strSQL = strSQL & "				WHERE AdminID = @id" & vbcrlf
strSQL = strSQL & "				Set @r_mgrantsta = '03'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				Set @r_mgrantsta = '03'" & vbcrlf
strSQL = strSQL & "				SET @return_out = 1 -- 로긴 카운트 올리지 않음" & vbcrlf
strSQL = strSQL & "			END" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			BEGIN" & vbcrlf
strSQL = strSQL & "				Select mid,mpwd, mname, mgrade, mgrantsta, mpoint " & vbcrlf
strSQL = strSQL & "				from wizmembers " & vbcrlf
strSQL = strSQL & "				where mid=@id" & vbcrlf
strSQL = strSQL & "				--SELECT @return_out = @@rowcount" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				select @r_mpwd=mpwd, @r_mgrantsta = mgrantsta from wizmembers where mid=@id" & vbcrlf
strSQL = strSQL & "			End" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			if (@r_mpwd is null ) -- id자체가 틀린경우" & vbcrlf
strSQL = strSQL & "				SET @return_out = 1" & vbcrlf
strSQL = strSQL & "			else if(@r_mpwd != @pwd) -- 패스워드가 다른 경우" & vbcrlf
strSQL = strSQL & "				SET @return_out = 2 " & vbcrlf
strSQL = strSQL & "			else if(@r_mgrantsta != '03')" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					if(@r_mgrantsta = '00')" & vbcrlf
strSQL = strSQL & "						SET @return_out = 3 -- 탈퇴처리" & vbcrlf
strSQL = strSQL & "					else if(@r_mgrantsta = '04')" & vbcrlf
strSQL = strSQL & "						SET @return_out = 4 -- 보류처리" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "			else " & vbcrlf
strSQL = strSQL & "				SET @return_out = 0 --정상처리" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			if (@return_out = 0 and @member != 'root') --로그인 카운트 올리기" & vbcrlf
strSQL = strSQL & "			update wizmembers " & vbcrlf
strSQL = strSQL & "			set mloginnum = mloginnum + 1, mlogindate = getdate()" & vbcrlf
strSQL = strSQL & "			where mid=@id" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)



strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('getOderList') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC getOderList" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	주문리스트 관련 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	CREATE  Proc " & Db_Owner & "[getOderList]" & vbcrlf
strSQL = strSQL & "		@PageNo           int" & vbcrlf
strSQL = strSQL & "		,@PageSize        int" & vbcrlf
strSQL = strSQL & "		,@SelectList   nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		,@PKField   nvarchar(100)" & vbcrlf
strSQL = strSQL & "		,@FilterString    nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		,@SortString           nvarchar(1000)" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		As" & vbcrlf
strSQL = strSQL & "		Begin" & vbcrlf
strSQL = strSQL & "		 Set nocount on" & vbcrlf
strSQL = strSQL & "		 set transaction isolation level read uncommitted" & vbcrlf
strSQL = strSQL & "		 Set ansi_warnings off" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		 Declare    @top    int" & vbcrlf
strSQL = strSQL & "		 ,@sql             nvarchar(2000)" & vbcrlf
strSQL = strSQL & "		 ,@AFilterStrings nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		 ,@BFilterStrings nvarchar(1000)" & vbcrlf
strSQL = strSQL & "		  ,@owner nvarchar(10)" & vbcrlf
strSQL = strSQL & "		 IF @FilterString = '' or @FilterString = null " & vbcrlf
strSQL = strSQL & "		  Begin" & vbcrlf
strSQL = strSQL & "		   Set @AFilterStrings = ''" & vbcrlf
strSQL = strSQL & "		   Set @BFilterStrings = ''" & vbcrlf
strSQL = strSQL & "		  End" & vbcrlf
strSQL = strSQL & "		 Else" & vbcrlf
strSQL = strSQL & "		  Begin" & vbcrlf
strSQL = strSQL & "		   Set @AFilterStrings = 'Where ' + @FilterString" & vbcrlf
strSQL = strSQL & "		   Set @BFilterStrings = 'And ' + @FilterString" & vbcrlf
strSQL = strSQL & "		  End" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		 Set @sql = N'Select Top ' + Cast(@PageSize as nvarchar) + ' ' + @SelectList" & vbcrlf
strSQL = strSQL & "		  +    N' , (select count(*) from wizcart c1 where b.codevalue = c1.oid) as totalcount '" & vbcrlf
strSQL = strSQL & "		  +    N' , (select top 1 c1.pid from wizcart c1 where b.codevalue = c1.oid) as pid '" & vbcrlf
strSQL = strSQL & "		  +    N' , (select top 1 m.pname  from wizcart c1 left join wizmall m on c1.pid = m.uid where b.codevalue = c1.oid) as pname '" & vbcrlf
strSQL = strSQL & "		  +    N' From wizbuyer b '" & vbcrlf
strSQL = strSQL & "		  +    N' Where ' + @PKField + ' Not In '" & vbcrlf
strSQL = strSQL & "		  +    N'  (Select Top ' + Cast(@PageSize * (@PageNo-1)  As nvarchar)+ ' ' + @PKField + ' ' " & vbcrlf
strSQL = strSQL & "		  +    N' From wizbuyer b'" & vbcrlf
strSQL = strSQL & "		  +    N'   ' + @AFilterStrings + ' Order By ' + @SortString + ')'" & vbcrlf
strSQL = strSQL & "		  +    @BFilterStrings + N' Order By ' + @SortString" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		Exec Sp_ExecuteSQL @sql" & vbcrlf
strSQL = strSQL & "		Set nocount off" & vbcrlf
strSQL = strSQL & "		 Return " & vbcrlf
strSQL = strSQL & "		End" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_board') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_board" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "set ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "set QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "go" & vbcrlf
''strSQL = strSQL & "	" & vbcrlf
''strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈보드 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- bd_idx_num : 실제 고유(unique) 값 - 검색의 편리를 도모하기 위해 게시판이 값이 들어갈 경우 이부분이 다시 변경됨" & vbcrlf
strSQL = strSQL & "	-- bd_num : 그룹값(bd_idx_num은 계속적인 증가를 하는 반면에 bd_num은 같은 부모글을 기준으로 같은 값을 가진다. bd_idx_num과 아무런 연관성 없음)" & vbcrlf
strSQL = strSQL & "	-- bd_step : bd_num을 기준으로 수차적인 값을 가진다." & vbcrlf
strSQL = strSQL & "	-- bd_level : 상위 부모글을 기준으로 순차적 값을 가진다." & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE " & Db_Owner & "usp_board" & vbcrlf
strSQL = strSQL & "		@smode varchar(10)," & vbcrlf
strSQL = strSQL & "		@tablename varchar(30)," & vbcrlf
strSQL = strSQL & "		@uid int = null," & vbcrlf
strSQL = strSQL & "		@notice int=0," & vbcrlf
strSQL = strSQL & "		@category tinyint=0," & vbcrlf
strSQL = strSQL & "		@id varchar(20) = null," & vbcrlf
strSQL = strSQL & "		@name nvarchar(30) = null," & vbcrlf
strSQL = strSQL & "		@email varchar(64) = null," & vbcrlf
strSQL = strSQL & "		@homepage varchar(100) = null," & vbcrlf
strSQL = strSQL & "		@pass varchar(20) = null," & vbcrlf
strSQL = strSQL & "		@subject nvarchar(200) = null," & vbcrlf
strSQL = strSQL & "		@flag nvarchar(100) = null," & vbcrlf
strSQL = strSQL & "		@sub_subject1 nvarchar(200) = null," & vbcrlf
strSQL = strSQL & "		@sub_subject2 nvarchar(200) = null," & vbcrlf
strSQL = strSQL & "		@content ntext = null," & vbcrlf
strSQL = strSQL & "		@sub_content1 ntext = null," & vbcrlf
strSQL = strSQL & "		@sub_content2 ntext = null," & vbcrlf
strSQL = strSQL & "		@op_flag varchar(20) = null," & vbcrlf
strSQL = strSQL & "		@filename varchar(250) = null," & vbcrlf
strSQL = strSQL & "		@filesize int = null," & vbcrlf
strSQL = strSQL & "		@ip varchar(15) = null," & vbcrlf
strSQL = strSQL & "		@count smallint=0," & vbcrlf
strSQL = strSQL & "		@reccount smallint = null," & vbcrlf
strSQL = strSQL & "		@replecount smallint = null," & vbcrlf
strSQL = strSQL & "		@filedown int = null" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	BEGIN	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	DECLARE" & vbcrlf
strSQL = strSQL & "		@strSQL nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@param  nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@bd_idx_num int," & vbcrlf
strSQL = strSQL & "		@bd_num int," & vbcrlf
strSQL = strSQL & "		@bd_step int," & vbcrlf
strSQL = strSQL & "		@bd_level int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_idx_num int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_num int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_step int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_level int," & vbcrlf
strSQL = strSQL & "		@p_uid int;" & vbcrlf
strSQL = strSQL & "		Set @bd_idx_num = 0;" & vbcrlf
strSQL = strSQL & "		Set @bd_num = 0;" & vbcrlf
strSQL = strSQL & "		Set @bd_step = 0;" & vbcrlf
strSQL = strSQL & "		Set @bd_level = 0;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "		BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "			IF (@smode = 'edit')" & vbcrlf
strSQL = strSQL & "				Set @strSQL = 'update	'+@tablename+' set" & vbcrlf
strSQL = strSQL & "					notice=@p_notice,category=@p_category,id=@p_id,name=@p_name" & vbcrlf
strSQL = strSQL & "					,email=@p_email,homepage=@p_homepage,subject=@p_subject,flag=@p_flag" & vbcrlf
strSQL = strSQL & "					,sub_subject1=@p_sub_subject1,sub_subject2=@p_sub_subject2" & vbcrlf
strSQL = strSQL & "					,content=@p_content,sub_content1=@p_sub_content1" & vbcrlf
strSQL = strSQL & "					,sub_content2=@p_sub_content2,[op_flag]=@p_op_flag" & vbcrlf
strSQL = strSQL & "					,filename=@p_filename,filesize=@p_filesize,ip=@p_ip" & vbcrlf
strSQL = strSQL & "					where uid=@p_uid" & vbcrlf
strSQL = strSQL & "				'" & vbcrlf
strSQL = strSQL & "			ELSE IF(@smode = 'reple')" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					-- 현재글의 bd_num, bd_step, bd_level 을 불러온다." & vbcrlf
strSQL = strSQL & "					Set @param = '@p_uid int, @rtn_bd_num int OUTPUT, @rtn_bd_step int OUTPUT, @rtn_bd_level int OUTPUT'" & vbcrlf
strSQL = strSQL & "					Set @strSQL = 'SELECT @rtn_bd_num = bd_num, @rtn_bd_step = [bd_step] , @rtn_bd_level = [bd_level]  " & vbcrlf
strSQL = strSQL & "					FROM '+@tablename+'" & vbcrlf
strSQL = strSQL & "					WHERE uid = @p_uid'" & vbcrlf
strSQL = strSQL & "					EXEC sp_executesql @strSQL, @param, @p_uid = @uid, @rtn_bd_num=@rtn_bd_num OUTPUT, @rtn_bd_step=@rtn_bd_step OUTPUT, @rtn_bd_level=@rtn_bd_level OUTPUT;" & vbcrlf
strSQL = strSQL & "					SELECT @rtn_bd_num, @rtn_bd_step, @rtn_bd_level	" & vbcrlf
strSQL = strSQL & "					Set @bd_num =@rtn_bd_num;" & vbcrlf
strSQL = strSQL & "					Set @bd_step = @rtn_bd_step;" & vbcrlf
strSQL = strSQL & "					Set @bd_level = @rtn_bd_level;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @param = '@bd_num int, @bd_step int'" & vbcrlf
strSQL = strSQL & "				Set @strSQL = 'UPDATE '+@tablename+' SET [bd_step] = [bd_step] + 1 WHERE [bd_num] = @bd_num AND [bd_step] > @bd_step'" & vbcrlf
strSQL = strSQL & "				EXEC sp_executesql @strSQL, @param, @bd_num=@bd_num, @bd_step=@bd_step;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @param = '@bd_num int, @bd_step int, @rtn_bd_idx_num int OUTPUT'" & vbcrlf
strSQL = strSQL & "				Set @strSQL = 'SELECT @rtn_bd_idx_num = [bd_idx_num] FROM '+@tablename+' WHERE [bd_num] = @bd_num AND [bd_step] = @bd_step'" & vbcrlf
strSQL = strSQL & "				Set @rtn_bd_idx_num = null" & vbcrlf
strSQL = strSQL & "				EXEC sp_executesql @strSQL, @param, @bd_num=@bd_num, @bd_step=@bd_step, @rtn_bd_idx_num=@rtn_bd_idx_num OUTPUT;" & vbcrlf
strSQL = strSQL & "				SELECT @rtn_bd_idx_num" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @param = '@rtn_bd_idx_num int'" & vbcrlf
strSQL = strSQL & "				Set @strSQL = 'UPDATE '+@tablename+' SET [bd_idx_num] = [bd_idx_num] + 1 WHERE [bd_idx_num] >= @rtn_bd_idx_num'" & vbcrlf
strSQL = strSQL & "				EXEC sp_executesql @strSQL, @param, @rtn_bd_idx_num=@rtn_bd_idx_num;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @bd_idx_num = @rtn_bd_idx_num;" & vbcrlf
strSQL = strSQL & "				--Set @bd_num;" & vbcrlf
strSQL = strSQL & "				Set @bd_step = @bd_step + 1;" & vbcrlf
strSQL = strSQL & "				Set @bd_level = @bd_level + 1;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @strSQL = 'insert into	'+@tablename+'(" & vbcrlf
strSQL = strSQL & "					notice,bd_idx_num,bd_num,bd_step, bd_level,category,id" & vbcrlf
strSQL = strSQL & "					,name,email,homepage,pass,subject,flag" & vbcrlf
strSQL = strSQL & "					,sub_subject1,sub_subject2, content" & vbcrlf
strSQL = strSQL & "					,sub_content1,sub_content2" & vbcrlf
strSQL = strSQL & "					,[op_flag],[count],reccount" & vbcrlf
strSQL = strSQL & "					,filename,filesize,filedown,ip,regdate" & vbcrlf
strSQL = strSQL & "					)values(" & vbcrlf
strSQL = strSQL & "					@p_notice,@p_bd_idx_num,@p_bd_num,@p_bd_step,@p_bd_level,@p_category,@p_id" & vbcrlf
strSQL = strSQL & "					,@p_name,@p_email,@p_homepage ,@p_pass,@p_subject,@p_flag" & vbcrlf
strSQL = strSQL & "					,@p_sub_subject1,@p_sub_subject2,@p_content" & vbcrlf
strSQL = strSQL & "					,@p_sub_content1,@p_sub_content2,@p_op_flag,@p_count,@p_reccount" & vbcrlf
strSQL = strSQL & "					,@p_filename,@p_filesize,@p_filedown,@p_ip,getdate()" & vbcrlf
strSQL = strSQL & "				)'" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "		END" & vbcrlf
strSQL = strSQL & "	ELSE --qin" & vbcrlf
strSQL = strSQL & "		BEGIN" & vbcrlf
strSQL = strSQL & "			SET @param = '@rtn_bd_idx_num int OUTPUT, @rtn_bd_num int OUTPUT'" & vbcrlf
strSQL = strSQL & "			Set @strSQL = 'SELECT TOP 1 @rtn_bd_idx_num = [bd_idx_num], @rtn_bd_num = [bd_num] FROM '+@tablename+' ORDER BY [bd_idx_num] DESC'" & vbcrlf
strSQL = strSQL & "			EXEC sp_executesql @strSQL, @param, @rtn_bd_idx_num OUTPUT, @rtn_bd_num OUTPUT;" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "			SELECT	@rtn_bd_idx_num, @rtn_bd_num;" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "			if (@rtn_bd_idx_num is null ) Set @bd_idx_num = 1;" & vbcrlf
strSQL = strSQL & "			else Set @bd_idx_num = @rtn_bd_idx_num+1;" & vbcrlf
strSQL = strSQL & "			if (@rtn_bd_num is null ) Set @bd_num = 1;" & vbcrlf
strSQL = strSQL & "			else Set @bd_num = @rtn_bd_num+1;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "			Set @strSQL = 'insert into	'+@tablename+'(" & vbcrlf
strSQL = strSQL & "				notice,bd_idx_num,bd_num,category,id" & vbcrlf
strSQL = strSQL & "				,name,email,homepage,pass,subject,flag" & vbcrlf
strSQL = strSQL & "				,sub_subject1,sub_subject2, content" & vbcrlf
strSQL = strSQL & "				,sub_content1,sub_content2" & vbcrlf
strSQL = strSQL & "				,[op_flag],[count],reccount" & vbcrlf
strSQL = strSQL & "				,filename,filesize,filedown,ip,regdate" & vbcrlf
strSQL = strSQL & "				)values(" & vbcrlf
strSQL = strSQL & "				@p_notice,@p_bd_idx_num,@p_bd_num,@p_category,@p_id" & vbcrlf
strSQL = strSQL & "				,@p_name,@p_email,@p_homepage ,@p_pass,@p_subject,@p_flag" & vbcrlf
strSQL = strSQL & "				,@p_sub_subject1,@p_sub_subject2,@p_content" & vbcrlf
strSQL = strSQL & "				,@p_sub_content1,@p_sub_content2,@p_op_flag,@p_count,@p_reccount" & vbcrlf
strSQL = strSQL & "				,@p_filename,@p_filesize,@p_filedown,@p_ip,getdate()" & vbcrlf
strSQL = strSQL & "			)'" & vbcrlf
strSQL = strSQL & "		End" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	 SET @param = '" & vbcrlf
strSQL = strSQL & "		@p_uid int," & vbcrlf
strSQL = strSQL & "		@p_notice tinyint," & vbcrlf
strSQL = strSQL & "		@p_bd_idx_num int," & vbcrlf
strSQL = strSQL & "		@p_bd_num int," & vbcrlf
strSQL = strSQL & "		@p_bd_step int," & vbcrlf
strSQL = strSQL & "		@p_bd_level int," & vbcrlf
strSQL = strSQL & "		@p_category tinyint," & vbcrlf
strSQL = strSQL & "		@p_id varchar(20)," & vbcrlf
strSQL = strSQL & "		@p_name nvarchar(30)," & vbcrlf
strSQL = strSQL & "		@p_email varchar(64)," & vbcrlf
strSQL = strSQL & "		@p_homepage varchar(100)," & vbcrlf
strSQL = strSQL & "		@p_pass varchar(20)," & vbcrlf
strSQL = strSQL & "		@p_subject nvarchar(200)," & vbcrlf
strSQL = strSQL & "		@p_flag nvarchar(100)," & vbcrlf
strSQL = strSQL & "		@p_sub_subject1 nvarchar(200)," & vbcrlf
strSQL = strSQL & "		@p_sub_subject2 nvarchar(200)," & vbcrlf
strSQL = strSQL & "		@p_content ntext," & vbcrlf
strSQL = strSQL & "		@p_sub_content1 ntext," & vbcrlf
strSQL = strSQL & "		@p_sub_content2 ntext," & vbcrlf
strSQL = strSQL & "		@p_op_flag varchar(20)," & vbcrlf
strSQL = strSQL & "		@p_filename varchar(250)," & vbcrlf
strSQL = strSQL & "		@p_filesize int," & vbcrlf
strSQL = strSQL & "		@p_ip varchar(15)," & vbcrlf
strSQL = strSQL & "		@p_count smallint," & vbcrlf
strSQL = strSQL & "		@p_reccount smallint," & vbcrlf
strSQL = strSQL & "		@p_replecount smallint," & vbcrlf
strSQL = strSQL & "		@p_filedown int'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	EXEC sp_executesql @strSQL, @param, " & vbcrlf
strSQL = strSQL & "		@p_uid = @uid," & vbcrlf
strSQL = strSQL & "		@p_notice = @notice," & vbcrlf
strSQL = strSQL & "		@p_bd_idx_num =@bd_idx_num," & vbcrlf
strSQL = strSQL & "		@p_bd_num =@bd_num," & vbcrlf
strSQL = strSQL & "		@p_bd_step =@bd_step," & vbcrlf
strSQL = strSQL & "		@p_bd_level =@bd_level," & vbcrlf
strSQL = strSQL & "		@p_category =@category," & vbcrlf
strSQL = strSQL & "		@p_id  =@id," & vbcrlf
strSQL = strSQL & "		@p_name =@name," & vbcrlf
strSQL = strSQL & "		@p_email =@email," & vbcrlf
strSQL = strSQL & "		@p_homepage =@homepage," & vbcrlf
strSQL = strSQL & "		@p_pass =@pass," & vbcrlf
strSQL = strSQL & "		@p_subject =@subject," & vbcrlf
strSQL = strSQL & "		@p_flag =@flag," & vbcrlf
strSQL = strSQL & "		@p_sub_subject1 =@sub_subject1," & vbcrlf
strSQL = strSQL & "		@p_sub_subject2 =@sub_subject2," & vbcrlf
strSQL = strSQL & "		@p_content =@content," & vbcrlf
strSQL = strSQL & "		@p_sub_content1 =@sub_content1," & vbcrlf
strSQL = strSQL & "		@p_sub_content2 =@sub_content2," & vbcrlf
strSQL = strSQL & "		@p_op_flag =@op_flag," & vbcrlf
strSQL = strSQL & "		@p_filename  =@filename," & vbcrlf
strSQL = strSQL & "		@p_filesize =@filesize," & vbcrlf
strSQL = strSQL & "		@p_ip =@ip," & vbcrlf
strSQL = strSQL & "		@p_count =@count," & vbcrlf
strSQL = strSQL & "		@p_reccount =@reccount," & vbcrlf
strSQL = strSQL & "		@p_replecount =@replecount," & vbcrlf
strSQL = strSQL & "		@p_filedown =@filedown;" & vbcrlf
strSQL = strSQL & "	--PRINT @strSQL;" & vbcrlf
strSQL = strSQL & "		IF @@ERROR <> 0 GOTO ERROR_HANDLER" & vbcrlf
strSQL = strSQL & "		COMMIT TRANSACTION" & vbcrlf
strSQL = strSQL & "		RETURN 1 " & vbcrlf
strSQL = strSQL & "	ERROR_HANDLER:" & vbcrlf
strSQL = strSQL & "		ROLLBACK TRANSACTION" & vbcrlf
strSQL = strSQL & "		RETURN -1" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
strSQL = strSQL & "" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_board_view') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_board_view" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈보드 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE [usp_board_view]" & vbcrlf
strSQL = strSQL & "		@smode varchar(10) = ''," & vbcrlf
strSQL = strSQL & "		@tablename varchar(30)," & vbcrlf
strSQL = strSQL & "		@uid int," & vbcrlf
strSQL = strSQL & "		@category int = 0," & vbcrlf
strSQL = strSQL & "		@rtn_puid int  = 0 OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_nuid int = 0 OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_psub nvarchar(200) = '' OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_nsub nvarchar(200) = '' OUTPUT" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	BEGIN	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	DECLARE" & vbcrlf
strSQL = strSQL & "		@strSQL nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@param nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@ccategory nvarchar(20)," & vbcrlf
strSQL = strSQL & "		@catwhere nvarchar(50)," & vbcrlf
strSQL = strSQL & "		--@rsub nvarchar(50) OUTPUT," & vbcrlf
strSQL = strSQL & "		@rsub nvarchar(50)," & vbcrlf
strSQL = strSQL & "		@ruid int;" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		--BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "		Begin Tran" & vbcrlf
strSQL = strSQL & "			Set @ccategory = @category" & vbcrlf
strSQL = strSQL & "			Set @catwhere = ''" & vbcrlf
strSQL = strSQL & "			if (@category <> 0 ) Set @catwhere = ' and category = '+@ccategory" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			--등록된 게시물을 불러온다" & vbcrlf
strSQL = strSQL & "			SET @param = '@p_uid int'" & vbcrlf
strSQL = strSQL & "			--Set @strSQL = 'select * from ' + @tablename + ' WHERE uid=@p_uid'" & vbcrlf
strSQL = strSQL & "			Set @strSQL = 'select * " & vbcrlf
strSQL = strSQL & "			from ' + @tablename + ' WHERE uid=@p_uid'" & vbcrlf
strSQL = strSQL & "			EXEC sp_executesql @strSQL, @param, @p_uid = @uid;" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			If (@smode <> 'edit' or @smode is null)" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					--카운팅을 올린다." & vbcrlf
strSQL = strSQL & "					SET @param = '@p_uid int'" & vbcrlf
strSQL = strSQL & "					Set @strSQL = 'update '+@tablename+' set count = count + 1 where uid=@p_uid'" & vbcrlf
strSQL = strSQL & "					EXEC sp_executesql @strSQL, @param, @p_uid = @uid;" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					-- get previous " & vbcrlf
strSQL = strSQL & "					SET @param = '@p_uid int, @ruid int OUTPUT, @rsub nvarchar(200) OUTPUT'" & vbcrlf
strSQL = strSQL & "					Set @strSQL = 'SELECT top 1 @ruid = uid,  @rsub= subject" & vbcrlf
strSQL = strSQL & "					FROM '+@tablename+' " & vbcrlf
strSQL = strSQL & "					WHERE uid < @p_uid '+@catwhere+' order by uid desc'" & vbcrlf
strSQL = strSQL & "					EXEC sp_executesql @strSQL, @param, @p_uid = @uid, @ruid = @ruid OUTPUT, @rsub=@rsub OUTPUT;" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					SELECT	@ruid, @rsub" & vbcrlf
strSQL = strSQL & "					Set @rtn_puid = @ruid" & vbcrlf
strSQL = strSQL & "					Set @rtn_psub = @rsub" & vbcrlf
strSQL = strSQL & "					Set @ruid = null" & vbcrlf
strSQL = strSQL & "					Set @rsub = null" & vbcrlf
strSQL = strSQL & "					-- get next" & vbcrlf
strSQL = strSQL & "					SET @param = '@p_uid int, @ruid int OUTPUT, @rsub nvarchar(200) OUTPUT'" & vbcrlf
strSQL = strSQL & "					Set @strSQL = 'SELECT top 1 @ruid = uid,  @rsub= subject" & vbcrlf
strSQL = strSQL & "					FROM '+@tablename+' " & vbcrlf
strSQL = strSQL & "					WHERE uid > @p_uid '+@catwhere+' order by uid asc'" & vbcrlf
strSQL = strSQL & "					EXEC sp_executesql @strSQL, @param, @p_uid = @uid, @ruid = @ruid OUTPUT, @rsub=@rsub OUTPUT;" & vbcrlf
strSQL = strSQL & "					" & vbcrlf
strSQL = strSQL & "					SELECT	@ruid, @rsub" & vbcrlf
strSQL = strSQL & "					Set @rtn_nuid = @ruid" & vbcrlf
strSQL = strSQL & "					Set @rtn_nsub = @rsub" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		If (@@error <> 0)" & vbcrlf
strSQL = strSQL & "			RollBack Tran" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			Commit Tran" & vbcrlf
strSQL = strSQL & "		RETURN" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_boardlist') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_boardlist" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,04" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈보드 리스트 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROC " & Db_Owner & "[usp_boardlist]" & vbcrlf
strSQL = strSQL & "			@tablename nvarchar(30)," & vbcrlf
strSQL = strSQL & "			@listcnt nvarchar(5) = '10'," & vbcrlf
strSQL = strSQL & "			@whereis nvarchar(200) = 'WHERE ( notice <> 1 or notice is null)'," & vbcrlf
strSQL = strSQL & "			@page nvarchar(5) ='1'," & vbcrlf
strSQL = strSQL & "			@orderby nvarchar(40) = 'ORDER BY bd_idx_num desc'," & vbcrlf
strSQL = strSQL & "			@selectfield varchar(100) = 'uid,name,content,subject,count,op_flag,filename,replecount,bd_level,regdate'" & vbcrlf
strSQL = strSQL & "			--@selectfield nvarchar(40) = '*'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED" & vbcrlf
strSQL = strSQL & "	    SET NOCOUNT ON" & vbcrlf
strSQL = strSQL & "		DECLARE" & vbcrlf
strSQL = strSQL & "				@strSQL nvarchar(1000)," & vbcrlf
strSQL = strSQL & "				@param  nvarchar(1000)," & vbcrlf
strSQL = strSQL & "				@notincnt nvarchar(10);" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				Set @notincnt = (@page - 1) * @listcnt;" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				Set @strSQL = 'select TOP '+@listcnt+' '+@selectfield+' from '+@tablename+' '+@whereis+" & vbcrlf
strSQL = strSQL & "				' and uid not in (SELECT TOP '+@notincnt+' uid from '+@tablename+' '+@whereis+' '+@orderby+') '+" & vbcrlf
strSQL = strSQL & "				@orderby;  " & vbcrlf
strSQL = strSQL & "				Exec Sp_ExecuteSQL @strSQL" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_member') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_member" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈멤버 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE " & Db_Owner & "[usp_member]" & vbcrlf
strSQL = strSQL & "		@qry varchar(10)," & vbcrlf
strSQL = strSQL & "		@mid varchar(12)," & vbcrlf
strSQL = strSQL & "		@mpwd varchar(15)," & vbcrlf
strSQL = strSQL & "		@mname varchar(30)," & vbcrlf
strSQL = strSQL & "		--@mregdate smalldatetime," & vbcrlf
strSQL = strSQL & "		@mgrantsta varchar(8)," & vbcrlf
strSQL = strSQL & "		@mpoint  int = 0," & vbcrlf
strSQL = strSQL & "		@mgrade varchar(10)," & vbcrlf
strSQL = strSQL & "		@mloginnum int = 0," & vbcrlf
strSQL = strSQL & "		@nickname varchar(20)," & vbcrlf
strSQL = strSQL & "		@jumin1 varchar(6)=NULL," & vbcrlf
strSQL = strSQL & "		@jumin2 varchar(7)=NULL," & vbcrlf
strSQL = strSQL & "		@tel1 varchar(20)=NULL," & vbcrlf
strSQL = strSQL & "		@tel2 varchar(20)=NULL," & vbcrlf
strSQL = strSQL & "		@tel3 nvarchar(50)=NULL," & vbcrlf
strSQL = strSQL & "		@zip1 varchar(7)=NULL," & vbcrlf
strSQL = strSQL & "		@address1 varchar(90)=NULL," & vbcrlf
strSQL = strSQL & "		@address2 varchar(50)=NULL," & vbcrlf
strSQL = strSQL & "		@email varchar(80)=NULL," & vbcrlf
strSQL = strSQL & "		@emailenable tinyint=NULL," & vbcrlf
strSQL = strSQL & "		@url varchar(80)=NULL," & vbcrlf
strSQL = strSQL & "		@age int=NULL," & vbcrlf
strSQL = strSQL & "		@birthdate varchar(15)=NULL," & vbcrlf
strSQL = strSQL & "		@birthtype varchar(2)=NULL," & vbcrlf
strSQL = strSQL & "		@gender int=NULL," & vbcrlf
strSQL = strSQL & "		@companynum varchar(12)=NULL," & vbcrlf
strSQL = strSQL & "		@companyname varchar(30)=NULL," & vbcrlf
strSQL = strSQL & "		@president varchar(20)=NULL," & vbcrlf
strSQL = strSQL & "		@czip varchar(7)=NULL," & vbcrlf
strSQL = strSQL & "		@caddress1 varchar(80)=NULL," & vbcrlf
strSQL = strSQL & "		@caddress2 varchar(50)=NULL," & vbcrlf
strSQL = strSQL & "		@contents ntext=NULL" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	BEGIN" & vbcrlf
strSQL = strSQL & "		BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "			IF(@qry = 'qin')" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					insert into	wizmembers(" & vbcrlf
strSQL = strSQL & "					mid,mpwd,mname,mregdate,mgrantsta,mpoint,mgrade,mloginnum" & vbcrlf
strSQL = strSQL & "					)values(" & vbcrlf
strSQL = strSQL & "					@mid,@mpwd,@mname,getdate(),@mgrantsta,@mpoint,@mgrade,@mloginnum" & vbcrlf
strSQL = strSQL & "					)" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					insert into	wizmembers_ind(" & vbcrlf
strSQL = strSQL & "						mid,nickname,jumin1,jumin2,tel1,tel2,tel3" & vbcrlf
strSQL = strSQL & "						,zip1,address1,address2,email,emailenable,url,age" & vbcrlf
strSQL = strSQL & "						,birthdate,birthtype,gender,companynum,companyname" & vbcrlf
strSQL = strSQL & "						,president,czip,caddress1,caddress2,contents" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					)values(" & vbcrlf
strSQL = strSQL & "						@mid,@nickname,@jumin1,@jumin2,@tel1,@tel2,@tel3" & vbcrlf
strSQL = strSQL & "						,@zip1,@address1,@address2,@email,@emailenable,@url,@age" & vbcrlf
strSQL = strSQL & "						,@birthdate,@birthtype,@gender,@companynum,@companyname" & vbcrlf
strSQL = strSQL & "						,@president,@czip,@caddress1,@caddress2,@contents" & vbcrlf
strSQL = strSQL & "					)" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "			ELSE" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					update wizmembers set" & vbcrlf
strSQL = strSQL & "						mpwd=@mpwd,mname=@mname" & vbcrlf
strSQL = strSQL & "					where mid = @mid" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					update	wizmembers_ind set" & vbcrlf
strSQL = strSQL & "						nickname=@nickname,tel1=@tel1,tel2=@tel2,tel3=@tel3,zip1=@zip1" & vbcrlf
strSQL = strSQL & "						,address1=@address1,address2=@address2,email=@email,emailenable=@emailenable" & vbcrlf
strSQL = strSQL & "						,url=@url,age=@age,birthdate=@birthdate,birthtype=@birthtype,gender=@gender" & vbcrlf
strSQL = strSQL & "						,companynum=@companynum,companyname=@companyname,president=@president" & vbcrlf
strSQL = strSQL & "						,czip=@czip,caddress1=@caddress1,caddress2=@caddress2,contents=@contents" & vbcrlf
strSQL = strSQL & "					where mid = @mid" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			IF @@ERROR <> 0 GOTO ERROR_HANDLER" & vbcrlf
strSQL = strSQL & "		COMMIT TRANSACTION" & vbcrlf
strSQL = strSQL & "		RETURN 1 " & vbcrlf
strSQL = strSQL & "	ERROR_HANDLER:" & vbcrlf
strSQL = strSQL & "		ROLLBACK TRANSACTION" & vbcrlf
strSQL = strSQL & "		RETURN -1" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_mk_boardtb') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_mk_boardtb" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)



strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈보드 테이블 생성 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE [usp_mk_boardtb]" & vbcrlf
strSQL = strSQL & "		-- Add the parameters for the stored procedure here" & vbcrlf
strSQL = strSQL & "		@bid varchar(30)," & vbcrlf
strSQL = strSQL & "		@gid varchar(30) = 'root'," & vbcrlf
strSQL = strSQL & "		@dbo varchar(30) = 'dbo'," & vbcrlf
strSQL = strSQL & "		@setTitle varchar(100) = '위즈보드'," & vbcrlf
strSQL = strSQL & "		@setSkin varchar(30) = 'default'," & vbcrlf
strSQL = strSQL & "		@intcategorynum smallint = 0," & vbcrlf
strSQL = strSQL & "		@intcategorycount smallint = 0," & vbcrlf
strSQL = strSQL & "		@categoryname varchar(30) = '전체'," & vbcrlf
strSQL = strSQL & "		@setorder smallint=0," & vbcrlf
strSQL = strSQL & "		@setSubjectCut smallint = 50," & vbcrlf
strSQL = strSQL & "		@setPageSize smallint = 10," & vbcrlf
strSQL = strSQL & "		@setPageLink smallint = 10," & vbcrlf
strSQL = strSQL & "		@setadminonly smallint = 0," & vbcrlf
strSQL = strSQL & "		@setboardwidth varchar(10) = 600," & vbcrlf
strSQL = strSQL & "		@setBoardWidthStep varchar(2) = 'px'," & vbcrlf
strSQL = strSQL & "		@setboardalign varchar(10) = 'center'," & vbcrlf
strSQL = strSQL & "		@setmemberonly bit = 0," & vbcrlf
strSQL = strSQL & "		@memberonly_mode varchar(10) = '11|11|11'," & vbcrlf
strSQL = strSQL & "		@setrepleenable smallint = 0," & vbcrlf
strSQL = strSQL & "		@setcategoryenable smallint = 0," & vbcrlf
strSQL = strSQL & "		@setlistinview smallint = 0," & vbcrlf
strSQL = strSQL & "		@setmallinclude smallint = 1," & vbcrlf
strSQL = strSQL & "		@setfileenable smallint = 1," & vbcrlf
strSQL = strSQL & "		@setfilenum smallint = 1," & vbcrlf
strSQL = strSQL & "		@setsecurityflag varchar(10) = '1|1'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	BEGIN" & vbcrlf
strSQL = strSQL & "		DECLARE " & vbcrlf
strSQL = strSQL & "		@maxsetorder smallint;" & vbcrlf
strSQL = strSQL & "		--BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "		Begin Tran" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	if (@dbo = '' or @dbo is null) Set @dbo = 'dbo'" & vbcrlf
strSQL = strSQL & "	--if('wizboard_'+@bid+'_'+@gid = (select name from sysobjects where name = 'wizboard_'+@bid+'_'+@gid )) -- 같은 이름의 테이블이 있는지 여부 확인" & vbcrlf
strSQL = strSQL & "	--print 'wizboard_'+@bid+'_'+@gid + '라는 이름의 테이블이 있습니다'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	EXEC (N'CREATE TABLE ['+@dbo+'].[wizboard_'+@bid+'_'+@gid+'] (		" & vbcrlf	
strSQL = strSQL & "		[uid] [int] identity (1, 1) not null ," & vbcrlf
strSQL = strSQL & "		[notice] [tinyint] not null ," & vbcrlf
strSQL = strSQL & "		[bd_idx_num] [int] not null ," & vbcrlf
strSQL = strSQL & "		[bd_num] [int] not null ," & vbcrlf
strSQL = strSQL & "		[bd_step] [tinyint] not null ," & vbcrlf
strSQL = strSQL & "		[bd_level] [tinyint] not null ," & vbcrlf
strSQL = strSQL & "		[category] [tinyint] not null ," & vbcrlf
strSQL = strSQL & "		[id] [nvarchar] (20) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[name] [nvarchar] (20) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[email] [nvarchar] (34) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[homepage] [nvarchar] (50) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[pass] [nvarchar] (20) collate korean_wansung_ci_as null," & vbcrlf
strSQL = strSQL & "		[subject] [nvarchar] (200) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[flag] [nvarchar] (100) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[sub_subject1] [nvarchar] (200) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[sub_subject2] [nvarchar] (200) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[content] [ntext] collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[sub_content1] [ntext] collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[sub_content2] [ntext] collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[op_flag] [nvarchar] (10) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[count] [smallint] not null ," & vbcrlf
strSQL = strSQL & "		[reccount] [smallint] null ," & vbcrlf
strSQL = strSQL & "		[replecount] [smallint] null ," & vbcrlf
strSQL = strSQL & "		[filename] [nvarchar] (250) collate korean_wansung_ci_as null ," & vbcrlf
strSQL = strSQL & "		[filesize] [int] null ," & vbcrlf
strSQL = strSQL & "		[filedown] [int] null ," & vbcrlf
strSQL = strSQL & "		[ip] [nvarchar] (15) collate korean_wansung_ci_as not null ," & vbcrlf
strSQL = strSQL & "		[moddate] [smalldatetime] null," & vbcrlf
strSQL = strSQL & "		[regdate] [smalldatetime] not null " & vbcrlf
strSQL = strSQL & "		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]'" & vbcrlf
strSQL = strSQL & "		)" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		EXEC (N'ALTER TABLE ['+@dbo+'].[wizboard_'+@bid+'_'+@gid+'] WITH NOCHECK ADD " & vbcrlf
strSQL = strSQL & "		CONSTRAINT [PK_wizboard_'+@bid+'_'+@gid+'] PRIMARY KEY  CLUSTERED " & vbcrlf
strSQL = strSQL & "		(" & vbcrlf
strSQL = strSQL & "			[bd_idx_num]" & vbcrlf
strSQL = strSQL & "		)  ON [PRIMARY] " & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		ALTER TABLE ['+@dbo+'].[wizboard_'+@bid+'_'+@gid+'] WITH NOCHECK ADD " & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_notice] DEFAULT (0) FOR [notice]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_bd_step] DEFAULT (0) FOR [bd_step]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_bd_level] DEFAULT (0) FOR [bd_level]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_category] DEFAULT (0) FOR [category]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_moddate] DEFAULT (getdate()) FOR [moddate]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_count] DEFAULT (0) FOR [count]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_reccount] DEFAULT (0) FOR [reccount]," & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_replecount] DEFAULT (0) FOR [replecount]'" & vbcrlf
strSQL = strSQL & "		)" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		EXEC (N'CREATE TABLE ['+@dbo+'].[wizboard_'+@bid+'_'+@gid+'_reply] (" & vbcrlf
strSQL = strSQL & "		[uid] [int] IDENTITY (1, 1) NOT NULL ," & vbcrlf
strSQL = strSQL & "		[b_uid] [int] NOT NULL ," & vbcrlf
strSQL = strSQL & "		[id] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "		[name] [nvarchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "		[email] [nvarchar] (64) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "		[pass] [nvarchar] (20) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "		[subject] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "		[content] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ," & vbcrlf
strSQL = strSQL & "		[filename] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ," & vbcrlf
strSQL = strSQL & "		[ip] [nvarchar] (15) collate korean_wansung_ci_as not null ," & vbcrlf
strSQL = strSQL & "		[regdate] [smalldatetime] NOT NULL " & vbcrlf
strSQL = strSQL & "		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]'" & vbcrlf
strSQL = strSQL & "		)" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		EXEC (N'ALTER TABLE ['+@dbo+'].[wizboard_'+@bid+'_'+@gid+'_reply] WITH NOCHECK ADD " & vbcrlf
strSQL = strSQL & "		CONSTRAINT [PK_wizboard_'+@bid+'_'+@gid+'_reply] PRIMARY KEY  CLUSTERED " & vbcrlf
strSQL = strSQL & "		(" & vbcrlf
strSQL = strSQL & "			[uid]" & vbcrlf
strSQL = strSQL & "		)  ON [PRIMARY] " & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		ALTER TABLE ['+@dbo+'].[wizboard_'+@bid+'_'+@gid+'_reply] WITH NOCHECK ADD " & vbcrlf
strSQL = strSQL & "		CONSTRAINT [DF_wizboard_'+@bid+'_'+@gid+'_reply_regdate] DEFAULT (getdate()) FOR [regdate]'" & vbcrlf
strSQL = strSQL & "		)" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "		select @maxsetorder = (case when max(setorder) is null then 0 else max(setorder) end ) from wiztable_board_config" & vbcrlf
strSQL = strSQL & "		Set @setorder	= @maxsetorder+1" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		insert into [wiztable_category](" & vbcrlf
strSQL = strSQL & "		[bid],[gid],[intcategorynum],[intcategorycount],[categoryname] " & vbcrlf
strSQL = strSQL & "		)values(" & vbcrlf
strSQL = strSQL & "		@bid,@gid,@intcategorynum,@intcategorycount,@categoryname);" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		insert into wiztable_board_config(" & vbcrlf
strSQL = strSQL & "		[setorder],[bid],[gid],[settitle],[setskin],[setsubjectcut],[setpagesize],[setpagelink],[setadminonly]" & vbcrlf
strSQL = strSQL & "		,[setboardwidth],[setboardwidthstep],[setboardalign],[setmemberonly],[memberonly_mode],[setrepleenable]" & vbcrlf
strSQL = strSQL & "		,[setcategoryenable],[setlistinview],[setmallinclude],[setfileenable],[setfilenum],[setsecurityflag]" & vbcrlf
strSQL = strSQL & "		)values(" & vbcrlf
strSQL = strSQL & "		@setorder,@bid,@gid,@settitle,@setskin,@setsubjectcut,@setpagesize,@setpagelink,@setadminonly" & vbcrlf
strSQL = strSQL & "		,@setboardwidth,@setboardwidthstep,@setboardalign,@setmemberonly,@memberonly_mode,@setrepleenable" & vbcrlf
strSQL = strSQL & "		,@setcategoryenable,@setlistinview,@setmallinclude,@setfileenable,@setfilenum,@setsecurityflag" & vbcrlf
strSQL = strSQL & "		);" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		SET NOCOUNT ON;" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	    -- Insert statements for procedure here" & vbcrlf
strSQL = strSQL & "		--Set @intResult = @@error" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "		If (@@error <> 0)" & vbcrlf
strSQL = strSQL & "			RollBack Tran" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			Commit Tran" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_pd_comment') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_pd_comment" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈몰 제품 상세보기 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE [usp_pd_comment]" & vbcrlf
strSQL = strSQL & "		@smod nvarchar(10)= NULL," & vbcrlf
strSQL = strSQL & "		@pid int," & vbcrlf
strSQL = strSQL & "		@c_id nvarchar(30) = NULL," & vbcrlf
strSQL = strSQL & "		@c_name nvarchar(30) = NULL," & vbcrlf
strSQL = strSQL & "		@c_pwd nvarchar(30) = NULL," & vbcrlf
strSQL = strSQL & "		@c_email nvarchar(50) = NULL," & vbcrlf
strSQL = strSQL & "		@c_grade int = NULL," & vbcrlf
strSQL = strSQL & "		@c_subject nvarchar(200) = NULL," & vbcrlf
strSQL = strSQL & "		@c_comment ntext = NULL," & vbcrlf
strSQL = strSQL & "		@c_option nvarchar(10) = NULL," & vbcrlf
strSQL = strSQL & "		@c_ip nvarchar(20) = NULL" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	BEGIN	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	--DECLARE" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		--BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "		Begin Tran" & vbcrlf
strSQL = strSQL & "			INSERT INTO wizmall_comment" & vbcrlf
strSQL = strSQL & "			(pid,c_id,c_name,c_pwd,c_email,c_grade,c_subject,c_comment,c_option,c_ip,c_wdate)" & vbcrlf
strSQL = strSQL & "			VALUES" & vbcrlf
strSQL = strSQL & "			(@pid,@c_id,@c_name,@c_pwd,@c_email,@c_grade,@c_subject,@c_comment,@c_option,@c_ip, getdate())" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		If (@@error <> 0)" & vbcrlf
strSQL = strSQL & "			RollBack Tran" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			Commit Tran" & vbcrlf
strSQL = strSQL & "		RETURN" & vbcrlf
strSQL = strSQL & "	END" & vbcrlfv
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_point') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_point" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	포인트 관련 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE [usp_point]" & vbcrlf
strSQL = strSQL & "		@pmode varchar(20)," & vbcrlf
strSQL = strSQL & "		@id varchar(30)," & vbcrlf
strSQL = strSQL & "		@ptype int," & vbcrlf
strSQL = strSQL & "		@point int," & vbcrlf
strSQL = strSQL & "		@flag  int = 0," & vbcrlf
strSQL = strSQL & "		@uid int = 0," & vbcrlf
strSQL = strSQL & "		@content varchar(50) = NULL," & vbcrlf
strSQL = strSQL & "		@rtn_point int OUTPUT" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	BEGIN" & vbcrlf
strSQL = strSQL & "		Begin Tran" & vbcrlf
strSQL = strSQL & "			IF(@pmode = 'qin')" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					insert into wizpoint (" & vbcrlf
strSQL = strSQL & "					id, ptype, [content], point,flag,wdate" & vbcrlf
strSQL = strSQL & "					) values (" & vbcrlf
strSQL = strSQL & "					@id,@ptype,@content,@point,@flag,getdate())" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					update	wizmembers set " & vbcrlf
strSQL = strSQL & "					mpoint = mpoint + @point" & vbcrlf
strSQL = strSQL & "					where mid = @id" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "			ELSE IF(@pmode = 'qde')" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					delete from wizpoint where uid = @uid" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "					update	wizmembers set " & vbcrlf
strSQL = strSQL & "					mpoint = mpoint - @point" & vbcrlf
strSQL = strSQL & "					where mid = @id" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		-- 저장이 완료되면 현재 포인트를 반환한다." & vbcrlf
strSQL = strSQL & "			select @rtn_point = mpoint from wizmembers where mid = @id" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		If (@@error <> 0)" & vbcrlf
strSQL = strSQL & "			RollBack Tran" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			Commit Tran" & vbcrlf
strSQL = strSQL & "		RETURN" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_product_view') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_product_view" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
''strSQL = strSQL & "SET ANSI_NULLS ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "SET QUOTED_IDENTIFIER ON" & vbcrlf
''strSQL = strSQL & "GO" & vbcrlf
''strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈몰 제품 상세보기 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE [usp_product_view]" & vbcrlf
strSQL = strSQL & "		@no int," & vbcrlf
strSQL = strSQL & "		@code int," & vbcrlf
strSQL = strSQL & "		@rtn_puid int OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_nuid int OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_ppname nvarchar(200) OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_npname nvarchar(200) OUTPUT" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	BEGIN	" & vbcrlf
strSQL = strSQL & "	--DECLARE" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		--BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "		Begin Tran" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			--등록된 게시물을 불러온다" & vbcrlf
strSQL = strSQL & "			SELECT * FROM wizmall WHERE uid=@no" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			-- 카운팅을 올린다." & vbcrlf
strSQL = strSQL & "			UPDATE wizmall set hit = hit + 1 where uid=@no" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "			-- 이전글" & vbcrlf
strSQL = strSQL & "			SELECT top 1 @rtn_puid = uid, @rtn_ppname = pname FROM wizmall where uid < @no AND category = @code  order by uid desc" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "			-- 다음글" & vbcrlf
strSQL = strSQL & "			SELECT top 1 @rtn_puid=uid,  @rtn_ppname=pname FROM wizmall where uid > @no AND category = @code order by uid asc" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		If (@@error <> 0)" & vbcrlf
strSQL = strSQL & "			RollBack Tran" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			Commit Tran" & vbcrlf
strSQL = strSQL & "		RETURN" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)







strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_product_qna') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_product_qna" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2010,05" & vbcrlf
strSQL = strSQL & "	-- Description:	제품 qna " & vbcrlf
strSQL = strSQL & "" & vbcrlf
	
strSQL = strSQL & "	CREATE PROCEDURE [dbo].[usp_product_qna]" & vbcrlf
strSQL = strSQL & "		@smode varchar(10)," & vbcrlf
strSQL = strSQL & "		@uid int = null," & vbcrlf
strSQL = strSQL & "		@pid int=0," & vbcrlf
strSQL = strSQL & "		@id varchar(20) = null," & vbcrlf
strSQL = strSQL & "		@name nvarchar(30) = null," & vbcrlf
strSQL = strSQL & "		@pass varchar(20) = null," & vbcrlf
strSQL = strSQL & "		@subject nvarchar(200) = null," & vbcrlf
strSQL = strSQL & "		@content ntext = null," & vbcrlf
strSQL = strSQL & "		@op_flag varchar(20) = null," & vbcrlf
strSQL = strSQL & "		@filename varchar(250) = null," & vbcrlf
strSQL = strSQL & "		@ip varchar(15) = null," & vbcrlf
strSQL = strSQL & "		@count smallint=0," & vbcrlf
strSQL = strSQL & "		@reccount smallint = null," & vbcrlf
strSQL = strSQL & "		@replecount smallint = null" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	BEGIN	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	DECLARE" & vbcrlf
strSQL = strSQL & "		@strSQL nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@param  nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@bd_idx_num int," & vbcrlf
strSQL = strSQL & "		@bd_num int," & vbcrlf
strSQL = strSQL & "		@bd_step int," & vbcrlf
strSQL = strSQL & "		@bd_level int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_idx_num int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_num int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_step int," & vbcrlf
strSQL = strSQL & "		@rtn_bd_level int," & vbcrlf
strSQL = strSQL & "		@p_uid int;" & vbcrlf
strSQL = strSQL & "		Set @bd_idx_num = 0;" & vbcrlf
strSQL = strSQL & "		Set @bd_num = 0;" & vbcrlf
strSQL = strSQL & "		Set @bd_step = 0;" & vbcrlf
strSQL = strSQL & "		Set @bd_level = 0;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "		BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "			IF (@smode = 'edit')" & vbcrlf
strSQL = strSQL & "				Set @strSQL = N'update	wizmall_product_qna set" & vbcrlf
strSQL = strSQL & "					id=@p_id,name=@p_name" & vbcrlf
strSQL = strSQL & "					,subject=@p_subject" & vbcrlf
strSQL = strSQL & "					,content=@p_content" & vbcrlf
strSQL = strSQL & "					,[op_flag]=@p_op_flag" & vbcrlf
strSQL = strSQL & "					,filename=@p_filename,ip=@p_ip" & vbcrlf
strSQL = strSQL & "					where uid=@p_uid" & vbcrlf
strSQL = strSQL & "				'" & vbcrlf
strSQL = strSQL & "			ELSE IF(@smode = 'reple')" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					-- 현재글의 bd_num, bd_step, bd_level 을 불러온다." & vbcrlf
strSQL = strSQL & "					Set @param = N'@p_uid int, @rtn_bd_num int OUTPUT, @rtn_bd_step int OUTPUT, @rtn_bd_level int OUTPUT'" & vbcrlf
strSQL = strSQL & "					Set @strSQL = N'SELECT @rtn_bd_num = bd_num, @rtn_bd_step = [bd_step] , @rtn_bd_level = [bd_level]  " & vbcrlf
strSQL = strSQL & "					FROM wizmall_product_qna" & vbcrlf
strSQL = strSQL & "					WHERE uid = @p_uid'" & vbcrlf
strSQL = strSQL & "					EXEC sp_executesql @strSQL, @param, @p_uid = @uid, @rtn_bd_num=@rtn_bd_num OUTPUT, @rtn_bd_step=@rtn_bd_step OUTPUT, @rtn_bd_level=@rtn_bd_level OUTPUT;" & vbcrlf
strSQL = strSQL & "					SELECT @rtn_bd_num, @rtn_bd_step, @rtn_bd_level	" & vbcrlf
strSQL = strSQL & "					Set @bd_num =@rtn_bd_num;" & vbcrlf
strSQL = strSQL & "					Set @bd_step = @rtn_bd_step;" & vbcrlf
strSQL = strSQL & "					Set @bd_level = @rtn_bd_level;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @param = N'@bd_num int, @bd_step int'" & vbcrlf
strSQL = strSQL & "				Set @strSQL = N'UPDATE wizmall_product_qna SET [bd_step] = [bd_step] + 1 WHERE [bd_num] = @bd_num AND [bd_step] > @bd_step'" & vbcrlf
strSQL = strSQL & "				EXEC sp_executesql @strSQL, @param, @bd_num=@bd_num, @bd_step=@bd_step;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @param = N'@bd_num int, @bd_step int, @rtn_bd_idx_num int OUTPUT'" & vbcrlf
strSQL = strSQL & "				Set @strSQL = N'SELECT @rtn_bd_idx_num = [bd_idx_num] FROM wizmall_product_qna WHERE [bd_num] = @bd_num AND [bd_step] = @bd_step'" & vbcrlf
strSQL = strSQL & "				Set @rtn_bd_idx_num = null" & vbcrlf
strSQL = strSQL & "				EXEC sp_executesql @strSQL, @param, @bd_num=@bd_num, @bd_step=@bd_step, @rtn_bd_idx_num=@rtn_bd_idx_num OUTPUT;" & vbcrlf
strSQL = strSQL & "				SELECT @rtn_bd_idx_num" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @param = N'@rtn_bd_idx_num int'" & vbcrlf
strSQL = strSQL & "				Set @strSQL = N'UPDATE wizmall_product_qna SET [bd_idx_num] = [bd_idx_num] + 1 WHERE [bd_idx_num] >= @rtn_bd_idx_num'" & vbcrlf
strSQL = strSQL & "				EXEC sp_executesql @strSQL, @param, @rtn_bd_idx_num=@rtn_bd_idx_num;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @bd_idx_num = @rtn_bd_idx_num;" & vbcrlf
strSQL = strSQL & "				--Set @bd_num;" & vbcrlf
strSQL = strSQL & "				Set @bd_step = @bd_step + 1;" & vbcrlf
strSQL = strSQL & "				Set @bd_level = @bd_level + 1;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				Set @strSQL = N'insert into	wizmall_product_qna(" & vbcrlf
strSQL = strSQL & "					pid, bd_idx_num,bd_num,bd_step, bd_level,id" & vbcrlf
strSQL = strSQL & "					,name,pass,subject" & vbcrlf
strSQL = strSQL & "					,content" & vbcrlf
strSQL = strSQL & "					,[op_flag],[count],reccount" & vbcrlf
strSQL = strSQL & "					,filename,ip,regdate" & vbcrlf
strSQL = strSQL & "					)values(" & vbcrlf
strSQL = strSQL & "					@p_pid,@p_bd_idx_num,@p_bd_num,@p_bd_step,@p_bd_level,@p_id" & vbcrlf
strSQL = strSQL & "					,@p_name,@p_pass,@p_subject" & vbcrlf
strSQL = strSQL & "					,@p_content" & vbcrlf
strSQL = strSQL & "					,@p_op_flag,@p_count,@p_reccount" & vbcrlf
strSQL = strSQL & "					,@p_filename,@p_ip,getdate()" & vbcrlf
strSQL = strSQL & "				)'" & vbcrlf
strSQL = strSQL & "" & vbcrlf

strSQL = strSQL & "		END" & vbcrlf
strSQL = strSQL & "	ELSE --qin" & vbcrlf
strSQL = strSQL & "		BEGIN" & vbcrlf
strSQL = strSQL & "			SET @param = N'@rtn_bd_idx_num int OUTPUT, @rtn_bd_num int OUTPUT'" & vbcrlf
strSQL = strSQL & "			Set @strSQL = N'SELECT TOP 1 @rtn_bd_idx_num = [bd_idx_num], @rtn_bd_num = [bd_num] FROM wizmall_product_qna ORDER BY [bd_idx_num] DESC'" & vbcrlf
strSQL = strSQL & "			EXEC sp_executesql @strSQL, @param, @rtn_bd_idx_num OUTPUT, @rtn_bd_num OUTPUT;" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "			SELECT	@rtn_bd_idx_num, @rtn_bd_num;" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "			if (@rtn_bd_idx_num is null ) Set @bd_idx_num = 1;" & vbcrlf
strSQL = strSQL & "			else Set @bd_idx_num = @rtn_bd_idx_num+1;" & vbcrlf
strSQL = strSQL & "			if (@rtn_bd_num is null ) Set @bd_num = 1;" & vbcrlf
strSQL = strSQL & "			else Set @bd_num = @rtn_bd_num+1;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "			Set @strSQL = N'insert into wizmall_product_qna(" & vbcrlf
strSQL = strSQL & "				pid,bd_idx_num,bd_num,id" & vbcrlf
strSQL = strSQL & "				,name,pass,subject" & vbcrlf
strSQL = strSQL & "				,content" & vbcrlf
strSQL = strSQL & "				,[op_flag],[count],reccount" & vbcrlf
strSQL = strSQL & "				,filename,ip,regdate" & vbcrlf
strSQL = strSQL & "				)values(" & vbcrlf
strSQL = strSQL & "				@p_pid,@p_bd_idx_num,@p_bd_num,@p_id" & vbcrlf
strSQL = strSQL & "				,@p_name,@p_pass,@p_subject" & vbcrlf
strSQL = strSQL & "				,@p_content" & vbcrlf
strSQL = strSQL & "				,@p_op_flag,@p_count,@p_reccount" & vbcrlf
strSQL = strSQL & "				,@p_filename,@p_ip,getdate()" & vbcrlf
strSQL = strSQL & "			)'" & vbcrlf
strSQL = strSQL & "		End" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
	
strSQL = strSQL & "	 SET @param = N'" & vbcrlf
strSQL = strSQL & "		@p_uid int," & vbcrlf
strSQL = strSQL & "		@p_pid tinyint," & vbcrlf
strSQL = strSQL & "		@p_bd_idx_num int," & vbcrlf
strSQL = strSQL & "		@p_bd_num int," & vbcrlf
strSQL = strSQL & "		@p_bd_step int," & vbcrlf
strSQL = strSQL & "		@p_bd_level int," & vbcrlf
strSQL = strSQL & "		@p_id varchar(20)," & vbcrlf
strSQL = strSQL & "		@p_name nvarchar(30)," & vbcrlf
strSQL = strSQL & "		@p_pass varchar(20)," & vbcrlf
strSQL = strSQL & "		@p_subject nvarchar(200)," & vbcrlf
strSQL = strSQL & "		@p_content ntext," & vbcrlf
strSQL = strSQL & "		@p_op_flag varchar(20)," & vbcrlf
strSQL = strSQL & "		@p_filename varchar(250)," & vbcrlf
strSQL = strSQL & "		@p_ip varchar(15)," & vbcrlf
strSQL = strSQL & "		@p_count smallint," & vbcrlf
strSQL = strSQL & "		@p_reccount smallint," & vbcrlf
strSQL = strSQL & "		@p_replecount smallint'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
	
strSQL = strSQL & "	EXEC sp_executesql @strSQL, @param, " & vbcrlf
strSQL = strSQL & "		@p_uid = @uid," & vbcrlf
strSQL = strSQL & "		@p_pid = @pid," & vbcrlf
strSQL = strSQL & "		@p_bd_idx_num =@bd_idx_num," & vbcrlf
strSQL = strSQL & "		@p_bd_num =@bd_num," & vbcrlf
strSQL = strSQL & "		@p_bd_step =@bd_step," & vbcrlf
strSQL = strSQL & "		@p_bd_level =@bd_level," & vbcrlf
strSQL = strSQL & "		@p_id  =@id," & vbcrlf
strSQL = strSQL & "		@p_name =@name," & vbcrlf
strSQL = strSQL & "		@p_pass =@pass," & vbcrlf
strSQL = strSQL & "		@p_subject =@subject," & vbcrlf
strSQL = strSQL & "		@p_content =@content," & vbcrlf
strSQL = strSQL & "		@p_op_flag =@op_flag," & vbcrlf
strSQL = strSQL & "		@p_filename  =@filename," & vbcrlf
strSQL = strSQL & "		@p_ip =@ip," & vbcrlf
strSQL = strSQL & "		@p_count =@count," & vbcrlf
strSQL = strSQL & "		@p_reccount =@reccount," & vbcrlf
strSQL = strSQL & "		@p_replecount =@replecount;" & vbcrlf
strSQL = strSQL & "	--PRINT @strSQL;" & vbcrlf
strSQL = strSQL & "		IF @@ERROR <> 0 GOTO ERROR_HANDLER" & vbcrlf
strSQL = strSQL & "		COMMIT TRANSACTION" & vbcrlf
strSQL = strSQL & "		RETURN 1 " & vbcrlf
strSQL = strSQL & "	ERROR_HANDLER:" & vbcrlf
strSQL = strSQL & "		ROLLBACK TRANSACTION" & vbcrlf
strSQL = strSQL & "		RETURN -1" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)




strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_product_qna_list') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_product_qna_list" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,04" & vbcrlf
strSQL = strSQL & "	-- Description:	상품 QNA 리스트 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
	
strSQL = strSQL & "	CREATE PROC [dbo].[usp_product_qna_list]" & vbcrlf
strSQL = strSQL & "			@listcnt nvarchar(5) = '10'," & vbcrlf
strSQL = strSQL & "			@whereis nvarchar(200) = 'WHERE ( notice <> 1 or notice is null)'," & vbcrlf
strSQL = strSQL & "			@page nvarchar(5) ='1'," & vbcrlf
strSQL = strSQL & "			@orderby nvarchar(40) = 'ORDER BY bd_idx_num desc'," & vbcrlf
strSQL = strSQL & "			@selectfield varchar(100) = 'uid,name,content,subject,count,op_flag,filename,replecount,bd_level,regdate'" & vbcrlf
strSQL = strSQL & "			--@selectfield nvarchar(40) = '*'" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED" & vbcrlf
strSQL = strSQL & "	    SET NOCOUNT ON" & vbcrlf
strSQL = strSQL & "		DECLARE" & vbcrlf
strSQL = strSQL & "				@strSQL nvarchar(1000)," & vbcrlf
strSQL = strSQL & "				@param  nvarchar(1000)," & vbcrlf
strSQL = strSQL & "				@notincnt nvarchar(10);" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				Set @notincnt = (@page - 1) * @listcnt;" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "				Set @strSQL = N'select TOP '+@listcnt+' '+@selectfield+' from wizmall_product_qna '+@whereis+" & vbcrlf
strSQL = strSQL & "				' and uid not in (SELECT TOP '+@notincnt+' uid from wizmall_product_qna '+@whereis+' '+@orderby+') '+" & vbcrlf
strSQL = strSQL & "				@orderby;  " & vbcrlf
strSQL = strSQL & "				Exec Sp_ExecuteSQL @strSQL" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)


strSQL = "IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID=OBJECT_ID('usp_product_qna_view') AND TYPE='P')" & vbcrlf
strSQL = strSQL & "DROP PROC usp_product_qna_view" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = ""
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	-- Author:	폰돌" & vbcrlf
strSQL = strSQL & "	-- Create date: 2009,03" & vbcrlf
strSQL = strSQL & "	-- Description:	위즈보드 저장 프로시저" & vbcrlf
strSQL = strSQL & "	-- =============================================" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	CREATE PROCEDURE [dbo].[usp_product_qna_view]" & vbcrlf
strSQL = strSQL & "		@smode varchar(10) = ''," & vbcrlf
strSQL = strSQL & "		@uid int," & vbcrlf
strSQL = strSQL & "		@rtn_puid int  = 0 OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_nuid int = 0 OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_psub varchar(200) = '' OUTPUT," & vbcrlf
strSQL = strSQL & "		@rtn_nsub varchar(200) = '' OUTPUT" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "	AS" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	BEGIN	" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "	DECLARE" & vbcrlf
strSQL = strSQL & "		@strSQL nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@param nvarchar(1000)," & vbcrlf
strSQL = strSQL & "		@rsub nvarchar(50)," & vbcrlf
strSQL = strSQL & "		@ruid int;" & vbcrlf
strSQL = strSQL & "		" & vbcrlf
strSQL = strSQL & "		--BEGIN TRANSACTION" & vbcrlf
strSQL = strSQL & "		Begin Tran" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "			--등록된 게시물을 불러온다" & vbcrlf
strSQL = strSQL & "			SET @param = N'@p_uid int'" & vbcrlf
strSQL = strSQL & "			--Set @strSQL = N'select * from wizmall_product_qna  WHERE uid=@p_uid'" & vbcrlf
strSQL = strSQL & "			Set @strSQL = N'select * " & vbcrlf
strSQL = strSQL & "			from wizmall_product_qna WHERE uid=@p_uid'" & vbcrlf
strSQL = strSQL & "			EXEC sp_executesql @strSQL, @param, @p_uid = @uid;" & vbcrlf
strSQL = strSQL & "			" & vbcrlf
strSQL = strSQL & "			If (@smode <> 'edit' or @smode is null)" & vbcrlf
strSQL = strSQL & "				BEGIN" & vbcrlf
strSQL = strSQL & "					--카운팅을 올린다." & vbcrlf
strSQL = strSQL & "					SET @param = N'@p_uid int'" & vbcrlf
strSQL = strSQL & "					Set @strSQL = N'update wizmall_product_qna set count = count + 1 where uid=@p_uid'" & vbcrlf
strSQL = strSQL & "					EXEC sp_executesql @strSQL, @param, @p_uid = @uid;" & vbcrlf
strSQL = strSQL & "" & vbcrlf
strSQL = strSQL & "				END" & vbcrlf
strSQL = strSQL & "	" & vbcrlf
strSQL = strSQL & "		If (@@error <> 0)" & vbcrlf
strSQL = strSQL & "			RollBack Tran" & vbcrlf
strSQL = strSQL & "		Else" & vbcrlf
strSQL = strSQL & "			Commit Tran" & vbcrlf
strSQL = strSQL & "		RETURN" & vbcrlf
strSQL = strSQL & "	END" & vbcrlf
Call db.ExecSQL(strSQL, Nothing, DbConnect)




db.Dispose : Set db=Nothing
%>
