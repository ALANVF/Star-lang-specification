## Things already in the language

Classes:
- scoped module importing.
- class and instance variables.
- multiple inheritance.
- partial initialization.
- static dispatch for methods (unless it's currently a protocol, in which case dynamic dispatch will be used).
- operator overloading.
- class-specific hygenic macros.
- generics.
- generic specialization.
- generic methods and variables.

Protocols:
- defines a set of methods and members that must be implemented in classes that use the protocol (although after looking at what I've done so far, members might be added automatically idk).
- methods use dynamic dispatch (todo: think about this more).
- methods may optionally be given a default body.
- may not inherit from anything (for now).
- may not be included in a category (for now).
- no macros.
- may not be generic (for now).

Catagories:
- declares a set of methods and macros that are added to a class at runtime.
- no overloading pre-existing methods or macros (for now).
- the catagory may not be generic.
- similar to Objective-C catagories.
- a value may be in more than one catagory at a time.
- catagories may be ~~anonymous, and then be~~ applied to specific objects.
- syntax for applying a catagory is TBD.
- categories will most likely be scoped, so you'll have to import them to implement them (more on that in the categories concept).

Modules:
- scoped module importing.
- nested modules, classes, protocols, categories, kinds, aliases, methods, and variables.
- nested generic structures.
- hygenic macros.
- pattern-matching macros.

Kinds:
- TBD.

## Things I'm considering adding

Classes:
- nested classes.
