use Core

module Main {
	on [main] {
		my doors = Array[Bool][length: 100][fill: false]
		
		for[my i in: [0 to: 99]] {
			for[my j in: [i to: 99 by: i + 1]] {
				doors[at: i] = !doors[at: i]
			}
		}
		
		for[my i, my door in: doors] {
			Core[say: "Door \(i+1) is \(door[yes: "open" no: "closed"])."]
		}
	}
}
