## Things already in the language

Classes:
- scoped module importing.
- class and instance variables.
- multiple inheritance.
- partial initialization.
- multiple/static dispatch for messages (unless it's currently a protocol, in which case dynamic dispatch will be used).
- operator overloading.
- class-specific hygenic macros.
- generics.
- generic specialization.
- generic messages and variables.

Protocols:
- defines a set of messages and members that must be implemented in classes that use the protocol.
- messages use dynamic dispatch (todo: think about this more).
- messages may optionally be given a default body.
- may not inherit from anything (for now).
- may not be included in a category (for now).
- no macros.
- may not be generic (for now).

Catagories:
- declares a set of messages and macros that are added to a class at runtime.
- no overloading pre-existing messages or macros.
- the catagory may not be generic.
- similar to Objective-C catagories.
- a class instance may be in more than one catagory at a time.
- catagories may be ~~anonymous, and then be~~ applied to specific objects.
- syntax for applying a catagory is TBD.

Modules:
- scoped module importing.
- nested modules, classes, protocols, categories, kinds, aliases, messages, and variables.
- nested generic structures.
- hygenic macros.
- pattern-matching macros.

## Things I'm considering adding

Classes:
- nested classes.
