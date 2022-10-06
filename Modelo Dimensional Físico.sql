select * from ProyectoFinal_TT_Supermercado;

-- DimSucursal
drop table ProyectoFinal_DimSucursal;
select row_number () over (order by [Branch]) as Id_Sucursal, B.Branch as 'Nombre Sucursal', B.City as Ciudad
into ProyectoFinal_DimSucursal
from (
	select distinct Branch, City
	from ProyectoFinal_TT_Supermercado
) as B;

select * from ProyectoFinal_DimSucursal;

-- DimCliente
drop table ProyectoFinal_DimCliente;
select row_number () over (order by [Customer type], Gender) as Id_Cliente, C.[Customer type] as 'Tipo de Cliente', C.Gender as Genero
into ProyectoFinal_DimCliente
from (
	select distinct [Customer type], Gender
	from ProyectoFinal_TT_Supermercado
) as C;

select * from ProyectoFinal_DimCliente;

-- DimProducto
drop table ProyectoFinal_DimProducto;
select row_number () over (order by [Product Line], [Unit price]) as Id_Producto, P.[Product line] as 'Linea de Producto', P.[Unit price] as 'Precio Unitario'
into ProyectoFinal_DimProducto
from (
	select distinct [Product Line], [Unit price]
	from ProyectoFinal_TT_Supermercado
) as P;

select * from ProyectoFinal_DimProducto;

-- DimFecha
drop table ProyectoFinal_DimFecha
select row_number () over (order by [Date], [Time]) as Id_Fecha, D.[Date] as Dia, D.[Time] as Hora
into ProyectoFinal_DimFecha
from (
	select distinct [Date], [Time]
	from ProyectoFinal_TT_Supermercado
) as D;

select * from ProyectoFinal_DimFecha;

-- DimPago
drop table ProyectoFinal_DimPago;
select row_number () over (order by [Payment]) as Id_Pago, P.Payment as 'Tipo de Pago'
into ProyectoFinal_DimPago
from (
	select distinct Payment
	from ProyectoFinal_TT_Supermercado
) as P;

select * from ProyectoFinal_DimPago;

-- FT_Ventas
drop table FT_Ventas;
select a.[Invoice ID] as Id_Venta, s.Id_Sucursal, c.Id_Cliente, p.Id_Producto, a.Quantity as Cantidad, 
a.[Tax 5%] as Impuestos, a.Total, f.Id_Fecha, pay.Id_Pago, a.[gross income] as 'Ingresos Brutos', a.Rating as Calificacion
into FT_Ventas
from ProyectoFinal_TT_Supermercado a
inner join ProyectoFinal_DimSucursal s
on a.Branch = s.[Nombre Sucursal]
inner join ProyectoFinal_DimCliente c
on a.[Customer type] = c.[Tipo de Cliente] and a.Gender = c.Genero
inner join ProyectoFinal_DimFecha f
on a.[Date] = f.Dia and a.[Time] = f.Hora
inner join ProyectoFinal_DimProducto p
on a.[Product line] = p.[Linea de Producto] and a.[Unit price] = p.[Precio Unitario]
inner join ProyectoFinal_DimPago pay
on a.Payment = pay.[Tipo de Pago];

select * from FT_Ventas;
