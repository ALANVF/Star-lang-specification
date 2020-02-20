; tags are kinda like preprocessor directives and metadata for expressions/statements

; uses the alloca instruction.
#alloca my usesAlloca = 1

; uses malloc instrinsic/instruction. needs to be freed.
my usesMalloc = 2
#free usesMalloc

; as a side note, #alloca and #free will obviously be removed once Star has a GC.

; creates a global c-string value (not having the #string would make it an instance of Star.Core.Str).
; also variables directly assigned to a global don't need to be freed.
my globalStr = #global #string "banana"

; unwraps an instance of Star.Core.Int to an i32.
my unwrappedInt = #unwrap 3

; this does the opposite.
my wrappedInt = #wrap unwrappedInt

; tags can be "stacked". essentially the same as #wrap (#not (#bool true)).
my bool = #wrap #not #bool true ;=> false

; for type casting instructions, normal casting syntax can be used
my rawDec1 = #neg #si2fp unwrappedInt[LLVM.Dec32] ;=> -3.0

; kinda ambiguous tho
my rawDec2 = #si2fp (#neg unwrappedInt)[LLVM.Dec32] ;=> -3.0

; maybe using (...) after a tag should be manditory (or at least recommended) to avoid ambiguous associativity.
; I'm also hoping that tags can be used outside of LLVM interop. Idk what yet tho.
