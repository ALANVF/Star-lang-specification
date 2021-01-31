class A {
	on [f] (Int) {return 1}
}

class B {
	on [f] (Int) {return 2}
}

class C of A, B {}

module Main {
	on [main] {
		Core[say: C[new][f]] ;=> 2
	}
}
