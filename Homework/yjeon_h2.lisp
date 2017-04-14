;;########################################
;;# Author: Yoonchan Jeon                #
;;# CS 463 - Homework2, Comparision Code #
;;# yjeon_h2.lisp                        #
;;########################################


;;
;;(defun  <funcName> ( params go here )
;;  "optional documentation string"
;; bodyExpression
;;)

(defun fib(n)
	"return nth fibonacci number"
	(if (= n 0) 0
	;;if n is 0 return 0
		(if (= n 1) 1
		;;if n is 1 return 1
			(fib-helper n 0 1)))
	)

(defun fib-helper(n f1 f2)
	"while decreasing n, Fibonacci number f1 and f2 are increasing"
	(if (zerop n) f1
	;;if n became 0 return f1
		(fib-helper (- n 1) f2 (+ f1 f2))
		;;make new fibonacci number with adding f1 and f2
		)
	)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun reversed(xs)
	"return the reverse version of given list"
	(if( null xs) NIL
	;;if xs is null return nill
		(append (reversed(rest xs)) (list (first xs))
		;;append the elements from back
			)
		)
	)

;;------------------------------------------
(defun is_prime(n)
	"return true if n is prime number"
	(setq f1 2)
	(if (<= n 1) NIL
	;;if n is less and equals than 1 return nil
		(if (= n 2) T
		;;if n is 2 return true
			(if ( and (evenp n)) NIL
			;;if n is even number return nil
				(if (= f1 n) T
				;;if f1 is n return true
					(check_prime n f1))
					;;recursive function as f1 increase
					)))

	)

(defun check_prime (a b)
	(if (= a b) T
	;;if a is b return true
		(if (= 0 (mod a b)) nil
		;;if there is divisible number return nil
			(check_prime a (+ b 1))))
			;;else true
	)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun nub (xs)
	"remove duplicate from the list and return new list"
	(if (null xs) nil
	;;if xs is null return nil
		(cons (first xs) (nub (nub-remove-same xs)))
		;;using helper function make a list
		)
	)
			
(defun nub-remove-same (xs)
	"remove duplicates"
	(if (null xs) nil
	;;checking null
		(remove (first xs) xs))
		;;remove duplicates
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun zip_with (f xs ys)
	"Given list, create a list applying the function"

	(setq a (compare-smaller (list-length xs) (list-length ys)))
	;;set small length to a
	(if (= a 0) nil
	;;if a is 0 return nil
		(if (= a 1) (list (zip-function-helper f (first xs) (first ys)))
		;;if smaller length is 1 reutnr just function and first of xs and ys
			(cons(zip-function-helper f (first xs) (first ys)) (zip_with f (rest xs) (rest ys)))
			;;recursive function and return the list
			)
		)
	)

(defun zip-function-helper (f x y)
	"function call f"
	(funcall f x y)
	)

(defun compare-smaller (a b)
	"choose smaller between a and b"
  	(if (< a b) a 
  		b)
  	)	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun collatz(n)
	"if n is even number, divide by 2 and if it is odd number times 3 and plus 1
	the last number must be 1."
	(reversed(collatz-list(list n)))
	;;using reversed function above, reverse the list

	)

(defun collatz-help(n)
	"collatz helper for calculation"
	(if (= n 1) n
	;;if n is 1 return n
		(if (evenp n) (/ n 2)
		;;if n is even number divide by 2
			(+ (* n 3) 1)
			;;if n is odd number times 3 and plus 1
			)
		)
	)

(defun collatz-list(xs)
	"collatz helper making list"
	(if (= (first xs) 1) xs
	;;checking the the first is 1
		(collatz-list (cons  (collatz-help (first xs)) xs)
		;;make a list adding elements
		;;this list became backward so need to be reveresed
			)
		)
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;list_report
(defun my-sum (xs)
	"sum calculation"
	(if (null xs ) 0
	;;check xs is null, if it is, return 0
		(+ (first xs) (my-sum (rest xs)))
		;;recursive, add the sum
		)

	)

(defun my-mean(xs)
	"mean calculation"
	(/ (my-sum xs) (+ (list-length xs) 0.0))
	
	)

(defun my-median(xs)
	"median calculation"
	(setq a (nth (/ (list-length xs) 2) (sort xs #'<)))
	(setq b (nth (- (/ (list-length xs) 2) 1) (sort xs #'<)))
	(if (oddp (list-length xs)) (nth (- (/ (+ (list-length xs) 1) 2) 1) (sort xs #'<))
	;;in case xs has odd length
		(/ (+ a b) 2.0))
		;;in case xs has even length
	)


(defun my-mode(xs)
	;;remove duplicate
	(setq a (list-length (nub xs)))
	;;using nub function above, check the length of list
	(if (= (list-length xs) a) (sort xs #'<)
	;;if length is same, then return xs
		
		(mode-helper xs)

		)

	)
(defun mode-helper(xs)
	(setq a (list-length(nub xs)))
	xs
	)


(defun list_report(xs)
	"return mean median mode as list"
	(if (null xs) nil
		(append (list (my-mean xs)) (append (list (my-median xs))) (append (list (my-mode xs))))
		)
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun check_sudoku(grid)
	(cond (T (check-grid-length(first grid))) (check_sudoku (rest grid))
		nil
		)

	)

(defun check-grid-length (grid)
	(if (= 9 (list-length(nub grid))) T
		nil
		)

	)

(defun change-col-row (grid)





	)
