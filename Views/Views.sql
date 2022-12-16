use db
go

-- Vista de Libros con su respectivo autor
create view view_libroWithAutor with encryption
as
	select libro.titulo, libro.subtitulo, libro.idAutor, autor.nombre, autor.apellido, autor.email
	from libro inner join autor on idAutor = autor.id
go
