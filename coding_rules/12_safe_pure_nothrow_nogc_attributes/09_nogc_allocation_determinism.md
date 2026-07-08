###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/09_nogc_allocation_determinism.md>

# 09 — @nogc Allocation Determinism

## 1. Definition
`@nogc` is the D language attribute that guarantees a function performs **no garbage‑collected heap allocation**.

If a function marked `@nogc` attempts to allocate GC memory, directly or indirectly, compilation fails.

All memory usage must be:

- static  
- stack‑based  
- manually controlled  
- or provided by the caller  

---

## 2. Compiler Guarantees
When a function is marked `@nogc`, the compiler enforces:

- no GC heap allocation  
- no array literals that allocate  
- no dynamic closures  
- no hidden runtime allocations  
- no implicit GC triggers  
- no use of library functions that allocate GC memory  

If any GC allocation path is detected, compilation fails.

---

## 3. Legality Meaning
`@nogc` ensures:

- no nondeterministic pauses  
- no nondeterministic allocation failures  
- no nondeterministic latency spikes  
- no runtime interference with legality evaluation  
- no hidden memory pressure  
- no unpredictable timing behavior  

It is the **allocation determinism guarantee** for legality code.

A `@nogc` function has fully predictable memory behavior.

---

## 4. Why This Matters
Garbage collection introduces nondeterminism:

- unpredictable pause times  
- unpredictable memory reclamation  
- unpredictable allocation latency  
- unpredictable failure modes  
- unpredictable timing under load  

Legality code must be:

- deterministic  
- sealed  
- predictable  
- replayable  
- auditable  
- certifiable  

GC behavior violates all of these requirements.

`@nogc` eliminates allocation‑based nondeterminism.

It is the **fourth wall of correctness**.

---

## 5. What @nogc Does *Not* Guarantee
`@nogc` does **not** guarantee:

- that the GC will not run during this function  
- that the GC is paused  
- that the GC is disabled  
- that other threads cannot trigger GC  
- that the runtime will not decide to collect  
- that the program is operating in a GC‑free environment  

`@nogc` only guarantees:

> **This function will not trigger GC allocation.**

It does **not** guarantee:

> **GC will not run while this function executes.**

The attribute prevents **local allocation**, not **global GC activity**.

---

## 6. How to Obtain Stronger Guarantees
To ensure **GC silence**, **GC absence**, or **GC impossibility**, additional measures are required.

### 6.1. GC‑Disabled Runtime Mode
Run the program with the GC disabled:

- disable the GC at startup  
- disable the GC for the legality subsystem  
- disable the GC for the entire process if required  

This guarantees:

- no GC cycles  
- no GC pauses  
- no GC interference  

### 6.2. GC‑Free Subsystems
Place legality code inside a subsystem that:

- uses no GC memory  
- calls no GC‑allocating libraries  
- operates with a manual allocator  
- uses only stack or static memory  

This guarantees:

- no GC allocation paths  
- no GC triggers  
- no GC dependencies  

### 6.3. Manual Allocation Discipline
Use:

- region allocators  
- bump allocators  
- slab allocators  
- static buffers  
- caller‑provided buffers  

This guarantees:

- deterministic allocation  
- deterministic reclamation  
- deterministic timing  

### 6.4. Thread Isolation
Run legality code in a thread where:

- no GC allocations occur  
- no GC‑allocating libraries are used  
- no GC triggers are possible  

This prevents GC activity from originating in the legality thread.

---

## 7. Summary of Guarantees
`@nogc` guarantees:

- **no GC allocation from this function**

It does **not** guarantee:

- **no GC activity anywhere else**

To guarantee **GC silence**, you must:

- disable the GC  
- isolate legality code  
- use manual allocation  
- avoid GC‑allocating libraries  
- ensure thread‑level allocation discipline  

`@nogc` is the **local guarantee**.  
GC‑free operation is the **system guarantee**.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/09_nogc_allocation_determinism.md>
