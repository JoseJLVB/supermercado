-- Creación de Base de datos Supermercado

CREATE DATABASE supermercado;

--Requrimiento 1. Cargar el respaldo de la base de datos unidad2.sql.

psql -U postgres -f unidad2.sql supermercado 

-- Requerimiento 2. El cliente usuario01 ha realizado la siguiente compra

begin transaction;
update producto set stock = stock-5 where id=9;
insert into compra (cliente_id, fecha) values (1, now());
insert into detalle_compra (producto_id, compra_id, cantidad) values (9, (select id from compra order by fecha desc limit 1), 5);
commit;
end transaction;

-- Requerimiento 3. El cliente usuario02 ha realizado la siguiente compra:

begin transaction;
update producto set stock = stock-3 where id=1;
update producto set stock = stock-3 where id=2;
update producto set stock = stock-3 where id=8;
insert into compra (cliente_id, fecha) values (2, now());
insert into detalle_compra (producto_id, compra_id, cantidad) values (1, (select id from compra order by fecha desc limit 1), 3);
insert into detalle_compra (producto_id, compra_id, cantidad) values (2, (select id from compra order by fecha desc limit 1), 3);
insert into detalle_compra (producto_id, compra_id, cantidad) values (8, (select id from compra order by fecha desc limit 1), 3);
commit;
end transaction; -- LA TRANSACCIÓN NO SE REALIZA PORQUE EL PRODUCTO DE ID=8 NO TIENE STOCK SUFICIENTE


--4. Realizar las siguientes consultas:

\set AUTOCOMMIT off

begin;
insert into cliente (nombre, email) values ('Jose Valcarcel', 'josevalcarcel@hotmail.com');
select * from cliente;
ROLLBACK;
commit;
end transaction;

\set AUTOCOMMIT on