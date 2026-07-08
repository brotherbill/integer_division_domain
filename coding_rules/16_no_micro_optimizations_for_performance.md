###### Start of Document <repo:integer_division_domain/coding_rules/16_no_micro_optimizations_for_performance.md>

# 16 — No Micro‑Optimizations for Performance  
## Optimize for Readability, Clarity, and Correctness

## 1. Rule
Prax Junior forbids **micro‑optimizations** whose purpose is to “make the code faster” at the expense of:

- readability  
- clarity  
- correctness  
- determinism  
- sealed‑domain reasoning  

All code must optimize for **clarity first**, **correctness second**, and **performance last**.

If a micro‑optimization makes the code harder to read, harder to reason about, or harder to verify, it is **forbidden**.

---

## 2. Why Micro‑Optimizations Are Forbidden

### 2.1. They Create Drift
Micro‑optimizations often introduce:

- clever tricks  
- compressed logic  
- implicit assumptions  
- hidden invariants  
- fragile constructs  

These cause drift between:

- what the code *does*  
- what the developer *thinks* it does  

Drift is forbidden.

### 2.2. They Reduce Readability
Micro‑optimizations frequently:

- shorten lines  
- compress logic  
- remove naming  
- remove structure  
- remove clarity  

Shorter is not better.  
Clearer is better.

### 2.3. They Break Deterministic Reasoning
Prax Junior requires:

- explicit types  
- explicit domains  
- explicit semantics  
- explicit correctness geometry  

Micro‑optimizations hide intent and break deterministic reasoning.

### 2.4. They Are Not Needed
Prax Junior legality code:

- runs in microseconds  
- is pure  
- is sealed  
- is deterministic  
- is allocation‑free  
- is exception‑free  

Performance is already optimal by architecture, not by tricks.

### 2.5. They Are Dangerous in Safety‑Critical Systems
Micro‑optimizations introduce:

- off‑by‑one errors  
- boundary mistakes  
- subtle bugs  
- nondeterministic behavior  
- correctness hazards  

Safety‑critical code must be boring, explicit, and predictable.

---

## 3. What Counts as a Micro‑Optimization

### 3.1. Clever Boolean Compression
Forbidden:

```d
if (!a && b || c) { ... }
```

Allowed:

```d
if (a_is_invalid) return Invalid;
if (b_is_ready) return Ready;
return Maybe;
```

### 3.2. Removing Names to “Shorten Code”
Forbidden:

```d
auto r = f(x, y);
```

Allowed:

```d
Result result = compute_result(left: x, right: y);
```

### 3.3. Using Positional Tuples
Forbidden:

```d
auto (x, y, z) = get_values();
```

Allowed:

```d
Values v = get_values();
```

### 3.4. Using `out` or `ref` to Avoid Struct Allocation
Forbidden:

```d
void compute(out int a, out int b);
```

Allowed:

```d
struct Parts { int a; int b; }
Parts compute();
```

### 3.5. Using Banned Operators for “Speed”
Forbidden:

```d
if (a > b) { ... }
```

Allowed:

```d
if (b < a) { ... }
```

---

## 4. The Correct Optimization Strategy

### 4.1. Optimize for Readability
Readable code is:

- easier to verify  
- easier to audit  
- easier to maintain  
- easier to certify  

### 4.2. Optimize for Clarity
Clarity eliminates:

- ambiguity  
- drift  
- misinterpretation  
- incorrect reasoning  

### 4.3. Optimize for Correctness
Correctness is the highest priority.  
Performance is a distant third.

### 4.4. Optimize by Architecture, Not Tricks
Prax Junior achieves performance through:

- purity  
- no GC  
- no exceptions  
- sealed domains  
- deterministic logic  
- explicit types  

Not through micro‑optimizations.

---

## 5. Doctrine Summary

- Micro‑optimizations are forbidden.  
- Readability is mandatory.  
- Clarity is mandatory.  
- Correctness is mandatory.  
- Deterministic reasoning is mandatory.  
- Performance comes from architecture and using the right containers and algorithms, not cleverness.  
- Code must be explicit, boring, and predictable.  

**Correctness first.  
Clarity second.  
Performance last.**

---

## 6. Developer Experience (DX)  
### Initial Pain, Long‑Term Gain

Prax Junior enforces clarity and determinism over convenience.

### 6.1. Developers Resist at First
New developers often react:

- “This is too strict.”  
- “Why can’t I compress this logic?”  
- “Why do I have to name everything?”  
- “This feels like Eiffel or Ada.”  

This reaction is normal.  
It comes from habit, not correctness.

### 6.2. Developers Appreciate It Later
Once maintaining Prax Junior code, developers say:

- “This is so much clearer.”  
- “I always know what the code means.”  
- “Refactoring is safe — nothing breaks silently.”  
- “I never want to go back to clever code.”  

### 6.3. The Emotional Arc
1. **Day 1:** “This is strict.”  
2. **Day 10:** “This is consistent.”  
3. **Day 100:** “This is the only sane way to write correctness‑grade code.”

### 6.4. Prax Junior Optimizes for Maintenance, Not Convenience
Short‑term developer comfort is not a design goal.  
Long‑term correctness is.

---

## 7 — Application Coding vs Systems Programming  
### Correctness First, Performance Where It Matters

Prax Junior must distinguish between **application coding** and **systems programming**.

---

### 7.1. Application Coding — Correctness, Clarity, Readability

Application developers operate where:

- performance < correctness   
- cleverness < clarity  
- shortcuts < maintainability  

They must:

- use named structs  
- use named parameters  
- avoid `out` / `ref`  
- avoid tuples  
- avoid clever compression  
- avoid micro‑optimizations  
- use existing data structures  
- use existing algorithms  
- avoid reinventing wheels  

Application code is correctness‑first.

---

### 7.2. Systems Programming — Performance Matters, but Correctness Still Leads

Systems programmers operate in:

- memory‑constrained environments  
- latency‑sensitive environments  
- hardware‑adjacent domains  
- origin‑0 indexing  
- pointer‑centric logic  

Systems programming may require:

- origin‑0 indexing  
- pointer arithmetic  
- `out` / `ref`  
- tight loops  
- careful memory layout  

These are **performance necessities**, not conveniences.

But even here:

- correctness still leads  
- readability still matters  
- maintainability still matters  

Shortcuts are allowed **only in profiled hotspots**.

Everywhere else, Prax Junior rules apply.

---

### 7.3. Compilers: The Perfect Example

Compiler authors:

- profile  
- optimize hotspots  
- tune memory layout  
- tune cache behavior  

But they also:

- use named structs everywhere else  
- use deterministic logic everywhere else  
- use readability everywhere else  

Compilers are:

- **95% correctness‑first**  
- **5% performance‑critical**

Only the 5% gets micro‑optimized.

---

### 7.4. Summary

- Application developers must **never** use micro‑optimizations.  
- Systems programmers may use them **only** in profiled hotspots.  
- Compilers follow Prax Junior rules everywhere except the tiny performance‑critical core.  
- Prax Junior is correctness‑first.

---

###### End of Document <repo:integer_division_domain/coding_rules/16_no_micro_optimizations_for_performance.md>
