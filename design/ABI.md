(this is kind of a work-in-progress)

# General things
- `_S`: global prefix for all symbols.
- `#`: a whole number (just for notation).
- `#name`: a name that is N characters long.


# Common escape prefixes
- `__`: regular `_` character.
- `_#s<names>`: scoped identifier (like `A.B.C` would be `_3s_m1A_m1B_c1C`).
- `_m<name>`: module.
- `_c<name>`: class.
- `_#c<name>`: generic class with N arguments.
- `_p<name>`: protocol.
- `_#p<name>`: generic protocol with N arguments.
- `_k<name>`: kind.
- `_#k<name>`: generic kind with N arguments.
- `_t<name>`: represents a type argument.
- `_#t<name>`: represents a generic type argument with N arguments.
- `_u`: unknown/throwaway type.
- `_#u`: unknown/throwawary type with N arguments.
- `_e<path><type>`: category.


# Attributes
- `is static`: `0`.
- `is hidden`: `1`.
- `is readonly`: `2`.
- `is writeonly`: `3`.
- `is custom`: `4`.
- `is unordered`: `5`.
- `is getter`: `6`.
- `is setter`: `7`.
- `is main`: `8`.
- `is inline`: `9`.
- `is noinherit`: `a`.
- `is pattern`: `b`.
- `is asm`: `c`.
- `is statement`: `d`.
- `is native`: `e`.
- `` is native `name` ``: `E#name`.
- `is c_struct`: `f`.
- `is c_union`: `g`.
- `is c_enum`: `h`.
- `is flags`: `i`.
- `is uncounted`: `j`.


# Sub-structures
Attributes: `_#I(<attr>)`
- `#`: number of attributes.

Condition:
- `a<cond><cond>`: logical and.
- `o<cond><cond>`: logical or.
- `x<cond><cond>`: logical xor.
- `n<cond>`: logical not.
- `e<type><type>`: types are equal.
- `i<type><type>`: types are inequal.
- `d<type><type>`: type 1 inherits from type 2.

Type arg:
- `n<name>`: type arg.
- `p<name>#(<type>)`: type arg with N parents.
- `c<name><condition>`: type arg with a condition.
- `b<name>#(<type>)<condition>`: type arg with N parents and a condition.

Type args: `_#T(<type-arg>)`

Namespace: `<path>` or `<type>` or `<category>`


# Declarations
Initializer/Method (`i`/`m`) decl:
- single-arity: `o0[im]<namespace><name><ret=type><attributes><type-args>`.
- multi-arity: `o#[im]<namespace>(<label=name><type>)<ret=type><attributes><type-args>`.

Operator decl:
- zero-arity: `o0o<namespace><name><ret=type><attributes><type-args>`
- single-arity: `o1o<namespace><name><arg=type><ret=type><attributes><type-args>`

Cast decl: `oc<namespace><ret=type><attributes><type-args>`

Deinitializer decl: `od<namespace><attributes><type-args>`


# Examples

## Ex. 1
code:
```
module Main {
	on [main] {
		Core[say: "Hello, world!"]
	}
}
```
exported symbols:
|         Definition         |      Exported Symbol                                       |
|----------------------------|------------------------------------------------------------|
| `Main[main]`               | `_So0m_m4Main4main_2s_m4Star_c4Void_1I8_0T`                |
| `Star.Value[new]`          | `_So0i_2s_m4Star_p5Value3new_0I_0T`                        |
| `Star.Core[say: (T)]`      | `_So1m_2s_m4Star_m4Core3say_t1T_2s_m4Star_c4Void_0I_1Tn1T` |


(more examples to come later...)