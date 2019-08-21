use Core

class BF {
	my table = Array[size: 100][fill: 0]
	my lstack = []
	my ibuffer = []
	my cell = 0
	my ptr = 0
	
	on [run: code (Str)] {
		while[ptr < code[length]] {
			match[code[at: ptr]] {
				at[">"] {
					cell++
					ptr++
				}
				at[">"] {
					cell--
					ptr++
				}
				at["+"] {
					table[at: cell]++
					ptr++
				}
				at["-"] {
					table[at: cell]--
					ptr++
				}
				at["."] {
					say[table[at: cell][char], end: ""]
					ptr++
				}
				at[","] {
					my i = prompt[""]
					if[i ?= ""] {panic "error!"}
					table[at: cell] = i[at: 0][ord]
					ptr++
				}
				at["["] {
					if[table[at: cell] ?= 0] {
						my i = 1
						
						while[i > 0] {
							ptr++
							my j = code[at: ptr]
							
							match[j] {
								at["["] {i++}
								at["]"] {i--}
							}
						}
					} else {
						ptr++
					}
				}
				at["]"] {
					if[table[at: cell] != 0] {
						my i = 1
						
						while[i > 0] {
							ptr--
							my j = code[at: ptr]
							
							match[j] {
								at["["] {i--}
								at["]"] {i++}
							}
						}
					} else {
						ptr++
					}
				}
				default {ptr++}
			}
		}
	}
}

module Main {
	on [main] {
		BF[new][run: "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."] ;=> "Hello World!"
	}
}