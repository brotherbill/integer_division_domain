###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/08_nothrow_no_exceptions.md>

# 08 — nothrow No Exceptions

## 1. Definition
`nothrow` is the D language attribute that guarantees a function **never throws exceptions**.

If a function marked `nothrow` attempts to throw, or calls a function that may throw, compilation fails.

All error signaling must be explicit and non‑exceptional.

---

## 2. Compiler Guarantees
When a function is marked `nothrow`, the compiler enforces:

- no `throw` statements  
- no calls to throwing functions  
- no implicit exception paths  
- no hidden exception propagation  
- no runtime exception‑based control flow  

If any exception path is detected, compilation fails.

---

## 3. Legality Meaning
`nothrow` ensures:

- no nondeterministic control flow  
- no hidden failure paths  
- no exception‑driven branching  
- no stack unwinding surprises  
- no runtime behavior that bypasses invariants  

It forces **total control** over failure classification.

Legality code must be exception‑free.

---

## 4. Why This Matters
Exceptions introduce nondeterminism:

- they unwind the stack  
- they bypass logic  
- they skip cleanup  
- they skip invariant checks  
- they create ambiguous failure modes  
- they cannot be replayed deterministically  

Legality code requires predictable, sealed, deterministic behavior.

`nothrow` eliminates exception‑based nondeterminism.

It is the **third wall of correctness**.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/08_nothrow_no_exceptions.md>
