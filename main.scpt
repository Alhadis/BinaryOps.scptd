#!/usr/bin/env osascript -ss

to convertToBinary from decimal
	set bits to ""
	repeat until decimal = 0
		set decimal to decimal / 2
		if decimal mod 1 isn't equal to 0
			set bits to "1" & bits
			set decimal to decimal - 0.5
		else
			set bits to "0" & bits
		end if
	end repeat
	bits
end

to convertToDecimal from binary
	set decimal to 0
	repeat with bit in characters of binary
		set decimal to decimal * 2 + (bit as Integer)
	end repeat
	decimal
end

to bitwiseAND(a, b)
	set {a, b} to normaliseBinary(a, b)
	set bits to ""
	repeat with i from 1 to a's length
		if character i of a is "1" AND character i of b is "1"
			set bits to bits & "1"
		else
			set bits to bits & "0"
		end if
	end repeat
	bits
end

to bitwiseOR(a, b)
	set {a, b} to normaliseBinary(a, b)
	set bits to ""
	repeat with i from 1 to a's length
		if character i of a is "1" OR character i of b is "1"
			set bits to bits & "1"
		else
			set bits to bits & "0"
		end if
	end repeat
	bits
end

to normaliseBinary(a, b)
	if a's class isn't Text then set a to convertToBinary from a
	if b's class isn't Text then set b to convertToBinary from b
	repeat while a's length isn't equal to b's length
		if a's length < b's length
			set a to "0" & a
		else
			set b to "0" & b
		end if
	end repeat
	{a, b}
end

on run argv
	bitwiseAND("1101", "1011")
end
