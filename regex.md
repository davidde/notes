# Regex intro
Regular expressions or regexes are character sequences that define a search pattern, e.g. for "find and replace" operations.
Different syntaxes for writing regular expressions exist, like the POSIX standard and the Perl syntax.   

Especially the Perl syntax is widely employed for string manipulation. A good example is the `rename` command:   
$ `rename -n 's/.rar/.cbr/' *.rar`  
(**Debian/Ubuntu Perl-based version** of rename by Larry Wall & Robin Barker,  
named 'prename' on CentOS and Fedora!)  
Batch rename all files in the current working directory from .rar to .cbr  
-n, -nono: no-execute mode; just print out the changes without actually making them.  
-v, -verbose: Print names of files successfully renamed.  


## Substitution: using 's/regex/replacement/modifiers'  
's': substitute  
'regex': the regex pattern that you want to replace  
'replacement': what should replace the regex  
'modifiers': options of the regex itself, e.g.:  
  - 'g': global; affects all occurrences of the expression  
  - 'i': perform case-insensitive substitution  
$ `rename -n 's/DSC/photo/gi' *.jpg`   
=> This would apply to all .jpg files that contain 'DSC', 'dsc' or 'dSC',
and change that part of the filename to 'photo'.  

## Translation: using 'y/regex/replacement/modifiers'
-> most often used to change the filename case:  
$ `rename 'y/a-z/A-Z/' *.jpg`  
=> This would change the names of all .jpg files from lowercase to uppercase.  

## Legend

| regex symbol |        Meaning                 |             Examples                         |
|--------------|--------------------------------|----------------------------------------------|
|  .           | any character except newline   | `.a` matches two consecutive characters where the last one is "a" |
|  ^           | - anchor for start of string   | `^a` matches "a" at the start of the string  |
|              | - negation symbol              | `[^0-9]` matches any non digit               |
|  $           | - anchor for end of string     | `b$` matches "b" at the end of a line        |
|              |                                | `^$` matches the empty string                |
|              | - backreference at sub-expression | A search for `(a)(c)` in the string "abc", followed by a replace `$2$1` results in "cba" |
|  < >         | anchors that specify a left or right word boundary |                          |
|  *           | match-zero-or-more quantifier  | `^.*$` matches an entire line                |
|  +           | match-one-or-more quantifier   |                                              |
|  ?           | match-zero-or-one quantifier   |                                              |
|  \|          | separates a series of alternatives | `(a\|b\|c)a` matches "aa" or "ba" or "ca"  |
|                                                                                              |
|  \           | escape character               |                                              |
|  \\. \\* \\\ | escaped special characters     | `\.` matches the literal dot "."            |
|              |                                | `\\` matches the actual backslash "\\"     |
|  \t \n \r    | tab, linefeed, carriage return |
|  \w \d \s    | word, digit, whitespace        |
|  \W \D \S    | not word, digit, whitespace    |	
|                                                                                              |
|  { }         | range quantifiers              | `a{2,3}` matches "aa" or "aaa"               |
|  ( )         | used for grouping characters or other regexes, creating a numbered capturing group. (It stores the part of the string matched by the capturing group for later retrieval.) | `Set(Value)?` matches "Set" or "SetValue". In the first case, the first (and only) capturing group remains empty. In the second case, the first capturing group matches "Value" |
|  [ ]         | character class to match a single character |                                 |
|  [abc]	     | any of a, b, or c              |
|  [^abc]      | not a, b, or c                 |
|  [a-g]	     | character between a & g        |
|  [A-Z]	     | any uppercase letter           |
|                                                                                              |
|  (?=…)       | Positive lookahead	            | `(?=\d{10})\d{5}` matches	01234 in 0123456789  |
|  (?<=…)      | Positive lookbehind	          | `(?<=\d)cat` matches	cat in 1cat              |
|  (?!…)       | Negative lookahead             | `(?!theatre)the\w+`	theme                      |
|  (?<!…)      | Negative lookbehind            | `\w{3}(?<!mon)ster`	Munster                    |
| (?:…)        | Non-capturing group  | The capturing group will be ignored, and the first capturing will be the first capturing group without `?:` |

E.g.:
* ```
  (https?|ftp)://([^/\r\n]+)(/[^\r\n]*)?
  ```
  (`[^/\r\n]+` matches 1 or more characters that are not `/`, `\r` or `\n`)  
  <br>
  Matches:
  ```
  Match "http://stackoverflow.com/"
      Group 1: "http"
      Group 2: "stackoverflow.com"
      Group 3: "/"

  Match "https://stackoverflow.com/questions/tagged/regex"
      Group 1: "https"
      Group 2: "stackoverflow.com"
      Group 3: "/questions/tagged/regex"
  ```
* But:
  ```
  (?:https?|ftp)://([^/\r\n]+)(/[^\r\n]*)?
  ```
  Matches:
  ```
  Match "http://stackoverflow.com/"
      Group 1: "stackoverflow.com"
      Group 2: "/"

  Match "https://stackoverflow.com/questions/tagged/regex"
      Group 1: "stackoverflow.com"
      Group 2: "/questions/tagged/regex"
  ```