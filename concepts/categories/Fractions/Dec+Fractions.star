category Fractions for Dec {
	on [Fraction] is cast {
		my top = this
		my bottomP = 0
		
		while[top[floor] != top] {
			top *= 10
			bottomP++
		}

		return Fraction[top: top[Int] bottom: 10 ** bottomP]
	}
}
