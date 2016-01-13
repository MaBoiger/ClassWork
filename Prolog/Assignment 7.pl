%Matthew Bogert, CS 291 Assignment 7
sister(Sis,Person) :- female(Sis), parent(X,Sis), parent(X,Person), Sis \= Person.

%1.
% mother(holly,X), X \= flora.

%2.
aunt(Aunt,Person) :- female(Aunt), parent(X,Person), sister(Aunt,X). 

%3. 
related(P1,P2) :- ancestor(P1,P2).
related(P1,P2) :- ancestor(P2,P1).
related(P1,P2) :- P1 \= P2, ancestor(X,P1), ancestor(X,P2).

%4. 
generations(Old,Young,0) :- Old = Young. 
generations(Old,Young,N) :- parent(Old,Middle), generations(Middle,Young,S), plus(1,S,N).
