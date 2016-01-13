import Data.List


-- Put your top-level code in the body of main, and define functions as
-- necessary to help implement the game.

main = 
   do
    putStrLn ("Please enter a word length: ")
    wordLength <- getLine
    let wLength = (read wordLength) :: Int
    let dict = filter (\word -> length word == wLength) mediumDict
    let size = length dict
    putStrLn ("Please enter a number of guesses you get: ")
    numGuess <- getLine
    let guesses = read numGuess :: Int
    putStrLn("Word length is " ++ wordLength ++ " characters, and you got " ++ numGuess ++ " guesses")
    putStrLn ("The dictionary contains "++(show size)++" words")	
    playGame guesses ['_' | x <- [1..wLength]] [] dict

--Plays the game
playGame guesses wordProgress lettersGuessed dict =
    do
     putStrLn("Guesses Left: " ++ (show guesses))
     putStrLn("Word: " ++ wordProgress) 
     putStrLn("Letters Guessed: " ++ lettersGuessed)
     putStrLn("Guess a Letter: ")
     guess <- getLine
     putStrLn("Calculating...")
     putStrLn("Possible Patterns")
     let possiblePatterns = getWordPatterns (head guess) dict wordProgress
     let mostFrequentPair = maximumPattern possiblePatterns --This is the most general pattern
     printPatterns possiblePatterns
     putStrLn("Using pattern " ++ (fst mostFrequentPair) ++ " which has " ++ (show (length (snd mostFrequentPair))) ++ " words")
     if elem (head guess) (fst mostFrequentPair) --Checks if guess is correct
      then do 
            if elem '_' (fst mostFrequentPair) --If the word is not complete
              then do
                putStrLn("You was right")
                playGame guesses (fst mostFrequentPair) (lettersGuessed ++ guess) (snd mostFrequentPair)
              else do
                putStrLn("Congratulations!")
                putStrLn(fst mostFrequentPair)            
      else do 
            putStrLn("You was wrong")
            if (guesses - 1) <= 0
              then do
                putStrLn("GAME OVER")
              else do
                playGame (guesses - 1) (wordProgress) (lettersGuessed ++ guess) (snd mostFrequentPair)

--Prints out all of the pattern/words sets
printPatterns patternPairs =
  do
    let wordList = [concat (map (++ ", ") (snd tuple))| tuple <- patternPairs] 
    let patterns = [fst tuple ++ ": " | tuple <- patternPairs]
    let patternsAndWords = zip patterns wordList
    let printed = [(fst str) ++ (snd str) ++ "\n" | str <- patternsAndWords]
    mapM putStrLn printed

--Checks if a word matches a pattern
letterMatch [] _ = True
letterMatch (x:xs) (y:ys) 
    | x /= '_' = if x /= y then False else letterMatch xs ys
    | otherwise = letterMatch xs ys

--Turns a word into a pattern based on a given letter
getPattern letter wordProgress word = if letterMatch wordProgress word
                                      then map (\l -> if l == letter then l else '_') word
                                      else ""
--(length wordProgress) == (length word) && 
--Returns a list of tuples, holding a pattern and the words that fit that pattern
getWordPatterns letter dict wordProgress = returnedSets
    where wordPatternPairs = map (\word -> ((getPattern letter wordProgress word), word)) dict 
          listOfPatterns = nub [fst tuple | tuple <- wordPatternPairs]
          returnedSets = makeSets listOfPatterns dict letter
            -- [(pattern, filter (matchesPattern pattern) dict) | pattern <- listOfPatterns]

--Creates the pattern/words sets 
makeSets [] _ _ = []
makeSets (p:ps) dict letter = (p, filter (matchesPattern p ) dict) : makeSets ps (filterDict p dict letter dict) letter

--Filters the dictionary so that words matching a given pattern are taken out
filterDict _ [] _ dict = dict
filterDict pattern (d:ds) letter dict
  | matches pattern (convertToPattern letter d) = filterDict pattern ds letter (delete d dict)
  | otherwise = filterDict pattern ds letter dict

--Turns a word into a pattern
convertToPattern _ [] = []
convertToPattern letter (w:ws)
  | letter == w = w : convertToPattern letter ws
  | otherwise = '_' : convertToPattern letter ws

--Checks if two strings equal
matches [] [] = True
matches (p:ps) (w:ws)
  | p == w = matches ps ws
  | otherwise = False  

--Checks if a word matches a pattern
matchesPattern pattern word
  | length pattern == 0  && length word == 0 = True
  | head pattern /= '_' = if (head pattern) /= (head word) then False else matchesPattern (tail pattern) (tail word)
  | otherwise = matchesPattern (tail pattern) (tail word)

--Finds the most general pattern out of a list of pattern/words tuples
maximumPattern [] = error "Empty list"
maximumPattern [tuple] = tuple
maximumPattern [t1,t2] = if length (snd t1) > length (snd t2) then t1 else t2
maximumPattern (t:ts:tss) = if length (snd t) > length (snd ts) then maximumPattern (t:tss) else maximumPattern (ts:tss)

-- These words match the ones used in the online writeup of the Evil Hangman
-- assignment.  You can use this dictionary to test the cases shown in the assignment.

trivialDict = ["ally", "beta", "cool", "deal", "else", "flew", "good", "hope", "ibex"]


-- The four-letter words in this dictionary contain only the letters 'e', 'a', 'l',
-- 's', 'r', and 't'.  You can take advantage of the limited character selection to
-- do some testing.

smallDict = ["alae", "alee", "ales", "area", "ares", "arse", "asea", "ates", "earl", "ears", "ease", "east", "eats", "eras", "etas", "lase", "late", "leal", "lear", "leas", "rale", "rare", "rase", "rate", "real", "rear", "sale", "sate", "seal", "sear", "seas", "seat", "sera", "seta", "tael", "tale", "tare", "tate", "teal", "tear", "teas", "tela"]


-- This is a larger group of four-letter words if you want a greater challenge.

mediumDict = ["abbe", "abed", "abet", "able", "abye", "aced", "aces", "ache", "acme", "acne", "acre", "adze", "aeon", "aero", "aery", "aged", "agee", "ager", "ages", "ague", "ahem", "aide", "ajee", "akee", "alae", "alec", "alee", "alef", "ales", "alme", "aloe", "amen", "amie", "anes", "anew", "ante", "aped", "aper", "apes", "apex", "apse", "area", "ares", "arse", "asea", "ates", "aver", "aves", "awed", "awee", "awes", "axed", "axel", "axes", "axle", "ayes", "babe", "bade", "bake", "bale", "bane", "bare", "base", "bate", "bead", "beak", "beam", "bean", "bear", "beat", "beau", "bema", "beta", "blae", "brae", "cade", "cafe", "cage", "cake", "came", "cane", "cape", "care", "case", "cate", "cave", "ceca", "dace", "dale", "dame", "dare", "date", "daze", "dead", "deaf", "deal", "dean", "dear", "deva", "each", "earl", "earn", "ears", "ease", "east", "easy", "eath", "eats", "eaux", "eave", "egad", "egal", "elan", "epha", "eras", "etas", "etna", "exam", "eyas", "eyra", "face", "fade", "fake", "fame", "fane", "fare", "fate", "faze", "feal", "fear", "feat", "feta", "flea", "frae", "gaed", "gaen", "gaes", "gage", "gale", "game", "gane", "gape", "gate", "gave", "gaze", "gear", "geta", "hade", "haed", "haem", "haen", "haes", "haet", "hake", "hale", "hame", "hare", "hate", "have", "haze", "head", "heal", "heap", "hear", "heat", "idea", "ilea", "jade", "jake", "jane", "jape", "jean", "kaes", "kale", "kame", "kane", "keas", "lace", "lade", "lake", "lame", "lane", "lase", "late", "lave", "laze", "lead", "leaf", "leak", "leal", "lean", "leap", "lear", "leas", "leva", "mabe", "mace", "made", "maes", "mage", "make", "male", "mane", "mare", "mate", "maze", "mead", "meal", "mean", "meat", "mesa", "meta", "nabe", "name", "nape", "nave", "neap", "near", "neat", "nema", "odea", "olea", "pace", "page", "pale", "pane", "pare", "pase", "pate", "pave", "peag", "peak", "peal", "pean", "pear", "peas", "peat", "plea", "race", "rage", "rake", "rale", "rape", "rare", "rase", "rate", "rave", "raze", "read", "real", "ream", "reap", "rear", "rhea", "sabe", "sade", "safe", "sage", "sake", "sale", "same", "sane", "sate", "save", "seal", "seam", "sear", "seas", "seat", "sera", "seta", "shea", "spae", "tace", "tael", "take", "tale", "tame", "tape", "tare", "tate", "teak", "teal", "team", "tear", "teas", "teat", "tela", "tepa", "thae", "toea", "twae", "urea", "uvea", "vale", "vane", "vase", "veal", "vela", "vena", "vera", "wade", "waes", "wage", "wake", "wale", "wame", "wane", "ware", "wave", "weak", "weal", "wean", "wear", "weka", "yare", "yeah", "yean", "year", "yeas", "zeal", "zeta", "zoea"]
