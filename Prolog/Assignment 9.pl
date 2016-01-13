%Matthew Bogert, CS 291, Assignment 9
:- dynamic b/2.

%Hard facts about conditional relationships
not(0,1).
not(1,0).

or(1,1,1).
or(1,0,1).
or(0,1,1).
or(0,0,0).

and(1,1,1).
and(1,0,0).
and(0,1,0).
and(0,0,0).


%There is one flaw in my program that occasionally will produce incomplete solutions. I believe that this is because of my fail mechanisms at the end of my endGate predicates. What I beleive is happening is that the fail mechanism is causing me to check more predicates than I should be (like checking 2 endGate relationships when there should only be 1). I tried to mitigate this issue by inserting a cut at the beginning of the endGate bodies, but this also produced bugs (Solutions would not appear at all).

%The endGate predicates are meant to initialize the solution finding, as it is the starting predicate in the main method. We know that the 'out' must be true, so that gives us one binding (out = 1). From there, we can trace back variables to other gates and find the input values. 

%When end gate has two variables tracing back (or one for not)
endGate([and,In1,In2,_]) :- and(X,Y,1), list(Gate1), last(Gate1,In1), list(Gate2), last(Gate2,In2), gate(Gate1,X), gate(Gate2,Y), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.
endGate([or,In1,In2,_]) :- or(X,Y,1), list(Gate1), last(Gate1,In1), list(Gate2), last(Gate2,In2), gate(Gate1,X), gate(Gate2,Y), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.
endGate([not,In,_]) :- not(0,1), list(Gate), last(Gate,In), gate(Gate,0), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.

%When end gate has only 1st variable tracing back
endGate([and,In1,In2,_]) :- and(X,Y,1), \+ hasLast(In2), list(Gate), last(Gate,In1), gate(Gate,X), buildBinding(In2,Y), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.
endGate([or,In1,In2,_]) :- or(X,Y,1), \+ hasLast(In2), list(Gate), last(Gate,In1), gate(Gate,X), buildBinding(In2,Y), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.

%When end gate has only 2nd variable tracing back
endGate([and,In1,In2,_]) :- and(X,Y,1), \+ hasLast(In1), list(Gate), last(Gate,In2), gate(Gate,Y), buildBinding(In1,X), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.
endGate([or,In1,In2,_]) :- or(X,Y,1), \+ hasLast(In1), list(Gate), last(Gate,In2), gate(Gate,Y), buildBinding(In1,X), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.

%For when end gate is only gate in circuit
endGate([and,In1,In2,_]) :- and(X,Y,1), \+ hasLast(In1), \+ hasLast(In2), buildBinding(In1,X), buildBinding(In2,Y), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.
endGate([or,In1,In2,_]) :- or(X,Y,1), \+ hasLast(In1), \+ hasLast(In2), buildBinding(In1,X), buildBinding(In2,Y),  write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.
endGate([not,In,_]) :- not(0,1), \+ hasLast(In), buildBinding(In,0), write('Circuit Set: '), buildList(List), printSolution(List), retractall(b(_,_)), nl, fail.

%These gate predicates are different from endGate, because the 'out' doesn't necessarily have to be true. These are used to trace backwards from the out gate (the endGate predicate)

%Gate tracing back two variables (or one for not)
gate([and,In1,In2,_],OutValue) :- and(X,Y,OutValue), list(Gate1), last(Gate1,In1), gate(Gate1,X), list(Gate2), last(Gate2,In2), gate(Gate2,Y).
gate([or,In1,In2,_],OutValue) :- or(X,Y,OutValue),  list(Gate1), last(Gate1,In1), gate(Gate1,X), list(Gate2), last(Gate2,In2), gate(Gate2,Y).
gate([not,In,_],OutValue) :- not(X,OutValue), list(Gate), last(Gate,In), gate(Gate,X).

%Gate tracing back only first variable
gate([and,In1,In2,_],OutValue) :- and(X,Y,OutValue), \+ hasLast(In2), list(Gate), last(Gate,In1), gate(Gate,X), buildBinding(In2,Y).
gate([or,In1,In2,_],OutValue) :- or(X,Y,OutValue), \+ hasLast(In2), list(Gate), last(Gate,In1), gate(Gate,X), buildBinding(In2,Y).

%Gate tracing back only second variable
gate([and,In1,In2,_],OutValue) :- and(X,Y,OutValue), \+ hasLast(In1), list(Gate), last(Gate,In2), gate(Gate,Y), buildBinding(In1,X).
gate([or,In1,In2,_],OutValue) :- or(X,Y,OutValue), \+ hasLast(In1), list(Gate), last(Gate,In2), gate(Gate,Y), buildBinding(In1,X).

%Gate case for when there's no more tracing back
gate([and,In1,In2,_],OutValue) :- and(X,Y,OutValue), \+ hasLast(In1), \+ hasLast(In2), buildBinding(In1,X), buildBinding(In2,Y).
gate([or,In1,In2,_],OutValue) :- or(X,Y,OutValue), \+ hasLast(In1), \+ hasLast(In2), buildBinding(In1,X), buildBinding(In2,Y).
gate([not,In,_],OutValue) :- not(X,OutValue), \+ hasLast(In), buildBinding(In,X).

%To produce the bindings we need
buildBinding(Name,Value) :- newFact(b(Name,Value)).

newFact(F) :- \+ clause(F,true), asserta(F).
newFact(F) :- clause(F,true).

%Checks if there is any list fact with Last as the final element in the list
hasLast(Last) :- list(X), last(X,Last).

%Builds the binding environment 
buildList(List) :- findall((Name,Num),clause(b(Name,Num),_),List).

%Prints the solutions all pretty
printSolution([]).
printSolution([(Name,Num) | Xs]) :- write(Name), write(':'), write(Num), write(', '), printSolution(Xs).

%Reads the file and makes it useable
readLists(_,end_of_file) :- !. %This cut ends the reading of the file, so that we do not continue to parse the end_of_file atom.
readLists(S,Item) :-
	write(Item), nl,
	asserta(list(Item)),
	read(S,Next),
	readLists(S,Next).

%Where it all comes together
main :-
	write('Please enter file name of circuit: '), %Taking in input
	read(Filename),
	open(Filename,read,S),
	write('Circuit'), nl,
	read(S,Item),
	readLists(S,Item), %Builds the circuit we're finding solutions for
	list(End),
	last(End,Out), %This is the end gate for the circuit
	!, %This cut helps prevents Prolog from interpreting different variables as the 'out' variable. There were situations such that Prolog finds solutions for 'out' as the out variable and then solutions for 'not_ab' as the out variable. 
	write('Finding solutions for circuit to make '), write(Out), write(' true'), nl, 
	endGate(End). %Finds the solutions


