###### Start of Document \<repo:integer_division_domain/coding_rules/06_enums.md\>

# 06 — Enums for String Literals and Magic Numbers

## Purpose
Enums eliminate drift caused by repeated string literals and magic numbers.  
They provide a single authoritative source of meaning.  
They prevent accidental divergence, typographical errors, and silent semantic changes.  
Enums are mandatory whenever a repeated literal conveys meaning.

---

# 1. Magic Constants Must Become Enums
Magic **constants** or **literals** must be dignified by becoming enums.  
A literal that carries meaning must never be buried inside code.

Correct:
```
enum repo = "integer_division_domain";
```

This form has three benefits:
1. **Immutable all the way down** — cannot be reassigned or mutated.  
2. **Stable meaning** — should rarely change, and when it does, the change is centralized.  
3. **Typed literal** — strings, integers, floats, and other types are allowed.

This eliminates drift caused by:
- repeated string literals  
- repeated directory names  
- repeated domain identifiers  
- repeated magic numbers  

Incorrect:
```
string repo = "integer_division_domain";   // mutable — forbidden
string path = "integer_division_domain";   // repeated literal — forbidden
```

### Exceptions
Some literals are too trivial to dignify:

- the empty string `""`  
- simple formatting strings such as `", "`  

These do **not** require enums because they carry no domain meaning.

---

# 2. Two Valid Uses of Enums in D

D has **two** legitimate enum forms, both required in Prax Junior.

## A. C‑Style Enumerations (Closed Sets)
These define a group of **unique names** representing semantic categories:

Correct:
```
enum Status {
    ready,
    waiting,
    failed
}
```

Use when:
- values form a closed universe  
- names represent domain meaning  
- variants are mutually exclusive  

Incorrect:
```
enum Status {
    r,
    w,
    f
}
```

## B. Immutable Compile‑Time Values
These define **typed constants** that eliminate repeated literals:

Correct:
```
enum domain_root  = "integer_division_domain";
enum max_attempts = 7;
enum default_mode = Mode.active;
```

Use when:
- a literal appears more than once  
- a literal conveys meaning  
- a literal should be sealed-domain  
- a literal must be immutable  
- a literal must be available at compile time  

Incorrect:
```
string domain_root = "integer_division_domain";   // mutable — forbidden
int max_attempts = 7;                             // magic number — forbidden
```

---

# 3. Enums Must Be Meaning‑Based
Enum names must convey meaning.  
They must not be abbreviations, partial words, or cryptic identifiers.

Correct:
```
enum FileMode {
    read_only,
    write_only,
    read_write
}
```

Incorrect:
```
enum FileMode {
    ro,
    wo,
    rw
}
```

Enums must be:
- readable  
- meaningful  
- deterministic  
- sealed-domain  

---

# 4. Enums Must Replace All Repeated Literals
Once an enum exists, all code must use it.  
String literals and magic numbers must not appear anywhere else.

Correct:
```
Mode a_mode = Mode.active;
```

Incorrect:
```
string a_mode = "active";   // enum exists — forbidden
```

Correct:
```
ErrorCode a_code = ErrorCode.bad_request;
```

Incorrect:
```
int a_code = 400;           // enum exists — forbidden
```

---

# 5. Platoon Formation for Enums
Enum definitions must follow spacing discipline.  
Names must align in platoon formation when values are present.

Correct:
```
enum ErrorCode {
    none        =   0,
    not_found   = 404,
    forbidden   = 403,
    bad_request = 400
}
```

Incorrect:
```
enum ErrorCode {
    none=0,
    not_found      =404,
    forbidden =   403,
    bad_request     =    400
}
```

Platoon formation is optional but recommended for clarity.

## Right‑Adjusted Numbers, Left‑Adjusted Words
When platoon formation is used:

- names are left‑adjusted  
- operators align in the same column  
- numbers are right‑adjusted  
- decimal points align in the same column  
- strings / words remain left‑adjusted  

Correct:
```
enum Limits {
    max_users     =   25,
    max_attempts  =    7,
    min_threshold = -300
}
```

Incorrect:
```
enum Limits {
    max_users = 25,
    max_attempts = 7,
    min_threshold = -300
}
```

---

# 6. Enums in Imports and Domain Modules
Enums must be imported explicitly.  
Spacing must follow import discipline.

Correct:
```
import domain.status : Status;
import domain.errors : ErrorCode;
```

Incorrect:
```
import domain.status;
import domain.errors;
```

Trailing spaces are forbidden.  
Invisible spacing differences are forbidden.

---

# 7. Summary

- Magic constants must become enums.  
- Exceptions: empty string, trivial formatting strings.  
- D supports two enum forms: C‑style and compile‑time immutable values.  
- Immutable enums eliminate drift and centralize meaning.  
- Enums must be meaningful and readable.  
- Once an enum exists, all code must use it.  
- Platoon formation applies to enum definitions.  
- Numbers right‑adjusted, words left‑adjusted.  
- Imports must follow spacing discipline.  
- Enums prevent drift and ensure sealed-domain meaning.

###### End of Document \<repo:integer_division_domain/coding_rules/06_enums.md\>
