use db
go

-- Traer Todos los Libros
create procedure sp_getAllLibros
as 
	select titulo, subtitulo, idAutor from libro
go

-- Traer los Libros activos
create procedure sp_getActiveLibros
as 
	select titulo, subtitulo, idAutor from libro where estado = 1
go

-- Traer Libro por id
create procedure sp_getLibroById(@pk int)
as 
	select titulo, subtitulo, idAutor from libro where id=@pk
go

-- Crear Libro
create procedure sp_createLibro(@titulo varchar(100), @subtitulo varchar(100), @idAutor int)
as
begin
	insert into libro(titulo, subtitulo, idAutor, fechaCreacion, fechaActualizacion)
	values(@titulo, @subtitulo, @idAutor, GETDATE(), GETDATE())
end
go

-- Creacion de Libros
exec sp_createLibro 'Un pequeño sabio', 'Lleno de conocimiento', 1
go
exec sp_createLibro 'Pequeños artistas', 'Personitas llenas de amor', 2
go

-- Actualizacion de Libro
create procedure sp_updateLibro(@titulo varchar(100), @subtitulo varchar(100), @idAutor int, @pk int)
as
begin
	update libro set titulo=@titulo, subtitulo=@subtitulo, idAutor=@idAutor, fechaActualizacion=GETDATE()
	where id=@pk
end
go

-- Eliminar Libro
create procedure sp_deleteLibro(@pk int)
as
	delete from autor where id=@pk
go

-- Eliminacion logica Libro
create procedure sp_logicalDeleteLibro(@pk int)
as
	update libro set estado=0 where id=@pk
go

-- Verificar estado de Libro por id
create procedure sp_checkStatusLibroById(@pk int)
as
begin
	if (select estado from libro where id = @pk) = 1
		print 'Su estado es activo'
	else
		print 'Su estado es inactivo'
end
go

-- Verificar si Libro no tiene registros
create procedure sp_autorisEmpty
as
begin
	if exists(select * from libro)
		exec sp_getAllLibros
	else
		print 'Libro no tiene ningun registro'
end
go

-- Contar numero de Libro ------ Este procedimiento se ejecuta en el procedimiento sp_showCountLibro
create procedure sp_countLibro @numLibros int output
as
begin
	set @numLibros = (select count(*) from libro)
end
go

-- Mostrar numero de Libros registrados
create procedure sp_showCountLibro
as
begin
	declare @numeroLibros int
	exec sp_countLibro @numeroLibros output
	select @numeroLibros as numeroLibros
end
go


