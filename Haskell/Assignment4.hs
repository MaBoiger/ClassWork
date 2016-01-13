--Matthew Bogert

generalizeToTuples :: (t -> t1) -> (t, t) -> (t1, t1)
generalizeToTuples fn tuple = (fn (fst tuple), fn (snd tuple))

stringify :: Show a => (t -> a) -> t -> String
stringify fn = newFn
	where newFn input = show (fn input)

restrict :: (t -> a) -> (t -> Bool) -> t -> Maybe a
restrict argFn legalFn = limitedFn
	where limitedFn input
			| legalFn input = Just (argFn input)
			| otherwise = Nothing

numToLetter num = case num of
				1 -> []
				0 -> []
				2 -> ["a","b","c"]
				3 -> ["d","e","f"]
				4 -> ["g","h","i"]
				5 -> ["j","k","l"]
				6 -> ["m","n","o"]
				7 -> ["p","q","r","s"]
				8 -> ["t","u","v"]
				9 -> ["w","x","y"]

phoneSpell :: [Int] -> [[Char]]
phoneSpell [] = []
phoneSpell [num] = (numToLetter num)
phoneSpell (n:ns) = (map (map charMapping (numToLetter n)) (phoneSpell ns))
	where charMapping char = (char++)
--Cannot fix why it won't compile. I feel like that the process I'm trying to implement is the right thing, but I cannot find any issues for the given compile error.
