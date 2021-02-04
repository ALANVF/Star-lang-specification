# Star specification
[Star](https://github.com/ALANVF/star) is an experimental language made to be powerful, productive, and predictable.

## Explanations of the random folders you see
- design: This folder contains documents talking about design choices/explanations for Star.
- examples: This folder contains various examples (mostly from Rosetta code) of programs written in Star. Nothing is final.
- syntax: This folder contains formal syntactic specification for Star.
- concepts: This folder contains experimental ideas I've come up with for Star. Nothing is guaranteed to actually be added.
- tools: This folder contains helpful stuff like syntax highlighting for Star for various editors. Will probably be moved once I put the actual language project on GitHub.
- revisions: This stuff in this folder keeps a record of changes to Star and this repo.

## What's the goal of Star?
I have many goals for Star, but I guess the big one right now is to make every part of the language *consistent*, which is something that very few languages have actually achieved (e.g. Go, Smalltalk). To me, consistency makes it much easier to learn and use a language since you don't have to remember all of the magical "exceptions" in the language's grammar (e.g. Perl, C).

## Inspirations
(non-exhaustive, and not in any particular order)
- Objective-C:
	- Messaging
	- ARC
	- Categories
	- Both dynamic and low-level
- Swift:
	- Parameters can optionally not have a label
	- ARC
	- Protocols
	- Good/stable ABI
	- Designated/explicit initializers (rather than magical method names)
	- Distinction between captured variables and existing variables in pattern-matching cases
	- Multi-dispatch
	- Numbered anonymous parameters
- [Nu](https://github.com/programming-nu/nu)
- [Red](https://github.com/red/red):
	- [Pattern-matching macros](https://github.com/red/docs/blob/master/en/preprocessor.adoc#macro)
	- Rich set of builtins
	- DSLs are trivial
	- C-like dialect for low-level code
	- `series!` types
- Crystal:
	- Easy and low-level
	- All types are capitalized
	- Macros
	- Method macros
	- Completely bootstrapped
	- Type narrowing
- Raku:
	- Its standard library comes with everything that you'll ever need
	- Automatically-generated constructors for classes
	- `is` attributes
	- Junctions
	- Amazing list-processing support
	- [NativeCall](https://docs.raku.org/language/nativecall)
	- Introduced the awesome [`%%` operator](https://docs.raku.org/routine/$PERCENT_SIGN$PERCENT_SIGN)
	- Actually has a logical exclusive-or operator
	- Chained comparison operators
- Smalltalk:
	- Simple syntax
	- Cascades
	- No top-level functions, variables, or constants
- C++:
	- Type conversion methods are identified by an actual type instead of a magical method name
	- Template specialization
	- [`std::enable_if` for template specialization](https://en.cppreference.com/w/cpp/types/enable_if)
- Scala:
	- Circular dependencies
	- Case classes (for enums)
	- User-defined pattern matching behavior
	- Conditional types
	- Opaque type aliases
	- Higher-kinded types
- [Ten](https://github.com/ten-lang/libten):
	- Commas and newlines are analogous

## Where is the compiler?
[WIP](https://github.com/ALANVF/star)

## Where is the runtime?
[WIP](https://github.com/ALANVF/star)

## Everything here seems really informal
Yeah I'm 17.

## Anything else?
Feel free to suggest ideas! I don't have all the creativity in the world, so if you come up with an idea just say something about it.
