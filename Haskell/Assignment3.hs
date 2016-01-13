--Matthew Bogert

sameOutput :: Integral a => (a -> a) -> (a -> a) -> a -> a -> Bool
sameOutput fn1 fn2 botRange topRange = if (map (fn1) list) == (map (fn2) list)
									   then True
									   else False
									   	where list = [botRange..topRange]


mostFrequent [] = error "Not defined on empty lists"
mostFrequent list = snd most
	where
		elemFrequency list element = (length (filter (element==) list), element)
		frequencyList = map (elemFrequency list) list
		most = maximum frequencyList

areaRect y1 _ xRange = y1 * xRange

areaTrap y1 y2 xRange = ((y1 + y2) / 2) * xRange

integrate integrationType intWidth x1 x2 fn = sum [integrationType (fn x) (fn (x + intWidth)) intWidth | x <- listUsed, x /= last listUsed] + integrationType (fn (last listUsed)) (fn x2) (x2 - (last listUsed))
   where integrationList = (filter (<x2) [x1, (x1 + intWidth) .. x2])
         listUsed = reverse (tail (reverse integrationList))

trapInt x1 x2 fn = integrate areaTrap 0.1 x1 x2 fn