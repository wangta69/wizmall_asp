if exists (select * from dbo.sysobjects where id = object_id(N'[piamusic].[popup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [piamusic].[popup]
GO

CREATE TABLE [piamusic].[popup] (
	[seq] [int] IDENTITY (1, 1) NOT NULL ,
	[title] [varchar] (100) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[startdate] [varchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[enddate] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[wdate] [smalldatetime] NOT NULL ,
	[memo] [text] COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[htm] [smallint] NOT NULL ,
	[isuse] [smallint] NOT NULL ,
	[strWid] [int] NULL ,
	[strHeight] [int] NULL ,
	[intscroll] [int] NULL ,
	[intcookie] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [piamusic].[popup] WITH NOCHECK ADD 
	CONSTRAINT [pk_popup] PRIMARY KEY  CLUSTERED 
	(
		[seq]
	)  ON [PRIMARY] 
GO

ALTER TABLE [piamusic].[popup] ADD 
	CONSTRAINT [DF__popup__wdate__1B0907CE] DEFAULT (getdate()) FOR [wdate]
GO



CREATE TABLE [wizpopup] (
  [uid] [int] IDENTITY (1, 1) NOT NULL ,
  [pskinname] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
  [pwidth] [int] NOT NULL ,
  [pheight] [int] NOT NULL ,
  [ptop] [int] NOT NULL ,
  [pleft] [int] NOT NULL ,
  [psubject] [varchar] (250)COLLATE Korean_Wansung_CI_AS NOT NULL ,
  [pcontents] [text] COLLATE Korean_Wansung_CI_AS NOT NULL ,
  [pattached] [varchar] (100) COLLATE Korean_Wansung_CI_AS NOT NULL ,
  [popupenable] [int] NOT NULL ,
  [options] [text] COLLATE Korean_Wansung_CI_AS NOT NULL ,
)