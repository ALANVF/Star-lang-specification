use Core

module Main {
	on [fact1: n (Int)] {
		if[n ?= 0] {
			return 1
		} else {
			return n * fact1[n - 1]
		}
	}
	
	on [fact2: n (Int)] {
		return [1 to: n][Array][reduce: {|a, b| return a * b}]
	}
	
	on [main] {
		say[fact1[5]] ;=> 120
		say[fact2[5]] ;=> 120
	}
}