use Northwind;

--2.1.1
--Найти общую сумму всех заказов из таблицы Order Details с учетом количества закупленных товаров
--и скидок по ним.
--Результатом запроса должна быть одна запись с одной колонкой с названием колонки 'Totals'.
select sum (Quantity * UnitPrice * (1 - Discount)) as Totals
from [Order Details]

--2.1.2
--По таблице Orders найти количество заказов, которые еще не были доставлены
--(т.е. в колонке ShippedDate нет значения даты доставки).
--Использовать при этом запросе только оператор COUNT. Не использовать предложения WHERE и GROUP.
select count(*) - count(ShippedDate)
from Orders

--2.1.3
--По таблице Orders найти количество различных покупателей (CustomerID), сделавших заказы.
--Использовать функцию COUNT и не использовать предложения WHERE и GROUP
select count(distinct CustomerID)
from Orders

--2.2.1
--По таблице Orders найти количество заказов с группировкой по годам.
--В результатах запроса надо возвращать две колонки c названиями Year и Total.
--Написать проверочный запрос, который вычисляет количество всех заказов.
select year(OrderDate) as 'Year', count(OrderId) as 'Orders'
from Orders
group by year(OrderDate);

--2.2.2
--По таблице Orders найти количество заказов, cделанных каждым продавцом.
--Заказ для указанного продавца – это любая запись в таблице Orders,
--где в колонке EmployeeID задано значение для данного продавца.
--В результатах запроса надо возвращать колонку с именем продавца
--(Должно высвечиваться имя полученное конкатенацией LastName & FirstName.
--Эта строка LastName & FirstName должна быть получена отдельным запросом
--в колонке основного запроса. Также основной запрос должен использовать группировку по EmployeeID.)
--с названием колонки ‘Seller’ и колонку c количеством заказов возвращать с названием 'Amount'.
--Результаты запроса должны быть упорядочены по убыванию количества заказов.
select
	(select concat(LastName, ' ', FirstName)
	from Employees
	where Employees.EmployeeID = Orders.EmployeeID) as 'Seller',
count(OrderID) as 'Amount'
from Orders
group by EmployeeID
order by 'Amount' desc

--2.2.3
--По таблице Orders найти количество заказов, сделанных каждым продавцом и для каждого покупателя.
--Необходимо определить это только для заказов, сделанных в 1998 году.
select count(OrderID) as 'Orders count', EmployeeID, CustomerID
from Orders
where year(OrderDate) = 1998
group by EmployeeID, CustomerID

--2.2.4
--Найти покупателей и продавцов, которые живут в одном городе.
--Если в городе живут только один или несколько продавцов, или только один или несколько покупателей,
--то информация о таких покупателя и продавцах не должна попадать в результирующий набор.
--Не использовать конструкцию JOIN.
select CustomerID, EmployeeID, City
from Customers
cross apply (select EmployeeID
			from Employees
			where Employees.City = Customers.City) Employees


--2.2.5
--Найти всех покупателей, которые живут в одном городе.
select ContactName, City
from Customers
group by City, ContactName


--2.2.6
--По таблице Employees найти для каждого продавца его руководителя
select EmployeesT.EmployeeID as 'EmployeeID', EmployeesT.FirstName as 'Seller name',(
select ManagersT.FirstName
from Employees as ManagersT
where ManagersT.EmployeeID = EmployeesT.ReportsTo) 
as 'Manager'
from Employees as EmployeesT

--2.3.1 (JOIN)
--Определить продавцов, которые обслуживают регион 'Western' (таблица Region)
select distinct EmployeesT.EmployeeId as 'EmployeeId', EmployeesT.FirstName as 'First name'
from Employees as EmployeesT
        inner join EmployeeTerritories EmployeeTerritoriesT 
            on EmployeesT.EmployeeID = EmployeeTerritoriesT.EmployeeID
        inner join Territories TerritoriesT 
            on EmployeeTerritoriesT.TerritoryID = TerritoriesT.TerritoryID
        inner join Region RegionT 
            on RegionT.RegionID = TerritoriesT.RegionID
where RegionT.RegionDescription = 'Western';

--2.3.2
--Выдать в результатах запроса имена всех заказчиков из таблицы Customers и суммарное количество их заказов из таблицы Orders.
--Принять во внимание, что у некоторых заказчиков нет заказов,
--но они также должны быть выведены в результатах запроса. Упорядочить результаты запроса по возрастанию количества заказов.
select CustomersT.ContactName as 'ContactName', count(OrdersT.OrderId) as 'OrdersCount'
from Customers as CustomersT 
    left join Orders as OrdersT 
        on CustomersT.CustomerId = OrdersT.CustomerId
group by CustomersT.CustomerID, CustomersT.ContactName
order by 'OrdersCount'

--2.4.1 (подзапросы)
--Выдать всех поставщиков (колонка CompanyName в таблице Suppliers), у которых нет хотя бы одного продукта на складе
--(UnitsInStock в таблице Products равно 0). Использовать вложенный SELECT для этого запроса с использованием оператора IN.
select CompanyName
from Suppliers 
where SupplierID in (select SupplierID
                      from Products
                      where UnitsInStock = 0)

--2.4.2
--Выдать всех продавцов, которые имеют более 150 заказов. Использовать вложенный SELECT.
select EmployeeID
from Employees 
where (select count(OrderID)
		from Orders
		where Orders.EmployeeID = Employees.EmployeeID) > 150


--2.4.3
--Выдать всех заказчиков (таблица Customers), которые не имеют ни одного заказа (подзапрос по таблице Orders).
--Использовать оператор EXISTS.
select CustomerId
from Customers 
where not exists (select OrderId 
                    from Orders  
                    where Orders.CustomerID = Customers.CustomerID)