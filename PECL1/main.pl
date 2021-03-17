% Autores: David M�rquez M�nguez, Robert Petrisor
% Fecha: 23/03/2021

:-['listado_personajes.pl'].
:-['listado_preguntas.pl'].
:-['juego_normal.pl'].

?- set_prolog_flag(character_escapes,false).

jugar:- write('________        .__                                ________        .__               '), nl,
        write('\_____  \  __ __|__| ____   ____     ____   ______ \_____  \  __ __|__| ____   ____  '), nl,
        write(' /  / \  \|  |  \  |/ __ \ /    \  _/ __ \ /  ___/  /  / \  \|  |  \  |/ __ \ /    \ '), nl,
        write('/   \_/.  \  |  /  \  ___/|   |  \ \  ___/ \___ \  /   \_/.  \  |  /  \  ___/|   |  \'), nl,
        write('\_____\ \_/____/|__|\___  >___|  /  \___  >____  > \_____\ \_/____/|__|\___  >___|  /'), nl,
        write('      \__>           \/        \/       \/     \/         \__>             \/     \/ '), nl,
        writeln(' '), nl,
        write('Escribe 1. para seleccionar el modo jugador vs maquina'), nl,
        write('Escribe 2. para seleccionar el modo jugador vs jugador'), nl,
        write('Escribe 3. para salir'), nl,
        read(X),
        comprobar_respuesta(X).
      
comprobar_respuesta(1):- listarPersonajes(ListaPersonajes),
                         write('La lista de personajes es: '),
                         writeln(ListaPersonajes),
                         writeln(''),
                         asignar_personaje(PersonajeJugador),
                         asignar_personaje(PersonajeMaquina),
                         write('Tu personaje asignado es: '),
                         writeln(PersonajeJugador),
                         personaje(PersonajeJugador,CaracteristicasPersonajeJugador),
                         write('Sus carcateristicas son: '),
                         writeln(CaracteristicasPersonajeJugador),
                         write('El personaje de la maquina es: '),
                         writeln(PersonajeMaquina),
                         listarPreguntas(ListaPreguntasJugador), listarPreguntas(ListaPreguntasMaquina),
                         listarPersonajes(ListaPersonajesJugador), listarPersonajes(ListaPersonajesMaquina),
                         jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,jugador).
                         
comprobar_respuesta(2):- listarPersonajes(ListaPersonajes),
                         write('La lista de personajes es: '),
                         writeln(ListaPersonajes),
                         writeln(''),
                         asignar_personaje(PersonajeJugador1),
                         asignar_personaje(PersonajeJugador2),
                         write('El personaje del jugador1 es: '),
                         writeln(PersonajeJugador1),
                         personaje(PersonajeJugador1,CaracteristicasPersonajeJugador1),
                         write('Sus carcateristicas son: '),
                         writeln(CaracteristicasPersonajeJugador1),
                         write('El personaje del jugador2 es: '),
                         writeln(PersonajeJugador2),
                         listarPreguntas(ListaPreguntasJugador1), listarPreguntas(ListaPreguntasJugador2),
                         listarPersonajes(ListaPersonajesJugador1), listarPersonajes(ListaPersonajesJugador2),
                         jugador_vs_jugador(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,jugador1).

comprobar_respuesta(3):- write('Hasta luego :(').

                




