use Core

module Main {
	on [main] {
		;[
			Star does not have the concept of "null", but rather "not yet assigned". You
			may declare variable/member without giving it a value, but it cannot be used
			until it has (definitely) been assigned a value. These checks are done at
			compile-time, which guarantees that there won't be any null errors at runtime.
		]

		my noValue (Int)

		Core[say: noValue] ;=> Throws an error
		
		if someCondition {
			noValue = 1
		}

		Core[say: noValue] ;=> Throws an error, even if `someCondition` is always true
		
		noValue = 2
		
		Core[say: noValue] ;=> 2
	}
}