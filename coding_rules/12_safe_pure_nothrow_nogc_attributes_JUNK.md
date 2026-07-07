###### Start of Document \<repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes.md\>

# 12 — @safe pure nothrow @nogc Attributes Rule

## Purpose
Prax Junior encourages the use of `@safe`, `pure`, `nothrow`, and `@nogc`.  
These attributes are optional and independent, but when present they provide **powerful guarantees** that make functions extremely easy to reason about.

Functions with all four attributes are as well‑behaved as wealthy parents’ young children in a fancy restaurant.  
These children know:

1. don’t fidget  
2. don’t have temper tantrums  
3. don’t kick anyone under the table  
4. don’t run to the restroom every two minutes  
5. use indoor voice  
6. say please and thank you  
7. respect other diners  
8. use the proper silverware in the right sequence  
9. let the parent order unless given permission  

These attributes are the exact behavioral equivalent.

---

# 1. Attribute Line Placement

The four attributes SHALL appear:

- **in the same order**  
- **on exactly one line**  
- **immediately above the function signature**

Example:
```
@safe pure nothrow @nogc
int meaning (in int x)
{
    return x + 1;
}
```

This placement preserves locality, eliminates drift, and makes the behavioral contract visible at a glance.

---

# 2. Attribute Ordering Rule

If present, the order SHALL be:

> **@safe pure nothrow @nogc**

This ordering is deterministic, predictable, and cognitively natural.

---

# 3. What Each Attribute Guarantees

## A. @safe — No Memory Shenanigans

**Guarantee:**  
The function cannot perform memory‑unsafe operations.  
Memory shenanigans are the **number one cause of Undefined Behavior (UB)** in all systems.  
`@safe` eliminates memory shenanigans entirely.

C was written by expert programmers for expert programmers, at a time when an **8K machine was a beast**.  
D inherited that C baggage — the assumption that:

> “We can trust the developer. The developer knows what they are doing.”

With **millions of lines of code**, that attitude might have been justifiable decades ago, when squeezing out every byte and cycle was necessary.  
But with modern hardware, that justification is gone — yet we still run **legacy code** written under those constraints.

We simply **cannot trust legacy code** written when performance was life‑or‑death and memory shenanigans were considered “clever.”

Then came **lint**, which said:

> “No, we cannot trust the developer.”

But lint:
- was optional  
- was not universal  
- did not catch every shenanigan  

`@safe` **does**.  
It captures **every** possible memory shenanigan.

D is mature.  
You are welcome to try to creatively sneak a memory shenanigan past the `@safe` nanny.  
If you succeed, create a PR — the language will fix it.

`@safe` says:

> **Don’t trust the developer with memory shenanigans.**

`@safe` forces the developer to write **clean D code** without memory shenanigans.

`@safe` code can be useless, but it **cannot** contain memory shenanigans.

Memory shenanigans include:
- raw pointer dereferencing  
- pointer arithmetic  
- casting pointers to unrelated types  
- slicing memory incorrectly  
- buffer overruns  
- underflows  
- aliasing violations  
- dangling pointers  
- misaligned loads  
- manual memory tricks  
- “trust me, bro” unsafe casts  

`@safe` forbids all of these.

Equivalent restaurant behavior:  
> The child does not fidget, spill soup, or stab anyone with a fork.

### Historical Context: Why @safe Matters

Early IT systems — including **traffic policing systems** — were written in **ASSEMBLER**.  
A police officer would radio dispatch, provide license and tag info, and the dispatcher would type it into an IBM/360 system (likely via CICS).  
Within **5 seconds**, the officer knew whether the driver was:
- law‑abiding  
- suspended  
- fraudulent  
- or driving a stolen vehicle  

It was primitive, but it **worked**.

Then came the “Next Generation” pitch:

> “ASSEMBLER is old. Our whiz‑bang system uses a higher‑level language.  
> One programmer can do the work of ten. Fire your assembly developers.”

The new system worked in QA.  
But under real traffic volume, it **buckled**:
- 5 seconds became 30  
- then 1 minute  
- then 5 minutes  
- then no response  

After a week, they rolled back to the old ASSEMBLER system — because it was **deterministic**, **predictable**, and **free of memory shenanigans**.

`@safe` brings that same reliability to modern D code.

### Example (allowed):
```
@safe
int add (int a, int b)
{
    return a + b;
}
```

### Counterexample (forbidden in @safe):
```
@safe
int bad (int* p)
{
    return *p;   // raw pointer dereference is not @safe
}
```

---

## B. pure — No Side Effects, No External Dependencies

**Guarantee:**  
The function depends only on its inputs and does not mutate or consult anything outside its parameters.

Equivalent restaurant behavior:  
> The child does not kick anyone under the table or interfere with other diners.

A pure function in Prax Junior:

1. **No checking the time.**  
   No system clock.  
   No timestamps.  
   No timers.  
   No “what time is it?”

2. **No accessing the internet, database, or file system — not even for reading.**  
   No HTTP.  
   No SQL.  
   No disk.  
   No environment variables.  
   No configuration files.  
   No “just reading one tiny file.”

3. **If it wasn’t spoon‑fed to you in the parameters line, it’s none of your business.**  
   No globals.  
   No hidden state.  
   No module‑level variables.  
   No static mutable fields.  
   No peeking at anything not explicitly passed in.

A pure function is a sealed‑domain function:  
It sees only what you hand it.  
It touches only what you allow.  
It returns only what it computes.

### Example (allowed):
```
pure
int square (int x)
{
    return x * x;
}
```

### Counterexample (forbidden in pure):
```
pure
int bad ()
{
    auto now = Clock.currTime;   // checking the time is forbidden
    globalCounter++;             // mutating global state is forbidden
    auto data = read("file");    // reading a file is forbidden
    return now + globalCounter + data.length;
}
```

---

## C. nothrow — No Exceptions  
**Guarantee:**  
The function will never throw an exception, **directly or indirectly**.

Equivalent restaurant behavior:  
> The child does not have temper tantrums.

### Example (allowed):
```
nothrow
int safeDivide (int a, int b)
{
    return b == 0 ? 0 : a / b;
}
```

### Counterexample (forbidden in nothrow):
```
nothrow
int bad (int a, int b)
{
    return a / b;   // may throw divide-by-zero
}
```

---

## D. @nogc — No Garbage Collector Use  
**Guarantee:**  
The function performs no GC allocations.

Equivalent restaurant behavior:  
> The child does not run to the restroom every two minutes.

### Example (allowed):
```
@nogc
int sum (int[] arr)
{
    int total = 0;
    foreach (x; arr)
        total += x;
    return total;
}
```

### Counterexample (forbidden in @nogc):
```
@nogc
int bad ()
{
    auto s = "hello".dup;   // allocation triggers GC
    return s.length;
}
```

---

# 4. Why These Guarantees Are Valuable

## A. They eliminate entire categories of bugs  
- memory corruption  
- global state mutation  
- exception‑based drift  
- GC pauses  
- nondeterministic behavior  

## B. They make reasoning trivial  
A function with all four attributes behaves like a mathematical function.

## C. They make testing trivial  
No side effects.  
No exceptions.  
No GC.  
No unsafe memory.

## D. They make auditing trivial  
Auditors can read the attribute line and know the behavioral contract instantly.

## E. They make junior programmers safe  
Junior programmers cannot accidentally introduce footguns.

---

# 5. Why They Are Always in the Same Order

The order:

> **@safe pure nothrow @nogc**

matches the cognitive order of guarantees:

1. **Safety** — no memory footguns  
2. **Purity** — no side effects  
3. **No throwing** — no tantrums  
4. **No GC** — no hidden allocations  

This ordering is deterministic, predictable, and sealed‑domain aligned.

---

# 6. Why They Appear on One Line Above the Signature

### A. They form a single behavioral contract  
Splitting them across lines introduces drift.

### B. They must be visible at a glance  
Auditors, managers, and junior programmers must see the guarantees immediately.

### C. They must not pollute the signature line  
The signature line should contain only:

- attributes from Rule 11 (`private static`)  
- return type  
- function name  
- parameters

### D. They must not float  
Floating attributes get separated, reordered, or lost.

One line.  
One place.  
One contract.

---

# 7. Summary

- `@safe`, `pure`, `nothrow`, and `@nogc` are optional but extremely valuable.  
- They provide strong behavioral guarantees.  
- They eliminate entire categories of bugs.  
- They make reasoning trivial.  
- They make auditing trivial.  
- They protect junior programmers.  
- They appear in the order **@safe pure nothrow @nogc**.  
- They appear on **one line** above the function signature.  
- They make functions behave like well‑trained children in a fancy restaurant.  
- This is Prax Junior.

###### End of Document \<repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes.md\>
