###### Start of Document \<repo:integer_division_domain/coding_rules/02_identity_header_footer.md\>

# 02 — Identity Header and Footer

## Purpose
Identity headers and footers define **file boundaries**.  
They are **not** UGLY BETTY.  
They **contain** UGLY BETTY.

UGLY BETTY = identity token  
Identity Header/Footer = boundary markers

These two concerns must never be conflated.

---

## Literal Text Rule
The phrases:

```
Start of Document
End of Document
```

are **exact, case‑sensitive literals**.

Rules:

- Do **not** shorten them.  
- Do **not** change case.  
- Do **not** translate them.  
- Do **not** paraphrase them.  
- Do **not** stylize them.  
- Do **not** mutate them in any way.

They are **fixed**, **immutable**, and must remain exactly as written in all families that use them.

---

## Creation Rule (New Files)
When creating a **new file**:

- The identity header must be placed on **line 1**.  
- The identity footer must be placed on the **last line**.  
- The footer must end with **exactly one newline** (`\n`).  
- No blank lines above the header.  
- No blank lines below the footer.  
- This placement is mandatory **unless** the external system forbids it.

If a company or toolchain has its own header/footer standards, **their rules take precedence**.  
We follow their format and placement exactly.

---

## Regeneration Rule (Existing Files)
When regenerating an **existing file**:

- **Do not move** the identity header if it is not at the top.  
- **Do not move** the identity footer if it is not at the bottom.  
- **Leave both markers exactly where they already are.**  
- **Only update the UGLY BETTY token inside them** if the repo/path/to/filename has changed.  
- **Never reposition** identity markers unless explicitly instructed.  
- **Never override** external system constraints.

This is the entire rule.

---

# 1. Markdown Family (.md)

Header:

```
###### Start of Document \<repo:repo-name/path/to/filename\>
```

Footer:

```
###### End of Document \<repo:repo-name/path/to/filename\>
```

Rules:

- Must use **six `#` characters**.  
- Must embed UGLY BETTY exactly.  
- Must appear at the very top and very bottom of **new** files.  
- If prohibited, place them **as close as possible** to the edges.  
- During regeneration, **update in place**; do not reposition.

---

# 2. C Family (.c, .h, .cpp, .hpp, .cs, .d)

Header:

```
// Start of Document \<repo:repo-name/path/to/filename\>
```

Footer:

```
// End of Document \<repo:repo-name/path/to/filename\>
```

Rules:

- Must use `//` comment syntax.  
- Must embed UGLY BETTY exactly.  
- Must appear at top and bottom of **new** files.  
- If prohibited, place them **as close as possible**.  
- During regeneration, **update in place**; do not reposition.

---

# 3. Eiffel Family (.e)

Header:

```
-- Start of Document \<repo:repo-name/path/to/filename\>
```

Footer:

```
-- End of Document \<repo:repo-name/path/to/filename\>
```

Rules:

- Must use `--` comment syntax.  
- Must embed UGLY BETTY exactly.  
- Must appear at top and bottom of **new** files.  
- If prohibited, place them **as close as possible**.  
- During regeneration, **update in place**; do not reposition.

---

# 4. JSON Family (.json)

**No identity header/footer.**

Rules:

- JSON must remain pure.  
- No comments.  
- No wrappers.  
- No UGLY BETTY.  
- No boundary markers.

### Anti‑Cleverness Rule
Developers must **never** attempt to be “clever” with JSON syntax to simulate identity markers.

Prohibited techniques include:

- Fake comments using strings (e.g., `"// Start of Document …"`).  
- Metadata objects pretending to be headers (e.g., `"__header__": "…"`)  
- Wrapper objects or arrays used to “hold” identity markers.  
- Top‑level keys inserted to mimic headers or footers.  
- Trailing objects added to simulate footers.  
- Whitespace tricks or formatting hacks.

All of these are prohibited because they:

- **change the semantics** of the JSON  
- break parsers  
- break schemas  
- break validators  
- break downstream systems  
- create a **hornet’s nest of issues**

JSON is the **only** family where identity markers are **never allowed**, under any circumstances.

Regeneration rule does not apply: JSON files have no identity markers to update.

---

# 5. Summary

- UGLY BETTY is the **identity token**.  
- Identity Header/Footer are **boundary markers**.  
- They are **separate concerns**.  
- New files: header on line 1, footer on last line, footer ends with exactly one newline.  
- Existing files: update identity **in place**, never reposition.  
- External systems: their rules override ours.  
- JSON gets none — **no clever hacks, no simulated markers, no exceptions**.  
- “Start of Document” and “End of Document” are **immutable literals**.  
- Markdown gets `######`.  
- C gets `//`.  
- Eiffel gets `--`.

###### End of Document \<repo:integer_division_domain/coding_rules/02_identity_header_footer.md\>
