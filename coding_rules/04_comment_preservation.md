###### Start of Document \<repo:integer_division_domain/coding_rules/04_comment_preservation.md\>

# 04 — Comment Preservation

## Purpose
Comments are part of the file’s identity.  
They carry meaning, intent, pedagogy, and provenance.  
They must be preserved exactly unless the user explicitly instructs otherwise.

---

# 1. Preservation Rule
Comments must be preserved **verbatim** during:

- refactoring  
- formatting  
- mechanical conversion  
- style normalization  
- module reorganization  
- import rewriting  
- naming geometry rewriting  

Comments are not optional.  
Comments are not decorative.  
Comments are not expendable.

They are part of the sealed‑domain identity of the file.

---

# 2. No Alteration Without Explicit Instruction
Comments must **not** be:

- rewritten  
- rephrased  
- shortened  
- expanded  
- removed  
- relocated  
- normalized  
- “cleaned up”  
- “improved”  

unless the user gives **explicit** instruction to do so.

Silence means **preserve**.

---

# 3. Comment Geometry Must Be Preserved
The following must remain unchanged:

- spacing  
- indentation  
- blank lines  
- alignment  
- comment markers (`//`, `/* */`, `--`, `#`, etc.)  
- placement relative to code  
- placement relative to other comments  

Comment geometry is part of the file’s identity.

---

# 4. Comments in Non‑Comment Languages
For languages that **do not support comments** (JSON, CSV, TSV, etc.):

- comments must **not** be added  
- comments must **not** be synthesized  
- comments must **not** be emulated  
- header/footer markers must be omitted  

This rule is absolute.

---

# 5. Comments as Pedagogical Anchors
Comments often serve as:

- invariant markers  
- teaching anchors  
- domain explanations  
- safety‑critical notes  
- identity envelopes  
- module‑boundary markers  

These must be preserved exactly.

Removing or altering them breaks:

- pedagogy  
- meaning  
- provenance  
- sealed‑domain reasoning  

---

# 6. Comments in Unit Tests
Unit test comments must be preserved because they:

- describe the intent of the test  
- prevent drift  
- help experts and newcomers  
- maintain clarity  
- maintain correctness  

These comments are part of the test’s identity.

---

# 7. Comments in VM and Domain Code
VM commentary blocks and domain commentary blocks are part of the file’s identity and pedagogy.

They must be preserved **exactly**, including:

- spacing  
- alignment  
- markers  
- blank lines  
- ordering  

These blocks are not optional.

---

# 8. Commentary Value Doctrine

## 8.1 Commentary Is Not a Substitute for Poor Naming
Commentary must never compensate for poorly named functions, variables, parameters, modules, or types.
If a name is unclear, the name must be corrected. Commentary cannot repair naming drift.

## 8.2 Commentary Must Add Value
Commentary must add meaning beyond what self-documenting names already provide.
It must explain intent, invariants, domain reasoning, architectural constraints, or safety-critical notes.
Commentary that merely restates the code does not deserve to exist.

If a comment does not add value, it must be removed.

## 8.3 Pedagogical Exception for Redundant Commentary
Redundant commentary is allowed when it serves an intentional pedagogical purpose.
Examples include emphasizing correct naming practices, reinforcing sealed-domain reasoning, or teaching newcomers how to read the code.

Pedagogical commentary is preserved even when naming is already perfect.


---

# 9. Summary

- Comments are part of file identity.  
- Comments must be preserved verbatim.  
- No changes unless explicitly instructed.  
- Comment geometry must be preserved.  
- No comments in comment‑less languages.  
- Unit test comments are mandatory.  
- VM and domain commentary blocks are mandatory.  
- Commentary must add value.  
- Commentary is not a substitute for poor naming.  
- Pedagogical commentary is allowed.  
- Silence means preserve.

###### End of Document \<repo:integer_division_domain/coding_rules/04_comment_preservation.md\>
