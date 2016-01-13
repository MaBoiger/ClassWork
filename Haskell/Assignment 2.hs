--Matthew Bogert

tuplesSummingToZero [] = []
tuplesSummingToZero tuples = [tuple | tuple <- tuples, ((fst tuple) + (snd tuple)) == 0]

largestDiff [] = error "Not enough items"
largestDiff [x] = error "Not enough items"
largestDiff (x:xs) 
	| length (x:xs) == 2 = x - (head xs)
	| otherwise = max (abs(x - head xs)) (largestDiff xs)	


take' :: Integral a => a -> [b] -> [b]
take' count list = if count <= 0 || length list == 0
				   then []
				   else (head list) : (take' (count - 1) (tail list))

subsequence pattern list = subsequence' pattern list pattern

subsequence' pattern list originalPattern
	| pattern == [] = True
	| list == [] = False
	| otherwise = if (head pattern) == (head list)
				  then subsequence' (tail pattern) (tail list) originalPattern
				  else subsequence' (originalPattern) (tail list) originalPattern