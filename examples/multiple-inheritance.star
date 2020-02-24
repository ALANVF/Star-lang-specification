use Core

class A {
	on [f] {return 1}
}

class B {
	on [f] {return 2}
}

class C of A, B {}

module Main {
	on [main] {
		Core[say: C[new][f]] ;=> 2
	}
}
