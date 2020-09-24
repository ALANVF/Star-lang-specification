use Core

module Main {
	on [main] {
		my doors = #[false] * 100
		
		for my i from: 0 to: 99 {
			for my j from: i to: 99 by: i + 1 {
				doors[at: i] = !doors[at: i]
			}
		}
		
		for my i, my door in: doors {
			Core[say: "Door \(i + 1) is \(door[yes: "open" no: "closed"])."]
		}
	}
}
