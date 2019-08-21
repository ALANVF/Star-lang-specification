use Core

module Main {
	on [main] {
		for[my i in: [99 to: 0]] {
			say["\(i) bottle(s) of beer on the wall, \(i) bottle(s) of beer."]
			my n = [i ?= 0 yes: "no more" no: "\(i - 1)"]
			say["Take one down, pass it around", "\(n) bottle(s) of beer."]
		}
	}
}