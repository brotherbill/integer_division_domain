###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/07_pure_deterministic_functions.md>

# 07 — pure Deterministic Functions

## 1. Definition
`pure` is the D language attribute that guarantees **deterministic, input‑only computation**.

A pure function’s output depends **only on its parameters** and **immutable global state**.  
It cannot read or write mutable global state, and it cannot depend on external nondeterminism.

Pure functions may allocate memory, but the allocation cannot affect purity.

---

## 2. Compiler Guarantees
When a function is marked `pure`, the compiler enforces:

- no reading mutable global variables  
- no writing global variables  
- no hidden state access  
- no impurity leakage through referenced objects  
- no nondeterministic dependencies  
- no mutation of parameters unless allowed by purity rules  
- no reliance on external systems or runtime state  

If any impurity is detected, compilation fails.

---

## 3. Legality Meaning
`pure` ensures:

- deterministic behavior  
- sealed‑domain predictability  
- replayable logic  
- invariant‑preserving computation  
- no nondeterministic influence on legality decisions  

It is the **determinism guarantee** for legality code.

A pure function is fully predictable:  
same inputs → same outputs → same legality.

---

## 4. Why This Matters
Determinism is required for:

- legality evaluation  
- invariant enforcement  
- correctness proofs  
- replayability  
- auditability  
- certifiable behavior  

Impure functions introduce nondeterminism, which:

- breaks sealed‑domain reasoning  
- prevents replay  
- prevents audit  
- prevents certification  
- introduces correctness drift  

`pure` eliminates nondeterministic influence on legality.

It is the **second wall of correctness**.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/07_pure_deterministic_functions.md>
