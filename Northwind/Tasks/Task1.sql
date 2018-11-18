use Northwind;

--1.1.1
--Выбрать в таблице Orders заказы, которые были доставлены после 6 мая 1998 года (колонка ShippedDate) 
--включительно и которые доставлены с ShipVia >= 2. Запрос должен возвращать только колонки OrderID,
--ShippedDate и ShipVia. 
select OrderId, ShippedDate, ShipVia
from Orders
where ShippedDate >= convert(datetime, '1998-05-06') AND ShipVia >= 2;

--1.1.2
--Написать запрос, который выводит только недоставленные заказы из таблицы Orders. 
--В результатах запроса возвращать для колонки ShippedDate вместо значений NULL строку ‘Not Shipped’ (использовать системную функцию CASЕ).
--Запрос должен возвращать только колонки OrderID и ShippedDate.
select OrderId,
case
when ShippedDate is null
then 'Not shipped' end
as 'ShippedDate'
from Orders
where ShippedDate is null

--1.1.3
--Выбрать в таблице Orders заказы, которые были доставлены после 6 мая 1998 года (ShippedDate) 
--не включая эту дату или которые еще не доставлены. В запросе должны возвращаться только колонки OrderID 
--(переименовать в Order Number) и ShippedDate (переименовать в Shipped Date). 
--В результатах запроса возвращать для колонки ShippedDate вместо значений NULL строку ‘Not Shipped’, 
--для остальных значений возвращать дату в формате по умолчанию.
select OrderId as 'Order Number',
case
when ShippedDate is null
then 'Not shipped'
end as 'Shipped Date'
from Orders
where ShippedDate > convert(datetime, '1998-05-06') or ShippedDate is null;

--1.2.1
--Выбрать из таблицы Customers всех заказчиков, проживающих в USA и Canada.
--Запрос сделать с только помощью оператора IN. Возвращать колонки с именем пользователя и названием страны в результатах запроса.
--Упорядочить результаты запроса по имени заказчиков и по месту проживания.
select ContactName, Address
from Customers
where Country in ('USA', 'Canada')
order by ContactName, Address

--1.2.2
--Выбрать из таблицы Customers всех заказчиков, не проживающих в USA и Canada. Запрос сделать с помощью оператора IN.
--Возвращать колонки с именем пользователя и названием страны в результатах запроса.
--Упорядочить результаты запроса по имени заказчиков.
select ContactName, Country
from Customers
where Country not in ('USA', 'Canada')
order by ContactName

--1.2.3
--Выбрать из таблицы Customers все страны, в которых проживают заказчики.
--Страна должна быть упомянута только один раз и список отсортирован по убыванию.
--Не использовать предложение GROUP BY. Возвращать только одну колонку в результатах запроса.
select distinct Country
from Customers
order by Country desc 

--1.3.1
--Выбрать все заказы (OrderID) из таблицы Order Details (заказы не должны повторяться),
--где встречаются продукты с количеством от 3 до 10 включительно – это колонка Quantity в таблице Order Details.
--Использовать оператор BETWEEN. Запрос должен возвращать только колонку OrderID.
select distinct OrderID
from [Order Details]
where Quantity between 3 and 10

--1.3.2
--Выбрать всех заказчиков из таблицы Customers, у которых название страны начинается на буквы из диапазона b и g.
--Использовать оператор BETWEEN. Проверить, что в результаты запроса попадает Germany. 
--Запрос должен возвращать только колонки CustomerID и Country и отсортирован по Country.
select CustomerID, Country
from Customers
where left(Country, 1) between 'b' and 'g'
order by Country

--1.3.3
--Выбрать всех заказчиков из таблицы Customers,
--у которых название страны начинается на буквы из диапазона b и g, не используя оператор BETWEEN.
select CustomerID, Country
from Customers
where left(Country, 1) >= 'b' and left(Country, 1) <= 'g'

--1.4.1
--В таблице Products найти все продукты (колонка ProductName), где встречается подстрока 'chocolade'.
--Известно, что в подстроке 'chocolade' может быть изменена одна буква 'c' в середине - найти все продукты,
--которые удовлетворяют этому условию.
select ProductName
from Products
where ProductName like '%cho_olade%'