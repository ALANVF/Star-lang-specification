use Core

module Main {
	on [main] {
		;[
			In Star, the `?` postfix operator is used to test if the variable has a value. Note that there is no "null" literal. Instead, a variable that is not assigned a value is classified as "null".
			Also, using a "null" value in an expression other than `?` or an assignment will result in an error.
			Lastly, if you never assign a variable a value, and you don't specify its type, you will also get an error.
		]
		my noValue
		say[noValue?] ;=> false
		noValue = "no value"
		say[noValue?] ;=> true
	}
}