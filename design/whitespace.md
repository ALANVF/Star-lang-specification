So statements and expressions in Star are separated by a "," or a new line. Example:
```swift
say[1]
say[2]
say[3], say[4, end: ","]
say[
	5
	end: ","
]
```
You may not have an expression span multiple lines unless it's inside parentheses. Example:
```swift
; incorrect
my a = 1
		+
		2

; correct
my b = (1
		+
		2)
```
For the moment, you are not allowed to put whitespace between the caller and message body when using the prefix notation for messages (e.g. `a[b]` not `a [b]`).