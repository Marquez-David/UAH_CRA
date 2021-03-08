% Autor: M�rquez M�nguez, David
% Fecha: 01/03/2021

%BASE DE DATOS CON LOS PERSONAJES
%personaje(nombre, [genero, color pelo, color ropa, estado animico, gafas?, color ojos, edad, sombrero?, barba?]).

personaje('Albert', ['masculino', 'pelo_negro', 'ropa_roja', 'feliz', 'con_gafas', 'ojos_azules', 'joven', 'sin_sombrero', 'con_barba']).
personaje('Paul', ['masculino', 'pelo_rubio', 'ropa_roja', triste, 'sin_gafas', 'ojos_marrones', 'anciano', 'sin_sombrero', 'sin_barba']).
personaje('Tom', ['masculino', 'pelo_negro', 'ropa_verde', 'feliz', 'sin_gafas', 'ojos_marrones', 'joven', 'sin_sombrero', 'con_barba']).
personaje('Richard', ['masculino', 'pelo_negro', 'ropa_verde', 'triste', 'sin_gafas', 'ojos_marrones', 'joven', 'con_sombrero', 'con_barba']).
personaje('Louis', ['masculino', 'pelo_negro', 'ropa_roja', 'triste', 'sin_gafas', 'ojos_azules', 'joven', 'sin_sombrero', 'con_barba']).
personaje('Michael', ['masculino', 'pelo_rubio', 'ropa_verde', 'feliz', 'con_gafas', 'ojos_marrones', 'anciano', 'sin_sombrero', 'sin_barba']).
personaje('Charles', ['masculino', 'pelo_negro', 'ropa_verde', 'feliz', 'con_gafas', 'ojos_marrones', 'joven', 'sin_sombrero', 'sin_barba']).
personaje('Sam', ['masculino', 'pelo_rubio', 'ropa_roja', 'triste', 'sin_gafas', 'ojos_azules', 'anciano', 'con_sombrero', 'con_barba']).
personaje('Steve', ['masculino', 'pelo_negro', 'ropa_roja', 'feliz', 'sin_gafas', 'ojos_marrones', 'anciano', 'con_sombrero', 'con_barba']).
personaje('Will', ['masculino', 'pelo_rubio', 'ropa_verde', 'feliz', 'sin_gafas', 'ojos_azules', 'joven', 'sin_sombrero', 'sin_barba']).
personaje('Anthony', ['masculino', 'pelo_rubio', 'ropa_roja', 'feliz', 'con_gafas', 'ojos_marrones', 'joven', 'sin_sombrero', 'sin_barba']).
personaje('Billy', ['masculino', 'pelo_rubio', 'ropa_verde', 'triste', 'sin_gafas', 'ojos_azules', 'anciano', 'sin_sombrero', 'con_barba']).
personaje('Henry', ['masculino', 'pelo_negro', 'ropa_roja', 'triste', 'sin_gafas', 'ojos_marrones', 'joven', 'con_sombrero', 'sin_barba']).
personaje('Tiffany', ['femenino', 'pelo_negro', 'ropa_verde', 'feliz', 'sin_gafas', 'ojos_marrones', 'joven', 'sin_sombrero', 'sin_barba']).
personaje('Natalie', ['femenino', 'pelo_rubio', 'ropa_roja', 'feliz', 'con_gafas', 'ojos_azules', 'joven', 'sin_sombrero', 'sin_barba']).
personaje('Roxanne', ['femenino', 'pelo_rubio', 'ropa_verde', 'feliz', 'sin_gafas', 'ojos_azules', 'anciano', 'sin_sombrero', 'sin_barba']).
personaje('Sarah', ['femenino', 'pelo_negro', 'ropa_roja', 'triste', 'sin_gafas', 'ojos_marrones', 'anciano', 'sin_sombrero', 'sin_barba']).
personaje('Sabrina', ['femenino', 'pelo_negro', 'ropa_verde', 'feliz', 'con_gafas', 'ojos_azules', 'anciano', 'sin_sombrero', 'sin_barba']).
personaje('Cindy', ['femenino', 'pelo_negro', 'ropa_roja', 'feliz', 'sin_gafas', 'ojos_marrones', 'joven', 'con_sombrero', 'sin_barba']).
personaje('Emma', ['femenino', 'pelo_rubio', 'ropa_verde', 'feliz', 'sin_gafas', 'ojos_marrones', 'joven', 'con_sombrero', 'sin_barba']).

listarPersonajes(ListaPersonajes):- listarAux([], ListaPersonajes),!.
listarAux(Y,Z):- personaje(Personaje,_), not(member(Personaje,Y)), listarAux([Personaje|Y],Z).
listarAux(X,X).

