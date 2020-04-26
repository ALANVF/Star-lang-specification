use Core

class Cell {
	my x (Int)
	my y (Int)
	
	on [neighbors] (Array[Cell]) {
		return #[-1, 0, 1][crossWith: #[-1, 0, 1] andCollect: {|_x, _y| (Cell)
			return Cell[x: x + _x y: y + _y]
		}]
	}

	operator `?=` [other (Cell)] (Bool) {
		return x ?= other.x && y ?= other.y
	}
}

class Colony {
	my width (Int)
	my height (Int)
	my cells (Array[Cell])
	
	on [neighborCounts] (Bag[Cell]) is hidden {
		return Bag[Cell][new: cells[collect: $0[neighbors]][flatten]]
	}
	
	on [Str] is cast is hidden {
		my out = ""

		for my y (Int) from: 0 to: height {
			for my x (Int) from: 0 to: width {
				out += cells[contains: Cell[:x :y]][yes: "#" no: "-"] + " "
			}

			out += "\n"
		}

		return out[trim]
	}
	
	on [runTimes: times] {
		for my i (Int) from: 0 to: times {
			Core
			-> [say: "Generation \(i + 1):"]
			-> [say: this[Str]]
			-> [say]
			
			this[runGeneration]
		}
	}
	
	on [runGeneration] is hidden {
		cells = this[neighborCounts][keepIf: {|cell, count| (Bool)
			return count ?= 2 && cells[contains: cell]) || count ?= 3
		}].keys
	}
}

module Main {
	on [main] {
		my blinker = #[
			Cell[x: 1 y: 0]
			Cell[x: 1 y: 1]
			Cell[x: 1 y: 2]
		]
		
		my colony = Colony[width: 3 height: 3 cells: blinker]
		
		Core[say: "Blinker:"]
		colony[runTimes: 3]
		
		my glider = #[
			Cell[x: 1 y: 0]
			Cell[x: 2 y: 1]
			Cell[x: 0 y: 2]
			Cell[x: 1 y: 2]
			Cell[x: 2 y: 2]
		]
		
		colony = Colony[width: 8 height: 8 cells: glider]

		Core[say: "Glider:"]
		colony[runTimes: 20]
	}
}