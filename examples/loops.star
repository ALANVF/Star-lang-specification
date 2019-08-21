use Core

module Main {
	on [main] {
		; while loop
		my i = 0
		while[i < 5] {
			say[i]
			i++
		}

		; do-while loop
		do {
			say[i]
			i--
		} while[i != 0]

		; for loop
		for[my i in: #[1, 2, 3]] {
			say[i]
		}

		for[my k, my v in: #("a" => 1, "b" => 2, "c" => 3)] {
			say["\(k): \(v)"]
		}

		; infinite loop (don't run!)
		forever {
			say["banana"]
		}
	}
}