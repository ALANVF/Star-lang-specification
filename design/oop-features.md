## Things already in the language

Classes:
- ~~scoped module importing.~~
- Static and instance variables.
- Multiple inheritance.
- Partial initialization (strict with compile-time checks).
- Static dispatch for methods (unless it's currently a protocol, in which case dynamic dispatch will be used).
- Operator overloading.
- (Non-virtual) typed hygenic macros.
- Generic arguments.
- Generic specialization.
- Generic methods and type signatures.
- Default initializer.
- Global initializer.
- Deinitializer.
- Global deinitializer.
- Top-level declarations.

Protocols:
- Defines a set of methods and members that must be implemented in classes that use the protocol (although after looking at what I've done so far, members might be added automatically idk).
- Methods use dynamic dispatch (todo: think about this more).
- Methods may optionally be given a default body.
- Operator overloading.
- Generic arguments.
- Generic specialization.
- Generic methods and type signatures.
- Deinitializer (or require one).
- (Non-virtual) typed hygenic macros.
- Top-level declarations.

Categories:
- Declares a set of methods and macros that are added to an existing type.
- ~~No overloading pre-existing methods or macros (for now).~~ It's not overloading, but rather locally redefining them.
- The category may not be generic.
- Similar to Objective-C categories.
- Similar to Rust traits.
- A type may be in more than one category at a time, including itself (technically the default).
- Since a category is identified by a type, it follows the subtyping behavior of said type.
- Top-level declarations.

Modules:
- ~~scoped module importing.~~
- Any declaration.
- Global initializer.
- Global deinitializer.
- Top-level declarations.
- Typed hygenic macros.
- ~~Pattern-matching macros.~~
- Generic arguments (basically functors ~~which can actually be mutually recursive *cough* ocaml *cough*~~).

Kinds:
- Can either act as a regular "enum" type (like in C or Java) or as a tagged union (like in F# or Haskell). unsure if it can act as both.
- Values in a normal enum kind may represent any type (kinda TBD).
- Values in instances of tagged union kinds may be extracted by using pattern matching.
- Each case in a tagged union may provide an optional alias and initializer.
- Operator overloading (except for `&`, `|`, `^`, and `~`; see below).
- Generic arguments.
- Generic specialization.
- Static and instance methods
- (Non-virtual) typed hygenic macros.
- A "flags" attribute that allows a single kind value to contain multiple kind values. similar to C enums that use bitwise-ops. this will be availible for normal kinds and tagged union kinds (this is explained more in the kinds docs).
- Unified class and instance members (can be accessed without pattern matching).
- Can inherit from classes, protocols, and other kinds.
- Deinitializer.
- Top-level declarations.

Aliases:
- Can either be a direct or distinct alias to another type, or an opaque type (mainly useful for C FFIs).
- Generic arguments.
- Generic specialization.

Opaque aliases:
- Top-level declarations.
- Typed hygenic macros.

Strong aliases:
- Basically a newtype.
- `is noinherit` can be used to hide all behavior inherted from the base type.
- Top-level declarations.
- Typed hygenic macros.

All types except direct aliases:
- A special "This" type that gets replaced with the current type lazily (similar to `this` in TypeScript).

## Things I'm considering adding

Kinds:
- Java-style "enum classes".

Aliases:
- Opaque aliases can also be used as OCaml-like abstracts.