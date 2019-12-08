use Core

module Main {
	on [main] {
		; Arrays in Star can only have one type
		my a1 = #[1, 2, 3], say[a1[typeName]] ;=> Array[Int]
		
		; An empty array has a special type of `Array` (as opposed to Array[Int] or Array[Bool]).
		; Whenever an empty array of an unspecified type is sent a message that adds any sort of data, it is
		; converted to an array of that data's type
		my a2 = #[]
		say[a2[typeName]] ;=> Array[_]
		a2[pushValue: "banana"]
		say[a2[typeName]] ;=> Array[Str]
		
		; I might expand on this or change some ideas later, but for now, this is what I'm thinking.
	}
}
