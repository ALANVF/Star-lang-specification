use Core

module Main {
	on [newCounter] {
		my i = 0
		return {|| return i++}
	}

	on [main] {
		my c1 = [newCounter]
		my c2 = [newCounter]

		c1[call] ;=> 1
		c1[call] ;=> 2
		c1[call] ;=> 3
		c2[call] ;=> 1
		c1[call] ;=> 4
	}
}