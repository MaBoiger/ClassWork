--Matthew Bogert
square x = x * x

absolute x = sqrt (square x) 

sumTo x y z = if x + y == z
			  then True
			  else False

largestSquare :: Int -> Int -> Int 
largestSquare x y =	if x <= y
					then maximum [square z | z <- [x..y]]
					else error "First argument must be less than or equal to the second"

myFunkShin (a,b) (c,d) e 
	| e == True = (a,d)
	| otherwise = (c,b)
	