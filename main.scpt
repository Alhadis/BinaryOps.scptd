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

on run argv
	set val to convertToBinary from 124
	convertToDecimal from val
end
