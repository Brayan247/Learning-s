use db
go

-- Traer todos los Autores
create procedure sp_getAllAutors
as 
	select id, nombre, apellido, email from autor
go

-- Traer los Autores activos
create procedure sp_getActiveAutors
as 
	select id, nombre, apellido, email from autor where id=1
go

-- Traer Autor por id
create procedure sp_getAutorById(@pk int)
as 
	select id, nombre, apellido, email from autor where id=@pk
go

-- Crear Autor
create procedure sp_createAutor(@nombre varchar(20), @apellido varchar(20), @email varchar(50))
as
	insert into autor(nombre, apellido, email, fechaCreacion, fechaActualizacion)
	values(@nombre, @apellido, @email, GETDATE(), GETDATE())
go

-- Creacion de Autores
exec sp_createAutor 'Bladimir', 'Medina', 'bladimir@gmail.com'
go
exec sp_createAutor 'brayan', 'chamico', 'brayanchamico2014@gmail.com'
go

-- Actualizacion de Autor
create procedure sp_updateAutor(@nombre varchar(20), @apellido varchar(20), @email varchar(50), @pk int)
as
	update autor set nombre=@nombre, apellido=@apellido, email=@email, fechaActualizacion=GETDATE()
	where id=@pk
go

-- Eliminar Autor
create procedure sp_deleteAutor(@pk int)
as
	delete from autor where id=@pk
go

-- Eliminacion logica Autor
create procedure sp_logicalDeleteAutor(@pk int)
as
	update autor set estado=0 where id=@pk
go
