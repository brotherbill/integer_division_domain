###### Start of Document \<repo:integer_division_domain/coding_rules/10_explicit_increment.md\>

# 10 — Explicit Increment Rule

## Purpose
Prax Junior eliminates all increment operators and all compound‑assignment operators.  
They hide mutation, hide evaluation order, hide intent, and create drift vectors.  
Explicit mutation is clearer, safer, deterministic, and auditable.
Prax Junior optimizes for clarity, not typing speed, not syntactic compression, and not 1972 hardware constraints.

---

# 1. Thou Shalt Not Use

Forbidden operators:
- ++i  
- i++  
- j--  
- i += 1  
- i += n  
- j -= n  
- k *= n  
- lhs (op)= rhs  

These operators compress meaning, hide behavior, and introduce evaluation‑order traps.

---

# 2. Thou Shalt Use

Required explicit forms:
- `i = i + 1;`  
- `j = j - 1;`  
- `k = k * 2;`  
- `lhs = lhs (op) rhs;`

Explicit mutation preserves cognition and eliminates cleverness.

---

# 3. Why This Rule Exists

## A. Explicit Mutation Preserves Cognition
Increment operators hide behavior.  
They compress intent.  
They force the reader to mentally decompress the operation.

`i = i + 1;` is readable by:
- Junior Programmers  
- Managers  
- SMEs  
- Auditors  

No translation required.

---

## B. Increment Operators Confuse Junior Programmers
The difference between `foo = ++i;` and `foo = i++;` is not obvious.  
It is not intuitive.  
It is not beginner‑friendly.  
It is not manager‑friendly.  
It is not auditor‑friendly.

Prax Junior removes the entire category.

---

## C. Cleverness Is Forbidden

Forbidden cleverness:
```
foo     = ++i / (j-- + ++i);
garbage = ++i / (++j + ++i);
```

These expressions are unreadable, untestable, and unsafe.

---

## D. Evaluation Order Becomes a Trap

### Q1. Will `garbage` evaluate the same on every compiler, on every machine?

**A1. You don’t know.**  
And if you *think* you know, you’re guessing.

This violates sealed‑domain determinism.

---

### Q2. Which `++` executes first?

**A2. You don’t know.**  
And if you *think* you know, you’re guessing.

Increment operators force the reader into a mental model that depends on:
- the language spec  
- the compiler spec  
- the optimizer  
- the architecture  
- register pressure  
- inlining decisions  

Increment operators create behavior that depends on compilers, not programmers.
Evaluation order must be determined by the programmer, not the compiler.

If you have to stop and ask:

> **Which `++` executes first?**

the code has already failed.

And the doctrinal hammer:

> **What kind of slouch are you, writing code that requires a language lawyer to decode basic arithmetic?**

---

# 4. The Myth of Typing Speed and Syntactic Shortcuts

### Q1. Is typing speed the main constraint for creating quality software?

Absolutely not.

Typing speed has **never** been the bottleneck in software engineering.  
The bottleneck is:
- cognition  
- correctness  
- clarity  
- debugging  
- architecture  
- invariants  
- reasoning  
- maintenance  
- auditability  

Typing is the **least** expensive part of programming.
Syntactic shortcuts save milliseconds of typing and cost hours of debugging.

If typing speed mattered, the best programmers would be stenographers.

---

### Q2. Do syntactic shortcuts radically improve programmer productivity?

If syntactic shortcuts improved productivity, someone would have measured it.

We would have:
- 10% productivity studies  
- 50% productivity studies  
- 500% productivity studies  
- peer‑reviewed papers  
- industry benchmarks  
- academic consensus  
- corporate adoption  

But after **50 years**, no one has produced a single credible study showing that:
- `i++`  
- `i += 1`  
- `lhs (op)= rhs`  

improve productivity at all.

Not 10%.  
Not 5%.  
Not 1%.  
Not even 0.1%.

There is **zero evidence** that syntactic shortcuts improve productivity.  
There is **overwhelming evidence** that they reduce clarity.

---

### Q3. Should we be married to language restrictions and optimizations that mattered in 1972, in 2026?

In 1972:
- RAM was measured in kilobytes  
- CPUs were measured in kilohertz  
- compilers were primitive  
- languages were minimal  
- readability was sacrificed for survival  
- syntactic compression mattered  

In 2026:
- RAM is measured in gigabytes  
- CPUs are measured in gigahertz  
- compilers are industrial‑grade  
- languages are expressive  
- readability is mandatory  
- correctness is mandatory  
- determinism is mandatory  
- auditability is mandatory  
- Explicit mutation is teachable; increment operators are not.

We should not be optimizing for:
- typing speed  
- syntactic compression  
- cleverness  
- byte‑saving hacks  
- 1972 constraints  

We should be optimizing for:
- correctness  
- determinism  
- sealed‑domain reasoning  
- clarity  
- auditability  
- maintainability  
- eliminating UB  
- eliminating drift  
- eliminating cleverness  
- eliminating reconciliation departments  

### The real cost in 2026 is not typing.

The real cost is:

> **writing apps that don’t need a Reconciliation Department to deal with the Undefined Behavior (UB) generated by those apps.**

Increment operators and compound assignments **increase** UB.  
Explicit mutation **decreases** UB.

---

# 5. Compound Assignment Hides Mutation

Forbidden:
```
lhs += rhs;
lhs -= rhs;
lhs *= rhs;
lhs /= rhs;
lhs %= rhs;
```

Required:
```
lhs = lhs + rhs;
lhs = lhs - rhs;
lhs = lhs * rhs;
lhs = lhs / rhs;
lhs = lhs % rhs;
```

This makes mutation explicit, readable, deterministic, and auditable.
Compound assignment hides mutation; explicit assignment reveals it.

---

# 6. General Rule

### Forbidden:
```
lhs (op)= rhs;
```

### Required:
```
lhs = lhs (op) rhs;
```

This eliminates:
- hidden mutation  
- compressed semantics  
- cleverness  
- UB‑adjacent behavior  
- evaluation‑order traps  
- readability failures  
- audit failures  

And restores:
- clarity  
- determinism  
- sealed‑domain reasoning  
- junior‑friendly semantics  
- manager‑friendly semantics  
- auditor‑friendly semantics  

---

# 7. Summary

- Increment operators are forbidden.  
- Compound‑assignment operators are forbidden.  
- Explicit mutation is required.  
- `i = i + 1;` is the canonical form.  
- Cleverness is forbidden.  
- Evaluation‑order puzzles are forbidden.  
- Typing speed is irrelevant.  
- Syntactic shortcuts do not improve productivity.  
- 1972 constraints do not apply in 2026.  
- Sealed‑domain determinism is preserved.  
- Managers, SMEs, and auditors can read the code.  
- Prax Junior eliminates UB‑generating constructs.  
- Clarity is mandatory.

###### End of Document \<repo:integer_division_domain/coding_rules/10_explicit_increment.md\>
