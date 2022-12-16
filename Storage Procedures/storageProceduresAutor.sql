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
	select id, nombre, apellido, email from autor where estado=1
go

-- Traer Autor por id
create procedure sp_getAutorById(@pk int)
as 
	select id, nombre, apellido, email from autor where id=@pk
go

-- Crear Autor
create procedure sp_createAutor(@nombre varchar(20), @apellido varchar(20), @email varchar(50))
as
begin
	insert into autor(nombre, apellido, email, fechaCreacion, fechaActualizacion)
	values(@nombre, @apellido, @email, GETDATE(), GETDATE())
end
go

-- Creacion de Autores
exec sp_createAutor 'Bladimir', 'Medina', 'bladimir@gmail.com'
go
exec sp_createAutor 'brayan', 'chamico', 'brayanchamico2014@gmail.com'
go

-- Actualizacion de Autor
create procedure sp_updateAutor(@nombre varchar(20), @apellido varchar(20), @email varchar(50), @pk int)
as
begin
	update autor set nombre=@nombre, apellido=@apellido, email=@email, fechaActualizacion=GETDATE()
	where id=@pk
end
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

-- Verificar estado de Autor por id
create procedure sp_checkStatusAutorById(@pk int)
as
begin
	if (select estado from autor where id = @pk) = 1
		print 'Su estado es activo'
	else
		print 'Su estado es inactivo'
end
go

-- Verificar si Autor no tiene registros
create procedure sp_autorisEmpty
as
begin
	if exists(select * from autor)
		exec sp_getAllAutors
	else
		print 'Autor no tiene ningun registro'
end
go

-- Autor con cantidad de Libros
create procedure sp_autorAmountLibro
as
begin
	create table #prueba(idAutor int, numLibros int)
	insert into #prueba select autor.id, (select count(*) from libro where idAutor = autor.id) from libro inner join autor on libro.idAutor = autor.id
	select id, nombre, apellido, email, #prueba.numLibros from autor inner join #prueba on #prueba.idAutor = autor.id
end
go

-- Contar numero de Autores ------ Este procedimiento se ejecuta en el procedimiento sp_showCountAutor
create procedure sp_countAutor @numAutores int output
as
begin
	set @numAutores = (select count(*) from autor)
end
go

-- Mostrar numero de Autores registrados
create procedure sp_showCountAutor
as
begin
	declare @numeroAutores int
	exec sp_countAutor @numeroAutores output
	select @numeroAutores as numeroAutores
end
go