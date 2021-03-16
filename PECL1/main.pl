% Autor: M�rquez M�nguez, David
% Fecha: 01/03/2021

:-['listado_personajes.pl'].
:-['reglas_programa.pl'].
-['reglas_programa_avanzado.pl'].
:-['preguntas_programa.pl'].
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
        listarPersonajes(ListaPersonajes),
        caracteristicas_comunes(ListaPersonajes,[],ListaFinalOut),
        write(ListaFinalOut).
        %read(X),
        %comprobar_respuesta(X).
      
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

jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,Turno):-
                   length(ListaPersonajesJugador,Tam), Tam==1 -> nl, write('He ganado, se que eres '), write(ListaPersonajesJugador);
                   length(ListaPersonajesMaquina,Tam), Tam==1  -> nl, write('Tu ganas, ya sabias que era '), write(ListaPersonajesMaquina);

                   Turno==jugador -> turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);
                   
                   Turno==maquina -> turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);
                   
                   writeln('Error en los turnos').
                   
jugador_vs_maquina_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,Turno):-
                            length(ListaPersonajesJugador,Tam), Tam==1 -> nl, write('He ganado, se que eres '), write(ListaPersonajesJugador);
                            length(ListaPersonajesMaquina,Tam), Tam==1  -> nl, write('Tu ganas, ya sabias que era '), write(ListaPersonajesMaquina);
                            
                            Turno==jugador -> turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);

                            Turno==maquina -> turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);

                            writeln('Error en los turnos').
                   
jugador_vs_jugador(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,Turno):-
                   length(ListaPersonajesJugador1,Tam),Tam==1 -> nl, writeln('Gana el jugador2!!');
                   length(ListaPersonajesJugador2, Tam),Tam==1  -> nl, writeln('Gana el jugador1!!');

                   Turno==jugador1 -> writeln(' '),nl,
                                      write('Turno de '), write(Turno), nl,
                                      writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escr�bela con un punto al final: '),
                                      writeln(ListaPreguntasJugador1),
                                      read(X), %El jugador hace la pregunta
                                      pregunta_disponible(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,Turno,X,ListaPreguntasJugador1Out),
                                      procesar_pregunta(X,ListaPersonajesJugador2,PersonajeJugador2,ListaFinalOut), %La pregunta se procesa y la maquina contesta
                                      length(ListaFinalOut,Length),
                                      write('Me quedan '), write(Length), write(' fichas aun.'),
                                      jugador_vs_jugador(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaFinalOut,ListaPreguntasJugador1Out,ListaPreguntasJugador2,jugador2);

                   Turno==jugador2 -> writeln(' '),nl,
                                      write('Turno de '), write(Turno), nl,
                                      writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escr�bela con un punto al final: '),
                                      writeln(ListaPreguntasJugador2),
                                      read(X), %El jugador hace la pregunta
                                      pregunta_disponible(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,Turno,X,ListaPreguntasJugador2Out),
                                      procesar_pregunta(X,ListaPersonajesJugador1,PersonajeJugador1,ListaFinalOut), %La pregunta se procesa y la maquina contesta
                                      length(ListaFinalOut,Length),
                                      write('Me quedan '), write(Length), write(' fichas aun.'),
                                      jugador_vs_jugador(PersonajeJugador1,PersonajeJugador2,ListaFinalOut,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2Out,jugador1).

turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
              writeln(' '),nl,
              writeln('Es tu turno.'),
              writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escr�bela con un punto al final: '),
              writeln(ListaPreguntasJugador),
              read(X), %El jugador hace la pregunta
              pregunta_disponible(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,X,ListaPreguntasJugadorOut),
              procesar_pregunta(X,ListaPersonajesMaquina,PersonajeMaquina,ListaFinalOut), %La pregunta se procesa y la maquina contesta
              length(ListaFinalOut,Length),
              write('Me quedan '), write(Length), write(' fichas aun.'),
              jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaFinalOut,ListaPreguntasJugadorOut,ListaPreguntasMaquina,maquina).

turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
              writeln(' '),nl,
              write('Ahora te hago yo una pregunta: '),
              seleccionar_pregunta_aleatoria(X,ListaPreguntasMaquina,ListaPreguntasMaquinaOut),
              writeln(' '),
              procesar_pregunta(X,ListaPersonajesJugador,PersonajeJugador,ListaFinalOut),
              length(ListaFinalOut,Length),
              write('Aun dudo entre '), write(Length), write(' posibilidades.'),
              jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaFinalOut,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquinaOut,jugador).

                




