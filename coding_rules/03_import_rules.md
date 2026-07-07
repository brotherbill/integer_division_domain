###### Start of Document \<repo:integer_division_domain/CODING_RULES/03_import_rules.md\>

# 03 — Import Rules

## Purpose
Import rules define how modules declare their dependencies with **maximum clarity**, **zero ambiguity**, and **zero drift**.  
These rules ensure that every imported feature is explicit, traceable, and reviewable.

Imports must reveal **exactly** what is being used, **exactly** where it came from, and **exactly** how it enters the module.

---

# 1. No Naked Imports
A naked import is forbidden.

Forbidden:

```
import std.string;
```

Allowed:

```
import std.string : toLower, toUpper;
```

Every imported feature must be explicitly listed.

---

# 2. No Use of `*`
Wildcard imports are forbidden.

Forbidden:

```
import std.string : *;
```

Wildcard imports hide meaning, hide dependencies, and hide module boundaries.

---

# 3. Grouping Rule
Imports must be grouped into **three groups**, separated by **exactly one blank line**:

1. Standard library  
2. Other libraries  
3. Project modules

No other grouping is allowed.  
No merging groups.  
No splitting groups.

---

# 4. Group Sorting Rule
Each group must be sorted **alphabetically**, **case‑insensitive**.

Example:

```
import std.algorithm : map;
import std.array     : array;
import std.string    : toLower;
```

This is correct because `algorithm`, `array`, `string` are sorted alphabetically.

---

# 5. Feature Sorting Rule
Inside each import statement, the imported features must be sorted **alphabetically**, **case‑insensitive**.

Correct:

```
import std.string : capitalize, toLower, toUpper;
```

Incorrect:

```
import std.string : toUpper, capitalize, toLower;
```

---

# 6. Renaming Rule (Name Collisions Only)
If two modules export features with the same name, the collision must be resolved by renaming.

Example:

```
import std.string : split;
import mylib.text : split as textSplit;
```

Renaming is **mandatory** when collisions occur.

### Renaming Prohibition (Stylistic Renaming Forbidden)
Renaming must **never** be used to match project coding standards.

Forbidden:

```
import std.string : toLower as to_lower;
```

Correct:

```
import std.string : toLower;
```

Renaming exists **only** to resolve collisions — never for stylistic alignment.

---

# 7. Why Stylistic Renaming Is Forbidden

Stylistic renaming is prohibited because it destroys meaning, provenance, and developer intuition.  
These weaknesses are **show‑stopping** and make codebases fragile, confusing, and error‑prone.

### 7.1 Loss of Provenance
Renaming hides the origin of a function.

Original:

```
toLower()
```

Renamed:

```
to_lower()
```

The renamed version no longer reveals:

- which library it came from  
- which version defines it  
- which semantics it carries  
- which documentation applies  

Provenance is a core part of meaning.  
Prax does not mutate meaning.

### 7.2 Harder Debugging
Stack traces show **original names**, not aliases.

If the code uses:

```
to_lower()
```

but the stack trace shows:

```
std.string.toLower
```

developers will search for `toLower` and find nothing.  
This breaks debugging.

### 7.3 Harder Searching
Documentation, examples, tutorials, blog posts, and error messages all use the **original** names.

Renaming breaks:

- documentation search  
- IDE search  
- Google search  
- library source search  
- error message search  
- stack trace search  

Discoverability collapses.

### 7.4 Alias Drift
Aliases drift over time.

```
toLower → to_lower → lower → lowercase → lc
```

Drift destroys consistency and meaning.  
Drift is forbidden in sealed‑domain architectures.

### 7.5 Semantic Mutation
Renaming implies ownership.

Renaming says:

> “This function is ours now.”

This is false.  
External library functions must retain their heritage.

### 7.6 Developer Intuition
Developers expect library functions to look like library functions.

When external names stand out:

- developers instantly recognize them  
- they know where to search  
- they know where to debug  
- they know where to find documentation  
- they know the meaning is upstream  

This is a benefit, not a drawback.

---

# 8. Group Order Rule
Imports must appear in this exact order:

1. Standard library  
2. Other libraries  
3. Project modules

This order is mandatory.

---

# 9. Group Definitions

### Standard Library
Modules beginning with `std.`

Example:

```
import std.string : toLower, toUpper;
```

### Other Libraries
Modules from external packages, frameworks, or vendors.

Example:

```
import vibe.data.json : Json, JsonValue;
```

### Project Modules
Modules belonging to this project.

Example (real):

```
import domain.fail_catalog : Fail_Code, fail_message;
```

Features must be sorted alphabetically:

```
import domain.fail_catalog : Fail_Code, fail_message;
```

---

# 10. Synthetic Examples (Pedagogical Only)

Synthetic examples must use **obviously pedagogical modules** that cannot be mistaken for real project modules.

Correct synthetic examples:

```
import animal.bear : name, speak, roar;
import animal.cat  : name, speak, purr;
```

These are correct because:

- “animal” is not a real project namespace  
- “bear” and “cat” are clearly pedagogical  
- “name”, “speak”, “roar”, “purr” are obviously fake features  
- developers have seen similar examples many times  
- no provenance is implied  
- no search path is implied  
- no debugging path is implied  

### Forbidden synthetic examples
Synthetic examples must **never** use:

- real project namespaces  
- real project naming geometry  
- real project module paths  
- real library names  
- real library features  

Forbidden:

```
import domain.fail_catalog : roar;        // mixing real module with fake feature
import animal.bear : Fail_Code;           // mixing fake module with real feature
import integer_division_domain.core : purr; // mixing real path with synthetic feature
```

This is strictly prohibited.

---

# 11. Flat Module Headers for Tree Structures
Even if the project has a **tree of modules**, imports must remain **flat**.

Example tree:

```
domain/
    fail_catalog/
        fail_catalog.d
    classified/
        classified.d
    classifier/
        classifier.d
```

Correct imports:

```
import domain.fail_catalog.fail_catalog : Fail_Code, fail_message;
import domain.classified.classified     : Classified, Kind;
import domain.classifier.classifier     : classify;
```

No collapsing.  
No wildcarding.  
No “import domain.*”.  
No “import fail_catalog.*”.

Every module is imported explicitly.

---

# 12. Summary

- No naked imports.  
- No wildcard imports.  
- Three groups: standard library, other libraries, project modules.  
- One blank line between groups.  
- Groups sorted alphabetically, case‑insensitive.  
- Features sorted alphabetically, case‑insensitive.  
- Renaming allowed **only** for collisions.  
- Renaming for style is forbidden.  
- External names must retain their heritage.  
- Synthetic examples must be obviously pedagogical.  
- Real examples must use real modules.  
- Never mix real and synthetic examples.  
- Tree modules imported with flat explicit paths.  
- Every dependency must be explicit, visible, and reviewable.

###### End of Document \<repo:integer_division_domain/CODING_RULES/03_import_rules.md\>
