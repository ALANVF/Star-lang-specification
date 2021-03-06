I don't think I need to explain what pattern matching is if you're already here.

Basic structure:
```swift
match value {
	at firstPossibleValue {
		...
	}

	at secondPossibleValue, thirdPossibleValue {
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
```swift
match value at my matchingValue (SomeType) if someCondition ?= true {
	...
} else {
	...
}
```

In a match statement, you can have a variety of different things. none of them are really mind-blowing though:
- basic match: `at someValue {...}`:
	- This statement checks to see if the current value is equal to someValue. If it is, the body of the statement is run it exits the match statement.
	- All other statements will exit after their body is run.
	- Any sort of "fall-through" statement is TBD.

- conditional match: `at someValue if someCondition {...}`:
	- This statement succeeds if the current value matches someValue and someCondition is true. This can be added to any kind of statement.

- default match: `else {...}`:
	- Self-explanatory I think.

- capture: `my matchingValue`:
	- This statement assigns the current value to matchingValue. it always succeeds when used by itself.
	- This can be used inside match statements such as at #[1, my secondValue], as well as in conditional statements.
	- Here, the statement succeeds if the array's length is 2 and the first element of the array is 1. The second value is then assigned to the second element of the array.
	
- destructuring: `#[1, my value (Int)]`
	- You can destructure classes, kinds, and arrays. Stuff for destructuring hashes is TBD.
	- Definition behavior of `...` (spread operator) for destructuring arrays, hashes, and tuples is TBD.


I'd also like to have match expressions such as the | and & operators seen in functional programming languages like F#.