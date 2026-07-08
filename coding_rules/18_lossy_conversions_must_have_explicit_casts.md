###### Start of Document <repo:integer_division_domain/coding_rules/18_lossy_conversions_must_have_explicit_casts.md>

# 18 — Lossy Conversions Must Have Explicit Casts  
## Lossless Conversions Do Not Require Explicit Casts

## 1. Rule
Prax Junior forbids **lossy implicit conversions**.

Any conversion that can:

- narrow  
- truncate  
- overflow  
- change signedness  
- reinterpret bits  
- lose information  

**must be explicit**.

Lossless implicit conversions — those that widen safely and preserve meaning — **do not require explicit casts**.

---

## 2. Why This Rule Exists

### 2.1. Lossy Conversions Cause Drift
Lossy conversions silently change:

- width  
- range  
- signedness  
- meaning  

This creates drift between:

- what the developer *thinks* the code does  
- what the compiler *actually* does  

Drift is forbidden.

### 2.2. Lossless Conversions Are Safe
Lossless conversions:

- widen  
- preserve value  
- preserve meaning  
- preserve correctness  
- preserve determinism  

These do not introduce drift and do not require redundant casts.

### 2.3. Explicitness Must Increase Clarity
Prax Junior requires explicitness **only when it increases clarity**.

Redundant explicitness decreases clarity and is forbidden.

---

## 3. Lossy Conversions — Explicit Cast Required

### 3.1. Narrowing
```d
int x = 300;
ubyte y = cast(ubyte) x;   // required
```

### 3.2. Signed → Unsigned
```d
int s = -5;
uint u = cast(uint) s;     // required
```

### 3.3. Unsigned → Signed
```d
uint u = 4000000000;
int s = cast(int) u;       // required
```

### 3.4. Large → Small
```d
long L = 123456;
int i = cast(int) L;       // required
```

### 3.5. Enum Conversions
```d
Mode m = cast(Mode) raw_value;   // required
```

### 3.6. Boolean Conversions
```d
int i = 42;
bool ok = cast(bool) i;          // required
```

### 3.7. Explicit Domain Narrowing
```d
string[] items = ["Bob", "Carol", "Ted", "Alice"];
int count = cast(int) items.length;   // required (narrowing)
```

All lossy conversions must be explicit.

---

## 4. Lossless Conversions — No Cast Required

### 4.1. Small → Large (Widening)
```d
ubyte a =  10;
int   i = 100;

i = i + a;   // allowed
```

### 4.2. ubyte + ubyte → int
```d
ubyte a = 10;
ubyte b = 20;

ubyte result = cast(ubyte)(a + b);   // cast required only for narrowing
```

The promotion to `int` is:

- deterministic  
- safe  
- predictable  
- lossless  

No cast is required on the operands.

### 4.3. Widening Chains
```d
int  i = 10;
long L = i + 5;   // allowed
```

Lossless conversions do not require redundant casts.

---

## 5. Forbidden Patterns

### 5.1. Implicit Narrowing
```d
ubyte result = a + b;   // forbidden
```

### 5.2. Redundant Explicit Widening
```d
ubyte result = cast(ubyte)(cast(int) a + cast(int) b);   // forbidden (too verbose)
```

Explicitness must increase clarity, not decrease it.

---

## 6. Doctrine Summary

- **Lossy implicit conversions are forbidden.**  
- **Lossless implicit conversions are allowed.**  
- **All narrowing must be explicit.**  
- **Widening does not require redundant casts.**  
- **Explicitness must increase clarity, not decrease it.**  
- **The domain must remain deterministic and drift‑free.**

**Lossy conversions require explicit casts.  
Lossless conversions do not.**

---

###### End of Document <repo:integer_division_domain/coding_rules/18_lossy_conversions_must_have_explicit_casts.md>
