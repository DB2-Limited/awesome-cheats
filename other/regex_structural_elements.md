<p align="left">
  <img src="./assets/regex/regexlogo.png" width="405">
</p>

#### REGULAR EXPRESSIONS STRUCTURAL ELEMENTS

## GROUPS AND RANGES

Group        | Description                        | Example
------------ | ---------------------------------- | ------------
**.**        | Any character except new line (\n) | [Try it!](https://regex101.com/r/pWk9ve/11)
**(a\|b)**   | a or b                             | [Try it!](https://regex101.com/r/pWk9ve/10)
**(...)**    | Group                              | [Try it!](https://regex101.com/r/pWk9ve/12)
**(?:...)**  | Passive (non-capturing) group      | [Try it!](https://regex101.com/r/pWk9ve/13)
**[abc]**    | Range (a or b or c)                | [Try it!](https://regex101.com/r/pWk9ve/14)
**[^abc]**   | Not (a or b or c)                  | [Try it!](https://regex101.com/r/pWk9ve/15)
**[a-q]**    | Lower case letters from a to q     | [Try it!](https://regex101.com/r/pWk9ve/16)
**[A-Q]**    | Upper case letter from A to Q      | [Try it!](https://regex101.com/r/pWk9ve/17)
**[0-8]**    | Digit from 0 to 8                  | [Try it!](https://regex101.com/r/pWk9ve/18)

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
**g**        | Global match                             | [Try it!](https://regex101.com/r/8aMufU/1)
**i \***     | Case insensitive                         | [Try it!](https://regex101.com/r/8aMufU/2)      
**m \***     | Multiple lines                           | [Try it!](https://regex101.com/r/8aMufU/3)   
**s \***     | Treat string as single line **           | [Try it!](https://regex101.com/r/8aMufU/4)  
**x \***     | Allow comments and whitespace in pattern | [Try it!](https://regex101.com/r/8aMufU/5)         
**U \***     | Ungreedy pattern (make quantifiers lazy) | [Try it!](https://regex101.com/r/8aMufU/6)  

\* PCRE modifier \
\*\* illegal in native JavaScript regular expressions


## LOOKAHEAD AND LOOKBEHIND ASSERTIONS

Assertion          | Description              | Example
-------------------| ------------------------ | -------------
**?=xxx**          | Lookahead assertion (followed by xxx but without including it in the match) | [Try it!](https://regex101.com/r/8aMufU/21)
**?!xxx**          | Negative lookahead (not followed by xxx) | [Try it!](https://regex101.com/r/8aMufU/22)    
**?<=xxx**         | Lookbehind assertion (preceded by xxx but without including it in the match)  | [Try it!](https://regex101.com/r/8aMufU/23)
**?!=xxx** or **?<!xxx** | Negative lookbehind (not preceded xxx) | [Try it!](https://regex101.com/r/8aMufU/24)

## CHARACTER CLASSES

Class        | Description        |  Example       
------------ | ------------------ | ------------ 
**\s**       | White space        | [Try it!](https://regex101.com/r/8aMufU/7)
**\S**       | Not white space    | [Try it!](https://regex101.com/r/8aMufU/8)
**\d**       | Digit              | [Try it!](https://regex101.com/r/8aMufU/10) 
**\D**       | Not digit          | [Try it!](https://regex101.com/r/8aMufU/9)
**\w**       | Word               | [Try it!](https://regex101.com/r/8aMufU/11)        
**\W**       | Not word           | [Try it!](https://regex101.com/r/8aMufU/12)


## QUANTIFIERS

Quantifier   | Description   | Example  
------------ | ------------- | ------------ 
**\***       | 0 or more     | [Try it!](https://regex101.com/r/8aMufU/13)
**+**        | 1 or more     | [Try it!](https://regex101.com/r/8aMufU/14)
**?**        | 0 or 1        | [Try it!](https://regex101.com/r/8aMufU/15)
**{3}**      | Exactly 3     | [Try it!](https://regex101.com/r/8aMufU/16)
**{3,}**     | 3 or more     | [Try it!](https://regex101.com/r/8aMufU/17)
**{3,5}**    | 3, 4 or 5     | [Try it!](https://regex101.com/r/8aMufU/18)  

Add a ? to a quantifier to make it ungreedy.

## SPECIAL CHARACTERS

Character    | Description         | Example    
------------ | ------------------- | ------------ 
**\n**       | New line            | [Try it!](https://regex101.com/r/8aMufU/19)
**\t**       | Tab                 | [Try it!](https://regex101.com/r/8aMufU/20) 
**\v**       | Vertical tab        | 
**\t**       | Form feed           | 
**\xxx**     | Octal character xxx | 
**\xhh**     | Hex character hh    | 

## STRING REPLACEMENT

Modifier     | Description                 | 
------------ | --------------------------- | 
**$n**       | nth non-passive group       |
**$2**       | "xyz" in /^(abc (xy z))$/   |
**$1**       | "xyz" in /^(?:a bc) (xyz)$/ |
**$`**       | Before matched string       |
**$'**       | After matched string        |
**$+**       | Last matched string         |
**$&**       | Entire matched string       |

Some regex implementations use \ instead of $.

## POSIX CLASSES

Class           | Description                    | 
--------------- | ------------------------------ | 
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




