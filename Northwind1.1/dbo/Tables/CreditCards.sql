CREATE TABLE [dbo].[CreditCards]
(
	[Id]             INT           NOT NULL,
	[ExpirationDate] DATE          NULL,
	[CardHolder]     NVARCHAR (50) NULL,
	[EmployeeID]     INT           NULL,
	PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_CreditCards_ToEmployees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID])
)