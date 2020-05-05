; Tags are kinda like preprocessor directives and metadata for expressions/statements created from my laziness to type stuff.

; Uses malloc instrinsic/instruction. needs to be freed.
my usesMalloc = 2
#free usesMalloc

; Creates a c-string value.
; Also variables directly assigned to a global don't need to be freed.
my globalStr = #c_str "banana"

; Nnwraps an instance of Star.Core.Int to an i32.
my unwrappedInt = #unwrap 3

; This does the opposite.
my wrappedInt = #wrap unwrappedInt

; Tags can be "stacked". essentially the same as #wrap (#not (#bool true)).
my bool = #wrap #not #bool true ;=> false

; For type casting instructions, normal casting syntax can be used
my rawDec1 = #neg #si2fp unwrappedInt[LLVM.Dec32] ;=> -3.0

; Kinda ambiguous tho
my rawDec2 = #si2fp (#neg unwrappedInt)[LLVM.Dec32] ;=> -3.0

; Maybe using (...) after a tag should be manditory (or at least recommended) to avoid ambiguous associativity.
; I'm also hoping that tags can be used outside of LLVM interop. Idk what yet tho.
