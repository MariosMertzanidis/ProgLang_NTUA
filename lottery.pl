update(A,0,0,Ntree):-
  integer(A),
  Ntree is A+1.

update(tree(N,A,B,C,D,E,F,G,H,I,J),Num,K,Ntree):-
  Temp is mod(Num,10),
  Tempb is Num-Temp,
  NNum is Tempb//10,
  NK is K-1,
  NN is N+1,
  (Temp =:= 0->
    update(A,NNum,NK,NNtree),
    Ntree=tree(NN,NNtree,B,C,D,E,F,G,H,I,J)
  ;Temp =:= 1->
    update(B,NNum,NK,NNtree),
    Ntree=tree(NN,A,NNtree,C,D,E,F,G,H,I,J)
  ;Temp =:= 2->
    update(C,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,NNtree,D,E,F,G,H,I,J)
  ;Temp =:= 3->
    update(D,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,NNtree,E,F,G,H,I,J)
  ;Temp =:= 4->
    update(E,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,D,NNtree,F,G,H,I,J)
  ;Temp =:= 5->
    update(F,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,D,E,NNtree,G,H,I,J)
  ;Temp =:= 6->
    update(G,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,D,E,F,NNtree,H,I,J)
  ;Temp =:= 7->
    update(H,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,D,E,F,G,NNtree,I,J)
  ;Temp =:= 8->
    update(I,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,D,E,F,G,H,NNtree,J)
  ;Temp =:= 9->
    update(J,NNum,NK,NNtree),
    Ntree=tree(NN,A,B,C,D,E,F,G,H,I,NNtree)
  ).

update(A,Num,K,Ntree):-
  integer(A),
  Temp is mod(Num,10),
  NNum is (Num-Temp)//10,
  NK is K-1,
  update(A,NNum,NK,NNtree),
  (Temp =:= 0->
    Ntree=tree(1,NNtree,0,0,0,0,0,0,0,0,0)
  ;Temp =:= 1->
    Ntree=tree(1,0,NNtree,0,0,0,0,0,0,0,0)
  ;Temp =:= 2->
    Ntree=tree(1,0,0,NNtree,0,0,0,0,0,0,0)
  ;Temp =:= 3->
    Ntree=tree(1,0,0,0,NNtree,0,0,0,0,0,0)
  ;Temp =:= 4->
    Ntree=tree(1,0,0,0,0,NNtree,0,0,0,0,0)
  ;Temp =:= 5->
    Ntree=tree(1,0,0,0,0,0,NNtree,0,0,0,0)
  ;Temp =:= 6->
    Ntree=tree(1,0,0,0,0,0,0,NNtree,0,0,0)
  ;Temp =:= 7->
    Ntree=tree(1,0,0,0,0,0,0,0,NNtree,0,0)
  ;Temp =:= 8->
    Ntree=tree(1,0,0,0,0,0,0,0,0,NNtree,0)
  ;Temp =:= 9->
    Ntree=tree(1,0,0,0,0,0,0,0,0,0,NNtree)).

create([],_,Tree,Ntree):- Ntree = Tree.

  create([X|List],K,Tree,NTree):-
    update(Tree,X,K,Temp),
    create(List,K,Temp,NTree).

findNum(tree(N,_,_,_,_,_,_,_,_,_,_),Answer):- Answer=N.

findNum(A,Answer):-
  integer(A),
  Answer=A.

findQuantity(tree(_,A,B,C,D,E,F,G,H,I,J),Num,Answer):-
  Temp is mod(Num,10),
  (Temp =:= 0->
    findNum(A,Answer)
  ;Temp =:= 1->
    findNum(B,Answer)
  ;Temp =:= 2->
    findNum(C,Answer)
  ;Temp =:= 3->
    findNum(D,Answer)
  ;Temp =:= 4->
    findNum(E,Answer)
  ;Temp =:= 5->
    findNum(F,Answer)
  ;Temp =:= 6->
    findNum(G,Answer)
  ;Temp =:= 7->
    findNum(H,Answer)
  ;Temp =:= 8->
    findNum(I,Answer)
  ;Temp =:= 9->
    findNum(J,Answer)
    ).

findTotal(A,_,K,Prev,Answer):-
  integer(A),
  Answer is (Prev-A)*(2^(K-1)-1)+A*(2^(K)-1).

findTotal(tree(N,A,B,C,D,E,F,G,H,I,J),LuckyNumber,K,Prev,Answer):-
  Temp is mod(LuckyNumber,10),
  NLuckyNumber is (LuckyNumber - Temp)//10,
  NK is K+1,
  (Temp =:= 0->
    findTotal(A,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 1->
    findTotal(B,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 2->
    findTotal(C,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 3->
    findTotal(D,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 4->
    findTotal(E,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 5->
    findTotal(F,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 6->
    findTotal(G,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 7->
    findTotal(H,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 8->
    findTotal(I,NLuckyNumber,NK,N,NAnswer)
  ;Temp =:= 9->
    findTotal(J,NLuckyNumber,NK,N,NAnswer)),
    (   K=\=0->
    Answer is (Prev-N)*(2^(K-1)-1)+NAnswer
    ;  Answer = NAnswer) .

  wholesaleTotal([X|List],tree(N,A,B,C,D,E,F,G,H,I,J),Answer,P):-
    findTotal(tree(N,A,B,C,D,E,F,G,H,I,J),X,0,P,TempAnswer),
    findQuantity(tree(N,A,B,C,D,E,F,G,H,I,J),X,Quantity),
    wholesaleTotal(List,tree(N,A,B,C,D,E,F,G,H,I,J),NAnswer,P),
    NTempAnswer is TempAnswer mod 1000000007,
    Answer = [[Quantity,NTempAnswer]|NAnswer].

  wholesaleTotal([],_,Answer,_):- Answer=[].


  final(PlayedList,LuckyList,K,N,Answer):-
    create(PlayedList,K,tree(0,0,0,0,0,0,0,0,0,0,0),Tree),
    wholesaleTotal(LuckyList,Tree,Answer,N),!.

  read_input(_, _, N, Q, PlayedList, LuckyList, Counter) :-
    Temp is N+Q,
    Counter =:= Temp,
    PlayedList=[],
    LuckyList=[].

    read_input(Stream, K, N, Q, PlayedList, LuckyList, Counter) :-
    (Counter<N ->
    read_line(Stream, [C]),
    NCounter is Counter+1,
    read_input(Stream, K, N, Q, NPlayedList, LuckyList, NCounter),
    PlayedList = [C|NPlayedList]
    ;read_line(Stream, [C]),
    NCounter is Counter+1,
    read_input(Stream, K, N, Q, PlayedList, NLuckyList, NCounter),
    LuckyList = [C|NLuckyList]).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

    lottery(File,L):-
      open(File, read, Stream),
      read_line(Stream, [K, N, Q]),
      read_input(Stream, K, N, Q, PlayedList, LuckyList, 0),
      final(PlayedList,LuckyList,K,N,L).
