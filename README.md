<!--*- coding: utf-8; fill-column: 80; truncate-lines: t; -*-
vim:se noet lbr tw=80 sts=0 sw=4 ts=4 nowrap: -->

BinaryOps
================================================================================
AppleScript library for bitwise arithmetic and base conversion.


Installation
--------------------------------------------------------------------------------
Clone this repository in your user scripts directory, or anywhere that libraries
are [searched for][1]. By default, this will be `~/Library/Script Libraries`.

~~~sh
mkdir -p ~/Library/'Script Libraries' && cd "$_"
git clone https://github.com/Alhadis/BinaryOps.scptd.git
make -C BinaryOps.scptd/Contents clean all
~~~


Usage
--------------------------------------------------------------------------------
To use the installed library, add the following line to your script's header:
~~~applescript
use BinaryOps: script "BinaryOps"
~~~

Access the library's functions using a [`tell`][2] statement:
~~~applescript
tell BinaryOps
	shiftLeft(2, 4) -- Equivalent to ‘2 << 4’ in C
end tell
~~~


Scripting definitions
--------------------------------------------------------------------------------

### Base conversion
Commands for converting between integer representations.

<a name="convert-to-binary"></a><b>convert to binary</b>
<i><abbr title="verb">v</abbr></i> :
Convert a decimal value to its binary representation.<br/>
<samp>&nbsp;	&nbsp;</samp><b>from</b> integer :
The base-10 (decimal) value to be converted.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#binary-string">binary string</a> :
A string of binary digits.

<a name="convert-to-decimal"></a><b>convert to decimal</b>
<i><abbr title="verb">v</abbr></i> :
Convert a binary, octal, or hexadecimal value to decimal.<br/>
<samp>&nbsp;	&nbsp;</samp><b>from</b>
<a href="#binary-string">binary&nbsp;string</a>,
<a href="#octal-string">octal&nbsp;string</a>,
or <a href="#hex-string">hex&nbsp;string</a> :
The value to be converted.<br/>
<samp>&nbsp;	&nbsp;</samp><b>radix</b>
<a href="#radix">2/‌8/‌10/‌16</a> :
The input base to convert from.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a> :
An integral base-10 (decimal) value.

<a name="convert-to-hex"></a><b>convert to hex</b>
<i><abbr title="verb">v</abbr></i> :
Convert a decimal integer to a hexadecimal string.<br/>
<samp>&nbsp;	&nbsp;</samp><b>from</b> integer :
The base-10 (decimal) value to be converted.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#hex-string">hex string</a> :
An uppercase hexadecimal string padded to at least two digits.

### Bitwise operations
Commands for performing bitwise operations.

<a name="bitwise-and"></a><b>bitwise AND</b>
<i><abbr title="verb">v</abbr></i> :
Combine two values using bitwise AND logic.<br/>
<samp>&nbsp;	&nbsp;</samp><b>a</b>
<a href="#binary-argument">binary argument</a> :
The first integer to be combined.</br>
<samp>&nbsp;	&nbsp;</samp><b>b</b>
<a href="#binary-argument">binary argument</a> :
The second integer to be combined.</br>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a>

<a name="bitwise-not"></a><b>bitwise NOT</b>
<i><abbr title="verb">v</abbr></i> :
Invert the bits of a binary value.<br/>
<samp>&nbsp;	&nbsp;</samp><b>for</b>
<a href="#binary-argument">binary argument</a> :
The value to flip the bits of.<br/>
<samp>&nbsp;	&nbsp;</samp><b>bytes</b> integer :
The length of the value being inverted, in bytes<br/>
<samp>&nbsp;	&nbsp;	&nbsp;</samp>
(default is the number of bytes needed to contain original argument).<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a>

<a name="bitwise-or"></a><b>bitwise OR</b>
<i><abbr title="verb">v</abbr></i> :
Combine two values using bitwise OR logic.<br/>
<samp>&nbsp;	&nbsp;</samp><b>a</b>
<a href="#binary-argument">binary argument</a> :
The first integer to be combined.<br/>
<samp>&nbsp;	&nbsp;</samp><b>b</b>
<a href="#binary-argument">binary argument</a> :
The second integer to be combined.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a>

<a name="bitwise-xor"></a><b>bitwise XOR</b>
<i><abbr title="verb">v</abbr></i> :
Combine two values using bitwise exclusive OR (XOR) logic.<br/>
<samp>&nbsp;	&nbsp;</samp><b>a</b>
<a href="#binary-argument">binary argument</a> :
The first integer to be combined.<br/>
<samp>&nbsp;	&nbsp;</samp><b>b</b>
<a href="#binary-argument">binary argument</a> :
The second integer to be combined.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a>

<a name="shift-left"></a><b>shift left</b>
<i><abbr title="verb">v</abbr></i> :
Shift an integer leftwards by the specified number of bits.<br/>
<samp>&nbsp;	&nbsp;</samp><b>value</b>
<a href="#binary-argument">binary argument</a> :
The value to be bit-shifted leftward.<br/>
<samp>&nbsp;	&nbsp;</samp><b>steps</b> integer :
The number of bits to shift the value by.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a>

<a name="shift-right"></a><b>shift right</b>
<i><abbr title="verb">v</abbr></i> :
Shift an integer rightwards by the specified number of bits.<br/>
<samp>&nbsp;	&nbsp;</samp><b>value</b>
<a href="#binary-argument">binary argument</a> :
The value to be bit-shifted rightward.<br/>
<samp>&nbsp;	&nbsp;</samp><b>steps</b> integer :
The number of bits to shift the value by.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
<a href="#decimal-number">decimal number</a>

### Internal commands
Ancillary commands used internally by library.

<a name="normalise-binary"></a><b>normalise binary</b>
<i><abbr title="verb">v</abbr></i> :
Convert a pair of arguments to binary strings,
padded out to matching lengths.<br/>
<samp>&nbsp;	&nbsp;</samp><b>a</b>
<a href="#binary-argument">binary argument</a> :
The first integer to be combined.<br/>
<samp>&nbsp;	&nbsp;</samp><b>b</b>
<a href="#binary-argument">binary argument</a> :
The second integer to be combined.<br/>
<samp>&nbsp;	&nbsp;</samp><abbr title="Return value">→</abbr>
list of <a href="#binary-string">binary strings</a>

<a name="validate-steps"></a><b>validate steps</b>
<i><abbr title="verb">v</abbr></i> :
Verify the <code>steps</code> argument of a shift operation,
throwing error <samp>-1719</samp> for values less than zero.<br/>
<samp>&nbsp;	&nbsp;</samp><b>steps</b> integer :
The number of steps to shift a value by.

### Type definitions
Value type definitions used by library commands.

<a name="radix"></a><b>radix</b>
<i><abbr title="enumeration">enum</abbr></i> :
Radix specifier for conversion operations.<br/>
<samp>&nbsp;	&nbsp;</samp><b>2</b> : Binary input.<br/>
<samp>&nbsp;	&nbsp;</samp><b>8</b> : Octal input.<br/>
<samp>&nbsp;	&nbsp;</samp><b>10</b> : Decimal input,
supported for completeness's sake only.<br/>
<samp>&nbsp;	&nbsp;</samp><b>16</b> : Hexadecimal input.
<p><samp>&nbsp;	&nbsp;</samp>Specifying any other value for a radix throws an error with code <code>-10023</code>.</p>

<a name="binary-string"></a><b>binary string</b>
<i><abbr title="noun">n</abbr></i> :
A string composed of "0" and "1" digits.
&nbsp;<i><abbr title="synonym">syn</abbr></i>&nbsp;<b>text</b>

<a name="octal-string"></a><b>octal string</b>
<i><abbr title="noun">n</abbr></i> :
A string composed of digits in the range "0" to "7" (inclusive).
&nbsp;<i><abbr title="synonym">syn</abbr></i>&nbsp;<b>text</b>

<a name="hex-string"></a><b>hex string</b>
<i><abbr title="noun">n</abbr></i> :
A string composed of digits and/or the letters "A", "B", "C", "D", "E", and "F".
&nbsp;<i><abbr title="synonym">syn</abbr></i>&nbsp;<b>text</b><br/>
<samp>&nbsp;	&nbsp;</samp>
See also: <a href="#convert-to-hex">convert to hex</a>

<a name="decimal-number"></a><b>decimal number</b>
<i><abbr title="noun">n</abbr></i> :
A decimal integer.<br/>
<samp>&nbsp;	&nbsp;</samp>
Values outside AppleScript’s limits for <samp>integer</samp> values
(<code>-536870912</code>, <code>536870911</code>)
are necessarily retained as <samp>real</samp> values instead.<br/>
<samp>&nbsp;	&nbsp;</samp>
See also: <a href="#convert-to-decimal">convert to decimal</a>

<a name="binary-argument"></a><b>binary argument</b>
<i><abbr title="noun">n</abbr></i> :
A string of ones and zeroes.<br/>
<samp>&nbsp;	&nbsp;</samp>
Input for a bitwise operation. If an integer,
will be converted to a string of binary digits using
<a href="#normalise-binary">normalise binary</a>.<br/>
<samp>&nbsp;	&nbsp;</samp>
See also: <a href="#normalise-binary">normalise binary</a>

<!-- Referenced links --------------------------------------------------------->
[1]: https://apple.co/3UPjwVs
[2]: https://apple.co/4sPR9mB
