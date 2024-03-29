% Autores: David M�rquez M�nguez, Robert Petrisor
% Fecha: 23/03/2021

:-['listado_personajes.pl'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       PROCESAMIENTO TURNOS      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se encarga del procesamiento de turnos durante una partida de jugador contra la maquina
jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,Turno):-
                   %Se comprueba que si la partida ha acabado o no
                   length(ListaPersonajesJugador,Tam), Tam==1 -> nl, write('He ganado, se que eres '), write(ListaPersonajesJugador);
                   length(ListaPersonajesMaquina,Tam), Tam==1  -> nl, write('Tu ganas, ya sabias que era '), write(ListaPersonajesMaquina);

                   %Turno del jugador
                   Turno==jugador -> turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);

                   %Turno de la maquina
                   Turno==maquina -> turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);

                   writeln('Error en los turnos').

%Se encarga del procesamiento de turnos durante una partida de jugador contra jugador
jugador_vs_jugador(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,Turno):-
                   %Se comprueba que si la partida ha acabado o no
                   length(ListaPersonajesJugador1,Tam),Tam==1 -> nl, writeln('Gana el jugador2!!');
                   length(ListaPersonajesJugador2, Tam),Tam==1  -> nl, writeln('Gana el jugador1!!');

                   %Turno de uno de los jugadores
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

                   %Turno del otro jugador
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

%Organiza el comportamiento de un jugador durante un mismo turno
turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
              writeln(' '),nl,
              writeln('Es tu turno.'),
              writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escr�bela con un punto al final: '),
              writeln(ListaPreguntasJugador),
              read(X), %El jugador hace la pregunta
              %Se determina si la pregunta esta disponible
              pregunta_disponible(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,X,ListaPreguntasJugadorOut),
              %Se procesa la pregunta
              procesar_pregunta(X,ListaPersonajesMaquina,PersonajeMaquina,ListaFinalOut), %La pregunta se procesa y la maquina contesta
              length(ListaFinalOut,Length),
              write('Me quedan '), write(Length), write(' fichas aun.'),
              jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaFinalOut,ListaPreguntasJugadorOut,ListaPreguntasMaquina,maquina).

%Organiza el comportamiento de la maquina durante un mismo turno
turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
              writeln(' '),nl,
              write('Ahora te hago yo una pregunta: '),
              seleccionar_pregunta_aleatoria(X,ListaPreguntasMaquina,ListaPreguntasMaquinaOut),
              writeln(' '),
              procesar_pregunta(X,ListaPersonajesJugador,PersonajeJugador,ListaFinalOut),
              length(ListaFinalOut,Length),
              write('Aun dudo entre '), write(Length), write(' posibilidades.'),
              jugador_vs_maquina(PersonajeJugador,PersonajeMaquina,ListaFinalOut,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquinaOut,jugador).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              FUNCIONES          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se selecciona un personaje de forma aleatoria
asignar_personaje(Personaje):- listarPersonajes(ListaPersonajes),
                               random_select(Personaje,ListaPersonajes,_).

%Se elimina un elemtno de una lista
del(X,[X|Tail],Tail).
del(X,[Head|Tail],[Head|NewTail]):- del(X,Tail,NewTail).

%Filtra una lista dada un filtro determinado(carcateristica de un personaje)
filtrar_lista([],_,ListaFinal,ListaFinal).
filtrar_lista(Lista,Filtro,ListaFinal,ListaFinalOut):- personaje(X,Z), member(Filtro,Z), member(X, Lista), not(member(X, ListaFinal)),
                                                       append(ListaFinal, [X] , NuevaListaFinal),
                                                       subtract(Lista,[X],NuevaLista),
                                                       filtrar_lista(NuevaLista,Filtro,NuevaListaFinal, ListaFinalOut);
                                                       subtract(Lista,[_],NuevaLista),
                                                       filtrar_lista(NuevaLista,Filtro,ListaFinal, ListaFinalOut).
                                                       
%Se procesa la pregunta realizada
procesar_pregunta(X,ListaPersonajes,Personaje,ListaFinalOut):-
                  X==es_chico -> es_chico(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==es_chica -> es_chica(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==pelo_negro -> pelo_negro(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==pelo_rubio -> pelo_rubio(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==ropa_verde -> ropa_verde(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==ropa_roja -> ropa_roja(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==feliz -> feliz(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==triste -> triste(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==gafas -> gafas(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==ojos_azules -> ojos_azules(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==ojos_marrones -> ojos_marrones(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==joven -> joven(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==anciano -> anciano(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==con_sombrero -> con_sombrero(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==sin_sombrero -> sin_sombrero(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  X==barba -> barba(ListaPersonajes,ListaFinalOut,[],_,Personaje);

                  writeln('Error al escribir la pregunta.'),
                  fail.

%Determina si una determinada pregunta esta disponible
pregunta_disponible(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,Pregunta,ListaPreguntasJugadorOut):-
                   %Si la pregunta es cuestion se encuentra dentro de la lista de pregunta, se elimina
                    member(Pregunta,ListaPreguntasJugador) -> del(Pregunta,ListaPreguntasJugador,ListaPreguntasJugadorOut);

                    writeln('Debes seleccionar una pregunta valida!'),
                    turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina).

pregunta_disponible(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,Turno,Pregunta,ListaPreguntasJugadorOut):-
                    %Dependiendo dle turno del jugador, se determina si la pregunta esta disponible o no
                    Turno==jugador1, member(Pregunta,ListaPreguntasJugador1) -> del(Pregunta,ListaPreguntasJugador1,ListaPreguntasJugadorOut);
                    Turno==jugador2, member(Pregunta,ListaPreguntasJugador2) -> del(Pregunta,ListaPreguntasJugador2,ListaPreguntasJugadorOut);

                    writeln('Debes seleccionar una pregunta valida!'),
                    jugador_vs_jugador(PersonajeJugador1,PersonajeJugador2,ListaPersonajesJugador1,ListaPersonajesJugador2,ListaPreguntasJugador1,ListaPreguntasJugador2,Turno).

%Se procesa la respuesta
procesar_respuesta(ListaFinalOut,Respuesta):-
                                              %Si la respuesta a la pregunta es afirmativa
                                              Respuesta==1 -> writeln('La respuesta a la pregunta es afirmativa'),
                                              writeln('Puede ser uno de los personajes de esta lista: '),
                                              writeln(ListaFinalOut);
                                              
                                              %Si la respuesta  la pregunta es negativa
                                              Respuesta==2 -> writeln('La respuesta a la pregunta es negativa'),
                                              writeln('Puede ser uno de los personajes de esta lista: '),
                                              writeln(ListaFinalOut).
                                              
%Del grupo de preguntas disponibles, se selecciona una de forma aleatoria
seleccionar_pregunta_aleatoria(X,ListaPreguntas,ListaPreguntasOut):- random_member(X,ListaPreguntas),
                                                                     write(X),
                                                                     del(X,ListaPreguntas,ListaPreguntasOut).
                                                                     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    PROCESAMIENTO DE PREGUNTAS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

procesar_opcion_es_chico(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('masculino',Z) -> filtrar_lista(Lista,'masculino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['masculino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,1);

                                                                           filtrar_lista(Lista,'femenino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['femenino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,2).

procesar_opcion_es_chica(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('femenino',Z) -> filtrar_lista(Lista,'femenino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['femenino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,1);

                                                                           filtrar_lista(Lista,'masculino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['masculino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,2).
                                                                          
procesar_opcion_pelo_negro(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('pelo_negro',Z) -> filtrar_lista(Lista,'pelo_negro',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_negro'],L2),
                                                                             procesar_respuesta(ListaFinalOut,1);

                                                                             filtrar_lista(Lista,'pelo_rubio',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_rubio'],L2),
                                                                             procesar_respuesta(ListaFinalOut,2).

procesar_opcion_pelo_rubio(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('pelo_rubio',Z) -> filtrar_lista(Lista,'pelo_rubio',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_rubio'],L2),
                                                                             procesar_respuesta(ListaFinalOut,1);

                                                                             filtrar_lista(Lista,'pelo_negro',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_negro'],L2),
                                                                             procesar_respuesta(ListaFinalOut,2).
                                                                            
procesar_opcion_ropa_roja(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ropa_roja',Z) -> filtrar_lista(Lista,'ropa_roja',ListaFinal,ListaFinalOut),
                                                                            append(L1,['ropa_roja'],L2),
                                                                            procesar_respuesta(ListaFinalOut,1);

                                                                            filtrar_lista(Lista,'ropa_verde',ListaFinal,ListaFinalOut),
                                                                            append(L1,['ropa_verde'],L2),
                                                                            procesar_respuesta(ListaFinalOut,2).


procesar_opcion_ropa_verde(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ropa_verde',Z) -> filtrar_lista(Lista,'ropa_verde',ListaFinal,ListaFinalOut),
                                                                             append(L1,['ropa_verde'],L2),
                                                                             procesar_respuesta(ListaFinalOut,1);

                                                                             filtrar_lista(Lista,'ropa_roja',ListaFinal,ListaFinalOut),
                                                                             append(L1,['ropa_roja'],L2),
                                                                             procesar_respuesta(ListaFinalOut,2).
                                                                            
procesar_opcion_feliz(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('feliz',Z) -> filtrar_lista(Lista,'feliz',ListaFinal,ListaFinalOut),
                                                                        append(L1,['feliz'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'triste',ListaFinal,ListaFinalOut),
                                                                        append(L1,['triste'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_gafas(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('con_gafas',Z) -> filtrar_lista(Lista,'con_gafas',ListaFinal,ListaFinalOut),
                                                                        append(L1,['con_gafas'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'sin_gafas',ListaFinal,ListaFinalOut),
                                                                        append(L1,['sin_gafas'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_ojos_azules(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ojos_azules',Z) -> filtrar_lista(Lista,'ojos_azules',ListaFinal,ListaFinalOut),
                                                                              append(L1,['ojos_azules'],L2),
                                                                              procesar_respuesta(ListaFinalOut,1);

                                                                              filtrar_lista(Lista,'ojos_marrones',ListaFinal,ListaFinalOut),
                                                                              append(L1,['ojos_marrones'],L2),
                                                                              procesar_respuesta(ListaFinalOut,2).
                                                                             
procesar_opcion_ojos_marrones(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ojos_marrones',Z) -> filtrar_lista(Lista,'ojos_marrones',ListaFinal,ListaFinalOut),
                                                                                append(L1,['ojos_marrones'],L2),
                                                                                procesar_respuesta(ListaFinalOut,1);

                                                                                filtrar_lista(Lista,'ojos_azules',ListaFinal,ListaFinalOut),
                                                                                append(L1,['ojos_azules'],L2),
                                                                                procesar_respuesta(ListaFinalOut,2).
                                                                               
procesar_opcion_joven(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('joven',Z) -> filtrar_lista(Lista,'joven',ListaFinal,ListaFinalOut),
                                                                        append(L1,['joven'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'anciano',ListaFinal,ListaFinalOut),
                                                                        append(L1,['anciano'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_anciano(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('anciano',Z) -> filtrar_lista(Lista,'anciano',ListaFinal,ListaFinalOut),
                                                                          append(L1,['anciano'],L2),
                                                                          procesar_respuesta(ListaFinalOut,1);

                                                                          filtrar_lista(Lista,'joven',ListaFinal,ListaFinalOut),
                                                                          append(L1,['joven'],L2),
                                                                          procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_con_sombrero(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('con_sombrero',Z) -> filtrar_lista(Lista,'con_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['con_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,1);

                                                                               filtrar_lista(Lista,'sin_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['sin_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,2).
                                                                              
procesar_opcion_sin_sombrero(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('sin_sombrero',Z) -> filtrar_lista(Lista,'sin_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['sin_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,1);

                                                                               filtrar_lista(Lista,'con_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['con_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,2).
                                                                              
procesar_opcion_barba(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('con_barba',Z) -> filtrar_lista(Lista,'con_barba',ListaFinal,ListaFinalOut),
                                                                        append(L1,['con_barba'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'sin_barba',ListaFinal,ListaFinalOut),
                                                                        append(L1,['sin_barba'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                        
