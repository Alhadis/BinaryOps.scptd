--*- on-save: "osacompile -o main.scpt main.applescript"; -*-
use AppleScript version "2.4"
use scripting additions

property name:    "BinaryOps"
property id:      "com.alhadis.binary-ops"
property version: "1.0"

-- Convert a decimal number to its binary representation
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

-- Convert a binary, octal, or hexadecimal value to decimal
to convertToDecimal from input given radix:radix as Integer
	if radix isn't contained by {2, 8, 10, 16}
		error "Radix must be one of 2, 8, 10 or 16" number -10023 from radix
	else if radix equals 10
		return input + 0
	end if

	-- Store/strip a leading sign component
	set negative to input starts with "-"
	if negative or input starts with "+"
		set input to text 2 thru end of input
	end if
	
	-- Strip radix indicators
	ignoring case
		if (radix is 16 and input starts with "0x") ¬
		or (radix is 2  and input starts with "0b") ¬
		or (radix is 8  and input starts with "0o")
			set input to text 3 thru end of input
		end if
	end ignoring

	-- Short-circuit values of zero
	if {"00", "0", ""} contains input then return 0

	set decimal to 0
	
	-- Binary
	if radix equals 2
		repeat with bit in input's characters
			set decimal to decimal * 2 + (bit as Integer)
		end repeat
	
	-- Octal and Hexadecimal
	else
		set position to 0
		repeat with digit in reverse of input's characters
			set decimal to decimal + (¬
				((offset of digit in "0123456789ABCDEF") - 1) * ¬
				(radix ^ position))
			set position to position + 1
		end repeat
	end if

	-- Negate result if input was originally negative
	if negative then set decimal to -decimal
	
	-- Coerce value to integer if it falls within AppleScript's limits for integral values
	if decimal > -536870912 and decimal ≤ 536870911 then set decimal to decimal as Integer
	
	-- Return result
	decimal
end convertToDecimal

-- Convert a decimal to a hexadecimal string of length ≥ 2
to convertToHex from decimal as Integer
	if decimal equals 0 then return "00"

	-- If negative, negate value and store sign for later
	set negative to decimal < 0
	if negative then set decimal to -decimal

	-- Convert value to base-16
	set hex to ""
	repeat until decimal = 0
		set hex to (text ((decimal mod 16) + 1) of "0123456789ABCDEF") & hex
		set decimal to decimal div 16
	end repeat

	-- Prepend leading zero if result is < 0x10
	if hex's length is 1 then set hex to "0" & hex

	-- Prepend sign if original value was negative
	if negative then set hex to "-" & hex
	hex
end convertToHex

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

to bitwiseNOT for value given bytes:bytes
	if value's class isn't Text then ¬
		set value to convertToBinary from value
	if bytes is missing value or bytes * 8 < value's length then ¬
		set bytes to round (value's length / 8) rounding up
	repeat until (value's length) equals bytes * 8
		set value to "0" & value
	end repeat
	set inverted to ""
	repeat with i from 1 to value's length
		if character i of value is "1"
			set inverted to inverted & "0"
		else
			set inverted to inverted & "1"
		end if
	end repeat
	return inverted
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

to bitwiseXOR(a, b)
	set {a, b} to normaliseBinary(a, b)
	set bits to ""
	repeat with i from 1 to a's length
		set b1 to character i of a is "1"
		set b2 to character i of b is "1"
		if (b1 or b2) and not (b1 and b2)
			set bits to bits & "1"
		else
			set bits to bits & "0"
		end if
	end repeat
	bits
end

to shiftLeft(value, steps as Integer)
	validateSteps(steps)
	if steps < 0 then ¬
		error "Cannot shift by negative offset" number -1719 from steps
	if value's class is Integer then ¬
		return value * (2 ^ steps) as Integer
	if value's class isn't Text then ¬
		set value to convertToBinary from value
	set value to text 1 thru (value's length - steps) of value
	repeat steps times
		set value to "0" & value
	end repeat
	value
end

to shiftRight(value, steps as Integer)
	validateSteps(steps)
	if value's class is Integer then ¬
		return value div (2 ^ steps)
	if value's class isn't Text then ¬
		set value to convertToBinary from value
	repeat steps times
		set value to value & "0"
	end repeat
	value
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

to validateSteps(steps)
	if steps < 0
		error "Shift offset cannot be negative" number -1719 from steps
	end if
end
