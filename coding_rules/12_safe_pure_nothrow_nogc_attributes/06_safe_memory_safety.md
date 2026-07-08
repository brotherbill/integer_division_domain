###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/06_safe_memory_safety.md>

# 06 — @safe Memory Safety

## 1. Definition
`@safe` is the D language attribute that guarantees **memory safety**.  
A function marked `@safe` cannot perform operations that may corrupt memory or violate reference integrity.

Memory‑unsafe operations are rejected at compile time.

---

## 2. Compiler Guarantees
When a function is marked `@safe`, the compiler enforces:

- no pointer arithmetic  
- no reading past array bounds  
- no writing past array bounds  
- no invalid casts  
- no type punning  
- no constructing invalid references  
- no escaping references to stack data  
- no violating lifetime rules  
- no aliasing violations  
- no unsafe reinterpretation of memory  

If any unsafe operation is attempted, compilation fails.

---

## 3. Legality Meaning
`@safe` ensures:

- no memory corruption  
- no undefined behavior  
- no nondeterministic memory faults  
- no invalid references  
- no aliasing violations  
- no lifetime violations  

It is the **baseline legality requirement** for deterministic code.

`@safe` guarantees that memory behavior is predictable, sealed, and correct.

---

## 4. Why This Matters
Memory corruption is nondeterministic.  
It produces failures that:

- cannot be classified  
- cannot be replayed  
- cannot be audited  
- cannot be certified  
- cannot be isolated  
- cannot be reasoned about deterministically  

`@safe` eliminates an entire class of nondeterministic failures.

It is the foundation of:

- deterministic legality  
- sealed‑domain correctness  
- replayable behavior  
- auditability  
- certifiable systems  

`@safe` is the **first wall of correctness**.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/06_safe_memory_safety.md>
