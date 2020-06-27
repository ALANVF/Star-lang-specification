use Core

module Main {
	on [main] {
		;[ (this might be changed later)
			In Star, the `?` postfix operator is used to test if the variable has a value. Note that there is no "null" literal. Instead, a variable that is not assigned a value is classified as "uninitialized".
			Also, using an "uninitialized" value in an expression other than `?` or an assignment will result in an error.
			If you never assign a variable a value, and you don't specify its type, you will also get an error.
			Lastly, `?` can be used to check for null pointers when using C libs.
		]
		my noValue
		Core[say: noValue?] ;=> false
		noValue = "no value"
		Core[say: noValue?] ;=> true
	}
}