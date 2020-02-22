;[ For the record:
	`...` = litstym
	(...) = paren
	[...] = group
	{...} = block
	a.b   = member
]


; Yay macros!
; Honestly this is probably the most experimental idea I've had for Star so far.
; Also, I'd highly recommend looking at how languages such as Crystal, Elixir, Julia, Red,
; and Nim use macros if you have little/no experience with macros.

; So Star has 2 kinds of macros: hygienic macros and pattern macros.
; Macros act similarly to regular methods, however they are run at compile-time rather
; than being run at run-time.
; Macros can also be overloaded, and can (maybe) have generic arguments (I'll explain later).

; I'll start with hygienic macros first since they're simpler.

; A simple hygienic macro:
macro [typeOf: expr (AST.Expr)] {
	@(expr.valueType)
}

Core[say: 2.3[[typeOf: 1]]] ;=> 2

; As you can see, hygienic macros are called like normal methods (hence the name "hygienic").
; They can take arguments just like normal methods, but their arguments can be "AST typed"
; as well as being normally typed.
; By "AST typed", I mean that it matches on the expression's syntactic type rather than
; its runtime type.
; This can be quite helpful if you want an argument to be entered in its "raw" form.
; For example, Int will match `(1 + 2)` and `myInt` assuming that myInt is an integer.
; However, AST.name will not match `(1 + 2)`, but will match `myInt` since `myInt` is
; a variable name.
; (This type behavior applies to all forms of macros).

; As mentioned before, I've been considering allowing macros to have generic arguments.
; I currently can't think of an example for this, but I might elaborate on it more in the future.



; Star also has "pattern" macros, which match on syntax rather than method calls.
; For an example, take a look at Accessors/Accessors.star and example.star before continuing.

; In case you didn't notice, pattern macros represent language grammar.
;[ Here are the rules I've come up with so far for it
	- `something`
		I haven't really gone into detail about it, but `...` represents a ruby-like "symbol" (called a litsym).
		In macro grammar, they match literal identifiers and operators.

	- (Type)
		This succeeds if the current node is an instance of Type.

	- name (Type)
		This captures the current node as long as its an instance of Type.

	- label: (Type)
		Similar to the last rule, but it requires the `label:` part to match.

	- label: name (Type)
		Self-explanatory.

	- name [rules...]
		Captures a group (as name) where the contents match rules.
		Any arguments declared inside the group are accessible as members of name.
		Adding the unordered attribute allows the group contents match the rules in any order.
		
	- name {rules...}
		Captures a block (as name) where the contents match rules
		Adding the unordered attribute allows the block contents match the rules in any order.
]

; There are still many more rules that I would like to add such as alternation, repetition, optional rules,
; rules inside parens, and possibly some form of recursive rules (rules that can reference themselves).

; The body of a macro represents what the resulting AST will be.
; Regular syntax will not be changed when during macro expansion, however macro-specific syntax will.
;[ Here are the rules I've come up with so far for this:
	- @name
		This inserts whatever was captured by `name` in the macro definition.
		I might change this in the future, but if @name is a regular variable name, then doing `@name:` will
		result in an error since it would basically result in `varName :` rather than `varName:`.

	- @(...)
		This evaluates whatever is in the (...) and inserts it.
		It's basically just a normal (...) but for macro stuff if that makes sense.
		I've also been considering allowing macro-level variables to be defined in this construct.
	
	- @[...] @{...}
		This is kinda like a macro-level flow control construct.
		For example, you could do something like this:
			@[for: my name in: #[`a`, `b`, `c`]] @{
				my @name (Int)
			}
		And then it would expand to something like this:
			my a (Int)
			my b (Int)
			my c (Int)
		I'm hoping that these can support stuff like conditionals, loops, and possibly even more.
]

; I've also considered implementing something along the lines of Raku's "grammars", where named rules are defined
; inside a namespace and can be referenced by each other to make complex macros easier to make/use.

; I'm hoping that pattern macros can be used to make DSLs for various things, and maybe even to build custom
; programming languages inside Star.
