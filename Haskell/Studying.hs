--1.
myLast [] = error "Empty List"
myLast [x] = x
myLast (_:xs) = myLast xs

--2.
butLast [] = error "Not enough elements"
butLast [x] = error "Not enough elements"
butLast [x,_] = x
butLast (x:xs) = butLast xs

3.
elemAt [] _ = error "Index out of bounds"
elemAt (x:_) 1 = x
elemAt (_:xs) num = elemAt xs (num - 1)

4.
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

5.*

6.*

14.
dupli [] = []
dupli (x:xs) = x:x: dupli xs

15.
repli list num = repli list num num

repli [] _ _ = []
repli (x:xs) 1 maxi = x:x: repli xs maxi maxi
repli (x:xs) num maxi = x:x: repli xs (num - 1) maxi

repli xs n = concatMap (replicate n) xs

31.
isPrime num
	| length (takeWhile (!divides num) [1..(fromIntegral (sqrt num))]) == (fromIntegral (sqrt num))  = True
	| otherwise = False
		where divides numerator denominator = (numerator mod denominator) == 0

32.
geeCeeDee 0 x = x
geeCeeDee y x = geeCeeDee z smaller
	where smaller = min y x
		  greater = max y x
		  z = greater mod smaller		

selfLoop [] = False
selfLoop ((E x y):xs) = if x == y
						then True
						else selfLoop xs

selfLoop list = if length (filter (\E x y -> x == y) list) == 0
				then False
				else True

superFilter fn list = ([x | x <- list, fn x],[x | x <- list, not (fn x)])

trimLengths list = map (take minLength) list
	where minLength = minimum (map length list)