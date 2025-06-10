

-- Create la base de datos de Stage_Northwind
create database stage_northwind;
go
-- Creaye database datamart_northwind
create database datamart_northwind;
go
-- Implementar la base de datos stage_northwind
use stage_northwind;
go
create table categoria(
	categoriaid int not null,
	nombrecategoria varchar(15)
);
go
create table clientes(
	clienteid char(5) not null,
	compania varchar(40) not null,
	ciudad varchar(15),
	region varchar (15), 
	codigopostal char(10),
	pais nvarchar(15)
);
go
create table empleado(
	empleadoid int not null,
	nombre varchar (10) not null,
	apellido varchar (20) not null,
	fechacontratacion date
);
go
create table producto(
	productoid int not null,
	nombreproducto varchar (50) not null,
	preciounitario decimal (15,2) not null
);
go
create table proveedor(
	proveedorid int not null,
	proveedornombre varchar (40) not null,
	cuidad varchar (15),
	region varchar (15),
	pais varchar (15)
);
go
create table ventas(
	clienteid char(5) not null,
	empleadocodigo int not null,
	productocodigo int not null,
	ventasorden datetime not null,
	ventasmonto decimal(15,2) not null,
	ventasunidades int not null,
	ventaspreciounitario decimal(15,2) not null,
	ventasdescuento decimal(15,2) not null
);
go
-- Crear el datamartNorthwind
use datamart_northwind;
go
create table dim_cliente(
	cliente_Skey int not null identity (1,1),
	cliente_codigoBKey char(5) not null,
	cliente_compania varchar(40) not null,
	cliente_ciudad varchar(15) not null,
	cliente_region varchar(25) not null,
	cliente_pais varchar(15) not null,
	constraint pk_dimcliente
	primary key (cliente_Skey)
);
go
create table dim_empleado(
	empleado_SKey int not null identity(1,1),
	empleado_codigoBKey int not null,
	empleado_NombreCompleto varchar (100) not null,
	constraint pk_dimempleado
	primary key (empleado_SKey)
);
go
create table dim_producto (
	producto_SKey int not null identity(1,1),
	producto_CodigoBKey int not null,
	producto_Nombre varchar(80) not null,
	producto_Categoria_nombre varchar(15) not null,
	constraint pk_dimproducto
	primary key (producto_SKey)
);
go
create table dim_tiempo(
	tiempo_SKey int not null identity(1,1),
	tiempo_fechaActual datetime not null,
	tiempo_anio int not null,
	tiempo_trimestre int not null,
	tiempo_mes int not null,
	tiempo_semana int not null,
	tiempo_diadeanio int not null,
	tiempo_diames int not null,
	tiempo_diasemana int not null
	constraint pk_dimtiempo
	primary key (tiempo_SKey)
);
go
create table fact_ventas(
	cliente_SKey int not null,
	empleado_SKey int not null,
	producto_SKey int not null,
	tiempo_SKey int not null,
	ventanas_Norden int not null,
	ventas_monto decimal (15,2) not null,
	ventas_unidades int not null,
	ventas_punitario decimal (15,2)not null,
	ventas_descuento decimal (15,2) not null,
	constraint pk_factVentas
	primary key (cliente_SKey,empleado_SKey,producto_SKey,tiempo_SKey),
	constraint fk_factventas_dimcliente
	foreign key (cliente_SKey)
	references dim_cliente(cliente_SKey),
	constraint fk_factventas_dimempleado
	foreign key (empleado_SKey)
	references dim_empleado(empleado_SKey),
	constraint fk_facventas_dimproducto
	foreign key(producto_SKey)
	references dim_producto(producto_SKey),
	constraint fk_factventas_dimtiempo
	foreign key(tiempo_SKey)
	references dim_tiempo(tiempo_SKey)
);
go
drop table fact_ventas;
go

