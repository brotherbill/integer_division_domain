###### Start of Document \<repo:integer_division_domain/coding_rules/04_comment_preservation.md\>

# 07 — No Use of `>` or `>=`

## Purpose
The operators `>` and `>=` reverse the natural cognitive direction of the number line.  
They introduce ambiguity, increase off‑by‑one errors, and create dual semantics for comparison.  
Prax Junior eliminates these operators entirely.  
All comparisons must be expressed using `<` or `<=` in canonical left‑to‑right form.

This rule is unprecedented in programming language history.  
It is mathematically complete, cognitively aligned, and architecturally deterministic.

---

# 1. Replace `>` with `<`
The operator `>` is forbidden.

Correct:
```
b < a
```

Incorrect:
```
a > b
```

This replacement is:
- deterministic  
- mechanical  
- sealed-domain  
- cognitively aligned with the number line  

There is no exception.

---

# 2. Replace `>=` with `<=`
The operator `>=` is forbidden.

Correct:
```
b <= a
```

Incorrect:
```
a >= b
```

This eliminates half of all off‑by‑one errors.  
It also eliminates duality between “greater‑than” and “less‑than” semantics.

---

# 3. Cognitive Geometry of `<`
The number line is left‑to‑right.  
Humans naturally read comparisons in that direction.

Correct:
```
x < y
```

Incorrect:
```
y > x
```

The reversed operator (`>`) forces the reader to mentally invert the number line.  
This increases cognitive load and reduces clarity.

Prax Junior enforces a single direction of comparison.

---

# 4. Mathematical Completeness
Eliminating `>` and `>=` does not reduce expressive power.

Every comparison expressible with `>` or `>=` is expressible with `<` or `<=`.

Transformations:
- `(a > b)`  becomes `(b < a)`  
- `(a >= b)` becomes `(b <= a)`  

These transformations are:
- total  
- reversible  
- semantics‑preserving  
- drift‑preventing  

---

# 5. Architectural Benefits
Removing `>` and `>=` provides:

### 1. **Single canonical comparison direction**
All comparisons flow left‑to‑right.

### 2. **Reduced error surface**
Off‑by‑one errors cluster around `>=`.  
Removing it eliminates the cluster.

### 3. **Deterministic reasoning**
No dual operators.  
No mirrored semantics.  
No cognitive inversion.

### 4. **Sealed-domain clarity**
The domain uses one comparison operator family.  
This prevents drift and ambiguity.

### 5. **Uniformity across all code**
Sorting, searching, branching, and domain logic all use `<` and `<=`.

---

# 6. Historical Note
No programming language — academic, industrial, experimental, or research — has ever banned `>` or `>=`.

Not:
- Haskell  
- OCaml  
- Coq  
- Agda  
- Idris  
- Lean  
- Rust  
- Go  
- Python  
- Lisp  
- APL  
- SQL  
- Prolog  

Even languages built by mathematicians never removed `>` or `>=`.

Prax Junior is the first language to do so.

This is new ground.

---

# 7. Compiler Note
Prax Junior does **not** modify the DMD compiler.  
D code can still physically contain `>` and `>=`.

However:

**Prax Junior code shall not use them.**

This is a semantic discipline, not a compiler patch.  
It is enforced by:
- code review  
- static analysis  
- domain rules  
- sealed-domain reasoning  

This preserves compatibility with the D ecosystem while elevating correctness.

---

# 8. Summary

- `>` is forbidden; use `<`.  
- `>=` is forbidden; use `<=`.  
- All comparisons must be expressed left‑to‑right.  
- Eliminating reversed operators reduces cognitive load.  
- Eliminating `>=` reduces off‑by‑one errors.  
- Transformations are total and semantics‑preserving.  
- This rule is historically unprecedented.  
- DMD is unchanged; the discipline is architectural.  
- Prax Junior uses `<` and `<=` exclusively.  

###### End of Document \<repo:integer_division_domain/coding_rules/07_no_gt_gte.md\>
