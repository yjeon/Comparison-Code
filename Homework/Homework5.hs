module Homework5 where
import Control.Monad.State      -- State, runState, get, put, guard
import Control.Concurrent       -- threadDelay
import Data.Char                -- toUpper


type Name = String
type FamilyTree = [(Name,Name)]

--return boolean if the given first list is a subsequence of the second list
isSubsequence :: (Eq a) => [a] -> [a] -> Bool
isSubsequence xs ys = isSubsequenceHelper xs ys (head xs)

--helper function for isSubsequence
--has 3 arguments list, list, the first item from the first list
isSubsequenceHelper xs ys a = if xs == [] 
								then True
								else
									if ys == []
										then False
									else
										if (head xs) == (head ys)
											then isSubsequenceHelper (tail xs) (tail ys) a	
										else
											if (head xs) == a
												then isSubsequenceHelper xs (tail ys) a
											else
												False

--find the index 
indexOf ::  (Eq a) => [a] -> [a] -> Maybe Int
indexOf xs ys = case isSubsequence xs ys of
					False -> Nothing
					True -> case headMaybe xs of
						Nothing -> Nothing
						Just x -> mindexOf (head xs) ys 0

mindexOf x xs i = if x == (head xs)
					then Just i
					else
						mindexOf x (tail xs) (i+1)

--type Name = String
tree = [
  ("Animal", "Object"),
  ("Cat","Animal"),
  ("Dog","Animal"),
  ("Siamese","Cat"),
  ("Calico","Cat"),
  ("Labrador","Dog"),
  ("Pug","Dog"),
  ("Book","Object"),
  ("Garbage","Can")
  ]

--helper function for parent
--chekcing whether the tree contains the name or not
findName :: (Eq a) => a -> [(a,b)] -> Maybe b
findName _ [] = Nothing
findName this ((key,val):xs) = if this == key
								then Just val
								else findName this xs

--looking for the parent's name from given a name and a tree
parent :: Name -> FamilyTree -> Maybe Name
parent name tree = case findName name tree of
 						Nothing -> Nothing
 						Just val -> Just val

-- looking for the list of ancestors from the given family tree
ancestors::Name -> FamilyTree -> Maybe [Name]
ancestors name tree = do
	--a <- parent name tree
	if name == "Object"
		then Just []
		else
			case parent name tree of
				Nothing -> Nothing
				Just val -> do
					case parent val tree of
						Nothing -> Nothing
						Just val -> Just (val : (ancestorsHelper val tree))

ancestorsHelper name tree =
	if name =="Object"
		then []
		else
			case parent name tree of
				Just val -> [val] ++ ancestorsHelper val tree

--looking for the first item from given list 
--if it has return item else Nothing
headMaybe :: [a] -> Maybe a
headMaybe [] = Nothing
headMaybe (x:xs) = Just x

--looking for the top branch that shared
leastUpperBound::Name -> Name -> FamilyTree -> Maybe Name
leastUpperBound a b tree = do
	a1 <- parent a tree
	b1 <- parent b tree
	if a == b
		then Just a
		else
			if a1 ==  b1
				then Just a1
				else
					if a1 == "Object"
						then leastUpperBound a b1 tree
					else
						if b1 == "Object"
							then leastUpperBound a1 b tree
							else
								leastUpperBound a1 b1 tree

--seperate by the given function
partition::(a->Bool) -> [a] -> ([a],[a])
partition f xs = runState (partitionM f xs) []

--static monadic version
partitionM::(a->Bool) -> [a] -> State [a] [a]
partitionM _ [] = return []
partitionM f (x:xs) = do
 	if f x 
		then do
			b <- partitionM f xs
			return ([x] ++ b)
		else do
			c <- get
			put (c ++ [x])
			partitionM f xs

charCode :: [Char]
charCode = [ '(', ')', '[', ']', '{', '}']

charCode1 :: [Char]
charCode1 = [ '(', '[', '{']

charCode2 :: [Char]
charCode2 = [ ')', ']', '}']

--checking the string contains the char
containChar :: Char -> String -> Bool
containChar _ "" = False
containChar c str = if c == (head str)
						then True
						else containChar c (tail str)
--just testing
findChar :: Char -> [Char] -> Bool
findChar _ [] = False
findChar c (x:xs) = if c == x
						then True
					else
						findChar c xs
--skip String if the string is not one of these, {} () {}
skipChar :: String -> String
skipChar "" = ""
skipChar str = if findChar (head str) charCode
					then str
					else
						skipChar (tail str)

--checking balance the string
plainBalanced :: String -> Bool
plainBalanced "" = True
plainBalanced str = do
	if findChar (head str) charCode2
		then False
		else do
			if findChar (head str) charCode1
				then
					if (head str) == '('
						then do
							if containChar ')' (tail str)
								then do
									if (head (tail str)) == ')'
										then True
										else do
											if (plainBalancedHelper '(' (tail str))
												then True
												else False
								else False
						else do
							if (head str) == '['
								then do
									if (head (tail str)) == ']'
										then True
										else do
											if containChar ']' (tail str)
												then do
													if (plainBalancedHelper '[' (tail str)) 
														then True
														else False
												else False
								else do
									if (head str) == '{'
										then do
											if (head (tail str)) == '}'
												then True
												else do
													if containChar '}' (tail str)
														then do
															if (plainBalancedHelper '{' (tail str))
																then True
																else False
														else False
										else
											plainBalanced (tail str)
				else plainBalanced (tail str)

plainBalancedHelper :: Char -> String ->Bool
plainBalancedHelper c "" = False
plainBalancedHelper c str = do
	if (head str) == '('
		then plainBalancedHelper '(' (tail str)
		else do
			if (head str) == '{'
				then plainBalancedHelper '{' (tail str)
				else do
					if (head str) == '['
						then plainBalancedHelper '[' (tail str)
						else do
							if c == '('
								then do
									if (head str) == ')'
										then True
										else do
											if (head (skipChar (tail str))) == ')'
												then do
													if skipChar (tail (tail str)) == ""
														then True
														else plainBalancedHelper '(' (skipChar (tail str))
												else False
								else do
									if c == '{'
										then do 
											if (head str) == '}'
												then True
												else do
													if (head (skipChar (tail str))) == '}'
														then do
															if skipChar (tail (tail str)) == ""
																then True
																else plainBalancedHelper '{' (skipChar (tail str))
														else False
									else do
										if c == '['
											then do
												if (head str) == ']'
													then True
													else do
														if (head (skipChar (tail str))) == ']'
															then do
																if skipChar (tail (tail str)) == ""
																	then True
																	else plainBalancedHelper '[' (skipChar (tail str))
															else False
										else plainBalancedHelper c (skipChar (tail str))

balancedM :: String -> State [Char] Bool
balancedM "" = do
	[] <- get
	return True
balancedM str = do
	return True

balanced :: String -> Bool
balanced str = case runState (balancedM str) [] of
				(b, []) -> b

divisors :: Int -> [Int]
divisors x = do
	[y | y <- [1..x], x `rem` y == 0]


geometric :: Int -> Int -> [Int]
geometric n i = do
	[n] ++ geometric (n*i) (i)


mersennes :: [Int]
mersennes = do
	[(2^x)-1 | x <- [1..] ]
	

share4way :: Int -> [(Int,Int,Int,Int)]
share4way n = do
	let range = [0..n]
	a <- range
	b <- range
	c <- range
	d <- range
	guard $ a>=b && b>=c && c>=d
	guard $ a+b+c+d == n
	return (a,b,c,d)

readNum :: IO Int
readNum = do
	num <- getLine
	let i = read num::Int
	return i

readNums :: Int -> IO [Int]
readNums 0 = do
	return []
readNums i = do
	num <- getLine
	let n = read num::Int
	if i == 1
		then return [n]
		else do
			c <- readNums (i-1)
			return (n:c)


slowEcho :: [String] -> IO ()
slowEcho [] = do
	threadDelay 1000000 

slowEcho (x:xs) = do
	putStrLn $ x
	threadDelay 1000000 
	slowEcho xs


crudeDiff :: FilePath -> FilePath -> IO Bool
crudeDiff a b = do
	text1 <- readFile a
	text2 <- readFile b

	if(map toUpper text1 == map toUpper text2)
		then return True
		else
			return False


sameBrackets :: FilePath -> FilePath -> IO Bool
sameBrackets a b = do
	t1 <- readFile a
	t2 <- readFile b

	if t1 == t2
		then return True
		else
			return False