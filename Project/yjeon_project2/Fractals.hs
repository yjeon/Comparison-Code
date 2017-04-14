module Fractals where
import Prelude
import System.IO
import Data.Char(toUpper)

type MaxIter = Int
type Row = Int
type Col = Int

data Complex 	= C Double Double deriving (Show, Eq)
data Mandelbrot = M MaxIter Row Col Complex Complex 
	| M1 Int Int Int Complex Complex
	deriving (Eq)

data Julia 		= J MaxIter Row Col Complex Complex Complex 
	| J1 Int Int Int Complex Complex Complex deriving (Eq)



class  (Show f)	=>	Fractal	f where
	escapeCount	::	f	->	Complex	->	Int 		-- how	many	iters	without	escaping?
	escapes	::	f	->	[[MaxIter]]					-- escapeCount	over	all	spots
	escapesString	::	f	->	String				-- String	version	of	escapes
	toFile	::	f	->	FilePath	->	IO	()		-- pushes	escapesString	to	file.
	toFile f a = do
		let s = escapesString f
		--putStrLn $ s
		output <- openFile a WriteMode
		hPutStrLn output (show f)
		hPutStrLn output ""
		hPutStr output s
		hClose output


{-
class	Ord	a	where	
				compare	::	a	->	a	-> Ordering
-}


instance Show Mandelbrot where
	show (M max row col c1 c2) = do
		let (C a b) = c1
		let (C c d) = c2
		"Mandelbrot "++ show(max)++" "++show(row)++" "++show(col)++" "++show(a)++" "++show(b)++" "++show(c)++" "++show(d)

instance Show Julia where
	show (J max row col c1 c2 c3) = do
		let (C a b) = c1
		let (C c d) = c2
		let (C e f) = c3
		"Julia "++ show(max)++" "++show(row)++" "++show(col)++" "++show(a)++" "++show(b)++" "++show(c)++" "++show(d)++" "++show(e)++" "++show(f)

instance Ord Complex where
	compare (C a b) (C c d)
		| sqrt((a^2)+(b^2)) == sqrt((c^2)+(d^2)) 	= EQ
		| sqrt((a^2)+(b^2)) < sqrt((c^2)+(d^2)) 	= LT
		| otherwise 								= GT

instance Num Complex where
	signum _ = error "no signum for complex numbers!"
	(+) (C a b) (C c d) = (C (a+c) (b+d))
	(*) (C a b) (C c d) = (C ((a*c)-(b*d)) ((b*c)+(a*d)))
	abs (C a b) = (C (sqrt((a^2)+(b^2))) 0.0)
	fromInteger a = (C (fromInteger a) 0.0)
	negate (C a b) = (C (a*(-1)) (b*(-1)))



instance Fractal Mandelbrot where
	escapeCount (M max row col c1 c2) (C a b) = escapeCountHelper 0 max (C 0 0) (C a b) 
	
	escapes (M max row col c1 c2) = do
		let xxs = buildGrid row col c1 c2
		escapesHelper1 (M max row col c1 c2) escapeCount xxs

	escapesString (M max row col c1 c2) = do
		let xxs = escapes (M max row col c1 c2)
		showGrid xxs

escapeCountHelper i max (C a b) (C c d) = do
	let a1 = (a^2) - (b^2)
	let b1 = (a*b)*2
	let a2 = a1+c
	let b2 = b1+d
	let temp = abs(sqrt((a2^2) + (b2^2)))
	if i == max
		then i
		else do
			if temp > 2
				then i
			else escapeCountHelper (i+1) max (C (a2) (b2)) (C c d)

escapesHelper (M max row col c1 c2) f [] = []
escapesHelper (M max row col c1 c2) f (x:xs) = do
	[(f (M max row col c1 c2) (x))] ++ (escapesHelper (M max row col c1 c2) f (xs))

escapesHelper1 (M max row col c1 c2) f [[]] = [[]]
escapesHelper1 (M max row col c1 c2) f [a] = [escapesHelper (M max row col c1 c2) f a]
escapesHelper1 (M max row col c1 c2) f (x:xs) = do
	[escapesHelper (M max row col c1 c2) f x] ++ escapesHelper1 (M max row col c1 c2) f xs


instance Fractal Julia where
	escapeCount (J max row col c1 c2 c3 ) (C a b) = escapeCountHelperJ 0 max c3 (C a b)

	escapes (J max row col c1 c2 c3 ) = do
		let xxs = buildGrid row col c1 c2
		escapesHelperJ1 (J max row col c1 c2 c3) escapeCount xxs

	escapesString (J max row col c1 c2 c3) = do
		let xxs = escapes (J max row col c1 c2 c3)
		showGrid xxs


escapesHelperJ (J max row col c1 c2 c3) f [] = []
escapesHelperJ (J max row col c1 c2 c3) f (x:xs) = do
	[(f (J max row col c1 c2 c3) (x))] ++ (escapesHelperJ (J max row col c1 c2 c3) f (xs))

escapesHelperJ1 (J max row col c1 c2 c3) f [[]] = [[]]
escapesHelperJ1 (J max row col c1 c2 c3) f [a] = [escapesHelperJ (J max row col c1 c2 c3) f a]
escapesHelperJ1 (J max row col c1 c2 c3) f (x:xs) = do
	[escapesHelperJ (J max row col c1 c2 c3) f x] ++ escapesHelperJ1 (J max row col c1 c2 c3) f xs




escapeCountHelperJ i max (C a b) (C pa pb) = do
	let a1 = (pa^2)-(pb^2)
	let b1 = (pa*pb)*2
	let a2 = a1+a
	let b2 = b1+b
	let temp = abs(sqrt((a2^2)+(b2^2)))
	if i == max
		then i
		else do
			if temp>2
				then i
			else escapeCountHelperJ (i+1) max (C a b) (C a2 b2)


buildGrid ::  Row -> Col -> Complex -> Complex -> [[Complex]]
buildGrid row col (C a b) (C c d)  = do
	let colD = (fromIntegral)col -1
	let rowD = (fromIntegral)row -1
	let gapR = (c-a)/(colD)
	let	gapI = abs((d-b)/(rowD))
	buildGridRowHelper row col 0 gapR gapI (C a b) (C c d)


buildGridRowHelper row col i gapR gapI (C a b) (C c d) = if (row == i)
														then []
														else 
															[buildGridColHelper col 0 gapR (C a d)] ++ buildGridRowHelper row col (i+1) gapR gapI (C a b) (C c (d- gapI))

buildGridColHelper col i gapR (C a b) = if (col == i) 
											then []
											else
												[(C a b)] ++ (buildGridColHelper col (i+1) gapR (C (a+gapR) b))


showGrid :: [[MaxIter]] -> String
showGrid [[]] = " \n"
showGrid [a] = showGrid1 0 a ++ " \n"
showGrid xxs = showGrid1 0 (head xxs) ++ " \n" ++ showGrid(tail xxs)

showGrid1 i [] = ""
showGrid1 i xs = do
		if i == 0
			then do 
				if (head xs) < 10
					then  "  " ++ show (head xs)++ showGrid1 (i+1) (tail xs)
					else do
						if (head xs)<100
						then  " " ++show (head xs) ++showGrid1 (i+1) (tail xs)
						else
							"" ++show (head xs) ++ showGrid1 (i+1) (tail xs)


			else do
				if (head xs) < 10
					then  "   " ++ show (head xs)++ showGrid1 (i+1) (tail xs)
					else do
						if (head xs)<100
						then  "  " ++show (head xs) ++showGrid1 (i+1) (tail xs)
						else
							" " ++show (head xs) ++ showGrid1 (i+1) (tail xs)

step :: (Complex, Complex) -> (Complex, Complex)
step ((C a b),(C c d)) = ((C (a^2 + c) (b^2 + d)), (C c d))

