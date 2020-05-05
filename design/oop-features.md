## Things already in the language

Classes:
- ~~scoped module importing.~~
- class and instance variables.
- multiple inheritance.
- partial initialization (strict with null checks).
- static dispatch for methods (unless it's currently a protocol, in which case dynamic dispatch will be used).
- operator overloading.
- class-specific hygenic macros.
- generic type arguments.
- generic specialization.
- generic methods and type signatures.
- deinitializer.

Protocols:
- defines a set of methods and members that must be implemented in classes that use the protocol (although after looking at what I've done so far, members might be added automatically idk).
- methods use dynamic dispatch (todo: think about this more).
- methods may optionally be given a default body.
- operator overloading.
- generic type arguments.
- generic specialization.
- generic methods and type signatures.
- deinitializer (or require one).
- no macros (unsure).

Categories:
- declares a set of methods and macros that are added to a class/protocol.
- no overloading pre-existing methods or macros (for now).
- the category may not be generic.
- similar to Objective-C categories.
- a value may be in more than one category at a time.
- ~~categories may be anonymous, and then be applied to specific objects.~~
- ~~syntax for applying a category is TBD.~~
- ~~categories will most likely be scoped, so you'll have to import them to implement them (more on that in the categories concept).~~
- categories are modular, and should usually have the same name as the module that they're defined in.

Modules:
- ~~scoped module importing.~~
- nested modules, classes, protocols, categories, kinds, aliases, methods, and variables.
- nested generic structures.
- hygenic macros.
- pattern-matching macros.

Kinds:
- can either act as a regular "enum" type (like in C or Java) or as a tagged union (like in F# or Haskell). unsure if it can act as both.
- values in a normal enum kind may represent any type (kinda TBD).
- values in instances of tagged union kinds may be extracted by using the `match`/`at` construct.
- operator overloading (except for `&`, `|`, `^`; see below).
- generic type arguments.
- generic specialization.
- class and instance methods (and possibly members as well).
- a "flags" attribute that allows a single kind value to contain multiple kind values. similar to C enums that use bitwise-ops. this will be availible for normal kinds and tagged union kinds (todo: elaborate on this in the kinds concept).

## Things I'm considering adding

Classes:
- nested classes.

Protocols:
- a special "this" type that gets replaced with the type of an inherited class in said class (hopefully that makes sense).

Modules:
- generic type arguments (basically parametric modules).
- global initializer (unsure if it would be needed).
- global deinitializer.

Kinds:
- unified instance members (can be accessed without pattern matching).
- deinitializer.
- allow inheriting from protocols.