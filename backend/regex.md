<p align="left">
  <img src="./assets/regex/regexlogo.png" width="250">
</p>


## GROUPS / RANGES

Group        | Description
------------ | -------------
**.**        | Any character except new line (\n)
**(a\|b)**   | a or b
**(...)**    | Group
**(?:...)**  | Passive (non-capturing) group
**[abc]**    | Range (a or b or c)
**[^abc]**   | Not (a or b or c)
**[a-q]**    | Lower case letters from a to q
**[A-Q]**    | Upper case letter from A to Q
**[0-8]**    | Digit from 0 to 8
**\\x**      | Group/subpattern number "x"
Ranges are inclusive.

## ANCHORS

Anchor       | Description
------------ | -------------
**^**        | Start of string, or start of line in multi-line pattern
**\A**       | Start of string
**$**        | End of string, or end of line in multi-line pattern
**\Z**       | End of string
**\b**       | Word boundary
**\B**       | Not word boundary
**\\<**      | Start of word
**\\>**      | End of word

## PATTERN MODIFIERS

Modifier     | Description
------------ | -------------
**g**        | Global match
**i \***     | Case insensitive
**m \***     | Multiple lines
**s \***     | Treat string as single line
**x \***     | Allow comments and whitespace in pattern
**e \***     | Evaluate replacement
**U \***     | Ungreedy pattern

* PCRE modifier

## CHARACTER CLASSES

Class        | Description   |  Class       | Description
------------ | ------------- | ------------ | -------------
**\c**       | Control character | **\D**       | Not digit
**\s**       | White space       | **\w**       | Word
**\S**       | Not white space   | **\W**       | Not word
**\d**       | Digit | **\x**    | Hexidecimal digit
**\O**       | Octal digit

## QUANTIFIERS

Quantifier   | Description   | Quantifier   | Description
------------ | ------------- | ------------ | -------------
**\***       | 0 or more     | **{3}**      | Exactly 3
**+**        | 1 or more     | **{3,}**     | 3 or more
**?**        | 0 or 1        | **{3,5}**    | 3, 4 or 5

Add a ? to a quantifier to make it ungreedy.

## SPECIAL CHARACTERS

Character    | Description   | Character    | Description
------------ | ------------- | ------------ | -------------
**\n**       | New line      | **\t**       | Form feed
**\r**       | Carriage return | **\xxx**   | Octal character xxx
**\t**       | Tab           |  **\xhh**    | Hex character hh
**\v**       | Vertical tab |
  
## ASSERTIONS

Assertion        | Description
------------ | -------------
**?=**           | Lookahead assertion
**?!**           | Negative lookahead
**?<=**          | Lookbehind assertion
**?!=** or **?<!** | Negative lookbehind
**?>**           | Once-only Subexp ression
**?()**          | Condition [if then]
**?()\|**        | Condition [if then else]
**?#**           | Comment


## STRING REPLACEMENT

Modifier     | Description
------------ | -------------
**$n**       | nth non-pa ssive group
**$2**       | "xyz" in /^(abc (xy z))$/
**$1**       | "xyz" in /^(?:a bc) (xyz)$/
**$`**       | Before matched string
**$'**       | After matched string
**$+**       | Last matched string
**$&**       | Entire matched string
Some regex implem ent ations use \ instead of $.

## POSIX

Group        | Description
------------ | -------------
**[:upper:]**   | Upper case letters
**[:lower:]**   | Lower case letters
**[:alpha:]**   | All letters
**[:alnum:]**   | Digits and letters
**[:digit:]**   | Digits
**[:xdigit:]**  | Hexadecimal digits
**[:punct:]**   | Punctuation
**[:blank:]**   | Space and tab
**[:space:]**   | Blank characters
**[:cntrl:]**   | Control characters
**[:graph:]**   | Printed characters
**[:print:]**   | Printed characters and spaces
**[:word:]**    | Digits, letters and underscore




