###### Start of Document <repo:integer_division_domain/coding_rules/13_auto_banned.md>

# 13 — `auto` Is Banned

## 1. Rule
`auto` is **banned** in Prax Junior.

All variables, fields, temporaries, and constructed values must use **explicit types**.

There are **no exceptions**, including:

- factory methods  
- static `make` constructors  
- domain constructors  
- obvious return types  
- visually obvious types  
- “shortening the line” cases  

If a type is required, it must be written explicitly.

---

## 2. Why `auto` Is Banned

### 2.1. Type Inference Causes Drift
`auto` relies on **compiler inference**, which may differ from:

- developer reasoning  
- domain intent  
- architectural semantics  
- future refactoring  
- template evolution  
- qualifier propagation  

When the compiler infers one type and the developer *believes* it is another, the system experiences **silent drift**.

Silent drift is forbidden.

---

### 2.2. Inference Is Nondeterministic From the Developer’s Perspective
The compiler infers types using:

- overload resolution  
- template deduction  
- implicit conversions  
- qualifiers (`const`, `immutable`, `shared`)  
- return‑type inference  

The developer reasons using:

- domain shape  
- naming geometry  
- construction semantics  

These two reasoning systems **can diverge**.

Prax Junior requires **alignment** between developer reasoning and compiler behavior.  
Inference breaks that alignment.

---

### 2.3. The “Static Make” Exception Is Not Safe
The following is **not allowed**:

```d
auto car = Car.make("Volkswagen Jetta");
```

Even though the developer believes the type is `Car`, the compiler may infer:

- a subtype  
- a wrapper  
- a template specialization  
- a qualified type  
- a future refactored type  

This creates **semantic ambiguity**.

Explicit typing eliminates ambiguity:

```d
Car car = Car.make("Volkswagen Jetta");
```

Explicitness is correctness.

---

### 2.4. Convenience Is Not a Correctness Argument
Arguments such as:

- “It shortens the line.”  
- “It looks cleaner.”  
- “It’s idiomatic D.”  
- “It’s modern.”  
- “It’s ergonomic.”  

are **not correctness arguments**.

Prax Junior is a **deterministic correctness discipline**, not a convenience language.

---

## 3. What D Experts Will Say — and Why They Are Wrong

### 3.1. “You’re dismantling D’s features.”
Prax Junior is not D.  
Prax Junior is **deterministic D**.

### 3.2. “You’re making D look like Eiffel or COBOL.”
Explicitness is not antiquated.  
Explicitness is correctness.

### 3.3. “auto is safe — the compiler knows the type.”
Prax Junior is not about what the compiler knows.  
Prax Junior is about what the developer knows.

### 3.4. “auto reduces typing.”
Correctness is more important than typing convenience.

---

## 4. Sealed‑Domain Requirement
Prax Junior requires:

- explicit types  
- explicit construction  
- explicit domain values  
- explicit legality  
- explicit semantics  

Inference is nondeterministic from the developer’s perspective.  
Therefore:

> **Inference is forbidden.**

---

## 5. Final Doctrine
**`auto` is banned in Prax Junior.  
All types must be explicit.  
All construction must be explicit.  
All domain values must be explicit.**

This eliminates:

- drift  
- ambiguity  
- inference‑based surprises  
- refactoring hazards  
- semantic misalignment  
- nondeterministic reasoning  

This strengthens:

- sealed‑domain determinism  
- UL‑grade correctness  
- replayability  
- auditability  
- domain clarity  
- architectural purity  

---

###### End of Document <repo:integer_division_domain/coding_rules/13_auto_banned.md>
