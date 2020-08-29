# Statements
These are statements that are valid inside method declarations.

Common rules:
```antlr
type-anno ::=
	'(' <type> ')'
```

### Expression
Any valid expression listed in the [expressions spec](expressions.md).

### Variable declaration
A variable declaration.

Spec:
```antlr
attribute ::=
	| 'readonly'

variable-decl ::=
	'my' <name> <type-anno>? ( 'is' <attribute> )* ( '=' <expr> )?
```

Examples:
```
my var1 = 1
my var2 (Dec) = 2.3
my var3 is readonly = "banana"
my var4 (Bool) is readonly = false
```

Notes:
- Although you may optionally leave out a default value, you must give the variable a value before using it later on in the program (will be checked at compile-time).
- There is no alternative syntax for `is readonly` because mutability is one of Star's core concepts (therefore immutability is discouraged).

### If statement
Spec:
```antlr
if-stmt ::=
	'if' <expr> <block> ( 'orif' <expr> <block> )* ( 'else' <block> )?
```

Examples:
```
if a {
	b
}

if a {
	b
} else {
	c
}

if a {
	b
} orif c {
	d
} orif e {
	f
}

if a {
	b
} orif c {
	d
} else {
	e
}
```

### Case statement
Similar to an if-orif-else chain, but it looks cleaner.

Spec:
```antlr
at-stmt ::=
	'at' <expr> <block>

else-stmt ::=
	'else' <block>

case-stmt ::=
	'case' <block(of:
		<at-stmt>*
		<else-stmt>?
	)>
```

Examples:
```
case {
	at a {
		b
	}

	at c {
		d
	}

	else {
		e
	}
}
```

### Match statement
Pattern matching for humans.

Spec:
```antlr
match-expr ::=
	| 'my' <name> <type-anno>? ( '=' <match-expr> )?
	| <array(of: <match-expr>)>
	| <hash(of: <match-expr>, <match-expr>)>
	| <tuple(of: <match-expr>)>
	| <type-constructor(of: <match-expr>)>
	| <type>
	| <expr>

at-stmt ::=
	'at' rep1sep(<match-expr>, ',') ( "\n"? 'if' <expr> )? <block>

else-stmt ::=
	'else' <block>

match-stmt ::=
	'match' <expr> <block(of:
		<at-stmt>*
		<else-stmt>?
	)>
```

Examples:
[pattern matching concept](../concepts/pattern-matching/pattern-matching.md)

### Inline-Match statement
For when you just want to match 1 thing.

Spec:
```antlr
match-inline-stmt ::=
	'match' <expr> 'at' <match-expr> ( 'if' <expr> )? <block> ( 'else' <block> )?
```

Examples:
```
match a at #[my b, my c] if b != c {
	d
}

match e at Maybe[the: my f] {
	...
} else {
	...
}
```

### While-loop statement
A loop that is controlled by a conditon.

Spec:
```antlr
while-stmt ::=
	'while' <expr> <block>
```

Examples:
```
while a {
	b
}
```

### Do-While-loop statement
Similar to a while-loop, but it's guaranteed to at least run once.

Spec:
```antlr
do-while-stmt ::=
	'do' <block> 'while' <expr>
```

### For-loop statement
A loop that is controlled by a counter or iterator, and optionally a condition.

Spec:
```antlr
loop-var ::=
	'my' <name> <type-anno>?

for-cond ::=
	| 'in:' <expr>
	| 'from:' <expr> 'to:' <expr> ( 'by:' <expr> )?

for-stmt ::=
	'for' <loop-var> ( ',' <loop-var> )? <for-cond> ( 'while:' <expr> )? <block>
```

Examples:
```
for my a in: b {...}
for my k (Str), v (Int) in: d while: v > 5 {...}
for my i from: 1 to: 10 by: 2 {...}
```

### Do statement
A statement that introduces a new scope.

Spec:
```antlr
do-stmt ::=
	'do' <block>
```

Examples:
```
do {...}
```

Notes:
- While similar in functionality, `{...}` on its own will act differently than `do {...}`.

### Return statement
Returns from a method, optionally with a value.

Spec:
```antlr
return-stmt ::=
	'return' <expr>?
```

Examples:
```
return
return a
```

### Break statement
Exits a loop, optionally with a specified nesting depth.

Spec:
```antlr
break-stmt ::=
	'break' \d*
```

Examples:
```
break
break 3
```

### Next statement
Exits the current iteration of a loop, optionally with a specified nesting depth.

Spec:
```antlr
next-stmt ::=
	'next' \d*
```

Examples:
```
next
next 3
```

### Panic statement
Throws an error.

Spec:
```antlr
panic-stmt ::=
	'panic' <expr>
```

Examples:
```
panic "error!"
panic SomeError[new]
```

Notes:
- I'll probably change the name of this at some point.


### Try-Catch statement
Needs work. Mostly here for completeness.

Spec:
```antlr
catch-var ::=
	'my' <name> <type-anno>?

try-catch-stmt ::=
	'try' <block> ( 'catch' <catch-var> <block> )*
```