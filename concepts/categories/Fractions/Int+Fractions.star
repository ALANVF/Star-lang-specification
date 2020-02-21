category Fractions for Int {
	on [Fraction] is cast {
		return Fraction[top: this bottom: 1]
	}
}
