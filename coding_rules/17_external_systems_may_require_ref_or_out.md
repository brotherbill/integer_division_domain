###### Start of Document <repo:integer_division_domain/coding_rules/17_external_systems_may_require_ref_or_out.md>

# 17 — External Systems May Require `ref` or `out`  
## These Must Be Isolated at the Boundary

## 1. Rule
Prax Junior forbids the use of `ref` and `out` **inside the domain**.

However, **external systems** — legacy libraries, OS APIs, hardware interfaces, C bindings, and performance‑critical subsystems — may require `ref` or `out` parameters.

When this occurs, the usage must be:

- isolated  
- contained  
- wrapped  
- never exposed to the rest of the system  

No Prax Junior code may depend on or propagate `ref` or `out`.

---

## 2. Why External Systems Require `ref` or `out`

### 2.1. Legacy APIs
Many older systems (C, C++, Win32, POSIX, embedded firmware) expose:

- pointer‑based output  
- buffer‑based output  
- in‑place mutation  
- origin‑0 indexing  
- manual memory management  

These APIs cannot be changed.

### 2.2. Hardware and OS Boundaries
Hardware interfaces often require:

- DMA buffers  
- memory‑mapped registers  
- in‑place updates  
- low‑latency mutation  

These are **systems‑programming necessities**, not conveniences.

### 2.3. Performance‑Critical Subsystems
Some subsystems (crypto, compression, codecs, drivers) require:

- tight loops  
- in‑place mutation  
- pointer arithmetic  

These are **profile‑driven optimizations**, not general coding patterns.

---

## 3. The Correct Pattern: Isolation at the Boundary

### 3.1. Wrap External Calls
All external calls using `ref` or `out` must be wrapped in a **single, small, audited function**:

```d
private void call_external_api(ref int value)
{
    // external call here
}
```

### 3.2. Convert to Named Structs Immediately
The wrapper must convert external mutation into a **named struct**:

```d
struct ExternalResult
{
    int value;
}

ExternalResult get_external_result()
{
    int temp = 0;
    call_external_api(ref temp);
    return ExternalResult(value: temp);
}
```

### 3.3. No Leakage
The rest of the system must see **only**:

- named structs  
- named fields  
- pure functions  
- deterministic logic  

Never `ref`.  
Never `out`.  
Never pointer mutation.

---

## 4. Why Isolation Is Mandatory

### 4.1. Prevents Mutation Drift
External mutation must never leak into the domain.  
Drift is forbidden.

### 4.2. Preserves Purity
Prax Junior requires:

- pure  
- nothrow  
- @safe  
- @nogc  

External mutation violates purity — but only at the boundary.

### 4.3. Maintains Determinism
The domain must remain:

- sealed  
- deterministic  
- explicit  
- predictable  

External nondeterminism stays outside.

### 4.4. Enables Certification
Safety‑critical systems require:

- explicit boundaries  
- isolated impurity  
- deterministic core logic  

Isolation enables certification.

---

## 5. Doctrine Summary

- `ref` and `out` are forbidden inside Prax Junior.  
- External systems may require them.  
- Their use must be isolated in small, audited wrappers.  
- Wrappers must convert results into named structs.  
- No mutation may leak into the domain.  
- The domain remains pure, deterministic, and sealed.

**External impurity stays outside.  
Internal correctness stays inside.**

---

###### End of Document <repo:integer_division_domain/coding_rules/17_external_systems_may_require_ref_or_out.md>
