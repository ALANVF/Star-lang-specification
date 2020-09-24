use Core
use IO

module Main {
	on [evaluateGuess: guess (Str) withCode: code (Str)] (Str) {
		return guess[collect: {|char, i|
			if char ?= code[at: i] {
				return #"X"
			} orif code[contains: char] {
				return #"O"
			} else {
				return #"-"
			}
		}][sort][reverse]
	}

	on [main] {
		my intReader = Core.stdin[IO[Int]]
		my boolReader = Core.stdin[IO[Bool]]

		my numColors = intReader[
			prompt: "Number of colors to use (2 - 20): "
			withinRange: 2[to: 20]
		]

		my colors = #"A"[upto: #"A" + numColors][Str]

		my allowDuplicates = boolReader[prompt: "Are duplicates allowed? "]

		my minLength = allowDuplicates[
			yes: 4
			no: 4[min: numColors]
		]
		my maxLength = allowDuplicates[
			yes: 10
			no: 10[min: numColors]
		]
		my codeLength = intReader[
			prompt: "Length of the code (\(minLength) - \(maxLength)): "
			withinRange: minLength[to: maxLength]
		]

		my maxGuesses = intReader[
			prompt: "Enter the max number of guesses (7 - 20): "
			withinRange: 7[to: 20]
		]

		my code = allowDuplicates[
			yes: colors[roll: codeLength]
			no: colors[pick: codeLength]
		]
		
		my guesses = #[]

		for my i from: 1 to: maxGuesses {
			my guess = Core[prompt: "Your guess (\(i)/\(maxGuesses)): "][trim][lower][to: codeLength]
			my res = Main[evaluateGuess: guess withCode: code]
			
			guesses[add: guess => res]

			for my guess in: guesses {
				Core[say: "\(i) : \(guess.key) : \(guess.value)"]
			}

			Core[say: "-" * 30]

			if res[all: $0 ?= #"X"] {
				Core[say: "You won! The code was \(code)"]
				break
			} orif i ?= maxGuesses {
				Core[say: "You lost... The code was \(code)"]
			}
		}
	}
}