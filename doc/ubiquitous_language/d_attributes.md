# D Attributes

D attributes define the legal behavior of functions and modules.  
They are part of the Ubiquitous Language because they constrain meaning, prevent drift, and enforce determinism.

Every vm must use the attributes listed below unless the attribute is illegal for the transformation being performed.

---

## @safe

**Meaning:**  
All memory operations are provably safe. No pointer arithmetic, no invalid casts, no undefined behavior.

**UL Rule:**  
A vm must be @safe.  
Domain functions should be @safe unless performing low-level operations.

---

## pure

**Meaning:**  
The function has no access to global mutable state.  
Its output depends only on its input.  
It cannot perform I/O.

**UL Rule:**  
A vm must be pure unless purity is illegal for the transformation.  
Domain classifiers should be pure.

---

## nothrow

**Meaning:**  
The function cannot throw exceptions.  
All failure must be represented in domain types (e.g., Invalid).

**UL Rule:**  
A vm must be nothrow.  
Domain functions must be nothrow.  
Exceptions are prohibited except for library functions that throw them.

---

## @nogc

**Meaning:**  
The function performs no garbage-collection allocations.

**UL Rule:**  
A vm should be @nogc when legal.  
Formatting functions may require GC; in those cases @nogc is not required.

---

## final switch

**Meaning:**  
All enum cases must be handled.  
The compiler enforces completeness.

**UL Rule:**  
A vm must use final switch when switching on domain enums.  
This prevents illegal states and drift.

---

## private imports

**Meaning:**  
Only the symbols required for the transformation are visible.

**UL Rule:**  
A vm must use private imports.  
Domain modules should use narrow imports.

---

## deterministic

**Meaning:**  
Same input → same output.  
No randomness, no time-based behavior, no external state.

**UL Rule:**  
All vm and domain functions must be deterministic.
