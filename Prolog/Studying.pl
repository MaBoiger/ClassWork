1.
last(X,[X]).
last(X,[_|Ls]) :- last(X,Ls).

2.*

3.
element(X,[X|_],1).
element(X,[_|Ls],Index) :- Index > 1, Decrement is Index - 1, element(X,Ls,Decrement).

4.
numElements([],0).
numElements([_|Xs],Num) :- numElements(Xs,NewNum), NewNum is Num + 1.

5.*
reverse([],[]).
reverse([X],[X]).
reverse([X,Y],[Y,X]).
reverse([X,Xs],[Y,Ys]) :- last(Ys,X), reverse(Xs,Ys).

6.*

7.*
flatten([],[])
flatten([X|Xs],[X|Rest]) :- \+ is_list(X), flatten(Xs,Rest).
flatten()

8.
compress([],_).
compress([X|Xs],List) :- \+ member(X,List), append(X,List,NewList), compress(Xs,NewList).
compress([X|Xs],List) :- member(X,List), compress(Xs,List).

9.*

10.*

11.*

12.*

13.*

14.
dupli([],[]).
dupli([X|Xs],[X,X|Ys]) :- dupli(Xs,Ys).

15.
dupli(List1, Num, List2) :- dupli(List1, Num, List2, Num).
dupli([],_,[],_).
dupli([X|Xs],1,[X|Ys],K) :- dupli(Xs,K,Ys,K).
dupli([X|Xs],Num,[X,X|Ys],K) :- Num > 1, NewNum is Num - 1, dupli(Xs,NewNum,[X|Ys],K).

16.
drop(List1,Num,List2) :- drop(List1,Num,List2,Num).
drop([],_,[],_).
drop([X|Xs],1,[Y|Ys],Num) :- drop(Xs,Num,Ys,Num).
drop([X|Xs],Count,[X|Ys],Num) :- Num > 1, Decrement is Count - 1, drop(Xs,Decreemnt,Ys,Num).

17.
split([],_,_,_).
split(List,0,[],List).
split([X|Xs],Length,[X|Ys],Zs) :- Length > 0, NewLength is Length - 1, split(Xs,NewLength,Ys,Zs).

18.
slice([X|_],1,1,[X]).
slice([_|Xs],Low,High,Zs) :- Low > 1, NewLow is Low - 1, High > 1, NewHigh is High - 1, slice(Xs,NewLow,High,Zs).
slice([X|Xs],1,High,[X|Ys]) :- High > 1, NewHigh is High - 1, slice(Xs,1,NewHigh,Ys).

19.*

20.
removeAt(X,[_|Ys],I,[X|Zs]) :- I > 1, I2 is I - 1, removeAt(X,Ys,I2,Zs).
removeAt(X,[X|Xs],1,[_|Xs]).

21.
insertAt(X,[_|Xs],1,[X|Xs]).
insertAt(X,[Y|Xs],I,[Y|Zs]) :- I > 1, I2 is I - 1, insertAt(X,Xs,I2,Zs).

22.
range(High,High,[High]).
range(Low,High,[Low|Xs]) :- Low < High, Low2 is Low+1, range(Low,High,Xs).