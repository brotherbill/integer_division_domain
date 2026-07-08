###### Start of Document <repo:integer_division_domain/coding_rules/14_accentuate_the_positive.md>

# 14 — Accentuate the Positive  
## Refactoring Negated Relational Expressions

## 1. Rule
Negated relational expressions must be rewritten into their **positive**, **direct**, and **non‑negated** equivalents.

Negation introduces:

- cognitive inversion  
- semantic ambiguity  
- readability drift  
- error‑prone reasoning  
- double‑negative confusion  

Positive expressions are:

- clearer  
- shorter  
- deterministic  
- sealed‑domain friendly  
- correctness‑aligned  

This rule applies to **all** relational operators.

---

## 2. Refactoring Table

| Negated Form | Positive Equivalent | Reason |
|--------------|---------------------|--------|
| `!(a == b)`  | `a != b`            | Direct inequality is clearer than negated equality. |
| `!(a != b)`  | `a == b`            | Direct equality is clearer than negated inequality. |
| `!(a < b)`   | `b <= a`            | Expresses the exact relational meaning without negation or banned operators. |
| `!(a <= b)`  | `b < a`             | Expresses strict greater‑than without using the banned `>` operator. |

All four transformations remove negation and avoid banned operators (`>` and `>=`).

---

## 3. Why Negated Expressions Are Forbidden

### 3.1. Negation Reverses Developer Reasoning
Negation forces the developer to mentally invert the condition:

- “not equal”  
- “not not‑equal”  
- “not less than”  
- “not less‑or‑equal”  

This increases cognitive load and introduces drift.

### 3.2. Negation Masks Intent
Negated expressions hide the **true** relational meaning:

- `!(a < b)` does not visually communicate “a is greater than or equal to b.”  
- `!(a <= b)` does not visually communicate “a is strictly greater than b.”

Positive expressions communicate intent directly.

### 3.3. Negation Interacts Poorly With Banned Operators
Prax Junior bans:

- `>`  
- `>=`

Negated expressions often imply these operators implicitly.  
Positive rewrites avoid them entirely.

### 3.4. Negation Is Error‑Prone
Negated relational expressions are a common source of:

- off‑by‑one errors  
- boundary mistakes  
- inverted logic  
- misclassification  
- incorrect legality decisions  

Positive expressions eliminate these hazards.

---

## 4. The Four Canonical Rewrites

### 4.1. `!(a == b)` → `a != b`
Negated equality becomes direct inequality.

### 4.2. `!(a != b)` → `a == b`
Negated inequality becomes direct equality.

### 4.3. `!(a < b)` → `b <= a`
Negated “less than” becomes “greater than or equal,” expressed without `>=`.

### 4.4. `!(a <= b)` → `b < a`
Negated “less‑or‑equal” becomes “greater than,” expressed without `>`.

These four transformations cover **all** negated relational expressions in Prax Junior.

---

## 5. Doctrine Summary

- Negated relational expressions are forbidden.  
- All relational logic must be expressed positively.  
- All comparisons must avoid `>` and `>=`.  
- Positive rewrites eliminate ambiguity and drift.  
- Positive rewrites strengthen deterministic reasoning.  
- Positive rewrites align with sealed‑domain correctness.

**Accentuate the positive.  
Eliminate the negative.  
Strengthen correctness.**

---

###### End of Document <repo:integer_division_domain/coding_rules/14_accentuate_the_positive.md>
