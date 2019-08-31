## Things already in the language

Classes:
- local module importing.
- class and instance variables.
- multiple inheritance.
- partial initialization.
- multiple/dynamic dispatch for messages.
- operator overloading.
- class-specific hygenic macros.
- generics (still working on the details).

Modules support:
- local module importing.
- nested modules, classes, messages, and variables.
- hygenic macros.
- pattern-matching macros.

## Things I'm considering adding

Classes:
- generic messages.
- generic operator overloading.
- nested classes.

Traits:
- defines a set of messages and members that must be implemented in classes that apply the trait.
- name may change.
- no macros.
- no generics (for now).
- default values for members.

Catagories:
- declares a set of messages, members, and macros that are added to a class at runtime.
- no overloading pre-existing messages, members, nor macros (for now).
- the catagory itself may not be generic.
- similar to Objective-C catagories.
- a class instance may be in more than one catagory at a time.
- catagories may be anonymous, and then be applied to specific objects.
- syntax for applying a catagory is TBD.
