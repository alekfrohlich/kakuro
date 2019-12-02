% constraint logic programming over finite domains CLP(FD)
:- use_module(library(clpfd)).
:- [board].
:- set_prolog_flag(verbose, silent).
:- initialization main.

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
    problem(Rows),
    maplist(checkWhiteLine, Rows),
    % get columns
    transpose(Rows, Columns),
    % apply constraints over rows and columns
    maplist(checkRawLineSequence, Rows),
    maplist(checkRawColSequence, Columns).
%

%
% print rows
printRow(Row) :-
    maplist(labeling([ff]), Row).
%

%
% entry point
main :-
    kakuro(Rows), maplist(printRow, Rows), maplist(writeln, Rows).
