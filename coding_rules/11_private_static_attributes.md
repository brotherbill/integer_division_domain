###### Start of Document \<repo:integer_division_domain/coding_rules/11_private_static_attributes.md\>

# 11 — private static Attributer Rule

## Purpose
Prax Junior requires `private` and `static`—when present—to appear **on the left side**, **before the return type**, **on the same line** as the function signature.  
This preserves locality, eliminates drift, improves scanning.

Attributes belong **with** the function signature, not floating above it.
Attributes bind to the function, not to the return type.

---

# 1. Thou Shalt Place Attributes on the Left, on the Same Line

### Required:
```
private static int meaning (in int x)
{
    return x + 1;
}
```

### Allowed (only one attribute):
```
private int meaning (in int x)
{
    return x + 1;
}

static int meaning (in int x)
{
    return x + 1;
}
```

### Forbidden:
```
static private int meaning (in int x)
{
    return x + 1;
}

int private static meaning (in int x)
{
    return x + 1;
}
```

### Absolutely Forbidden:
```
private:
static:
int meaning (in int x)
{
    return x + 1;
}
```

Attributes must be **local**, **visible**, **bound**, and **deterministic**.

---

# 2. Attribute Ordering Rule

Both attributes are optional.  
But if both are present, the order SHALL be:

> **private static**

This ordering is deterministic, readable, and cognitively aligned.

---

# 3. Why This Rule Exists

## A. Attribute Locality Preserves Cognition
These attributes belong **with** the signature.  
Splitting them across lines forces the reader to re‑associate meaning.

Locality improves:
- readability  
- scanning  
- comprehension  
- determinism  

---

## B. Attribute Drift Is Eliminated
Floating attributes drift:
- they get separated  
- they get reordered  
- they get lost  
- they get mis‑copied  

Left‑anchoring attributes eliminates drift vectors.

---

## C. Attribute Grouping Improves Scanning
A function signature is a **single cognitive unit**.

Splitting attributes forces:
- upward scanning  
- re‑binding  
- re‑parsing  

---

## D. Attribute Placement Is Deterministic
Prax Junior requires deterministic structure.

Attributes must be:
- visible  
- local  
- predictable  
- unambiguous  

Left‑anchoring satisfies this.

---

## E. Attribute Ordering Is Cognitively Natural
Humans say:

> “This is a **private static** helper.”

They do **not** say:

> “This is a static private helper.”

Natural language ordering improves readability and scanning.

---

## F. What `private` Means (Short Form)
**private** restricts access to the current module.  
Only code in this module may call the function.

This is deterministic visibility.

---

## G. What `static` Means (Short Form)
**static** means the function does not use an object instance.  
It is called directly from the module.

---

## H. Attribute Placement Is Junior‑Friendly
Junior programmers understand:

```
private static int meaning (...)
```

They do **not** understand:

```
static private int meaning (...)
```

or:

```
private:
static:
int meaning (...)
```

This supports clarity for:
- Junior Programmers  
- Managers  
- SMEs  
- Auditors  

---

# 4. Summary

- Attributes go on the **left**.  
- Attributes go **before the return type**.  
- Attributes go **on the same line**.  
- If both are present, the order is **private static**.  
- `private` = module‑local access.  
- `static` = no object is used.  
- This preserves locality, eliminates drift, and improves scanning.  
- This maintains sealed‑domain determinism.  
- This is junior‑friendly, manager‑friendly, and auditor‑friendly.  
- This is Prax Junior.

###### End of Document \<repo:integer_division_domain/coding_rules/11_private_static_attributes.md\>
