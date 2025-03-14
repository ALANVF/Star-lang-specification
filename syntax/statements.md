# Statements
These are statements that are valid inside method declarations.

Common rules:
```antlr
type-anno ::=
	'(' <type> ')'

then ::=
	| <block>
	| '=>' <statement>
```

### Expression
Any valid expression listed in the [expressions spec](expressions.md).

### Variable declaration
A variable declaration. Technically an expression, but listed here as a statement for documentation purposes.

Spec:
```antlr
variable-decl ::=
	'my' <name> <type-anno>? ( '=' <expr> )?
```

Examples:
```
my var1 = 1
my var2 (Dec) = 2.3
```

Notes:
- Although you may optionally leave out a default value, you must give the variable a value before using it later on in the program (will be checked at compile-time).

### If statement
Spec:
```antlr
if-stmt ::=
	| 'if' <expr> <block> ( 'else' <block> )?
	| 'if' <expr> '=>' <statement>
```

Examples:
```
if a {
	b
}

if a => b

if a {
	b
} else {
	c
}
```

### Case statement
Similar to the else-if syntax in common languages, but it looks cleaner.

Spec:
```antlr
at-stmt ::=
	'at' <expr> <then>

else-stmt ::=
	'else' <then>

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
	| 'my' <name> <type-anno>?
	| <match-expr> '=' <match-expr>
	| <array(of: <match-expr>)>
	| <hash(of: <match-expr>, <match-expr>)>
	| <tuple(of: <match-expr>)>
	| <type-constructor(of: <match-expr>)>
	| <type>
	| <expr(as: <match-expr>)>
	| <expr>

at-stmt ::=
	'at' <match-expr> ( "\n"? 'if' <expr> )? <then>

else-stmt ::=
	'else' <then>

match-stmt ::=
	'match' <expr> <block(of:
		<at-stmt>*
		<else-stmt>?
	)>
```

Examples:
[pattern matching concept](../design/pattern-matching.md)

### Inline-Match statement
For when you just want to match 1 thing.

Spec:
```antlr
match-inline-stmt ::=
	'match' <expr> 'at' <match-expr> ( 'if' <expr> )? (
		| <block> ( 'else' <block> )?
		| '=>' <statement>
	)
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
	'while' <expr> ( 'label:' <litsym> )? <then>
```

Examples:
```
while a {
	b
}

while a label: `b` {
	break `b`
}
```

### Do-While-loop statement
Similar to a while-loop, but it's guaranteed to at least run once.

Spec:
```antlr
do-while-stmt ::=
	'do' ( 'label:' <litsym> )? <block> 'while' <expr>
```

### For-loop statement
A loop that is controlled by a counter or iterator, and optionally a condition.

Spec:
```antlr
loop-var ::=
	'my' <name> <type-anno>?

for-cond ::=
	| 'in:' <expr>
	| ( 'from:' | 'after:' ) <expr> ( 'upto:' | 'downto:' | 'to:' | 'times:' ) <expr> ( 'by:' <expr> )?

for-stmt ::=
	'for' <match-expr> ( ',' <match-expr> )? <for-cond> ( 'while:' <expr> )? ( 'label:' <litsym> )? <then>
```

Examples:
```
for my a in: b {...}
for my k (Str), v (Int) in: d while: v > 5 {...}
for my i from: 1 to: 10 by: 2 {...}
for #{my a, my b} in: pairs {...}
for my value in: array => ...
```

Notes:
- `upto:` and `after:` are exclusive.
- ~~`after:` can't actually be used with `times:`, I'm just too lazy to rewrite the grammar.~~ This probably works fine now that I think about it.

### Recurse statement
A loop that recurses like a recursive function.

Spec:
```antlr
recurse-stmt ::=
	'recurse' <lvar> ( ',' <lvar> )* ( 'label:' <litsym> )? <then>
```

Example:
```
use List from: Immutable

recurse my list = List #[1, 2, 3] {
	match list at List[head: my value tail: my rest] {
		Core[say: value]
		next with: rest
	} else {
		break
	}
}

;=> 1
;=> 2
;=> 3
```

### Do statement
A statement that introduces a new scope.

Spec:
```antlr
do-stmt ::=
	'do' ( 'label:' <litsym> )? <block>
```

Examples:
```
do {...}
do label: `blk` {...}
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

Notes:
- `return`ing inside a block expression will return from the block, NOT the method.

### Break statement
Exits a loop, optionally with a specified nesting depth.

Spec:
```antlr
break-stmt ::=
	'break' ( <int> | <litsym> )?
```

Examples:
```
break
break 3
break `outer`
```

### Next statement
Exits the current iteration of a loop, optionally with a specified nesting depth.

It may also be supplied with values via `with:` when used inside a `recurse` statement

Spec:
```antlr
next-stmt ::=
	'next' ( <int> | <litsym> )? ( 'with:' <expr> ( ',' <expr> )* )
```

Examples:
```
next
next 3
next `outer`
next with: values, i + 1
```

### Throw statement
Throws an error.

Spec:
```antlr
throw-stmt ::=
	'throw' <expr>?
```

Examples:
```
throw "error!"
throw SomeError[new]
throw                ;-- rethrows
```

### Try-Catch statement
Spec:
```antlr
at-stmt ::=
	'at' <match-expr> ( "\n"? 'if' <expr> )? <then>

try-catch-stmt ::=
	'try' <block> ('catch' <block(of:
		<at-stmt>*
		<else-stmt>?
	)>)?
```