<p align="left">
  <img src="./assets/regex/regexlogo.png" width="250">
</p>


## GROUPS / RANGES

Group        | Description                        | Example
------------ | ---------------------------------- | ------------
**.**        | Any character except new line (\n) | 
**(a\|b)**   | a or b                             |
**(...)**    | Group                              |
**(?:...)**  | Passive (non-capturing) group      |
**[abc]**    | Range (a or b or c)                |
**[^abc]**   | Not (a or b or c)                  |
**[a-q]**    | Lower case letters from a to q     |
**[A-Q]**    | Upper case letter from A to Q      |
**[0-8]**    | Digit from 0 to 8                  |
**\\x**      | Group/subpattern number "x"        |

Ranges are inclusive.

## ANCHORS

Anchor       | Description                                              | Example
------------ | -------------------------------------------------------- | ------------------------------------------
**^**        | Start of string, or start of line in multi-line pattern  | [Try it!](https://regex101.com/r/pWk9ve/1)
**$**        | End of string, or end of line in multi-line pattern      | [Try it!](https://regex101.com/r/pWk9ve/2) 
**\A**       | Start of string                                          | [Try it!](https://regex101.com/r/pWk9ve/6)
**\Z**       | End of string                                            | [Try it!](https://regex101.com/r/pWk9ve/7)
**\b**       | Word boundary                                            | [Try it!](https://regex101.com/r/pWk9ve/8)
**\B**       | Not word boundary                                        | [Try it!](https://regex101.com/r/pWk9ve/9)

## PATTERN MODIFIERS

Modifier     | Description                              | Example
------------ | ---------------------------------------- | -------------
**g**        | Global match                             |
**i \***     | Case insensitive                         |       
**m \***     | Multiple lines                           |   
**s \***     | Treat string as single line              |   
**x \***     | Allow comments and whitespace in pattern |
**e \***     | Evaluate replacement                     |           
**U \***     | Ungreedy pattern                         |  

* PCRE modifier

## CHARACTER CLASSES

Class        | Description        |  Example       
------------ | ------------------ | ------------ 
**\c**       | Control character  | 
**\s**       | White space        |
**\S**       | Not white space    |  
**\d**       | Digit              |  
**\O**       | Octal digit        |    
**\D**       | Not digit          | 
**\w**       | Word               |         
**\W**       | Not word           |
**\x**       | Hexidecimal digit  |  

## QUANTIFIERS

Quantifier   | Description   | Example  
------------ | ------------- | ------------ 
**\***       | 0 or more     |
**+**        | 1 or more     | 
**?**        | 0 or 1        | 
**{3}**      | Exactly 3     |
**{3,}**     | 3 or more     |
**{3,5}**    | 3, 4 or 5     |   

Add a ? to a quantifier to make it ungreedy.

## SPECIAL CHARACTERS

Character    | Description         | Character    
------------ | ------------------- | ------------ 
**\n**       | New line            | 
**\r**       | Carriage return     | 
**\t**       | Tab                 |  
**\v**       | Vertical tab        |
**\t**       | Form feed           |
**\xxx**     | Octal character xxx |
**\xhh**     | Hex character hh    |    

## ASSERTIONS

Assertion          | Description              | Example
-------------------| ------------------------ | -------------
**?=**             | Lookahead assertion      |
**?!**             | Negative lookahead       |     
**?<=**            | Lookbehind assertion     | 
**?!=** or **?<!** | Negative lookbehind      |
**?>**             | Once-only Subexp ression |
**?()**            | Condition [if then]      |
**?()\|**          | Condition [if then else] |
**?#**             | Comment                  |


## STRING REPLACEMENT

Modifier     | Description                 | Example
------------ | --------------------------- | --------------
**$n**       | nth non-pa ssive group      |
**$2**       | "xyz" in /^(abc (xy z))$/   |
**$1**       | "xyz" in /^(?:a bc) (xyz)$/ |
**$`**       | Before matched string       |
**$'**       | After matched string        |
**$+**       | Last matched string         |
**$&**       | Entire matched string       |

Some regex implem ent ations use \ instead of $.

## POSIX

Group           | Description                    | Example
--------------- | ------------------------------ | -----------
**[:upper:]**   | Upper case letters             |
**[:lower:]**   | Lower case letters             |
**[:alpha:]**   | All letters                    |
**[:alnum:]**   | Digits and letters             |
**[:digit:]**   | Digits                         |
**[:xdigit:]**  | Hexadecimal digits             |
**[:punct:]**   | Punctuation                    |
**[:blank:]**   | Space and tab                  |
**[:space:]**   | Blank characters               |
**[:cntrl:]**   | Control characters             |
**[:graph:]**   | Printed characters             |
**[:print:]**   | Printed characters and spaces  |
**[:word:]**    | Digits, letters and underscore |




