% constraint logic programming over finite domains CLP(FD)
:- use_module(library(clpfd)).
:- use_module(library(lists)).


% constraint white cells to [1,9]
checkWhiteLine(Line) :-
    maplist(checkWhite, Line).
checkWhite([Color,First,_]) :-
    (Color #= 0, !);
    First in 1..9.
%

%
% retrieves guided white sequence as a list of list:
% Sequences = [[Black, w1, ..., wn], [Black2],
%       [Black3, w31, ..., w3n], ..., [Blackn, wn1, ..., wnn]]
% ehLineGetSequence(Sequnce, SmallList, [[0,0,17], [1,12,32]]).
% [[0,0,17], [1,12,32], [1,13,15], [0,22,11], [1,14,16], [0,15,29]]
ehLineGetSequence([],[],[]) :- !.
ehLineGetSequence(BigList, SmallList, [[Color, First, Second]|T3]) :-
    ehLineGetSequence(NewBigList, NewSmallList, T3),
    (
        (Color #= 0, BigList = [[Second|NewSmallList]|NewBigList], SmallList = [], !) ;
        (SmallList = [First|NewSmallList], BigList = NewBigList)
    ).

ehColGetSequence([],[],[]) :- !.
ehColGetSequence(BigList, SmallList, [[Color, First, _]|T3]) :-
    ehColGetSequence(NewBigList, NewSmallList, T3),
    (
        (Color #= 0, BigList = [[First|NewSmallList]|NewBigList], SmallList = [], !);
        (SmallList = [First|NewSmallList], BigList = NewBigList)
    ).
%

%
% retrieve guided white sequences
getLineSequence(RawSequence, Sequences) :-
    ehLineGetSequence(Sequences, [], RawSequence).

getColSequence(RawSequence, Sequences) :-
    ehColGetSequence(Sequences, [], RawSequence).
%

%
% constraint sum and repetition of sequence.
checkRawLineSequence(RawSequence) :-
    getLineSequence(RawSequence, Sequences),
    maplist(checkSequence, Sequences).

checkRawColSequence(RawSequence) :-
    getColSequence(RawSequence, Sequences),
    maplist(checkSequence, Sequences).

% checkSequence([17,X1,X2]).

checkSequence([_]) :- !.
checkSequence([Black|Whites]) :-
    all_different(Whites),
    sum(Whites, #=, Black).
%

%
% solves kakuro board
kakuro(Rows) :-
    % make sure white cells are in [1,9]
    maplist(checkWhiteLine, Rows),
    % get columns
    transpose(Rows, Columns),
    % apply constraints over rows and columns
    maplist(checkRawLineSequence, Rows),
    maplist(checkRawColSequence, Columns).

problem(1, Rows) :-
    Rows = ([[[0,0,0], [0,12,0], [0,21,0], [0,0,0], [0,16,0], [0,13,0]]
            ,[[0,0,17], [1,_,0], [1,_,0], [0,22,11], [1,_,0], [1,_,0]]
            ,[[0,0,15], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [1,_,0]]
            ,[[0,0,0], [0,4,13], [1,_,0], [1,_,0], [1,_,0], [0,10,0]]
            ,[[0,0,18], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [1,_,0]]
            ,[[0,0,10], [1,_,0], [1,_,0], [0,0,14], [1,_,0], [1,_,0]]]).
%

%
% print rows
printRow(Row) :-
    maplist(labeling([ff]), Row).
% problem(1, Rows), kakuro(Rows), maplist(printRow, Rows), maplist(writeln, Rows).

% [[[0,0,0], [0,14,0], [0,29,0], [0,10,0], [0,0,0], [0,0,0], [0,0,0], [0,24,0], [0,16,0], [0,22,0], [0,0,0], [0,0,0]]
% ,[[0,0,23], [1,_,0], [1,_,0], [1,_,0], [0,3,0], [0,0,0], [0,12,24], [1,_,0], [1,_,0], [1,_,0], [0,24,0], [0,0,0]]
% ,[[0,0,11], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [0,6,34], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [0,17,0]]
% ,[[0,0,13], [1,_,0], [1,_,0], [0,39,16], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [0,9,19], [1,_,0], [1,_,0], [1,_,0]]
% ,[[0,0,0], [0,0,16], [1,_,0], [1,_,0], [0,4,3], [1,_,0], [1,_,0], [0,7,29], [1,_,0], [1,_,0], [1,_,0], [1,_,0]]
% ,[[0,0,0], [0,4,0], [0,7,8], [1,_,0], [1,_,0], [1,_,0], [0,10,7], [1,_,0], [1,_,0], [1,_,0], [0,10,0], [0,0,0]]
% ,[[0,0,10], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [0,6,4], [1,_,0], [1,_,0], [0,4,3], [1,_,0], [1,_,0], [0,15,0]]
% ,[[0,0,11], [1,_,0], [1,_,0], [1,_,0], [0,4,11], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [0,4,11], [1,_,0], [1,_,0]]
% ,[[0,0,0], [0,0,16], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [1,_,0], [0,0,11], [1,_,0], [1,_,0], [1,_,0], [1,_,0]]
% ,[[0,0,0], [0,0,0], [0,0,13], [1,_,0], [1,_,0], [1,_,0], [0,0,0], [0,0,0], [0,0,7], [1,_,0], [1,_,0], [1,_,0]]]
