<p align="left">
  <img src="./assets/regex/regexlogo.png" width="250">
</p>


## ANCHORS

Anchor       | Description
------------ | -------------
^            | Start of string, or start of line in multi-line pattern
\A           | Start of string
$            | End of string, or end of line in multi-line pattern
\Z           | End of string
\b           | Word boundary
\B           | Not word boundary
\\<          | Start of word
\\>          | End of word


## CHARACTER CLASSES

Class        | Description
------------ | -------------
\c           | Control character
\s           | White space
\S           | Not white space
\d           | Digit
\D           | Not digit
\w           | Word
\W           | Not word
\x           | Hexidecimal digit
\O           | Octal digit
  
## GROUPS / RANGES

Group        | Description
------------ | -------------
.            | Any character except new line (\n)
(a|b)        | a or b
(...)        | Group
(?:...)      | Passive (non-capturing) group
[abc]        | Range (a or b or c)
[^abc]       | Not (a or b or c)
[a-q]        | Lower case letters from a to q
[A-Q]        | Upper case letter from A to Q
[0-8]        | Digit from 0 to 8
\\x          | Group/subpattern number "x"

## ASSERTION

Group        | Description
------------ | -------------
?=           | Lookahead assertion
?!           | Negative lookahead
? <=         | Lookbehind assertion
?!= or ?<!   | Negative lookbehind
?>           | Once-only Subexp ression
?()          | Condition [if then]
?()|         | Condition [if then else]
?#           | Comment