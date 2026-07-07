###### Start of Document \<repo:integer_division_domain/coding_rules/01_ugly_betty.md\>

# 01 — UGLY BETTY Identity Token

## Purpose
UGLY BETTY defines the **identity token** used to represent the origin of a file.  
It is **not** a header.  
It is **not** a footer.  
It is **not** a wrapper.  
It is **only** the identity token.

UGLY BETTY packages exactly three things:

1. **repo**  
2. **directory path**  
3. **filename.ext**

Nothing more.

---

# Why UGLY BETTY Exists

UGLY BETTY was created because **normal syntax cannot safely carry identity** across all environments.  
Every conventional mechanism fails somewhere:

- comments get stripped  
- metadata gets rewritten  
- annotations get reformatted  
- JSON/XML gets parsed and mutated  
- AI regenerators “fix” or “improve” things  
- editors auto‑correct or auto‑indent  
- OSes normalize slashes or paths  
- humans rename files without preserving lineage

There was **no safe place** to store identity.

UGLY BETTY is that safe place.

It is a **pure identity geometry** that survives:

- copy/paste  
- merges  
- refactors  
- AI regeneration  
- editor transformations  
- OS path rewriting  
- human error  
- language differences  
- tooling differences

No existing syntax could do this.  
UGLY BETTY had to be invented.

---

# Why the Syntax Is Strange

UGLY BETTY looks strange **on purpose**.

Its geometry:

```
\<repo:repo-name/path/to/filename\>
```

is intentionally:

- **not a comment**  
- **not markup**  
- **not JSON**  
- **not XML**  
- **not HTML**  
- **not a pragma**  
- **not an annotation**  
- **not a docstring**  
- **not a shebang**  
- **not a language feature**

This weirdness is a **feature**, not a bug.

The syntax is strange because:

### 1. No parser will interpret it  
It is syntactically alien.  
No language thinks it means anything.  
No tool tries to “fix” it.

### 2. Editors will not auto‑format it  
It does not trigger:

- indentation  
- wrapping  
- comment alignment  
- syntax coloring  
- auto‑closing  
- auto‑escaping

Editors leave it alone.

### 3. AI systems will not mutate it  
AI models tend to “improve” normal syntax.  
UGLY BETTY is so unusual that AI treats it as a **literal**, not a pattern.

### 4. Humans cannot confuse it with content  
Developers instantly recognize it as:

- not code  
- not documentation  
- not metadata  
- not a directive

It stands out.

### 5. It is portable across all environments  
It works everywhere because it belongs nowhere.

---

# Why UGLY BETTY Was Created

UGLY BETTY was invented to solve one destructive problem:

> **Files lose their identity when moved, copied, regenerated, or edited.**

Symptoms:

- A file is copied → origin lost.  
- A file is regenerated → wrong identity used.  
- A file is merged → identity overwritten.  
- A file is renamed → lineage disappears.  
- A fragment is pasted → identity missing.  
- AI regenerators hallucinate new filenames.  
- Humans forget where a file came from.  
- Toolchains rewrite comments or metadata.

UGLY BETTY solves this by providing a **single, immutable identity token** that:

- never overlaps with real syntax  
- never overlaps with comments  
- never overlaps with markup  
- never overlaps with metadata  
- never overlaps with language features  
- never overlaps with human conventions

It is the **one place** where identity can live safely.

---

# Canonical Form (Repo‑Based)
The one true UGLY BETTY syntax is:

```
\<repo:repo-name/path/to/filename\>
```

This is the **only** correct form.

### Forbidden forms
```
<repo:repo-name/path/to/filename>
/<repo:repo-name/path/to/filename/>
<<repo:repo-name/path/to/filename>>
<repo:path>
<repo:...>
```

None of these are UGLY BETTY.

---

# Files Not Using Repos

### Windows (Correct)
```
\</C/path/to/filename\>
```

### Windows (Forbidden)
```
<C:/path/to/filename>
<C:\path\to\filename>
```

These violate UGLY BETTY geometry.

### Mac/Linux (Correct)
```
\<home/bb/path/to/filename\>
```

### Notes
- No drive letters on Unix‑like systems.  
- No colon.  
- No backslashes.  
- No raw `<…>`.

---

# Summary
UGLY BETTY is **only** the identity token.  
It exists because **no other syntax can safely carry identity** across all environments.  
Its geometry is intentionally strange to prevent mutation, confusion, and interpretation.  
It is a **pure identity anchor** that survives editors, OSes, languages, humans, and AI.

###### End of Document \<repo:integer_division_domain/coding_rules/01_ugly_betty.md\>
