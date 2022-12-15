use db
go

create table autor(
	id int identity(1,1) primary key,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	email varchar(50),
	estado bit default(1),
	fechaCreacion date not null,
	fechaActualizacion date not null
)
go

create table libro(
	id int identity(1,1) primary key,
	titulo varchar(100) not null,
	subtitulo varchar(100) not null,
	idAutor int not null,
	estado bit default(1),
	fechaCreacion date not null,
	fechaActualizacion date not null,
	constraint fk_autor foreign key (idAutor) references autor (id)
)
go
