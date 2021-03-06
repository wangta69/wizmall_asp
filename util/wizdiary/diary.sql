

CREATE TABLE [dbo].[Diary] (
	[cc_id] [int] IDENTITY (1, 1) NOT NULL ,
	[cc_m_id] [varchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[cc_Title] [varchar] (80) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_Position] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_Kind] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_Open] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_sDate] [smalldatetime] NULL ,
	[cc_sHour] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_sMin] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_eHour] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_eMin] [char] (2) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_Desc] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_Reid] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_ReType] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[cc_eDate] [datetime] NULL ,
	[cc_dType] [char] (1) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Diary] ADD 
	CONSTRAINT [PK_Diary] PRIMARY KEY  CLUSTERED 
	(
		[cc_id]
	)  ON [PRIMARY] 
GO

