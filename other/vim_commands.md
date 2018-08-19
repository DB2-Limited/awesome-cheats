<p align="left">
  <img src="./assets/vim/vim_logo.png" width="250">
</p>

#### VIM USEFUL COMMANDS

## HOW TO EXIT

Command          | Description                        
---------------- | ---------------------------------- 
**:q[uit]**	     | Quit Vim. This fails when changes have been made
**:q[uit]!**	   | Quit without writing                             
**:cq[uit]**	   | Quit always, without writing                              
**:wq**	         | Write the current file and exit     
**:wq!**	       | Write the current file and exit always              
**:wq {file}**   | Write to {file}. Exit if not editing the last                
**:wq! {file}**  | Write to {file} and exit always
**:[range]wq[!]**| [file] Same as above, but only write the lines in [range]     
**ZZ**	         | Write current file, if modified, and exit
**ZQ**	         | Quit current file and exit (same as ":q!")  

## EDIT FILE

Command            | Description                        
------------------ | ---------------------------------- 
**:e[dit]**		     | Edit the current file. This is useful to re-edit the current file, when it has been changed outside of Vim
**:e[dit]!**		   | Edit the current file always. Discard any changes to the current buffer. This is useful if you want to start all over again                             
**:e[dit] {file}** | Edit {file}                            
**:e[dit]! {file}**| Edit {file} always. Discard any changes to the current buffer     
**gf**	           | Edit the file whose name is under or after the cursor. Mnemonic: "goto file"     

## INSERT TEXT

Command  | Description                        
-------- | ---------------------------------- 
**a**	   | Append text following current cursor position
**A**	   | Append text to the end of current line                            
**i**	   | Insert text before the current cursor position   
**I**	   | Insert text at the beginning of the cursor line    
**gI**	 | Insert text in column 1 [count] times              
**o**    | Open up a new line following the current line and add text there       
**O**    | Open up a new line in front of the current line and add text there 

## INSERT FILE

Command            | Description                        
------------------ | ---------------------------------- 
**:r[ead] [name]** | Insert the file [name] below the cursor
**:r[ead] !{cmd}** | Execute {cmd} and insert its standard output below the cursor 

## DELETE TEXT

Command                            | Description                        
---------------------------------- | ---------------------------------- 
**x**	                             | Delete [count] characters under and after the cursor
**X**	                             | Delete [count] characters before the cursor          
**d{motion}**	                     | Delete text that {motion} moves over       
**dd**	                           | Delete line    
**dw**                             | Delete word from cursor on 
**db**                             | Delete word backward
**D**	                             | Delete the characters under the cursor until the end of the line         
**{Visual}x** or **{Visual}d**     | Delete the highlighted text (for {Visual} see [Selecting Text][1])       
**{Visual}CTRL-H** or **{Visual}** | When in Select mode: Delete the highlighted text    
**{Visual}X** or **{Visual}D**     | Delete the highlighted lines    
**:[range]d[elete]**	             | Delete [range] lines (default: current line) 
**:[range]d[elete] {count}**	     | Delete {count} lines, starting with [range]

## CHANGE (OR REPLACE) TEXT

Command          | Description                        
---------------- | ---------------------------------- 
**r{char}**      | Replace the character under the cursor with {char}
**R**	           | Enter Insert mode, replacing characters rather than inserting                        
**~**	           | Switch case of the character under the cursor and move the cursor to the right. If a [count] is given, do that many characters                              
**~{motion}**	   | Switch case of {motion} text
**{Visual}~**	   | Switch case of highlighted text       

## COPYING AND MOVING TEXT

Command                       | Description                        
----------------------------- | ---------------------------------- 
**"{a-zA-Z0-9.%#:-"}**	      | Use register {a-zA-Z0-9.%#:-"} for next delete, yank or put (use uppercase character to append with delete and yank) ({.%#:} only work with put)
**:reg[isters]**	            | Display the contents of all numbered and named registers                 
**:reg[isters] {arg}**	      | Display the contents of the numbered and named registers that are mentioned in {arg}                           
**:di[splay] [arg]**	        | Same as :registers
**["x]y{motion}**	            | Yank {motion} text [into register x]            
**["x]yy**                    | Yank [count] lines [into register x]               
**["x]Y**                     | Yank [count] lines [into register x] (synonym for yy)
**{Visual}["x]y**             | Yank the highlighted text [into register x] (for {Visual} see [Selecting Text][1]) 
**{Visual}["x]Y**	            | Yank the highlighted lines [into register x]
**:[range]y[ank] [x]**	      | Yank [range] lines [into register x]
**:[range]y[ank] [x] {count}**| Yank {count} lines, starting with last line number in [range] (default: current line), [into register x]
**["x]p**	                    | Put the text [from register x] after the cursor [count] times
**["x]P**	                    | Put the text [from register x] before the cursor [count] times 
**["x]gp**	                  | Just like "p", but leave the cursor just after the new text
**["x]gP**	                  | Just like "P", but leave the cursor just after the new text
**:[line]pu[t] [x]**	        | Put the text [from register x] after [line] (default current line)
**:[line]pu[t]! [x]**	        | Put the text [from register x] before [line] (default current line)

## UNDO / REDO / REPEAT 

Command     | Description                        
----------- | ---------------------------------- 
**u**	      | Undo [count] changes
**:u[ndo]**	| Undo one change              
**CTRL-R**	| Redo [count] changes which were undone                          
**:red[o]**	| Redo one change which was undone
**U**	      | Undo all latest changes on one line. {Vi: while not moved off of it}  
**.**       |  Repeat last change, with count replaced with [count]

## MOVING AROUND

Command                         | Description                        
------------------------------- | ---------------------------------- 
**h**                           | Moves the cursor one character to the left
**l**                           | Moves the cursor one character to the right             
**k**                           | Moves the cursor up one line                          
**j**                           | Moves the cursor down one line
**0**	                          | To the first character of the line (exclusive)   
**\<Home\>**                    | To the first character of the line (exclusive)
**nG** or **:n**                | Cursor goes to the specified (n) line
**^**                           | To the first non-blank character of the line
**$** or **<End>**              | To the end of the line and [count - 1] lines downward[Selecting Text][1]) 
**g0** or **g**	                | When lines wrap ('wrap on): To the first character of the screen line (exclusive). Differs from "0" when a line is wider than the screen. When lines don't wrap ('wrap' off): To the leftmost character of the current line that is on the screen. Differs from "0" when the first character of the line is not on the screen
**g^**	                        | When lines wrap ('wrap' on): To the first non-blank character of the screen line (exclusive). Differs from "^" when a line is wider than the screen. When lines don't wrap ('wrap' off): To the leftmost non-blank character of the current line that is on the screen. Differs from "^" when the first non-blank character of the line is not on the screen
**:[range]y[ank] [x] {count}**| Yank {count} lines, starting with last line number in [range] (default: current line), [into register x]
**g$**	or  **g<End&gr;**       | Put the text [from register x] after the cursor [count] times
**+** or **CTRL-M <CR>**	      | [count] lines downward, on the first non-blank character (linewise) 
**_**	                          | [count] - 1 lines downward, on the first non-blank character (linewise)
**\<C-End\>** or **G**	        | Goto line [count], default last line, on the first non-blank character
**<\C-Home\>** or **gg**	      | Goto line [count], default first line, on the first non-blank character
**\<S-Right\>** or **w**	      | [count] words forward
**\<C-Right\>**	 or **W**       | [count] WORDS forward
**e**	      | Forward to the end of word [count]
**E**     | 	Forward to the end of WORD [count]
**\<S-Left\>** or **b**	        | [count] words backward
**\<S-Left\>** or **B**         | [count] WORDS backward
**ge**	                        | Backward to the end of word [count]
**gE**                          | Backward to the end of WORD [count]

These commands move over words or WORDS.

A word consists of a sequence of letters, digits and underscores, or a sequence of other non-blank characters, separated with white space (spaces, tabs, ). This can be changed with the 'iskeyword' option.

A WORD consists of a sequence of non-blank characters, separated with white space. An empty line is also considered to be a word and a WORD

Command  | Description                        
-------  | ---------------------------------- 
**(**	   | [count] sentences backward
**)**	   | [count] sentences forward                           
**{**	   | [count] paragraphs backward                             
**}**	   | [count] paragraphs forward   
**]]**   | [count] sections forward or to the next '{' in the first column. When used after an operator, then the '}' in the first column             
**][**   | [count] sections forward or to the next '}' in the first column
**[[**   | [count] sections backward or to the previous '{' in the first column
**[]**   | [count] sections backward or to the previous '}' in the first column 

Screen movement commands

Command  | Description                        
-------  | ---------------------------------- 
*z.**	   | Center the screen on the cursor
**zt**	 | Scroll the screen so the cursor is at the top                       
**zb**	 | Scroll the screen so the cursor is at the bottom

## SEARCHING

Command                  | Description                        
-------------------------| ---------------------------------- 
**\/{pattern}[/]**	     | Search forward for the [count]'th occurrence of {pattern}
**\/{pattern}/{offset}** | 	Search forward for the [count]'th occurrence of {pattern} and go {offset} lines up or down             
**\/**	                 | Search forward for the [count]'th latest used pattern          
**\//{offset}**	         | Search forward for the [count]'th latest used pattern with new. If {offset} is empty no offset is used
**?{pattern}[?]**	       | Search backward for the [count]'th previous occurrence of {pattern}
**?{pattern}?{offset}**  |  Search backward for the [count]'th previous occurrence of {pattern} and go {offset} lines up or down
**?**                    | Search backward for the [count]'th latest used pattern
**??{offset}**           | Search backward for the [count]'th latest used pattern with new {offset}. If {offset} is empty no offset is used
**N**                    | Repeat the latest "/" or "?" [count] times
**n**                    | Repeat the latest "/" or "?" [count] times in opposite direction

## HOW TO SUSPEND 

Command    | Description                        
---------- | ---------------------------------- 
**CTRL-Z** | Suspend Vim, like ":stop". Works in Normal and in Visual mode. In Insert and Command-line mode, the CTRL-Z is inserted as a normal character
**:sus[pend][!]** or	 |                       
**:st[op][!]**	 | Suspend Vim. If the '!' is not given and 'autowrite' is set, every buffer with changes and a file name is written out. If the '!' is given or 'autowrite' is not set, changed buffers are not written, don't forget to bring Vim back to the foreground later!

## References
- [Vim Homepage](https://www.vim.org/)
- [Source Cheat Sheet 1](https://ohshitvim.com/)
- [Source Cheat Sheet 2](https://www.radford.edu/~mhtay/CPSC120/VIM_Editor_Commands.htm) 
