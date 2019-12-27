empty_queue(queue(0, Q, Q)).

queue_head(queue(s(X), [H|Q], Q0), H, queue(X, Q, Q0)).

queue_last(queue(X, Q, [L|Q0]), L, queue(s(X), Q, Q0)).



help(Assoc0,NAssoc,Depth):-
  empty_queue(Assoc0),
  NDepth is Depth+1,
  trim_stacks,
  help(NAssoc,Assoc0,NDepth).

help(Assoc0,NAssoc0,Depth):-
    queue_head(Assoc0,(Key,Val1,Val2),Assoc1),
    RK is 2*Key-1,
    LK is 2*Key,
    RVal1 is Val1 div 2,
    RVal2 is Val2 div 2,
    LVal1 is Val1*3+1,
    LVal2 is Val2*3+1,
    nb_getval(goal1,Goal1),
    nb_getval(goal2,Goal2),
    ((Goal1=<RVal1 , Goal2>=RVal2) -> nb_setval(check,0),nb_setval(ans,(RK,Depth)), fail; true),
    ((Goal1=<LVal1 , Goal2>=LVal2) -> nb_setval(check,0),nb_setval(ans,(LK,Depth)), fail; true),
    (\+seen(RVal1,RVal2)->queue_last(NAssoc0,(RK,RVal1,RVal2),NAssoc1),assertz(seen(RVal1,RVal2))
    ;NAssoc1=NAssoc0),
    ((LVal2<1000000,\+seen(LVal1,LVal2)) -> queue_last(NAssoc1,(LK,LVal1,LVal2),NAssoc2),assertz(seen(RVal1,RVal2))
      ; NAssoc2=NAssoc1),
      help(Assoc1,NAssoc2,Depth).


find_list(_,0,[]).

find_list(Key,Depth,[L|List]):-
  NDepth is Depth-1,
  Check is Key mod 2,
  NKey is (Key+1) div 2,
  (Check=0->L=t,find_list(NKey,NDepth,List)
  ;L=h,find_list(NKey,NDepth,List)).

help_atom([],'').

help_atom([L|List],A):-
  help_atom(List,B),
  atomic_concat(L,B,A).

find_atom(Key,Depth,A):-
  find_list(Key,Depth,L),
  reverse(L,D),
  help_atom(D,A).

help_ztaloc(N1,N2,G1,G2,A):-
  empty_queue(Assoc0),
  empty_queue(NAssoc0),
  nb_setval(goal1,G1),
  nb_setval(goal2,G2),
  assertz(seen(N1,N2)),
  queue_last(Assoc0,(1,N1,N2),Assoc1),
  \+help(Assoc1,NAssoc0,1),!,
  retractall(seen(_,_)),
  nb_getval(ans,(Key,Depth)),
  find_atom(Key,Depth,A)
  .

is_bad(C,D):-
  C>=500000,
  Dif is D-C,
  ModD is D mod 3,
  (Dif=1,ModD=0
  ;Dif=0,ModD\=1
  ).


  read_input(_, 0, []).

  read_input(Stream, N, [L|List]):-
    NN is N-1,
    read_line(Stream, [A,B,C,D]),
    read_input(Stream, NN, List),
    (is_bad(C,D)-> L='Impossible'
    ;(A>=C,B=<D-> L='EMPTY'
    ;help_ztaloc(A,B,C,D,L))),!
    .

  read_line(Stream, L) :-
        read_line_to_codes(Stream, Line),
        atom_codes(Atom, Line),
        atomic_list_concat(Atoms, ' ', Atom),
        maplist(atom_number, Atoms, L).


  ztalloc(File,L):-
    open(File, read, Stream),
    read_line(Stream, [N]),
    read_input(Stream,N,L),!.
