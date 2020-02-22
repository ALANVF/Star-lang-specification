use Accessors

class Circle {
	my radius (Real)

	property diameter (Real) {
		getter {
			return 2 * radius
		}

		setter {
			radius = diameter / 2
		}
	}
}

module Main {
	on [main] {
		my circle = Circle[radius: 5]

		Core[say: circle.diameter] ;=> 10

		circle.diameter = 5
		
		Core[say: circle.diameter] ;=> 5
		Core[say: circle.radius]   ;=> 2.5
	}
}
