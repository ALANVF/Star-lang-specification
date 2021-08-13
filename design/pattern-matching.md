I don't think I need to explain what pattern matching is if you're already here.

Basic structure:
```scala
match value {
	at firstPossibleValue {
		...
	}

	at secondPossibleValue || thirdPossibleValue {
		...
	}

	at fourthPossibleValue
	if someCondition ?= true {
		...
	}

	at my matchingValue (SomeType)
	if matchingValue != someOtherValue {
		...
	}

	else {
		...
	}
}
```

Condensed form:
```scala
match value at my matchingValue (SomeType) if someCondition ?= true {
	...
} else {
	...
}
```

Try/Catch statement:
```scala
try {
	...
} catch {
	at Error1 => ...
	
	at my e (Error2) {
		...
	}
	
	else {
		...
	}
}
```

In a match or try/catch statement, you can have a variety of different things:
- basic match: `at someValue {...}`:
	- This statement checks to see if the current value is equal to someValue. If it is, the body of the statement is run it exits the match statement.
	- All other statements will exit after their body is run.
	- Any sort of "fall-through" statement is TBD.
	- `| pattern => ...` will never be a thing. deal with it pls.

- conditional match: `at someValue if someCondition {...}`:
	- This statement succeeds if the current value matches someValue and someCondition is true.
	- `if someCondition` may optionally be placed on a new line/

- default match: `else {...}`:
	- Self-explanatory I think.

- expression: `myValue`:
	- Matches a normal value or expression.
	- BARE VARIABLE NAMES ARE NOT CAPTURES, PLEASE USE `my myValue` TO CAPTURE THEM.
		- Bare variables are instead compared by value. Be happy, at least they're compared structurally by default (like normal `?=`).

- capture: `my matchingValue`:
	- This statement assigns the current value to `matchingValue`. it always succeeds when used by itself.
	- A type annotation can be added to the capture, in which case it'll only match if the value is an instance of the type, and the variable will become the value cast to the matched type.
		- This is is similar to "flow-typing" seen in languages like Dart and TypeScript.
	- This can be used inside match statements such as at #[1, my secondValue], as well as in conditional statements.
	- Here, the statement succeeds if the array's length is 2 and the first element of the array is 1. The second value is then assigned to the second element of the array.
	
- destructuring: `#[1, my value (Int)]`:
	- You can destructure classes, kinds, and arrays. Stuff for destructuring hashes is TBD.
	- Definition behavior of `...` (spread operator) for destructuring arrays, hashes, and tuples is TBD.
	- `my #{a, b}` is invalid syntax, please use `#{my a, my b}` instead.
	- For types that have literal constructors (like `Series[T]`), you can leave out the type prefix when destructuring at the top-level.
		- Maybe don't do this?

- extractor: `#{a, my b} = _[doSomething]`:
	- This feature is shamelessly taken from [Haxe's feature](https://haxe.org/manual/lf-pattern-matching-extractors.html) with the same name.
	- The behavior of an extractor is equivilent to destructuring assignment (which means that `var = _` can be used to reassign an existing variable).
		- If you want to match against a variable instead of reassign it, use a conditional pattern.
	- `&`, `|`, `^`, and `~` can be used for matching on multi-kinds.
		- Why do I need `|` here again?
	- Not sure if cascades will be allowed here.
		- If you really need cascades for destructuring, you're probably doing it wrong in the first place.

- logical pattern: `a && b`:
	- `&&`, `||`, `^^`, `!!`, and `!` work with patterns as well as normal expressions
		- Inside parentheses, the binary operator can also be at the start of the expression, that way you can align everything nicely.
		- Yes, they all work exactly how you think they do.
	- `?` is planned to be used for optional values in sequential patterns, but nothing is final yet.
	- Todo: should `!` and `?` operator overloads be ignored?

- conditional pattern: `_ != 1`:
	- Different from a conditional match
	- Works with method calls, not just operators
	- `a <= _ <= b` is a range pattern without any overhead (and either side can be made exclusive by changing the op to `<`)

Also, the arrow syntax `=> stmt` can be used in place of blocks in an `at` or `else` branch (except in condensed match statements).
Please don't accidently do `=> {...}`