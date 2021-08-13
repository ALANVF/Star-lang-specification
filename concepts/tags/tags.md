Tags are kinda like preprocessor directives and metadata for expressions.
They're currently only used to represent things that don't currently have concrete syntax in Star, as well as generating IR code.

These tags are currently used for the following features that don't yet have concrete syntax:
- `#init_this`: Call another initializer from the current initializer.
- `#expand`: Expand a quoted macro value or expression.
- `#quote`: Quote a macro value, or create a quoted macro expression.
- `#asm`: Quickly enter IR mode.
... more here later

These tags are common IR functionality:
- `#kind_id`: Get the tag of a kind value.
- `#kind_slot`: Get the Nth slot of a kind value. Type must be inferrable.
... more here later