
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/Y809MT.pdf").

solution([
         [184, 'Ollie', 5, 'Lindy'],
         [187, 'Judith', 4, 'Twist'],
         [190, 'Lillian', 3, 'Foxtrot'],
         [193, 'Darla', 1, 'Samba'],
         [196, 'Patti', 9, 'Charleston']
]).

solve(T) :-
    T= [[184, N1, P1, D1],
        [187, N2, P2, D2],
        [190, N3, P3, D3],
        [193, N4, P4, D4],
        [196, N5, P5, D5]
       ],
    permutation(
        ['Ollie', 'Judith', 'Lillian', 'Darla', 'Patti'],
        [N1, N2, N3, N4, N5]),
    rule7(T), % N _ _
    
    permutation(
        ['Lindy', 'Twist', 'Foxtrot', 'Samba', 'Charleston'],
        [D1, D2, D3, D4, D5]),
    rule3(T), % N _ D
    rule8(T), % N _ D
    rule10(T), %_ _ D
    
    permutation(
        [5, 4, 3, 1, 9],
        [P1, P2, P3, P4, P5]),
    rule9(T), % N P D
    rule2(T), % N P D
    rule1(T), % _ P D
    rule4(T), % N P _
    rule5(T), % _ P D
    rule6(T), % N P _
    true.


%1. The person who danced fourth scored 3 points lower than the performer who did the foxtrot..
rule1(T) :-
    member([S1, _, 4, _], T),
    member([S2, _, _, 'Foxtrot'], T),
    S1 is S2- 3.
    
%2. Of the dancer who did the foxtrot and the dancer that scored 196 points, one was Patti and the other danced third..
rule2(T) :-
    member([196, N1, P1, _], T),
    member([_, N2, P2, 'Foxtrot'], T),
    (N1 = 'Patti', P2 = 3; N2 = 'Patti', P1 = 3).
%3. Judith didn't dance the lindy..
rule3(T) :-
    member([_, 'Judith', _, D], T),
    D \= 'Lindy'.
%4. Neither the person that scored 196 points nor the dancer who performed fifth was Judith..
rule4(T) :-
    member([196, N1, P, _], T),
    member([S, N2, 5, _], T),
    (N1 \= 'Judith', N2 \= 'Judith', S \= 196, P \= 5).
%5. The dancer who performed fourth scored 9 points lower than the performer who did the charleston..
rule5(T) :-
    member([S1, _, 4, _], T),
    member([S2, _, _, 'Charleston'], T),
    S1 is S2 - 9.
%6. Judith didn't perform first..
rule6(T) :-
    member([_, 'Judith', P1, _], T),
    P1 \= 1.
%7. Darla didn't finish with 184 points..
rule7(T) :-
    member([S1, 'Darla', _, _], T),
    S1 \= 184.
%8. Lillian scored 3 points lower than the dancer who did the samba..
rule8(T) :-
    member([S1, 'Lillian', _, _], T),
    member([S2, _, _, 'Samba'], T),
    S1 is S2 - 3.
%9. Of Patti and the dancer who performed first, one performed the charleston and the other performed the samba..
rule9(T) :-
    member([_, 'Patti', _, D1], T),
    member([_, _, 1, D2], T),
    (D1 = 'Charleston', D2 = 'Samba'; D1 = 'Samba', D2 = 'Charleston').
%10. The person that scored 187 points didn't perform the foxtrot..
rule10(T) :-
    member([187, _, _, D], T),
    D \= 'Foxtrot'.

check :- 
	% Confirm that the correct solution is found
	solution(S), (solve(S); not(solve(S)), writeln("Fails Part 1: Does  not eliminate the correct solution"), fail),
	% Make sure S is the ONLY solution 
	not((solve(T), T\=S, writeln("Failed Part 2: Does not eliminate:"), print_table(T))),
	writeln("Found 1 solutions").

print_table([]).
print_table([H|T]) :- atom(H), format("~|~w~t~20+", H), print_table(T). 
print_table([H|T]) :- is_list(H), print_table(H), nl, print_table(T). 


% Show the time it takes to conform that there are no incorrect solutions
checktime :- time((not((solution(S), solve(T), T\=S)))).
