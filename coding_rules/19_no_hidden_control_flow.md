###### Start of Document <repo:integer_division_domain/coding_rules/19_no_hidden_control_flow.md>

# 19 — No Hidden Control Flow  
## Single Exit, Canonical Result, Structured Loops Only

## 1. Rule

Prax Junior forbids **hidden control flow**.

Any construct that:

- jumps unexpectedly  
- exits early  
- skips silently  
- unwinds invisibly  

is **illegal**.

Control flow must be:

- single‑exit  
- explicit  
- structured  
- deterministic  
- audit‑friendly  

---

## 2. Commands vs Queries

### 2.1. Commands (Procedures)

Commands:

- have **no return value**  
- end **naturally** when control reaches the last line  
- **must not** use last line `return;` (naked return is noise and forbidden)  
- **must not** use early `return;`  
- **must not** use `break`  
- **must not** use `continue`  
- **must not** use `goto`

Commands model actions.  
They must have **structured, linear control flow**.

### 2.2. Queries (Functions)

Queries:

- **must return a value**  
- **must** use a canonical return variable named `result`  
- **must** return exactly once  
- **must** return on the **last line**  
- **must not** use early `return result;`  
- **must not** use `break`  
- **must not** use `continue`  
- **must not** use `goto`

`result` is a **reserved semantic identifier**:

- it has **one meaning only** — the canonical return value  
- it may **not** be used for any other purpose  
- no parameter, local, alias, import, or field may be named `result` inside a query

---

## 3. Forbidden Control Flow Constructs

### 3.1. Early Return

```d
Status result;

if (x < 0)
{
    return Invalid;   // forbidden
}

result = Valid;
return result;        // last line
```

Early returns are forbidden.  
Queries must return exactly once, on the last line.

### 3.2. `break` and `continue`

```d
for (int i = 0; i < 10; ++i)
{
    if (done)
    {
        break;        // forbidden
    }

    if (!ready)
    {
        continue;     // forbidden
    }
}
```

`break` and `continue` introduce hidden jumps and are forbidden.

### 3.3. `goto`

```d
goto cleanup;   // forbidden
```

`goto` is forbidden.  
All control flow must be structured.

---

## 4. Loop Variants and Structured Iteration

### 4.1. Run-forever-intentionally loops do not have variants.

These loops are written and maintained by your strongest developers and architects.
This is not where Junior Programmers get to play.
These loops get the strongest code review possible.

### 4.2. Variants Required for `for`, `while`, `do‑while` loops that must terminate

All finite number of iteration loops of the form:

- `for`  
- `while`  
- `do‑while`  

**must have an explicit variant** — a monotonically decreasing integer that must not become negative proves termination.

Even trivial loops require variants.  
There are **no exceptions**.

```d
int i            =  3;
int variant      = 10;  // Some fudge margin is allowable.  
                        // This isn't a math theorem.  
                        // But if you get it wrong, the app ABENDS unnecessarily.
int last_variant = variant;

while (i > 0)
{
    // loop body 
    writeln(i);

    // prepare for next loop iteration
    i = i - 1;

    // update and enforce variant
    variant = variant - 1;                          // developer writes this.  must decrease by at least 1.
    assert(0 <= variant && variant < last_variant); // boilerplate
    last_variant = variant;                         // boilerplate
}
```

### 4.3. `foreach` Gets a Pass

`foreach` is structurally safe:

- iterates over a finite container  
- has an implicit variant: **remaining elements**  
- cannot accidentally become non‑terminating  
- Prax Junior forbids mutating the container during iteration

Therefore:

- `foreach` **does not require** an explicit variant  
- `foreach` is allowed without additional termination proof

```d
foreach (name; names)
{
    // allowed without explicit variant
}
```

### 4.4. Developer Experience With Variants

No developer enjoys writing loop variants.  
Variants require mathematical reasoning and a deep understanding of loop state and container geometry.

However:

- variants prevent infinite loops  
- variants prevent retry storms  
- variants prevent stalled state machines  
- variants enforce progress  
- variants enforce termination  
- variants enforce correctness  

Therefore:

> **If a developer cannot write the variant for a complex container or algorithm,  
> they must choose a simpler container and a simpler algorithm  
> that they *do* understand well enough to write the variant.**

Variants are mandatory because correctness is mandatory.

---

### 4.5. The Real Costs of Non‑Terminating Loops

Real systems do not fail because of “ivory‑tower academic concerns.”  
Real systems fail because a loop that **should** terminate **does not**.

Non‑terminating loops are one of the **top causes of severe production failures** across the software industry.  
They cause:

- **hung microservices**  
- **hung schedulers**  
- **hung batch jobs**  
- **hung pipelines**  
- **hung UI threads**  
- **hung embedded controllers**  
- **runaway CPU burn**  
- **retry storms**  
- **deadlocks**  
- **resource starvation**  
- **full‑system outages**

These failures are not theoretical.  
They are not academic.  
They are not rare.  
They are not “movie bugs.”

They are **common**, **expensive**, and **catastrophic**.

#### 4.5.1. Industry Failure Rates

Across industry systems:

- **85–95%** of hung loops occur in loops that **should** terminate  
- **5–15%** occur in “run‑forever intentionally” loops written incorrectly

The overwhelming majority of failures come from loops that developers *believed* would end — but didn’t.

Variant discipline eliminates this entire category.

#### 4.5.2. Why Developers Miss These Bugs

Developers do not write infinite loops intentionally.  
They write loops that *accidentally* fail to terminate because:

- a counter never updates  
- a condition never flips  
- a queue never drains  
- a retry never succeeds  
- a flag never changes  
- a lock never releases  
- a message never arrives  
- a state machine never transitions

These bugs are **easy to write** and **hard to detect**.

Variant checking makes them **impossible to hide**.

#### 4.5.3. Why Variant Checking Is Mandatory

Variant checking:

- enforces **progress**  
- enforces **termination**  
- enforces **correctness**  
- prevents **runaway CPU**  
- prevents **hung systems**  
- prevents **retry storms**  
- prevents **deadlocks caused by loops**  
- prevents **silent infinite loops**

Variant checking is not ceremony.  
Variant checking is **industrial safety equipment**.

#### 4.5.4. Management Impact

When variant checking is mandatory, management notices:

- fewer outages  
- fewer escalations  
- fewer pager storms  
- fewer “system stuck” incidents  
- fewer “job never finished” failures  
- lower cloud bills  
- higher reliability  
- higher developer velocity

Variant checking produces **visible business outcomes**, even though the mechanism is invisible to management.

#### 4.5.5. Developer Complaints

Developers may complain:

- “It’s boilerplate.”  
- “It’s ceremony.”  
- “It’s academic.”  
- “It’s a waste of time.”

These are **feelings**, not engineering arguments.

The cost of writing:

```
variant--;
assert(0 <= variant && variant <= last_variant);
last_variant = variant;
```

is measured in **seconds**.

The cost of debugging a hung system is measured in:

- hours  
- nights  
- weekends  
- postmortems  
- money  
- reputation

Variant checking is mandatory because correctness is mandatory.

---

## 5. Branching Structure — Flat Only

### 5.1. Flat If‑Else Chains

Allowed:

```d
if (x < 0)
{
    // ...
}
else if (x == 0)
{
    // ...
}
else if (x < 10)
{
    // ...
}
else
{
    // ...
}
```

### 5.2. Nested Branching Forbidden

Forbidden:

```d
if (x < 0)
{
    if (y > 0)
    {
        // nested branch — forbidden
    }
}
```

Branching must be **one level deep only**:

- no nested `if` inside `if`  
- no nested `if` inside `else`  
- no branching trees

Complex decisions must be expressed as:

- flat if‑else chains  
- tables  
- explicit domain logic

---

## 6. Doctrine Summary

- **No hidden control flow.**  
- **Commands**: no return, no early return, no break/continue/goto.  
- **Queries**: canonical `result`, single return, last‑line return, no early return, no break/continue/goto.  
- **`result`**: reserved semantic identifier; one meaning only; no collisions.  
- **Loops**: variants required for `for`, `while`, `do‑while`; `foreach` gets a pass (implicit variant).  
- **Branching**: flat if‑elseif‑elseif‑else only; no nested branching.  
- **Variants**: if you cannot write the variant, you do not understand the algorithm; choose a simpler one.  
- **All control flow must be explicit, structured, deterministic, and audit‑friendly.**

Hidden exits, hidden jumps, and hidden control flow are forbidden.  
Prax Junior code must be **readable, certifiable, and drift‑free**.

---

###### End of Document <repo:integer_division_domain/coding_rules/19_no_hidden_control_flow.md>
