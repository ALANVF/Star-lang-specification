```less
// todo: macros

line-comment ::=
	";" ... EOL

embedded-comment ::=
	";[" ... "]"

sep ::=
	| ["\n\r"]
	| ","



name ::= ['a'..'z'] ['A'..'Z', 'a'..'z', '0'..'9', '_']*

type ::=
	| ['A'..'Z'] ['A'..'Z', 'a'..'z', '0'..'9', '_']*
	| "_"

typename ::=
	rep1sep(type, '.')

typeanno ::=
	'(' typename ')'

label ::= name ":"

digit ::= ['0'..'9']

number ::=
	| ["+-"]? digit+ (["eE"] ["+-"]? digit+ ('.' digit+)?)?
	| ["+-"]? digit+ '.' digit+ (["eE"] ["+-"]? digit+ ('.' digit+)?)?

string ::=
	| '"' ... '"'
	| "'" ... "'"

bool ::=
	| "true"
	| "false"

array ::=
	"#[" repsep(expr, sep) "]"

hash ::=
	"#(" repsep(expr "=>" expr, sep) ")"

function ::=
	"{"
		"|" rep1sep(arg, sep?) "|" typeanno?
		repsep(statement, sep)
	"}"

block ::=
	"{" repsep(statement, sep) "}"

unary-sym ::=
	["-+!~"]

postfix-sym ::=
	["+-"]{2}

binary-sym ::=
	| "**"
	| ["*/%"]
	| ["+-"]
	| ["&|^"] | ">"{2,3} | "<<"
	| ["?!<>"]"=" | ["<>"]
	| ["&|^"]{2}

unary ::=
	["-+!~"] expr

postfix ::=
	| expr ["+-"]{2}
	| expr '?'

// '\\' is broken or something
binary ::=
	| expr "." name
	| expr '\\ '["&|^"] expr
	| expr "**" expr
	| expr ["*/%"] expr
	| expr ["+-"] expr
	| expr (["&|^"] | ">"{2,3} | "<<") expr
	| expr (["?!<>"]"=" | ["<>"]) expr
	| expr (["&|^"]{2} expr
	| expr (["&|*^"]{1,2} | ["+-/%"] | ">"{2,3} | "<<")?"=" expr

call ::=
	| expr "[" repsep(param, sep?) "]"
	| "[" rep1sep(param, sep?) "]"



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
		| "main"
	)

macro-attr ::=
	"is" (
		| "pattern"
		| "statement"
	)



var-decl ::=
	"my" name typeanno? attr* ("=" expr)?

on ::=
	| "on" "[" rep1sep(arg, sep?) "]" typeanno? attr* block
	| "on" "[" typename "]" attr* block

init-decl ::=
	"init" "[" rep1sep(arg, sep?) "]" attr* block

unary-decl ::=
	"operator" unary-sym typeanno? attr* block

postfix-decl ::=
	"operator" postfix-sym typeanno? attr* block

binary-decl ::=
	"operator" binary-sym "[" name typeanno? "]" typeanno? attr* block

class-decl ::=
	"class" typename ("of" rep1sep(typename, ","))? attr* block

module-decl ::=
	"module" typename attr* block

macro-decl ::=
	"macro" "[" ... "]" macro-attr* "{" ... "}"



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
	| unary
	| postfix
	| binary
	| "(" expr ")"

statement ::=
	| on
	| init-decl
	| unary-decl
	| postfix-decl
	| binary-decl
	| var-decl
	| "alias" typename
	| class-decl
	| module-decl
	| "use" expr
	| "return" expr?
	| "break" expr?
	| "next"
	| macro-decl
	| expr
```