
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/I439LZ.pdf").

solution([
         [500, 'Kimsight', 'Rustic village', 1981],
         [750, 'Rynir', 'Postage stamp', 1995],
         [1000, 'Irycia', 'Outer space', 1988],
         [1250, 'Vesem', 'Autumn leaves', 1992],
         [1500, 'Lyrod', 'Coral reef', 1982],
         [1750, 'Sonaco', 'Football', 1989]
         ]).

solve(T) :-
    T = [[500, C1, T1, Y1],
         [750, C2, T2, Y2],
         [1000, C3, T3, Y3],
         [1250, C4, T4, Y4],
         [1500, C5, T5, Y5],
         [1750, C6, T6, Y6]],
    permutation(
        ['Rustic village', 'Postage stamp', 'Outer space', 'Autumn leaves', 'Coral reef', 'Football'],
        [T1, T2, T3, T4, T5, T6]),
    rule10(T), % _ T _
    
	permutation(
        [1981, 1995, 1988, 1992, 1982, 1989],
        [Y1, Y2, Y3, Y4, Y5, Y6]),
    rule1(T), % _ T Y
    rule2(T), % _ T Y
    rule3(T), % _ T Y
    rule4(T), % _ T Y
    rule6(T), % _ T Y
    
    permutation(
        ['Kimsight', 'Rynir', 'Irycia', 'Vesem', 'Lyrod', 'Sonaco'],
		[C1, C2, C3, C4, C5, C6]),
    rule8(T), % C T Y
    rule5(T), % C T Y
    rule11(T), % C T Y
    rule7(T), % C _ Y
    rule9(T), % C _ Y    
    rule12(T), % C _ Y
    rule13(T), % C _ Y
    true.


%1. The jigsaw puzzle released in 1981 has 250 fewer pieces than the jigsaw puzzle with the postage stamp
%theme.
rule1(T) :-
    member([P1, _, _, 1981], T),
    member([P2, _, 'Postage stamp', _], T),
    P1 is P2 - 250.
%2. The jigsaw puzzle released in 1995 doesn't have the football theme.
rule2(T) :-
    member([_, _, T1, 1995], T),
    T1 \= 'Football'.
%3. The puzzle released in 1982 has the coral reef theme.
rule3(T) :-
    member([_, _, 'Coral reef', 1982], T).
%4. The jigsaw puzzle with 1000 pieces is either the puzzle released in 1989 or the puzzle with the outer space
%theme.
rule4(T) :-
    member([P1, _, _, 1989], T),
    member([P2, _, 'Outer space', _], T),
    P1 \= P2, (P1 = 1000; P2 = 1000).
    
%5. The jigsaw puzzle with the autumn leaves theme, the jigsaw puzzle released in 1988, the jigsaw puzzle
%made by Lyrod and the jigsaw puzzle released in 1995 are all different puzzles.
rule5(T) :-
    permutation(T,
                [[_, _, 'Autumn leaves', _],
                 [_, _, _, 1988],
                 [_, 'Lyrod', _, _],
                 [_, _, _, 1995],
                 [_, _, _, _],
                 [_, _, _, _]
                ]).
%6. The puzzle released in 1995 has somewhat more than the jigsaw puzzle with the rustic village theme.
rule6(T) :-
    member([P1, _, 'Rustic village', _], T),
    member([P2, _, _, 1995], T),
    P2 > P1.
%7. The jigsaw puzzle made by Sonaco has 500 more pieces than the puzzle released in 1992.
rule7(T) :-
    member([P1, 'Sonaco', _, _], T),
    member([P2, _, _, 1992], T),
    P1 is P2 + 500.
%8. Neither the jigsaw puzzle with the coral reef theme nor the jigsaw puzzle released in 1989 is the jigsaw
%puzzle made by Irycia.
rule8(T) :-
    member([_, C1, 'Coral reef', _], T),
    member([_, C2, _, 1989], T),
    C1 \= 'Irycia', C2 \= 'Irycia', C1 \= C2.
%9. The puzzle made by Irycia is either the puzzle released in 1988 or the jigsaw puzzle with 1500 pieces.
rule9(T) :-
    member([1500, C1, _, _], T),
    member([_, C2, _, 1988], T),
    C1 \= C2, (C1 = 'Irycia'; C2 = 'Irycia').
%10. The puzzle with 750 pieces has the postage stamp theme.
rule10(T) :-
    member([750, _, 'Postage stamp', _], T).
%11. Of the puzzle with the football theme and the jigsaw puzzle released in 1982, one has 1500 pieces and
%the other was made by Sonaco.
rule11(T) :-
    member([P1, C1, 'Football', _], T),
    member([P2, C2, _, 1982], T),
    (P1 = 1500, C2 = 'Sonaco'; P2 = 1500, C1 = 'Sonaco').
%12. The puzzle made by Rynir has 250 more pieces than the puzzle released in 1981.
rule12(T) :-
    member([P1, 'Rynir', _, _], T),
    member([P2, _, _, 1981], T),
    P1 is P2 + 250.
%13. The puzzle made by Kimsight has 1,000 fewer pieces than the jigsaw puzzle released in 1982.
rule13(T) :-
    member([P1, 'Kimsight', _, _], T),
    member([P2, _, _, 1982], T),
    P1 is P2 - 1000.

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
