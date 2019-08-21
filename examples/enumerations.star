use Core

module Main {
	catagory Fruit {
		Apple
		Banana
		Cherry
	}
	
	on [main] {
		my f (Fruit) = Fruit.Banana
		say[f] ;=> Fruit.Banana
	}
}