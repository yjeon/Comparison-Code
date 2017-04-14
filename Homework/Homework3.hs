{-
Name: Yoonchan Jeon
NetID: yjeon
CS 463 - Homework3
-}

module Homework3 where
import Prelude hiding (zipWith) 

--return nth fibonacci number
fib :: Int -> Int
fib 0 = 0	--if n is 0 then return 0
fib 1 = 1	--if n is 1 then return 0	
fib n = fibHelper n 0 1

--while n is decreasing, fibonacci number a and b
--is increasing, so if n became 0 return a
--else make new fibonacci number with adding a and b
fibHelper n a b = if n == 0
					then a
					else fibHelper (n-1) b (a+b)
-------------------------------------------------
--return the reversed version of given list
reversed :: [a] -> [a]
--if list is empty return empty list
reversed [] = []	
--append the elements from back
reversed a = [last a] ++ reversed (init a)

-------------------------------------------------
--return True if n is prime number
prime :: Int -> Bool
--check n is whether less than 1
--if it is then return false
prime n = if n <= 1
			then False
		else
			--if n is 2 return true
			if n==2
				then True
			else
				--if n is even number, return false
				if even n
					then False
				else
					--using sub function
					--checking it has other divsible number or not
					--if it hase return false
					primeHelper n 2

primeHelper a b = if a == b
					then True
				else
					if 0 == (mod a b)
						then False
					else
						primeHelper a (b+1)
--------------------------------------------------
--remove duplicate from the given list and return the new list
nub :: (Eq a) =>[a] -> [a]
--if it is empty list return empty list
nub [] = []
--using helper function make a list
nub a = [head a] ++ nub (nubHelper a [head a])
--remove duplicate from the list
nubHelper a i = [x | x <- a, not (elem x i)]

--------------------------------------------------
--given two list, create a list applying the given function
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
--if either one is empty list from the given lists
--return empty list
zipWith f _ [] = []
zipWith f [] _ = []
--applyling function each of the elements by using recursive
zipWith f (x:xs) (y:ys) = (f x y) : (zipWith f xs ys)


--------------------------------------------------
--if n is even number, divide by 2
--if n is odd nubmer, times 3 and plus 1
--the last number must be 1
-- return the list contains the values until 1
collatz :: Int -> [Int]
collatz n = if (head [n]) == 1
				--if n is 1 return [1]
        		then [n]
         	else
	            if even( head [n])
	            --if it is even number, then divide by 2 and append to the list, and call collatz again
	            --until it becomes 1
	            	then [n] ++ collatz (quot (head [n]) 2)
	            else 
	            -- if it is odd nubmer, then times 3 and plus 1, and append to the list
	            -- and call collatz again until it becomes 1
	            	[n] ++ collatz ((head [n]) * 3 + 1)
--------------------------------------------------
--return mean median mode as a list
listReport :: [Int] -> (Double, Double, [Int])
--if given list is empty, return 0,0,[]
listReport [] = (0.0, 0.0, [])
--else call mean sub function, median sub function, mode sub-function
listReport a = (mean a, median a, mode a)

--calculate mean
mean a = (fromIntegral(listHelperSum (a)))/(fromIntegral(length a))
--calculate median
--if it has even number elements, find two mid points and calculate the mean
--if it has odd number elements, find the mid value
median a = if even( length a )
				then (fromIntegral(medianEvenHelper (qsort a)))/2
			else
				(fromIntegral(medianOddHelper (qsort a)))
--quick sort
qsort [] = []
qsort (x:xs) = let low = [ v | v <- xs, v <= x ]
                   high = [ v | v <- xs ,v > x ]
               in (qsort low)++[x]++(qsort high)

--find the two mid points of the list and calculate the mean of two points
medianEvenHelper a = (a !! ((quot (length a) 2)-1)) + (a !! (quot (length a) 2))
--find the mid point of the list
medianOddHelper a = (a !! ((quot (length a) 2)))

--calculate the sum
listHelperSum :: [Int] -> Int
listHelperSum [] = 0
listHelperSum a  = foldr (+) 0 a

--find the mode and gives the result as list
mode [] = []
--first using maxCount, find the maximum number of occurence 
--and find the elements which have that occurence 
mode xs = if (countNumElement [head xs] xs) == (maxCount xs)
				then [head xs]++mode(tail xs)
				else
					mode(tail xs)

--modeHelper a
--give you maximum number of the occurence
maxCount :: [Int] -> Int
maxCount [] = 0
maxCount xs = let max = (countNumElement [head xs] xs)
			in if (countNumElement [head (tail xs)] xs) > max then (countNumElement [head (tail xs)] xs) else max

--count the number of element in the list
countNumElement a [] = 0
countNumElement a xs = (length xs) - (length (countHelper xs a))

countHelper a i = [x | x <- a, not (elem x i)]


--------------------------------------------------
--checking the given sudoku is valid or not
checkSudoku :: [ [Int] ] -> Bool
checkSudoku [] = True
checkSudoku xxs = if rowchecker(head xxs) == True
							then checkSudoku(tail xxs)
						else
							False
--checking rows
rowchecker [] = False				 
rowchecker xs = if (length (nub xs)) == 9
						then True
				else
					False


------------------------------------------------------------
--examples for sudoku
good1 :: [ [Int] ]
good1 =
  [[1, 2, 3, 4, 5, 6, 7, 8, 9],
   [4, 5, 6, 7, 8, 9, 1, 2, 3],
   [7, 8, 9, 1, 2, 3, 4, 5, 6],

   [2, 3, 4, 5, 6, 7, 8, 9, 1],
   [5, 6, 7, 8, 9, 1, 2, 3, 4],
   [8, 9, 1, 2, 3, 4, 5, 6, 7],

   [3, 4, 5, 6, 7, 8, 9, 1, 2],
   [6, 7, 8, 9, 1, 2, 3, 4, 5],
   [9, 1, 2, 3, 4, 5, 6, 7, 8]
   ]

bad_cols :: [ [Int] ]
bad_cols =
  [[1, 2, 3, 4, 5, 6, 7, 8, 9],
   [4, 5, 6, 7, 8, 9, 1, 2, 3],
   [7, 8, 9, 1, 2, 3, 4, 5, 6],

   [1, 2, 3, 4, 5, 6, 7, 8, 9],
   [4, 5, 6, 7, 8, 9, 1, 2, 3],
   [7, 8, 9, 1, 2, 3, 4, 5, 6],

   [1, 2, 3, 4, 5, 6, 7, 8, 9],
   [4, 5, 6, 7, 8, 9, 1, 2, 3],
   [7, 8, 9, 1, 2, 3, 4, 5, 6]
  ]

bad_rows :: [ [Int] ]
bad_rows = 
  [[1, 2, 3, 1, 2, 3, 1, 2, 3],
   [4, 5, 6, 4, 5, 6, 4, 5, 6],
   [7, 8, 9, 7, 8, 9, 7, 8, 9],

   [2, 3, 4, 2, 3, 4, 2, 3, 4],
   [5, 6, 7, 5, 6, 7, 5, 6, 7],
   [8, 9, 1, 8, 9, 1, 8, 9, 1],

   [3, 4, 5, 3, 4, 5, 3, 4, 5],
   [6, 7, 8, 6, 7, 8, 6, 7, 8],
   [9, 1, 2, 9, 1, 2, 9, 1, 2]
  ]

bad_grps :: [ [Int] ]
bad_grps =
  [[1, 2, 3, 4, 5, 6, 7, 8, 9],
   [2, 3, 4, 5, 6, 7, 8, 9, 1],
   [3, 4, 5, 6, 7, 8, 9, 1, 2],

   [4, 5, 6, 7, 8, 9, 1, 2, 3],
   [5, 6, 7, 8, 9, 1, 2, 3, 4],
   [6, 7, 8, 9, 1, 2, 3, 4, 5],

   [7, 8, 9, 1, 2, 3, 4, 5, 6],
   [8, 9, 1, 2, 3, 4, 5, 6, 7],
   [9, 1, 2, 3, 4, 5, 6, 7, 8]
  ]













