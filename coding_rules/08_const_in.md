###### Start of Document \<repo:integer_division_domain/coding_rules/08_const_in.md\>

# 08 — const and in Parameters

## Purpose
`const` and `in` enforce immutability at the **usage point**, not globally.  
They eliminate accidental mutation, reduce drift, and make intent explicit.  
Buffers are the only exception, because they are intentionally mutable and must remain simple.

---

# 1. Use `const` for Immutable Variables
A variable marked `const` cannot be mutated **by us**.  
This is a guarantee, not a convention.

Correct:
```
const string domain_root = "integer_division_domain";
```

Incorrect:
```
string domain_root = "integer_division_domain";   // mutable — forbidden
```

Use `const` when:
- the value should never change  
- the value conveys domain meaning  
- the value is used across modules  
- the value is a literal that must not drift  

`const` is mandatory for all immutable values.

---

# 2. What `const` Actually Means in Prax Junior
D’s `const` does **not** mean the underlying target is immutable.  
It means **we** will not mutate it — through **this** reference, in **this** scope, under **this** contract.

This distinction is essential.

### Correct interpretation
> **`const` means *we* won’t and *can’t* mutate it.  
> It does *not* mean the target itself is immutable.**

The underlying object may be:
- mutable  
- shared  
- externally modified  
- part of a mutable struct  
- part of a buffer  

We do **not** care.

What matters is:

### Our promise
> **We declare that *we* will not mutate it.  
> That is sufficient for sealed-domain reasoning.**

### Example
Correct:
```
const Config cfg = loadConfig();
```

This does **not** mean `cfg` is deeply immutable.  
It means:
- we will not mutate `cfg`  
- we cannot mutate `cfg`  
- the compiler enforces this  
- sealed-domain reasoning is preserved  

---

# 3. All Parameters Use `in` (Except Buffers)
The `in` keyword is shorthand for `const` for parameters.  
It guarantees:
- no mutation  
- no aliasing surprises  
- no hidden side effects  
- sealed-domain safety  

Correct:
```
void process(in string name, in int count)
{
    // name and count cannot be mutated
}
```

Incorrect:
```
void process(string name, int count)   // mutable parameters — forbidden
{
}
```

All parameters must use `in` unless they are buffers.

---

# 4. `in` Applies Even to Value Types
Even for value types (such as `int`, `bool`, `double`, enums, and small structs), Prax Junior requires `in`.

D passes value types by value, so mutation of the parameter does **not** affect the caller.  
But Prax Junior forbids even that mutation.

Correct:
```
void compute(in int a, in int b)
{
    // a and b are immutable *to us*
    // even though they are passed by value
}
```

Incorrect:
```
void compute(int a, int b)   // mutable local copies — forbidden
{
}
```

### Why this rule exists

1. **We preserve the original meaning sent to us.**  
   The caller’s intent is preserved exactly.

2. **We eliminate accidental drift.**  
   A mutated local copy can mislead future readers.

3. **We maintain sealed-domain reasoning.**  
   Immutable parameters are easier to reason about.

4. **We guarantee invariants.**  
   A parameter that never changes is easier to validate.

5. **We unify the rule.**  
   No special cases.  
   No “value types are safe to mutate.”  
   No exceptions.

This is stronger than D’s semantics, but architecturally correct.

---

# 5. Buffers Are Intentionally Mutable
Buffers are the only exception to the `in` rule.  
Buffers exist to be modified.  
They must remain simple and direct.

Correct:
```
void fillBuffer(ubyte[] buffer)
{
    buffer[0] = 42;
}
```

Incorrect:
```
void fillBuffer(in ubyte[] buffer)   // forbids mutation — violates buffer intent
{
}
```

### Buffer Rules
1. **No indirection**  
   Buffers must be passed directly, not wrapped in abstractions.

2. **No abstractions**  
   No helper types, no proxy objects, no “safe buffer” wrappers.

3. **No games**  
   No hidden mutation, no aliasing tricks, no cleverness.

Buffers are the only place where mutation is allowed and expected.

---

# 6. const vs enum — Runtime vs Compile‑Time Immutability

D provides two immutability mechanisms, used for different purposes.

### A. `const` — runtime immutability (memory allocated)
```
const int max_attempts = 7;
```

This creates a **runtime variable**:

- occupies memory  
- addressable  
- immutable to us  
- underlying object may be mutable  
- part of the runtime domain  

### B. `enum` — compile‑time immutability (no memory allocated)
```
enum int max_attempts = 7;
```

This creates a **pure compile‑time literal**:

- no memory allocated  
- not addressable  
- deeply immutable  
- inlined wherever used  
- part of the compile‑time domain  

### Why both exist in Prax Junior

| Layer | Mechanism | Memory | Addressable | Mutability | Purpose |
|------|-----------|--------|-------------|------------|---------|
| **Compile‑time** | enum | none | no | deeply immutable | eliminate drift, centralize meaning |
| **Runtime** | const | yes | yes | immutable to us | preserve caller intent, prevent drift |

Use:
- **enum** for domain constants  
- **const** for runtime values we promise not to mutate  

---

# 7. Why This Rule Exists

### A. Immutability Eliminates Drift
Mutable parameters drift over time.  
Immutable parameters do not.

### B. Intent Becomes Explicit
`in` tells the reader:  
> “This parameter will not be changed.”

`const` tells the reader:  
> “This variable will not be changed.”

### C. Buffers Are a Special Case
Buffers represent raw data.  
They must remain simple, direct, and mutation‑friendly.

### D. Architectural Clarity
This rule creates a clean separation:
- **immutable domain values**  
- **immutable parameters**  
- **mutable buffers only**  

No ambiguity.  
No drift.  
No accidental mutation.

---

# 8. Examples

### Immutable Parameters
Correct:
```
void compute(in int a, in int b)
{
    return b < a;   // Rule 07 applies
}
```

Incorrect:
```
void compute(int a, int b)   // forbidden
{
}
```

### Immutable Variables
Correct:
```
const int max_attempts = 7;
```

Incorrect:
```
int max_attempts = 7;   // magic number — forbidden
```

### Compile‑Time Constant
Correct:
```
enum int max_attempts = 7;
```

### Mutable Buffer
Correct:
```
void writeBytes(ubyte[] buf)
{
    buf[3] = 0xFF;
}
```

Incorrect:
```
void writeBytes(in ubyte[] buf)   // forbids mutation — violates buffer intent
{
}
```

---

# 9. Summary

- `const` means **we** won’t and can’t mutate it.  
- `const` does **not** require the underlying target to be immutable.  
- `in` guarantees immutability for parameters.  
- `in` applies even to value types; we do not mutate the local copy.  
- `enum` is compile‑time, deeply immutable, and memory‑free.  
- `const` is runtime, addressable, and immutable to us.  
- All parameters must use `in` except buffers.  
- Buffers are intentionally mutable and must remain simple.  
- No indirection, no abstractions, no games with buffers.  
- This rule enforces sealed-domain clarity and eliminates drift.

###### End of Document \<repo:integer_division_domain/coding_rules/08_const_in.md\>
