use Core

; pretending that LibC doesn't already exist
module LibC is native "c" {
	on [strdup: (Str)] (Str) is native
	on [free: (Ptr[Void])] is native
}

module Main {
	on [main] {
		my charPtr = LibC[strdup: #c_str "banana"]
		Core[say: charPtr[Str]]
		LibC[free: charPtr[LLVM.Ptr[Void]]]
	}
}
