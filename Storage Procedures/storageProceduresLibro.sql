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
	insert into libro(titulo, subtitulo, idAutor, fechaCreacion, fechaActualizacion)
	values(@titulo, @subtitulo, @idAutor, GETDATE(), GETDATE())
go

-- Creacion de Libros
exec sp_createLibro 'Un pequeño sabio', 'Lleno de conocimiento', 1
go
exec sp_createLibro 'Pequeños artistas', 'Personitas llenas de amor', 2
go

-- Actualizacion de Libro
create procedure sp_updateLibro(@titulo varchar(100), @subtitulo varchar(100), @idAutor int, @pk int)
as
	update libro set titulo=@titulo, subtitulo=@subtitulo, idAutor=@idAutor, fechaActualizacion=GETDATE()
	where id=@pk
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

