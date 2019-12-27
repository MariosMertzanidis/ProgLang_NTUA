%%%%%%%%%%%%%%%%%%%% from https://www.swi-prolog.org/pldoc/doc/_SWI_/library/rbtrees.pl?show=src#rb_new/1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


rb_new(t(Nil,Nil)) :-
      Nil = black('',_,_,'').


rb_lookup(Key, Val, t(_,Tree)) :-
      lookup(Key, Val, Tree).

  lookup(_, _, black('',_,_,'')) :- !, fail.
  lookup(Key, Val, Tree) :-
      arg(2,Tree,KA),
      compare(Cmp,KA,Key),
      lookup(Cmp,Key,Val,Tree).

  lookup(>, K, V, Tree) :-
      arg(1,Tree,NTree),
      lookup(K, V, NTree).
  lookup(<, K, V, Tree) :-
      arg(4,Tree,NTree),
      lookup(K, V, NTree).
  lookup(=, _, V, Tree) :-
      arg(3,Tree,V).


rb_update(t(Nil,OldTree), Key, OldVal, Val, t(Nil,NewTree)) :-
      update(OldTree, Key, OldVal, Val, NewTree).

  rb_update(t(Nil,OldTree), Key, Val, t(Nil,NewTree)) :-
      update(OldTree, Key, _, Val, NewTree).

  update(black(Left,Key0,Val0,Right), Key, OldVal, Val, NewTree) :-
      Left \= [],
      compare(Cmp,Key0,Key),
      (   Cmp == (=)
      ->  OldVal = Val0,
          NewTree = black(Left,Key0,Val,Right)
      ;   Cmp == (>)
      ->  NewTree = black(NewLeft,Key0,Val0,Right),
          update(Left, Key, OldVal, Val, NewLeft)
      ;   NewTree = black(Left,Key0,Val0,NewRight),
          update(Right, Key, OldVal, Val, NewRight)
      ).
  update(red(Left,Key0,Val0,Right), Key, OldVal, Val, NewTree) :-
      compare(Cmp,Key0,Key),
      (   Cmp == (=)
      ->  OldVal = Val0,
          NewTree = red(Left,Key0,Val,Right)
      ;   Cmp == (>)
      ->  NewTree = red(NewLeft,Key0,Val0,Right),
          update(Left, Key, OldVal, Val, NewLeft)
      ;   NewTree = red(Left,Key0,Val0,NewRight),
          update(Right, Key, OldVal, Val, NewRight)
      ).

fix_root(black(L,K,V,R),black(L,K,V,R)).
  fix_root(red(L,K,V,R),black(L,K,V,R)).

rb_insert(t(Nil,Tree0),Key,Val,t(Nil,Tree)) :-
      insert(Tree0,Key,Val,Nil,Tree).

fix_left(done,T,T,done) :- !.
  fix_left(not_done,Tmp,Final,Done) :-
      fix_left(Tmp,Final,Done).


fix_left(black(red(Al,AK,AV,red(Be,BK,BV,Ga)),KC,VC,red(De,KD,VD,Ep)),
        red(black(Al,AK,AV,red(Be,BK,BV,Ga)),KC,VC,black(De,KD,VD,Ep)),
        not_done) :- !.
fix_left(black(red(red(Al,KA,VA,Be),KB,VB,Ga),KC,VC,red(De,KD,VD,Ep)),
        red(black(red(Al,KA,VA,Be),KB,VB,Ga),KC,VC,black(De,KD,VD,Ep)),
        not_done) :- !.

fix_left(black(red(Al,KA,VA,red(Be,KB,VB,Ga)),KC,VC,De),
        black(red(Al,KA,VA,Be),KB,VB,red(Ga,KC,VC,De)),
        done) :- !.

fix_left(black(red(red(Al,KA,VA,Be),KB,VB,Ga),KC,VC,De),
        black(red(Al,KA,VA,Be),KB,VB,red(Ga,KC,VC,De)),
        done) :- !.

fix_left(T,T,done).


fix_right(done,T,T,done) :- !.
fix_right(not_done,Tmp,Final,Done) :-
    fix_right(Tmp,Final,Done).


fix_right(black(red(Ep,KD,VD,De),KC,VC,red(red(Ga,KB,VB,Be),KA,VA,Al)),
          red(black(Ep,KD,VD,De),KC,VC,black(red(Ga,KB,VB,Be),KA,VA,Al)),
          not_done) :- !.
fix_right(black(red(Ep,KD,VD,De),KC,VC,red(Ga,Ka,Va,red(Be,KB,VB,Al))),
          red(black(Ep,KD,VD,De),KC,VC,black(Ga,Ka,Va,red(Be,KB,VB,Al))),
          not_done) :- !.

fix_right(black(De,KC,VC,red(red(Ga,KB,VB,Be),KA,VA,Al)),
          black(red(De,KC,VC,Ga),KB,VB,red(Be,KA,VA,Al)),
          done) :- !.



fix_right(black(De,KC,VC,red(Ga,KB,VB,red(Be,KA,VA,Al))),
          black(red(De,KC,VC,Ga),KB,VB,red(Be,KA,VA,Al)),
      done) :- !.


fix_right(T,T,done).




insert(Tree0,Key,Val,Nil,Tree) :-
    insert2(Tree0,Key,Val,Nil,TreeI,_),
    fix_root(TreeI,Tree).

insert2(black('',_,_,''), K, V, Nil, T, Status) :-
    !,
    T = red(Nil,K,V,Nil),
    Status = not_done.
insert2(red(L,K0,V0,R), K, V, Nil, NT, Flag) :-
    (   K @< K0
    ->  NT = red(NL,K0,V0,R),
        insert2(L, K, V, Nil, NL, Flag)
    ;   K == K0
    ->  NT = red(L,K0,V,R),
        Flag = done
    ;   NT = red(L,K0,V0,NR),
        insert2(R, K, V, Nil, NR, Flag)
    ).
insert2(black(L,K0,V0,R), K, V, Nil, NT, Flag) :-
    (   K @< K0
    ->  insert2(L, K, V, Nil, IL, Flag0),
        fix_left(Flag0, black(IL,K0,V0,R), NT, Flag)
    ;   K == K0
    ->  NT = black(L,K0,V,R),
        Flag = done
    ;   insert2(R, K, V, Nil, IR, Flag0),
        fix_right(Flag0, black(L,K0,V0,IR), NT, Flag)
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

read_input(File, N, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

help_create_tree(0,Tree, Answer):-
  Answer=Tree.

help_create_tree(K, Tree, Answer) :-
  rb_insert(Tree,K, 0, NTree),
  NK is K-1,
  help_create_tree(NK,NTree, Answer).

create_tree(K,Tree):-
  rb_new(NTree),
  help_create_tree(K,NTree,Tree).

help_color(_, _, [], _, Best, Sofar, K, Answer):-
  Sofar \= K,
  Answer=Best.

%help_color(_, _, [], _, Best, Sofar, K, Answer):-
%  once(Sofar \= K),
%  Answer=Best.

help_color(Tree, [L|Llist], [], Counter, Best, Sofar, K, Answer):-
  Sofar=K,
  rb_lookup(L,Value,Tree),
              NCounter is Counter-1,
            (Value=1-> rb_update(Tree,L,0,Ntree),
                        NSofar is Sofar-1,
                      (Counter<Best-> help_color(Ntree,Llist,[], NCounter, Counter, NSofar, K, Answer)
                        ;help_color(Ntree,Llist,[], NCounter, Best, NSofar, K, Answer))
            ;NValue is Value-1,
            rb_update(Tree,L,NValue,Ntree),
            help_color(Ntree,Llist,[], NCounter, Best, Sofar, K, Answer)).

help_color(Tree, [L|Llist], [R|Rlist], Counter, Best, Sofar, K, Answer):-
  (Sofar=K-> rb_lookup(L,Value,Tree),
              NCounter is Counter-1,
            (Value=1-> rb_update(Tree,L,0,Ntree),
                        NSofar is Sofar-1,
                      (Counter<Best-> help_color(Ntree,Llist,[R|Rlist], NCounter, Counter, NSofar, K, Answer)
                        ;help_color(Ntree,Llist,[R|Rlist], NCounter, Best, NSofar, K, Answer))
            ;NValue is Value-1,
            rb_update(Tree,L,NValue,Ntree),
            help_color(Ntree,Llist,[R|Rlist], NCounter, Best, Sofar, K, Answer))
  ; rb_lookup(R,Value,Tree),
  NCounter is Counter+1,
    (Value=0-> NSofar is Sofar+1,
              rb_update(Tree,R,1,Ntree),
              help_color(Ntree,[L|Llist],Rlist, NCounter, Best, NSofar,K, Answer)
    ; NValue is Value+1,
      rb_update(Tree,R,NValue,Ntree),
      help_color(Ntree,[L|Llist],Rlist, NCounter, Best, Sofar,K, Answer)
    )).

colors(File, Answer):-
  read_input(File, N, K, C),
  create_tree(K,Tree),
  Best is N+1,
  help_color(Tree,C,C,0,Best,0,K, Apantisi),
  (Apantisi=Best-> Answer=0
  ;Answer=Apantisi),!.
