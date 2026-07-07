###### Start of Document \<repo:integer_division_domain/coding_rules/09_snake_case.md\>

# 09 — snake_case and Snake_Case Naming

## Purpose
Prax Junior is a hybrid language.  
We respect the parent D language’s existing type and feature names, while introducing a purified, angelic naming discipline for Prax Junior identifiers.

This creates a **fusion** of two worlds:

1. The existing D world (`int`, `string`, `double`, `ubyte[]`, etc.)  
2. The Prax Junior world (`employee_last_name`, `Employee_Record`, etc.)

We do **not** alias D’s built‑ins.  
We do **not** rename them.  
We do **not** wrap them.  
We simply introduce a clean, readable naming discipline for everything **we** create.

---

# 1. Two Naming Worlds

## A. The Existing D World (Unchanged)
Examples:
```
int
string
double
ubyte[]
File
Socket
Exception
```

These remain exactly as they are.  
We do **not** create aliases like:
```
Int
String
Double
```

This preserves:
- searchability  
- debuggability  
- interoperability  
- clarity  

## B. The Prax Junior World (Purified)
### Variables → snake_case
```
employee_last_name
total_count
domain_root
buffer_index
```

### Types → Snake_Case
```
Employee_Record
Domain_Error
Positive_Integer_Pairs
```

This creates a **visual boundary** between the two worlds without breaking compatibility.

---

# 2. Why Snake Case?

Snake case is **easier to read**, **faster to scan**, and **more cognitively aligned** with natural language.

Compare:

```
the_lazy_fox_jumped_over_the_quick_chicken
```

vs.

```
theLazyFoxJumpedOverTheQuickChicken
```

The first is:
- chunked  
- segmented  
- rhythmic  
- instantly scannable  

The second is:
- compressed  
- visually dense  
- harder to parse  
- cognitively heavier  

Snake case mirrors how humans actually read text.  
CamelCase does not.

---

# 3. The Publishing Industry Test — CamelCase Failed Everywhere

Not one publisher — not a single one — has ever published a book written in pure camelCase or PascalCase.

This includes:
- fiction  
- non‑fiction  
- textbooks  
- technical manuals  
- scientific papers  
- legal documents  
- children’s books  
- religious texts  
- poetry  
- journalism  

If camelCase or PascalCase were truly:
- clean  
- readable  
- superior  
- optimized  
- cognitively aligned  

then the publishing industry — which optimizes for readability above all else — would have adopted them.

They didn’t.  
They never even considered it.

---

# 4. The Technical Publishing Test — CamelCase Failed Here Too

Not one computer technical book has ever been written in full camelCase or PascalCase.

Not even one.

And now the knockout blow:

### O’Reilly — the most influential technical publisher in programming history — never used camelCase or PascalCase for prose.

O’Reilly:
- published thousands of programming books  
- covered every major language  
- shaped naming conventions  
- printed code samples containing camelCase and PascalCase  
- absolutely knew about these naming styles  

If camelCase or PascalCase were truly superior for human reading, O’Reilly would have published at least one book written entirely in them.

They didn’t.  
They never experimented with it.  
They never even flirted with the idea.

### Why?

Because camelCase and PascalCase are **not human writing systems**.  
They are **compression hacks** born from 1970s hardware scarcity.

Snake case is the closest legal identifier equivalent to how humans actually read text.

---

# 5. Historical Reasoning — Why CamelCase Exists at All

### PDP‑8 (1972)
- 8K of RAM  
- OS + program + working memory all inside that 8K  
- every byte mattered  

Long names were impossible luxuries.

Developers wrote:
```
emp_last_name   // 13 bytes
empLastName     // 11 bytes
eLstNm          // 6 bytes
```

CamelCase was a **compression strategy**, not a readability strategy.

### Modern Times
We have:
-  8 GB RAM  
- 16 GB RAM  
- 32 GB RAM  

Variable names are free.

We can let them **breathe**:
```
employee_last_name
```

Readable.  
Clear.  
Modern.

We are no longer paying $250 per vowel like Wheel of Fortune.

It is time to emancipate variable names.

---

# 6. CamelCase and PascalCase Belong in the Smithsonian

This will come as a shock to most who read this:

> **camelCase and PascalCase are relics of the early 1970s — artifacts of machines with 8K of RAM — and they belong in the Smithsonian Museum, not in your current source code file.**

They were invented because:
- memory was scarce  
- bytes were precious  
- long names were impossible  
- readability was sacrificed for survival  

CamelCase and PascalCase were never designed for human readability.  
They were designed for **hardware constraints** that disappeared half a century ago.

Snake case is readable.  
CamelCase is compressed.

Snake case is human.  
CamelCase is historical.

Snake case belongs in modern code.  
CamelCase belongs in a museum.

---

# 7. Meyer Saw This in 1985 — We See It Even More Clearly in 2026

Bertrand Meyer saw this truth **41 years ago** in *Object‑Oriented Software Construction* (1985):

> Readability is more important than brevity.  
> Names must be meaningful.  
> Compression destroys clarity.

He saw that camelCase and PascalCase were **compression artifacts**, not readability strategies.
He saw the **shape** of the problem.  
We now see the **full geometry** of it.

### Forty‑one years later, the argument is vastly stronger.

We have:
- 8 GB → 16 GB → 32 GB RAM  
- unlimited identifier length  
- modern IDEs  
- syntax highlighting  
- auto‑completion  
- static analysis  
- sealed‑domain reasoning  
- deterministic naming rules  

And yet…

### Just about every programmer is still compressing variable names like it’s 1972.

They are still writing:
```
empLastName
totalCount
bufferIndex
domainRoot
```

as if:
- vowels cost $250  
- RAM is measured in single digit kilobytes  
- identifiers must be compressed  
- readability is optional  
- PDP‑8 constraints still apply  

This is not “industry standard.”  
This is **historical inertia** — a habit carried forward from machines that belong in museums.

---

# 8. Why Prax Junior Chooses Snake Case

Because Prax Junior is a **clarity‑first language**.

Snake case:
- prevents drift  
- prevents ambiguity  
- improves readability  
- improves scanning  
- improves debugging  
- aligns with sealed‑domain reasoning  

CamelCase:
- is a historical artifact  
- is harder to read  
- is harder to scan  
- is harder to debug  
- is harder to maintain  

Prax Junior is not constrained by 1972 hardware.  
It is constrained by **clarity**.

---

# 9. Summary

- Prax Junior is a hybrid language.  
- D built‑ins remain untouched and unaliased.  
- Prax Junior variables use **snake_case**.  
- Prax Junior types use **Snake_Case**.  
- Snake case is more readable and cognitively aligned.  
- CamelCase is a compression hack from 1972 hardware scarcity.  
- No publisher has ever used camelCase or PascalCase for human text.  
- Not even O’Reilly used camelCase or PascalCase for prose.  
- CamelCase and PascalCase belong in the Smithsonian.  
- Meyer saw the truth in 1985; Prax Junior sees it even more clearly in 2026.  
- Snake case mirrors how humans actually read.  
- This naming discipline creates a clean fusion of the D world and the Prax Junior world.

###### End of Document \<repo:integer_division_domain/coding_rules/09_snake_case.md\>
