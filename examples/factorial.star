module Main {
	on [fact1: n (Int)] (Int) {
		if n ?= 0 {
			return 1
		} else {
			return n * Main[fact1: n - 1]
		}
	}
	
	on [fact2: n (Int)] (Int) {
		return 1[to: n][Array[Int]][reduce: $0 * $1]
	}
	
	on [main] {
		Core[say: Main[fact1: 5]] ;=> 120
		Core[say: Main[fact2: 5]] ;=> 120
	}
}
