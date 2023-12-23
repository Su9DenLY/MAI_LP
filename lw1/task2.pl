:- ['one.pl'].

group_average(Group, Average) :-
    findall(Grade, (student(Group, Name), grade(Name, _, Grade)), Grades),
    length(Grades, NumGrades),
    (NumGrades > 0 -> sum_list(Grades, Total), Average is Total / NumGrades; Average is 0).

failed_students(Subject, FailedStudents) :-
    findall(Name, (student(_, Name), grade(Name, Subject, 2)), FailedStudents).
    
count_failed_students(Group, Count) :-
    findall(Student, (student(Group, Student), grade(Student, _, 2)), FailedStudents),
    length(FailedStudents, Count).
    




% Вывести средний балл для каждой группы
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

% Вывести студентов, не сдавших экзамен, для каждого предмета
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
