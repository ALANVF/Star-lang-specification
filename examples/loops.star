use Core

module Main {
	on [main] {
		; while loop
		my i = 0
		while i < 5 {
			Core[say: i]
			i++
		}

		; do-while loop
		do {
			Core[say: i]
			i--
		} while i != 0

		; for loop
		for my i in: #[1, 2, 3] {
			Core[say: i]
		}

		for my k, my v in: #("a" => 1, "b" => 2, "c" => 3) {
			Core[say: "\(k): \(v)"]
		}

		; infinite loop (don't run!)
		forever {
			Core[say: "banana"]
		}
	}
}