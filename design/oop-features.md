## Things already in the language

Classes:
- ~~scoped module importing.~~
- Class and instance variables.
- Multiple inheritance.
- Partial initialization (strict with null checks).
- Static dispatch for methods (unless it's currently a protocol, in which case dynamic dispatch will be used).
- Operator overloading.
- Class-specific hygenic macros.
- Generic type arguments.
- Generic specialization.
- Generic methods and type signatures.
- Default initializer.
- Global initializer.
- Deinitializer.
- Global deinitializer.
- Top-level statements.

Protocols:
- Defines a set of methods and members that must be implemented in classes that use the protocol (although after looking at what I've done so far, members might be added automatically idk).
- Methods use dynamic dispatch (todo: think about this more).
- Methods may optionally be given a default body.
- Operator overloading.
- Generic type arguments.
- Generic specialization.
- Generic methods and type signatures.
- Deinitializer (or require one).
- No macros (unsure).
- Top-level statements.

Categories:
- Declares a set of methods and macros that are added to a class/protocol.
- No overloading pre-existing methods or macros (for now).
- The category may not be generic.
- Similar to Objective-C categories.
- A value may be in more than one category at a time.
- ~~categories may be anonymous, and then be applied to specific objects.~~
- ~~syntax for applying a category is TBD.~~
- ~~categories will most likely be scoped, so you'll have to import them to implement them (more on that in the categories concept).~~
- Categories are modular, and should usually have the same name as the module that they're defined in.
- Top-level statements.

Modules:
- ~~scoped module importing.~~
- Any declaration.
- Global initializer.
- Global deinitializer.
- Top-level statements.
- Hygenic macros.
- Pattern-matching macros.

Kinds:
- Can either act as a regular "enum" type (like in C or Java) or as a tagged union (like in F# or Haskell). unsure if it can act as both.
- Values in a normal enum kind may represent any type (kinda TBD).
- Values in instances of tagged union kinds may be extracted by using the `match`/`at` construct.
- Each case in a tagged union may provide an optional initializer.
- Operator overloading (except for `&`, `|`, `^`; see below).
- Generic type arguments.
- Generic specialization.
- Class and instance methods
- A "flags" attribute that allows a single kind value to contain multiple kind values. similar to C enums that use bitwise-ops. this will be availible for normal kinds and tagged union kinds (this is explained more in the kinds concept).
- Unified class and instance members (can be accessed without pattern matching).
- Can inherit from protocols and other kinds.
- Top-level statements.

Aliases:
- Can either be a direct or distinct alias to another type.
- Generic type arguments.
- Generic specialization.

## Things I'm considering adding

Classes/Protocols/Kinds:
- Nested types.

Protocols:
- A special "This" type that gets replaced with the type of an inherited class in said class (hopefully that makes sense).

Modules:
- Generic type arguments (basically parametric modules).

Kinds:
- Deinitializer.