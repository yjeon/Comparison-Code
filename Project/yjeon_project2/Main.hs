module Main where

import Fractals

import System.Environment
--import System.IO (getLine,putStr,putStrLn) -- needed these three.
import System.IO


main ::	IO ()
main = do
	argsList <- getArgs
	let m0 = (head argsList)
	let args = (tail argsList)
	--putStrLn $ (show (argsList))
	if m0 == "mandelbrot"
		then do
			let max = read (head args) :: Int
			let args1 = (tail args)
			
			let row = read (head args1):: Int
			let args2 = (tail args1)
			
			let col = read (head args2) :: Int
			let args3 = (tail args2)
			
			let lowR = read (head args3) :: Double
			let args4 = (tail args3)
			
			let lowI = read (head args4) :: Double
			let args5 = (tail args4)

			let hiR = read (head args5) :: Double
			let args6 = (tail args5)	

			let hiI = read (head args6) ::  Double
			let args7 = (tail args6)

			let filename = (head args7)

			let c1 = (C lowR lowI)
			let c2 = (C hiR hiI)
			let m = (M max row col c1 c2)

			--putStrLn (show m)
			toFile m filename
			--toFile m (args7)

		else do
			if m0 == "julia" 
				then do
					let max = read (head args) :: Int
					let args1 = (tail args)
					
					let row = read (head args1) :: Int
					let args2 = (tail args1)
					
					let col = read (head args2) :: Int
					let args3 = (tail args2)
					
					let lowR = read (head args3) :: Double
					let args4 = (tail args3)
					
					let lowI = read (head args4) :: Double
					let args5 = (tail args4)

					let hiR = read (head args5) :: Double
					let args6 = (tail args5)

					let hiI = read (head args6) :: Double
					let args7 = (tail args6)

					let cR = read (head args7) :: Double
					let args8 = (tail args7)

					let cI = read (head args8) :: Double
					let args9 = (tail args8)

					let filename = (head args9)
					let c1 = (C lowR lowI)
					let c2 = (C hiR hiI)
					let c3 = (C cR cI)

					let j = (J max row col c1 c2 c3)

					--putStrLn (show j)
					toFile j filename
				else				
					putStrLn "Nothing"
