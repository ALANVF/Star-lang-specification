; In Star, categories are similar to Objective-C categories.
; They can be used to add methods to classes and protocols, however they do have some differences.
; Mainly, categories are not automatically applied to the classes/protocols that they extend.
; Categories kind of act like modules, except that they don't actually contain anything.
; Oh also if a protocol in included in a category, all classes that conform to that protocol must
; implement the classes defined in the protocol extension.

; Before reading further, go look at the stuff in the Fractions folder and then come back.

; Let's try this
use Fractions.Fraction

Core[say: Fraction[top: 1 bottom: 2]] ;=> Fraction[top: 1 bottom: 2]
Core[say: 0.5[Fraction]]              ;=> error!

; That didn't work because in Star, categories have to be imported in order to be used.
; This prevents unnecessary "monkey-patching" frequently used in languages such as Ruby and JavaScript.
; What this instead does is that it encourages programmers to only extend classes when it'll actually be useful (hopefully).

; Ok so now let's actually use the Fractions category
use Fractions

Core[say: Fraction[top: 1 bottom: 2]] ;=> Fraction[top: 1 bottom: 2]
Core[say: 0.5[Fraction]]              ;=> Fraction[top: 1 bottom: 2]

; So I think that this could be useful because it can be used to separate large classes and stuff into smaller files, which
; makes the code more readable and more organized.
; For example, there could be a separate Math category that adds mathmatical functions to numeric structures, or an Native
; category that provides conversion functions from regular structures to primitive datatypes.
; I might expand on this more in the future, but this is all I've got for now.
