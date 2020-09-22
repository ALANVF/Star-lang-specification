```antlr
line-comment ::=
	";" ... EOL

embedded-comment ::=
	";[" ... "]"

sep ::=
	| ["\n\r"]
	| ","



name ::=
	| ['a'..'z'] ['A'..'Z', 'a'..'z', '0'..'9', '_']*
	| "_" ['A'..'Z', 'a'..'z', '0'..'9', '_']+

type ::=
	| ['A'..'Z'] ['A'..'Z', 'a'..'z', '0'..'9', '_']*
	| "_"

typename ::= rep1sep(type, '.') ('[' rep1sep(typename, ",") ']')?

typeanno ::= '(' typename ')'

label ::= name ":"

litsym ::= "`" ... "`"

digit ::= ['0'..'9']

number ::=
	| ["+-"]? digit+ (["eE"] ["+-"]? digit+ ('.' digit+)?)?
	| ["+-"]? digit+ '.' digit+ (["eE"] ["+-"]? digit+ ('.' digit+)?)?

string ::= '"' ... '"'

bool ::=
	| "true"
	| "false"

array ::= "#[" repsep(expr, sep) "]"

hash ::= "#(" repsep(expr "=>" expr, sep) ")"

function ::=
	"{"
		"|" repsep(name typeanno?, ",") "|" typeanno?
		repsep(statement, sep)
	"}"

block ::= "{" repsep(statement, sep) "}"

prefix-sym ::=
	| "-" | "+" | "!" | "~"
	| "++" | "--"

postfix-sym ::=
	| "++" | "--"
	| "?"

binary-sym ::=
	| "**"
	| "*" | "/" | "//" | "%"
	| "+" | "-"
	| "%%"
	| "&" | "|" | "^" | ">>" | "<<"
	| "&&" | "||" | "^^"

prefix ::= prefix-sym expr

postfix ::= expr postfix-sym

binary ::=
	| expr "." name
	| expr ("?=" | "!=" | ">=" | "<=" | ">" | "<") expr
	| expr binary-sym "="? expr
	| expr "=" expr

call ::=
	| expr "[" rep1sep(param, sep?) "]"
	| "[" expr? rep1sep(param, sep?) "]"



arg ::=
	| name typeanno? "..."?
	| label name typeanno? "..."?
	| label typeanno "..."?

param ::=
	| name
	| label expr
	| expr

attr ::=
	"is" (
	| "hidden"
	| "static"
	| "readonly"
	| "writeonly"
	| "unordered"
	| "custom"
	| "getter"
	| "setter"
	| "inline"
	| "noinherit"
	| "main"
	| "native" (
		| '"' ... '"'
		| '[' ... ']'
	)?
	| "c_struct"
	| "c_union"
	| "c_enum"
	| "flags"
	| "uncounted"
	| "strong"
	)

macro-attr ::=
	"is" (
	| "pattern"
	| "statement"
	| "unordered"
	)



var-decl ::= "my" name typeanno? attr* ("=" expr)?

generic-decl ::= "type" typename ("of" rep1sep(typename, ","))? ("if" expr)?

alias-decl ::= "alias" typename attr* "=" typename

on ::=
	| "on" "[" rep1sep(arg, sep?) "]" typeanno? attr* block?
	| "on" "[" typename "]" typeanno? attr* block?

init-decl ::= "init" "[" rep1sep(arg, sep?) "]" attr* block?

deinit-decl ::= "deinit" block

op-decl ::= "operator" litsym ("[" (name typeanno?)? "]")? typeanno? attr* block?

class-decl ::= "class" typename ("of" rep1sep(typename, ","))? attr* block?

protocol-decl ::= "protocol" typename ("of" rep1sep(typename, ","))? attr* block?

category-decl ::= "category" typename "for" typename attr* block?

kind-decl ::= "kind" typename typeanno? attr* block

module-decl ::= "module" typename attr* block?

macro-decl ::= "macro" "[" ... "]" macro-attr* "{" ... "}"



expr ::=
	| "this"
	| bool
	| name
	| number
	| string
	| array
	| hash
	| block
	| function
	| call
	| prefix
	| postfix
	| binary
	| "(" expr ")"

statement ::=
	| generic-decl
	| alias-decl
	| on
	| init-decl
	| deinit-decl
	| op-decl
	| var-decl
	| class-decl
	| protocol-decl
	| category-decl
	| kind-decl
	| module-decl
	| "use" expr
	| "return" expr?
	| "break" digit*
	| "next" digit*
	| macro-decl
	| expr
```
