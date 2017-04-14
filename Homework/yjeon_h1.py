########################################
# Author: Yoonchan Jeon                #
# CS 463 - Homework1, Comparision Code #
# yjeon_h1.py                          #
########################################


#make a list that has fibonacci numbers
#and find the numbers that equals with n.
def fib(n):	
	#prepare the set first.
	xs = [0,1]
	#if n is less than or equals with 2
	#return the nth value of the current list 
	if(n < len(xs)):
		return xs[n]
	#else make the fibonacci number
	#with using while loop.
	else:
		#print ("here")
		#while loop runs
		# unitl length of the list 
		# becomes less than or equals with n
		while (n>=len(xs)):
			#print ("there")
			l = len(xs)
			#make the fibonacci number
			num = xs[l-1] + xs[l-2]
			#add to the list
			xs.append(num)
		#if while loop ends
		#return the nth value of the list
		return xs[n]

#given a list of values, and return the reversed it
def reversed(xs):
	#make a empty list
	ys =[]
	#using for loop, add the value from the last to first
	for x in range(0,len(xs)):
		l = len(xs)-1
		a = xs[l-x]
		ys.append(a)
	#return the reversed list.
	return ys
 
#checking the n value whether it is prime or not
def is_prime(n):
	#precondition if n is less than or equal with 1
	#return false
	if(n <= 1):
		return False
	#All even number is not prime, except 2
	#so if n == 2, return true
	#or if n == other even numbers, return false
	elif(n == 2):
		return True
	elif(n%2 == 0):
		return False
	#for the odd number, if there is any other divisible number except 1 and itself
	#return false
	#other return True
	else:
		for i in range(2,n):
			if(n%i == 0):
				return False
		return True

#make a new list that has all values from given list, but no duplicates
def nub(xs):
	#set the empty list
	ys = []
	#set the boolean which indicates it has any duplicates or not
	dub = True

	#using nested for loops comparing two list, xs and ys
	#if there is no duplicate then add to ys
	#if there is duplicate then skip it
	for i in range(0,len(xs)):
		for j in range(0,len(ys)):
			if(xs[i]==ys[j]):
				dub = False
		if(dub == True):
			ys.append(xs[i])
		else:
			dub = True
	return ys

#given a two-argument function and two lists of arguments
#applying the function with two list, create a new list
def zip_with(f,xs,ys):
	#set the new empty list
	ls = []
	#comparing two lengths of the lists
	#if ys has more elements, then use the length of xs
	#if xs has more elements, then use the length of ys
	if (len(ys) >= len(xs)):
		for i in range(len(xs)):
			a = f(xs[i],ys[i])
			ls.append(a)
	else:
		for i in range(len(ys)):
			a = f(xs[i],ys[i])
			ls.append(a)
	return ls

#generating the next value until n becomes 1
#if n is even, the next number is n/2
#if n is odd, the next number is (n*3)+1
def collatz(n): 
	ls = []

	if(n<1):
		return ls
	#using while loop until n == 1
	while (n !=1):
		#if n is odd, triple it and add one
		if (n%2 == 1): 
			ls.append(n)
			n = (n*3)+1
		#if n is even, divide it by two until n is 1.
		else: 
			ls.append(n)
			n = int(n/2)
	ls.append(1)
	return ls


###### file_report methods ########

#given function from CS463
def make_file(msg, filename='data.txt'):
	f = open(filename, 'w')
	f.write(msg)
	f.close()

#using the given list, find the median
def median(xs):
	#median is the middle value of the sorted values
	#if it has even length, average them
	l = len(xs)
	if(l%2 == 0):
		a = xs[int(l/2)-1]
		b = xs[int(l/2)]
		result = (a+b)/2
	else:
		result = xs[int((l-1)/2)]
	return result

#make a set list which does not has any duplicates
#same method with nub function
def set_list(xs):
	xss = []
	h = True
	for i in range(0,len(xs)):
		for j in range(0,len(xss)):
			if(xs[i]==xss[j]):
				h = False
		if(h==True):
			xss.append(xs[i])
		else:
			h= True
	return xss

#using the given list.
#find the most occurrences, ordered increasing
def mode(xs):
	#now xss has unique items only.
	#need to compare between xs and xss
	#count each of items in xs
	xss = set_list(xs)
	#print (xss)
	max = 0;
	
	#using two for loop count the maximum occurrences
	#and add to xsss
	#return xss
	for i in range(0,len(xss)):
		temp=0
		for j in range(0,len(xs)):
			if(xss[i]==xs[j]):
				temp+=1
		if(temp>max):
			result =[]
			max = temp
			result.append(xss[i])
		elif(temp == max):
			result.append(xss[i])
	return result

#instead using sort function
#i made a insertion sort function
#sorting
def sorted_list(xs):
	for i in range(1,len(xs)):
		temp = xs[i]
		for j in range(i,0,-1):
			if(xs[j]<xs[j-1]):
				temp = xs[j]
				xs[j] = xs[j-1]
				xs[j-1]=temp

	return xs

#read the file first. and get the int only
#and using above functions which are 
#make_file, median, set_list,mode, sorted_list
#make a triplet
#and return it.
def file_report(filename):
	file = open(filename)
	ln = file.read()
	#print(ln)
	sum = 0
	count = 0
	xs = []
	s =""
	#getting only integers without '\n'
	for num in ln:
		if(num != '\n'):
			s+=num
		else:
			count+=1
			i = int(s)
			xs.append(i)
			sum+=i
			s =""
	##get the list of number from the file. it is in xs list
	#print(xs)
	##sort the list
	#xs.sort()
	#instead using sort function,
	xs = sorted_list(xs)
	#print (xs)

	#calculate the MEAN value
	mean = (sum / count);

	#calculate the MEDIAN value
	med = median(xs)

	#find the values that shows the most occurrences
	md = mode(xs)
	result= (mean,med,md)

	file.close()
	return result


#######check_sudoku methods########
#checking only rows by using length
#first make the list as set list.
#so if there is any duplicates then the length cannot be 9
#and check every elements whether it is between 1 to 9
def check_rows(grid):
	for i in range(0,len(grid)):
		xs = set_list(grid[i])
		if(len(xs)!=9):
			return False
		else:
			for j in range(0, len(xs)):
				if (xs[j]>9 or xs[j]<1):
					return False
	return True

#this method is make lists that has column values
def swapRowToCol(grid):
	xs=[]
	j=0
	while(j<9):
		xss=[]
		for i in range(0, len(grid)):
			xss.append(grid[i][j])
		xs.append(xss)
		j+=1
	return xs

#after swap the row to col by using swapRowToCol method
#like check_rows, check the lengths and values
def check_cols(grid):
	xs = swapRowToCol(grid)
	for i in range(0,len(xs)):
		xss = set_list(xs[i])
		if(len(xss)!=9):
			return False
		else:
			for j in range(0,len(xss)):
				if(xss[j]>9 or xss[j]<1):
					return False
	return True

#like swapRowToCol, 
#this method also make the lists that consist each of groups 
def swapGrps(grid):
	xs=[]
	n = 3
	xss=[]
	while(n<10):
		for i in range(0, len(grid)):
			for j in range(n-3, n):
				xss.append(grid[i][j])
			#print(xss)
			if(i==2 or i==5 or i==8):
				xs.append(xss)
				xss=[]
		n+=3
	return xs
#liek check_cols and check_rows
#check the length and values
def check_grps(grid):
	xs = swapGrps(grid)
	for i in range(0,len(xs)):
		xss = set_list(xs[i])
		if(len(xss)!=9):
			return False
		else:
			for j in range(0,len(xss)):
				if(xss[j]>9 or xss[j]<1):
					return False
	return True

#using check_grps, check_cols, and check_rows methods
#if grid passes all the three method
#then grid is valid sudoku grid
#at least it cannot pass, then it is fail sudoku grid
def check_sudoku(grid):
	if(check_grps(grid) == True and check_cols(grid)== True and check_rows(grid)==True):
		return True
	else:
		return False


