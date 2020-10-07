Revision #12:
- Hinted at dependent types in `generics.md`.
- Improved `classes.md` and `oop-features.md`.
- Moved `syntax-is-data.md` to `design/old`.
- Added info about StarVM in the README.

Revision #11:
- Updated all examples.
- Added new examples.

Revision #10:
- Type aliases now use `alias` instead of `type` because it's already used for generic type args.
- Kind cases now use `has` to declare a case, rather than nothing at all.
- Added the `strong` attribute for types.
- Updated the README.
- Anonymous closure syntax has changed.

Revision #9:
- Added `syntax/namespace-declarations.md`.
- Started `syntax/other-declarations.md`.
- Type aliases *can* in fact be generic.
- Minor tweaks in various places.

Revision #8:
- Added syntax spec for statements.
- Removed `>>>` operator because it's useless.
- Cascades can now call into block expressions.

Revision #7:
- Added ABI.md to explain Star's ABI conventions.

Revision #6:
- The `default` keyword has been removed because `else` works the same way.
- Added the `match ... at ... {...} [else {...}]` construct (shorthand match statement).
- Changed concept documents to use markdown.

Revision #5:
- The `is cast` attribute no longer exists because it's redundant.
- The `super` keyword has been removed because it had no use.
- Updated and added information in oop-features design document.
- Fixed some wording.
- `s/catagory/category/`.

Revsion #4:
- Added literals.md to document basic syntax for literals.

Revision #3:
- Control flow statements no longer require `[`...`]` since it wasn't helping anyone.
- Changed some wording.

Revision #2:
- Added Star highlighting modes for Vim and CudaText.
- Added the `uncounted` attribute to the syntax spec.

Revision #1:
- Floating `:` literals have been removed, as it was too magical and differed from other constructs with type annotations.
- Global methods have also been removed, mostly to make context methods (e.g. `[a: b]`) less ambiguous.
- Fixed enough typos that I lost count of how many there were.
- Updated examples and design documents to reflect recent changes to the language.
- Added this file.