if not exists (select * from SYS.TABLES SysTables where SysTables.Name = 'CreditCards')
begin
    create table dbo.CreditCards(
        CreditCardId int not null primary key identity(1,1),
        ExpirationDate datetime default(null),
        CardHolderName varchar(200) not null,
        EmployeeId int references dbo.Employees(EmployeeID)
        );
end