module Main {
	on [main] {
		; Arrays in Star can only have one type
		my a1 = #[1, 2, 3] ;=> Array[Int]
		
		; An empty array has a special type of `Array` (as opposed to Array[Int] or Array[Bool]).
		; Whenever an empty array of an unspecified type is sent a message that requires any sort of data
		; that relates to the array's element type (such as adding a value), it's converted to an array of that data's type
		my a2 = #[] ;=> Array[_]
		
		a2[add: "banana"] ;=> Array[Str]
	}
}
