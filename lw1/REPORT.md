# Отчет по лабораторной работе №1
## Работа со списками и реляционным представлением данных
## по курсу "Логическое программирование"

### студент: Теребаев К.Д.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение
Списки в языке Пролог отличаются тем, что у них динамическая структура, то есть можно удалять или прибавлять элементы к списку без явного указания размера списка, и что список разделён на две части: голова и хвост.
Своей динамической структорой похож на vector в C++. Так же схож с линейными списками за счет необходимости рекурсивного обхода обоих.

## Стандартные предикаты

```prolog
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
```

## Задание 1.1: Предикат обработки списка

#### На основе стандартных предикатов обработки списков

`del_last(L,R)` - Удаление последнего элемента 

Примеры использования:
```prolog
?- del_last([1,2,3,4,5], R).
R = [1, 2, 3, 4] ;
false.

?- del_last([1], R).
R = [] ;
false.
```

Реализация:
```prolog
del_last(L,R):- append(R,[_],L).
```

Удаление последнего элемента достигается путем рекурсивного использования append, разделяя исходный список на R (все элементы, кроме последнего) и последнего элемента. Процесс повторяется рекурсивно до тех пор, пока не останется пустой список, создавая эффект удаления последнего элемента.

#### Без использования стандартных предикатов

`my_del([_], [])` - Удаление последнего элемента 

Примеры использования:
```prolog
?- my_del([1,2,3,4,5],R).
R = [1, 2, 3, 4] ;
false.

?- my_del([1], R).
R = [] ;
false.
```

Реализация:
```prolog
my_del([_], []).
my_del([X|L], [X|T]) :-
    my_del(L, T).
```

В базовом случае, когда входной список состоит из одного элемента, результатом будет пустой список. В рекурсивном случае, предикат удаляет первый элемент из входного списка и рекурсивно вызывает сам себя для хвоста списка, таким образом удаляя последний элемент.

## Задание 1.2: Предикат обработки числового списка

#### На основе стандартных предикатов обработки списков

`count_even_numbers([H|T], Count)` - Вычисление числа четных элементов  

Примеры использования:
```prolog
?- count_even_numbers([1,2,4,5,6,7,8,9,0],R).
R = 5 ;
false.

?- count_even_numbers([1,5,7,9],R).
R = 0.
```

Реализация:
```prolog
count_even_numbers([], 0).
count_even_numbers([H|T], Count) :-
    H mod 2 =:= 0,
    count_even_numbers(T, RestCount),
    Count is RestCount + 1.
count_even_numbers([H|T], Count) :-
    H mod 2 =\= 0,
    count_even_numbers(T, Count).
```

Если голова (первый элемент) списка четная, он рекурсивно вызывает себя для остального списка (T) и увеличивает результат на 1. Если голова нечетная, предикат просто рекурсивно вызывает себя для остального списка, не изменяя текущий счетчик. Таким образом, после обработки всего списка, переменная Count будет содержать количество четных чисел в списке.

#### Без использования стандартных предикатов

`my_count_even_numbers([H|T], Count)` - Вычисление числа четных элементов  

Примеры использования:
```prolog
?- my_count_even_numbers([1,2,4,5,6,7,8,9,0],R).
R = 5 ;
false.

?- my_count_even_numbers([1,5,7,9],R).
R = 0.
```

Реализация:
```prolog
my_count_even_numbers([], 0).
my_count_even_numbers([H|T], Count) :- 
    is_even(H),
    my_count_even_numbers(T, RestCount),
    Count is RestCount + 1.
my_count_even_numbers([H|T], Count) :- 
    \+is_even(H),
    my_count_even_numbers(T, Count).
```

Здесь то же самое, только проверка через предикат `is_even(X)`
Реализация:
```prolog
is_even(X) :- X mod 2 =:= 0.
```

## 1.3 Пример совместного использовния

Предикат `count_even_in_few(L, R, X)` - подсчет четных элементов в двух списках

Пример использования:
```prolog
?- count_even_in_two([1,2,3], [1,2,4,6],R).
R = 4 ;
false.
```

Реализация:
```prolog
count_even_in_two(L, R, X) :-
    my_append(L, R, Q),
    my_count_even_numbers(Q, X).
```

## Задание 2: Реляционное представление данных

##### Преимущества реляционного представления данных в Прологе:
1) Простота и читаемость: Реляционное представление позволяет описывать данные в виде отношений, что делает код простым и легко читаемым.
2) Гибкость: Можно легко добавлять новые отношения и связи между данными, не меняя структуру базы данных.
3) Универсальность: Реляционное представление подходит для различных типов данных и предметных областей.
##### Недостатки реляционного представления данных в Прологе:
1) Эффективность: При больших объемах данных операции могут быть неэффективными из-за поиска в глубину.
2) Сложность запросов: Некоторые сложные запросы могут потребовать глубокого понимания языка и структуры данных.

### Вариант 1
1) Получить таблицу групп и средний балл по каждой из групп

Предикат `group_average(Group, Average)` - Получить средний балл группы

Примеры использования:
```prolog
?- group_average(102, R).
R = 3.7777777777777777.

?- group_average(104, R).
R = 3.861111111111111.

?- group_average(103, R).
R = 3.7708333333333335.
```

Реализация:
```prolog
group_average(Group, Average) :-
    findall(Grade, (student(Group, Name), grade(Name, _, Grade)), Grades),
    length(Grades, NumGrades),
    (NumGrades > 0 -> sum_list(Grades, Total), Average is Total / NumGrades; Average is 0).
```
Предикат собирает все оценки учащихся из определенной группы. Затем он вычисляет общий балл и делит его на количество оценок, чтобы найти средний балл. Если в группе нет ни одного ученика или никто не сдал экзамен, средний балл равен 0.

Предикат `print_group_averages` - Получить таблицу групп

Примеры использования:
```prolog
?- print_group_averages.
Group: 101, Average 3.9
Group: 102, Average 3.7777777777777777
Group: 103, Average 3.7708333333333335
Group: 104, Average 3.861111111111111
true.
```

Реализация:
```prolog
print_group_averages :-
    write('Group: 101, Average: '),
    group_average(101, X),
    writeln(X),
    write('Group: 102, Average: '),
    group_average(102, Y),
    writeln(Y),
    write('Group: 103, Average: '),
    group_average(103, Z),
    writeln(Z),
    write('Group: 104, Average: '),
    group_average(104, Q),
    writeln(Q).
```

2) Для каждого предмета получить список студентов, не сдавших экзамен (grade=2)

Предикат `failed_students(Subject, FailedStudents)` - Получить список студентов, не сдавших экзамен

Примеры использования:
```prolog
?- failed_students('MAT', R).
R = [].

?- failed_students('MTH', R).
R = ['Запорожцев', 'Круглосчиталкин', 'Густобуквенникова', 'Криптовалютников', 'Блокчейнис', 'Азурин'].
```

Реализация:
```prolog
failed_students(Subject, FailedStudents) :-
    findall(Name, (student(_, Name), grade(Name, Subject, 2)), FailedStudents).
    
```
Предикат использует findall, чтобы собрать имена всех студентов, которые имеют оценку 2 в указанном предмете. Полученные имена студентов сохраняются в списке.

Предикат `print_failed_students_by_subject` - Для каждого предмета получить список студентов, не сдавших экзамен

Примеры использования:
```prolog
?- print_failed_students_by_subject.
Subject: Логическое программирование
FailedStudents: [Запорожцев,Эфиркина,Текстописов]
Subject: Математический анализ
FailedStudents: [Запорожцев,Круглосчиталкин,Густобуквенникова,Криптовалютников,Блокчейнис,Азурин]
Subject: Функциональное программирование
FailedStudents: [Криптовалютников]
Subject: Информатика
FailedStudents: [Эфиркина,Джаво,Безумников]
Subject: Английский язык
FailedStudents: [Эфиркина]
Subject: Психология
FailedStudents: [Биткоинов,Текстописова,Криптовалютников,Азурин,Вебсервисов]
true.
```

Реализация:
```prolog
print_failed_students_by_subject :-
    writeln('Subject: Логическое программирование'),
    write('FailedStudents: '),
    failed_students('LP', X),
    writeln(X),
    writeln('Subject: Математический анализ'),
    write('FailedStudents: '),
    failed_students('MTH', Y),
    writeln(Y),
    writeln('Subject: Функциональное программирование'),
    write('FailedStudents: '),
    failed_students('FP', Q),
    writeln(Q),
    writeln('Subject: Информатика'),
    write('FailedStudents: '),
    failed_students('INF', W),
    writeln(W),
    writeln('Subject: Английский язык'),
    write('FailedStudents: '),
    failed_students('ENG', R),
    writeln(R),
    writeln('Subject: Психология'),
    write('FailedStudents: '),
    failed_students('PSY', T),
    writeln(T).
```

3) Найти количество не сдавших студентов в каждой из групп

Предикат `count_failed_students(Group, Count)` - Найти количество не сдавших студентов в группе.

Примеры использования:
```prolog
?- count_failed_students(102, R).
R = 7.

?- count_failed_students(103, R).
R = 5.
```

Реализация:
```prolog
count_failed_students(Group, Count) :-
    findall(Student, (student(Group, Student), grade(Student, _, 2)), FailedStudents),
    length(FailedStudents, Count).
    
```
Предикат использует предикат findall, чтобы найти всех студентов из определенной группы, получивших оценку 2 в любом предмете. Затем он использует length, чтобы посчитать количество этих студентов и возвращает результат в переменной Count.

Предикат `print_failed_students_by_group` - Для каждого предмета получить список студентов, не сдавших экзамен

Примеры использования:
```prolog
?- print_failed_students_by_group.
Group: 101, Failed Students: 2
Group: 102, Failed Students: 7
Group: 103, Failed Students: 5
Group: 104, Failed Students: 5
true.
```

Реализация:
```prolog
print_failed_students_by_group :-
    write('Group: 101, Failed Students: '),
    count_failed_students(101, X),
    writeln(X),
    write('Group: 102, Failed Students: '),
    count_failed_students(102, Y),
    writeln(Y),
    write('Group: 103, Failed Students: '),
    count_failed_students(103, Z),
    writeln(Z),
    write('Group: 104, Failed Students: '),
    count_failed_students(104, Q),
    writeln(Q).
```

## Выводы

Я научился писать предикаты на языке Пролог, понял, как он работает. Заставила задуматься о другом способе программирования: логическом.



