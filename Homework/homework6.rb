#################################################
#	Author: Yoonchan Jeon						#
# 	CS463 - Homework6, Comparison Code			#
#	yjeon_hw6.rb								#
#################################################

def fib(n)
	xs = [0,1]
	if (n < xs.length) then
		return xs[n]
	else
		while (n >= xs.length) do
			l = xs.length
			num = xs[l-1] + xs[l-2]
			xs.push(num)
		end
		return xs[n]
	end
end

#################################################

def reversed(xs)
	ys = []
	l = xs.length - 1
	xs.each_with_index do |x,i|
		a = xs[l-i]
		ys.push(a)
	end
	return	ys
end

#################################################

def is_prime(n)
	if n < 2 then
		return false
	elsif n == 2 then
		return true
	elsif n%2 == 0
		return false
	else
		for i in 2...n do
			if n % i == 0 then
				return false
			end
		end
		return true
	end
end

#################################################

def nub (xs)
	ys = []
	dub = true
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

def zipwith(f, xs, ys)
	ls = []

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

def collatz(n)
	ls = []

	if n <1 then
		return ls
	end
	while (n != 1) do
		if(n % 2 == 1) then
			ls.push(n)
			n = (n*3) + 1
		else
			ls.push(n)
			n = n/2
		end
	end
	ls.push(1)
	return ls

end

#################################################

def median(xs)
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

def mode(xs)
	xss = nub(xs)
	count = 0
	result = []
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

class Report
	def initialize(mean,median,mode)
		@mean = mean
		@median = median
		@mode = mode
	end

	def str
		return ("("+(@mean.to_s) +", "+(@median.to_s)+", "+ (@mode.to_s)+ ")")
	end

	def mean
		@mean
	end

	def median
		@median
	end

	def mode
		@mode
	end
end

def make_file(str, filename)
	f = File.open(filename, "w")
	if f
		f.syswrite(str)
	else
		puts "failed it"
	end
	f.close
end

def mean(sum, count)
	return ((sum.to_f)/count)
end


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

def check_sudoku(grid)
	if(check_grps(grid) == true and check_cols(grid) == true and check_rows(grid) == true) then
		return true
	else
		return false
	end
end