:- use_module(library(clpfd)).

black([C,_,_]) :- C =:=0.
white([C,_,_]) :- C =:=1.
color([C,_,_], X) :- X is C.
first([_,F,_], X) :- X is F.
second([_,_,S], X) :- X is S.

addB([], []).
addB([H|T],Sequences) :-
    black(H),
    addB(T, SE),
    second(H,Elem),
    append([Elem],["-"], R),
    append(SE, R, Sequences).

addB([H|T], Sequences) :-
    white(H),
    addB(T, SE),
    second(H,Elem),
    atom_string(Elem, Stri),
    string_concat(Stri, "_", String3),
    append(SE, [String3], Sequences).

numb([],[]).
numb([H|T],I) :-
    H == "",
    numb(T,I).

numb([H|T],I) :-
    number_string(Number, H),
    numb(T,SE),
    append(SE,[Number], I).


outroSplit([],[]).
outroSplit([H|T],L) :-
    split_string(H, "_","",R),
    numb(R,I),
    outroSplit(T,SE),
    append([I],SE,L).

final(O, L) :-
    addB(O, S),
    atomics_to_string(S, F),
    split_string(F, "-","",G),
    otherSplit(G,L).

% ([[0,0,17], [1,12,32], [1,13,15], [0,22,11], [1,14,16], [0,15,29]],L).