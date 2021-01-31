; this is kinda outdated with the category concept but eh

category DoStuff for Int {
	on [doStuff] {
		return "thing"
	}
}

category DoThings {
	on [doThings] {
		return "stuff"
	}
}

module Main {
	on [main] {
		Core[say: 1[doStuff]]                             ;=> "thing"
		Core[say: 1[inCategory: DoStuff]]                 ;=> true

		Core[say: 1[Int[DoThings]][doThings]]             ;=> "stuff"
		Core[say: 1[inCategory: DoThings]]                ;=> false
		Core[say: 1[Int[DoThings]][inCategory: DoThings]] ;=> true
	}
}
