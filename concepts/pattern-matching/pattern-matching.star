; I don't think I need to explain what pattern matching is if you're already here.

; basic structure:
match[value] {
	at[firstPossibleValue] {
		; ...
	}

	at[secondPossibleValue, thirdPossibleValue] {
		; ...
	}

	at[fourthPossibleValue]
	if[someCondition ?= true] {
		; ...
	}

	at[my val]
	if[val != someValue] {
		; ...
	}

	default {
		; ...
	}
}

;[ in a match statement, you can have a variety of different things. none of them are really mind-blowing though.
- basic match: at[someValue] {...}
	this statement checks to see if the current value is equal to someValue. if it is, the body of the statement is run it exits the match statement.
	all other statements will exit after their body is run.
	any sort of "fall through" statement is TBD.

- multiple match: at[someValue1, someValue2, ... someValueN] {...}
	this statement succeeds if the current value matches at least one of the values this statement.

- conditional match: at[someValue] if[someCondition] {...}
	this statement succeeds if the current value matches someValue and someCondition is true. this can be added to any kind of statement.

- default match: default {...}
	self-explanatory I think.

- capture: my matchingValue
	this statement assigns the current value to matchingValue. it always succeeds when used by itself.
	this can be used inside match statements such as at[#[1, my secondValue]], as well as in conditional statements.
	here, the statement succeeds if the array's length is 2 and the first element of the array is 1. the second value is then assigned to the second element of the array.
	
- destructuring: #[1, 2]
	you can destructure classes, kinds, and arrays. semantics for destructuring hashes is TBD.
]



; I'd also like to have match expressions such as the |, &, and :: operators seen in functional programming languages like F#.
