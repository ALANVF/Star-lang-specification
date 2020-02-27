use Core

; this is kinda outdated with the category concept but eh

catagory DoStuff for Int {
	on [doStuff] {
		return "thing"
	}
}

catagory DoThings {
	on [doThings] {
		return "stuff"
	}
}

module Main {
	on [main] {
		Core[say: 1[doStuff]]                             ;=> "thing"
		Core[say: 1[inCatagory: DoStuff]]                 ;=> true

		Core[say: 1[Int[DoThings]][doThings]]             ;=> "stuff"
		Core[say: 1[inCatagory: DoThings]]                ;=> false
		Core[say: 1[Int[DoThings]][inCatagory: DoThings]] ;=> true
	}
}
