Revisions #3:
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