@res = 0
def findWordVert(table, word)
	table.each do |line|
	  @res += 1 if line.include?word
	end

end

def getFlippedTable(table, tableF)
	range = (0..table[0].length-1)
	range.each do |index|
		str = ""
		table.each do |line|
			str += line[index]
		end
		tableF << str
	end
end

def getDiagTable(table, tableDiag, wordLen)
	sup = table[0].length-1
	(1..sup).each do |indexCol|
		str = ""
		(0..sup-1).each do |indexRow|
			char = table[indexRow][indexCol+indexRow]
			str += char unless char.nil?
		end
		tableDiag << str if str.length > wordLen - 1
	end

	(0..table.length-1).each do |indexRow|
		str = ""
		(0..sup).each do |indexCol|
			if table[indexRow+indexCol]
				char = table[indexRow+indexCol][indexCol]
				str += char
			end
		end
		tableDiag << str if str.length > wordLen - 1
	end
end

def main()

	table = [
		"ivan",
		"evnh",
		"inav",
		"mvvn",
		"qrit"
	]

	input = "ivan"
	#Take reversed input and then just search
	#twice vertical from left to right. Take res.
	inputReversed = input.reverse
	findWordVert(table, input)
	findWordVert(table, inputReversed)
	
	#Flip the table and repeat with verticals, get res.
	tableFlip = []
	getFlippedTable(table, tableFlip)
	findWordVert(tableFlip, input)
	findWordVert(tableFlip, inputReversed)

	#Get main diag table res.
	tableDiag = []
	getDiagTable(table, tableDiag, input.length)
	findWordVert(tableDiag, input)
	findWordVert(tableDiag, inputReversed)

	#Get secondary diag by using main diag method on 
	#the flipped table
	tableSecDiag = []
	#getDiagTable(tableFlip, tableSecDiag, input.length)
	findWordVert(tableSecDiag, input)
	findWordVert(tableSecDiag, inputReversed)

	puts @res

end

main()
