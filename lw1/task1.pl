% Первая часть задания - предикаты работы со списками
my_length([], 0) . 
my_length([_|Y], N) :- my_length(Y, N1), N is N1 + 1.

my_member(A, [A|_]).
my_member(A, [_|Z]) :- my_member(A, Z).

my_append([], X, X).
my_append([A|X], Y, [A|Z]) :- my_append(X,Y,Z).

my_remove(X,[X|T],T).
my_remove(X,[Y|T],[Y|T1]):-my_remove(X,T,T1).

my_permute([],[]).
my_permute(L,[X|T]):-my_remove(X,L,R), my_permute(R,T).

my_sublist(S,L):-my_append(_,L1,L), my_append(S,_,L1).

% Задание по удалению последнего элемента списка с помощью стандартных предикатов.
del_last(L,R):- append(R,[_],L).

% Это же задание без использования стандартных предикатов.
my_del([_], []).
my_del([X|L], [X|T]) :-
    my_del(L, T).

% Предикат для вычисления числа четных элементов в списке
count_even_numbers([], 0).
count_even_numbers([H|T], Count) :-
    H mod 2 =:= 0,
    count_even_numbers(T, RestCount),
    Count is RestCount + 1.
count_even_numbers([H|T], Count) :-
    H mod 2 =\= 0,
    count_even_numbers(T, Count).

% Предикат для вычисления числа четных элементов в списке (без использования стандартных предикатов)
my_count_even_numbers([], 0).
my_count_even_numbers([H|T], Count) :- 
    is_even(H),
    my_count_even_numbers(T, RestCount),
    Count is RestCount + 1.
my_count_even_numbers([H|T], Count) :- 
    \+is_even(H),
    my_count_even_numbers(T, Count).

% Предикат для проверки, является ли число четным
is_even(X) :- X mod 2 =:= 0.

% Пример
count_even_in_two(L, R, X) :-
    my_append(L, R, Q),
    my_count_even_numbers(Q, X).
