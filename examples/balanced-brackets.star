use Core

module Main {
	on [isBalanced: brackets (Str)] {
		my l = 0
		
		for[my c in: brackets[chars]] {
			if[l < 0] {return false}
			
			match[c] {
				at["["] {l++}
				at["]"] {l--}
			}
		}
		
		return l ?= 0
	}
	
	on [main] {
		my bb = #[
			"",
			"[]",
			"[[][]]",
			"][",
			"][][",
			"[]][[]"
		]
		
		for[my s in: bb] {
			say[isBalanced[s]]
		}
		
		;=> true, true, true, true, false, false, false
	}
}