%Matthew Bogert, Professor Richards, CS 291

% 1. ancestorPath

ancestorPath(Old,Young,[Old,Young]) :- parent(Old,Young).
ancestorPath(Old,Young,[Old|Xs]) :-  parent(Old,Middle), ancestorPath(Middle,Young,Xs).

% 2. common

common(Sub,List1,List2) :- subsequence(Sub,List1), subsequence(Sub,List2).

subsequence([],_).
subsequence([X|Xs],[X|Ys]) :- subsequence(Xs,Ys).
subsequence([X|Xs],[_|Ys]) :- subsequence([X|Xs],Ys).


% 3. numnames: Is the use of the 0 okay?

numnames([],0).
numnames([one],1).
numnames([two],2).
numnames([three],3).
numnames([four],4).
numnames([five],5).
numnames([six],6).
numnames([seven],7).
numnames([eight],8).
numnames([nine],9).
numnames([ten],10).
numnames([eleven],11).
numnames([twelve],12).
numnames([thirteen],13).
numnames([fourteen],14).
numnames([fifteen],15).
numnames([sixteen],16).
numnames([seventeen],17).
numnames([eighteen],18).
numnames([nineteen],19).
numnames([twenty],20).
numnames([thirty],30).
numnames([forty],40).
numnames([fifty],50).
numnames([sixty],60).
numnames([seventy],70).
numnames([eighty],80).
numnames([ninety],90).


%For Numbers 20-99 
numnames([Tens,Ones],Num) :- numnames([Tens],Y), numnames([Ones],X), plus(X,Y,Num), X is X mod 10, 0 is Y mod 10.
%For Numbers 100-999 
numnames([Digit, hundred], Num) :- numnames([Digit], X), Num is X * 100.
numnames([Hundreds, hundred, and, Ones], Num) :- numnames([Hundreds, hundred],X), numnames([Ones],Y), plus(X,Y,Num), Y is Y mod 10.
numnames([Hundreds, hundred, and, Tens, Ones], Num) :- numnames([Hundreds, hundred, and, Ones], X), numnames([Tens], Y), plus(X,Y,Num), 0 is Y mod 10.


% 4. Draw a pretty picture (See Attached PNG)


