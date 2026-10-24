--*- on-save: "osacompile -o main.scpt main.applescript"; -*-
property name:    "BinaryOps"
property id:      "com.alhadis.binary-ops"
property version: "1.0"

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
