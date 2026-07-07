// Start of Document /</repo:integer_division_domain/CODING_RULES.md/>

# CODING RULES
A single, authoritative set of operator‑discipline rules for all code in this repository.  
These rules exist to eliminate drift, ambiguity, cleverness, and invisible behavior.  
They are designed so that **AI, novices, managers, auditors, and Homer Simpson** all understand the code the same way.

---

## 1. Explicit Increment Rule
**Thou shalt not use:**  
- ++i  
- i++  
- i += 1  
- i += n  

**Thou shalt use:**  
- `i = i + 1;`

**Why:**  
- Explicit mutation preserves cognition. Increment operators hide behavior, confuse novices, and introduce drift vectors.  
- It removes all the cleverness of ++i vs. i++, that Junior Programmers have challenges with.  
- Managers and auditors can read `i = i + 1;` and know exactly what it does, without a team lead or architect translating it for them.  
- `foo = ++i / (j-- + ++i);`  // Is this UB or well‑defined? Let’s waste a few hours to find out.

---

## 2. Spacing Discipline
Function calls, asserts, and control structures must have a space before `(`:

- `assert (x == y);`  
- `fraction_vm (c, buf[]);`

**Why:**  
- Prevents visual compression.  
- Makes code readable for novices and auditors.  
- Eliminates “operator soup.”

---

## 3. Import Rules

### 3.1 Platoon Alignment
Imports must be platoon‑aligned:

```
import domain.classified      : Classified;
import domain.fraction        : Fraction;
import utility.int_to_decimal : int_to_decimal;
```

**Why:**  
- Scan‑friendly.  
- Audit‑friendly.  
- Makes large import blocks readable.

---

### 3.2 Ordered Import Groups
Imports must appear in the following order:

1. **Standard libraries** (e.g., `std.*`)  
2. **Other libraries** (third‑party or external)  
3. **Our modules** (domain, classifier, vm, utility, etc.)

Within each group, imports must be **sorted ascending, case‑insensitive**.

Example:

```
import std.algorithm      : sort;
import std.ascii          : toLower;

import vibe.http.server   : HTTPServer;
import vibe.data.json     : Json;

import domain.fraction    : Fraction;
import utility.math_ops   : add, subtract, multiply;
```

**Why:**  
- Predictable structure.  
- Easy for novices and auditors to navigate.  
- Prevents chaotic import ordering.

---

### 3.3 Itemized Features Only
Imports must list **specific features**.  
No `*`, no “grab everything,” no wildcard imports.

```
import utility.math_ops : add, subtract, multiply;
```

Features must be **sorted ascending, case‑insensitive**.

**Why:**  
- Prevents accidental symbol bleed.  
- Makes dependencies explicit.  
- Guarantees deterministic refactoring.

---

### 3.4 Renaming Colliding Features
If two modules export features with the same name, the feature must be **renamed** at import time:

```
import utility.formatting : render as fmtRender;
import vm.fraction_vm     : render as vmRender;
```

**Why:**  
- Prevents namespace collisions.  
- Makes call‑sites unambiguous.  
- Keeps code readable for novices, managers, and auditors.

---

## 4. Comment Preservation Rule
VM commentary blocks are **sacred**.  
They must never be removed, compressed, or rewritten unless explicitly commanded.

**Why:**  
- They encode architectural intent.  
- They prevent future drift.  
- They teach novices how the system works.

---

## 5. UGLY BETTY Identity Wrapper Rule
Every file must begin and end with:

```
// Start of Document /</repo:path/to/file>
// End of Document /</repo:path/to/file>
```

**Why:**  
- Prevents partial‑copy syndrome.  
- Ensures file identity.  
- Protects boundaries during regeneration.

---

## 6. Digit‑Separator Rule
Digit grouping must use underbars:

- `1_000`  
- `411_522`  
- `5_000_000`

**Why:**  
- Commas have semantic meaning in messages.  
- Underbars are unambiguous and D‑native.  
- Prevents confusion in rendering code.

---

## 7. VM Purity Rule
VM code must:

- be @safe, pure, nothrow, @nogc  
- allocate nothing  
- use no Phobos  
- contain no domain logic  
- contain no classifier logic  

**Why:**  
- VM is a pure renderer.  
- Purity ensures deterministic behavior.  
- Prevents semantic leakage across layers.

---

## 8. Domain Purity Rule
Domain code must contain **meaning only**.  
No rendering, no formatting, no UI logic.

**Why:**  
- Keeps meaning geometry clean and sealed.  
- Prevents accidental coupling with VM or classifier layers.

---

## 9. Classifier Purity Rule
Classifier code must contain **mapping only**.  
No rendering, no formatting, no UI logic.

**Why:**  
- Prevents semantic leakage.  
- Keeps classification logic deterministic and isolated.

---

## 10. Test Discipline Rule
All tests must follow:

- AAA structure (Arrange, Act, Assert)  
- Named test functions (`xxx_should_yyy`)  
- No anonymous tests  
- No cleverness  
- No compression  

**Why:**  
- Tests must be readable by novices, managers, and auditors.  
- Predictable structure prevents drift and confusion.

---

## 11. No Clever Operators Rule
Forbidden:

- `>`  
- `>=`  
- `?:`  
- `++`  
- `--`  
- `+=`  
- `-=`  
- `*=`  
- `/=`  

Allowed:

- explicit comparisons  
- explicit arithmetic  
- explicit mutation  

**Why:**  
- Clever operators hide intent.  
- They break UL‑grade clarity.  
- They confuse novices and auditors.

---

## 12. No Hidden Semantics Rule
Code must never rely on:

- implicit conversions  
- overloaded operators  
- side‑effects  
- magic behavior  

**Why:**  
- Hidden semantics destroy determinism.  
- They make code unpredictable for novices and AI.

---

## 13. No Shortcuts Rule
Code must be boring, explicit, and predictable.

**Why:**  
- Safety‑critical systems demand clarity over cleverness.  
- Predictability prevents catastrophic drift.

---

# End of Document /</repo:integer_division_domain/CODING_RULES.md/>
