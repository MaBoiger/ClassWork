sum([X],X).
sum([X|Xs],Sum) :- sum(Xs,NewSum), Sum is X + NewSum.

evenSplit(List,X,Y) :- sum(X,N), sum(Y,N), append(X,Y,List).
evenSplit([X|Xs],L1,[X|Ys]) :- evenSplit(Xs,[L1|X],Ys).

evenSplit([X|Xs],[X|Ys],[Y|Zs]) :- evenSplit(Xs,Ys,Zs).
evenSplit([X|Xs],[],[X|Zs]) :- evenSplit(Xs,[],Zs).
evenSplit([],[],[]).

count(_, [], 0).
count(State, [edge(State,_)|Xs], Num) :- !, count(State,Xs,Num2), Num is Num2 + 1.
count(State, [edge(_,State)|Xs], Num) :- !, count(State,Xs,Num2), Num is Num2 + 1.
count(State, [edge(_,_)|Xs], Num) :- !, count(State,Xs,Num).

edge(b,a).

edge(a,b).
 
edge(c,b).
 
edge(a,c).
 
valid_path([]).

valid_path([_]).
 
valid_path([X,Y|Zs]) :- edge(X,Y), valid_path([Y|Zs]).