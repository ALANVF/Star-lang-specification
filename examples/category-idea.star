use Core

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
		say[1[doStuff]]                             ;=> "thing"
		say[1[inCatagory: DoStuff]]                 ;=> true

		say[1[Int[DoThings]][doThings]]             ;=> "stuff"
		say[1[inCatagory: DoThings]]                ;=> false
		say[1[Int[DoThings]][inCatagory: DoThings]] ;=> true
	}
}
