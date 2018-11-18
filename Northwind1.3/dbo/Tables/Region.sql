﻿CREATE TABLE [dbo].[Regions] 
	( [RegionID] [int] NOT NULL ,
	[RegionDescription] [nchar] (50) NOT NULL 
) ON [PRIMARY]
GO
ALTER TABLE [Regions]
	ADD CONSTRAINT [PK_Region] PRIMARY KEY  NONCLUSTERED 
	(
		[RegionID]
	)  ON [PRIMARY]