#################################################
#	Author: Yoonchan Jeon						#
# 	CS463 - Homework6, Comparison Code			#
#	yjeon_hw6.rb								#
#################################################

#make a list includes fibonacci numbers
#and find n-th fibonacci number
def fib(n)
	#set the first list
	xs = [0,1]
	#if n ==0 or n ==1
	#then return 0 or 1
	if (n < xs.length) then
		return xs[n]
	else
		#expand the fibonacci list
		while (n >= xs.length) do
			l = xs.length
			num = xs[l-1] + xs[l-2]
			xs.push(num)
		end
		#return n-th fibonacci number
		return xs[n]
	end
end

#################################################
#given a list of values, and return the reversed of it
def reversed(xs)
	ys = []				#set new empty list
	l = xs.length - 1	#get the length of given list
	xs.each_with_index do |x,i|
		a = xs[l-i]		#get from the last element to first
		ys.push(a)		#and add to new list
	end
	return	ys			#return the new list
end

#################################################
#checking the given number whether it is prime or not
def is_prime(n)
	if n < 2 then		#if n<2 return false
		return false
	elsif n == 2 then	#if n == 2 return true
		return true
	elsif n%2 == 0		#if n is even number return false
		return false
	else
		#case when n is odd number
		#if there is any other divisible number
		#except 1 and itself then return true
		#else return false
		for i in 2...n do
			if n % i == 0 then
				return false
			end
		end
		return true
	end
end

#################################################
#make a list that has all values from given list, but no duplicates
def nub (xs)
	ys = []			#set new empty list
	dub = true		#set bool which indicates it has any duplicate or not
	
	#using nested for loops comparing two list, xs and ys
	#if there is no duplicate then add to ys
	#if there is duplicate then skip it
	for i in 0...xs.length
		for j in 0...ys.length
			if xs[i]==ys[j] then
				dub = false
			end
		end
		if (dub == true) then
			ys.push(xs[i])
		else
			dub =true
		end
	end

	return ys
end

#################################################
#given a two arguments function and two list of arguments
#applying the function with two list, and create a new list
def zipwith(f, xs, ys)
	ls = []				#set the new empty list
	#comparing two length of the lists
	# if ys has more elements, then use the length of xs
	# if xs has more elements, then use the length of ys
	if(xs.length < ys.length) then
		for i in 0...xs.length
			a = f.call(xs[i], ys[i])
			ls.push(a)
		end
	else
		for i in 0...ys.length
			a = f.call(xs[i], ys[i])
			ls.push(a)
		end
	end
	return ls
end

#################################################
#generating the next value until n becomes 1
#if n is even, the next number is n/2
#if n is odd, the next number is (n*3)+1
def collatz(n)
	ls = []

	if n <1 then
		return ls
	end
	#checking until n==1
	while (n != 1) do
		if(n % 2 == 1) then
			#case n is odd number
			#then add n into new list
			#n = n times 3 plus 1
			ls.push(n)
			n = (n*3) + 1
		else
			#case n is even number
			#then add n into new list
			#n = n divide by 2
			ls.push(n)
			n = n/2
		end
	end
	#add 1 into new list when n =1
	ls.push(1)
	return ls #retrun new list

end

#################################################
#### for file_report method #####################

#using the given list, find the median
def median(xs)
	#median is the middle of list value from the sorted list
	# if it has even length, average the two of middle elements of the list
	l  = xs.length
	if(l % 2 ==0) then
		a = xs[(l/2)-1]
		b = xs[(l/2)]
		print a 
		print b
		return (a+b)/2.0
	else
		return xs[(l-1)/2]
	end
end

#using the given list
#find the most occurrences, ordered increasing
def mode(xs)
	xss = nub(xs)		#using nub method, list has no duplicate item
	count = 0
	result = []
	#using two for loops count the maximum occurreneces
	#and add to the result list
	#and return result list
	for i in 0...xss.length
		temp = 0
		for j in 0...xs.length
			if xss[i] == xs[j]
				temp+=1
			end
		end
		if (temp>count) then
			result = []
			count = temp
			result.push(xss[i])
		elsif (temp == count)
			result.push(xss[i])
		end
	end
	return result
end

#Report class
#it has three instance variables : mean, median, mode
class Report
	#constructor
	def initialize(mean,median,mode)
		@mean = mean
		@median = median
		@mode = mode
	end
	#for string method
	#style like tuple
	def str
		return ("("+(@mean.to_s) +", "+(@median.to_s)+", "+ (@mode.to_s)+ ")")
	end
	#getter methods
	def mean
		@mean
	end

	def median
		@median
	end

	def mode
		@mode
	end

	#setter methods
	def mean=(v)
		@mean = v
	end
	def median=(v)
		@median = v
	end
	def mode=(v)
		@mode = v
	end
	
end

#write the given string to the given filename
def make_file(str, filename)
	#open file with mode = writing
	f = File.open(filename, "w")
	#write the given string
	if f
		f.syswrite(str)
	else
		puts "failed it"
	end
	#close file
	f.close
end

#find the mean value from given sum and total number of elements
def mean(sum, count)
	return ((sum.to_f)/count)
end

#read file with using the given filename, get only int values, not '\n'
#using method mean, median, and mode
#get the data
#return Report class with mean, median, and mode value
def file_report(filename)
 	f = File.open(filename, "r")
 	sum = 0
 	count = 0
 	xs = []
 	f.each_line do |line|
		count += 1
		i = line.to_i
		xs.push(i)
		sum+=i
		#print line
 	end
 	f.close
 	xs.sort!

 	mn = mean(sum,count).to_f
 	#mn = ((sum.to_f)/count)
 	med = median(xs).to_f
 	md = mode(xs)
 	return Report.new(mn,med,md)
end

#################################################
######### check_sudoku helper methods ###########

#checking only rows by using length
#first make the list as set list.
#so if there is any duplicates then the length cannot be 9
#and check every elements whether it is between 1 to 9
def check_rows(grid)
	for i in 0...grid.length
		xs = nub(grid[i])
		if (xs.length != 9) then
			return false
		else
			for j in 0...xs.length
				if (xs[j]>9 or xs[j]<1) then
					return false
				end
			end
		end
	end
	return true
end

def swapRowToCol(grid)
	xs = []
	j = 0
	while j<9 do
		xss=[]
		for i in 0...grid.length
			xss.push(grid[i][j])
		end
		xs.push(xss)
		j+=1
	end
	return xs
end

def check_cols(grid)
	xs = swapRowToCol(grid)
	for i in 0...xs.length
		xss = nub(xs[i])
		if(xss.length != 9) then
			return false
		else
			for j in 0...xss.length
				if xss[j]>9 or xss[j]<1 then
					return false
				end
			end
		end
	end
	return true
end

def swapGrps(grid)
	xs = []
	n = 3
	xss = []
	while n <10 do
		for i in 0...grid.length
			for j in (n-3)...n
				xss.push(grid[i][j])
			end
			if (i==2 or i==5 or i==8) then
				xs.push(xss)
				xss=[]
			end
		end
		n+=3
	end
	return xs
end

def check_grps(grid)
	xs = swapGrps(grid)
	for i in 0...xs.length
		xss = nub(xs[i])
		if (xss.length != 9) then
			return false
		else
			for j in 0...xss.length
				if(xss[j]>9 or xss[j]<1) then
					return false
				end
			end
		end
	end
	return true
end

#using check_grps, check_cols, and check_rows methods
#if grid passes all the three method
#then grid is valid sudoku grid
#at least it cannot pass, then it is fail sudoku grid
def check_sudoku(grid)
	if(check_grps(grid) == true and check_cols(grid) == true and check_rows(grid) == true) then
		return true
	else
		return false
	end
end