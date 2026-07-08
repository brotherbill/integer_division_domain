###### Start of Document <repo:integer_division_domain/coding_rules/15_use_named_structs_to_return_multiple_values.md>

# 15 — Use Named Structs to Return Multiple Values  
## Never Use `out`, `ref`, or Tuples

## 1. Rule
When a function must return multiple pieces of information, it must return a **named struct** with **named fields**.

Prax Junior forbids:

- `out` parameters  
- `ref` parameters  
- positional tuples  
- anonymous tuples  
- returning multiple values through mutation  
- returning multiple values through side effects  

All multi‑value returns must use **explicit, named structs**.

---

## 2. Why `out` and `ref` Are Forbidden

### 2.1. They Leak Mutation Visibility
`out` and `ref` expose internal mutation to the caller.  
This violates sealed‑domain determinism.

### 2.2. They Create Hidden Dataflow
The caller must reason about:

- which parameters mutate  
- when they mutate  
- how they mutate  
- whether mutation is visible  
- whether mutation is allowed  

Hidden dataflow is nondeterministic from the developer’s perspective.

### 2.3. They Break Purity
Prax Junior requires:

- `pure`  
- `nothrow`  
- `@safe`  
- `@nogc`  

`out` and `ref` violate purity by introducing external mutation channels.

### 2.4. They Are Error‑Prone
`out` and `ref` commonly cause:

- partial initialization  
- accidental mutation  
- aliasing bugs  
- incorrect legality decisions  
- nondeterministic behavior  

Named structs eliminate these hazards.

---

## 3. Why Tuples Are Forbidden

### 3.1. Tuples Are Positional, Not Named
Positional fields cause drift:

- `result[0]`  
- `result[1]`  
- `result[2]`

If the tuple changes shape, all callers break silently.

Named fields do not drift.

### 3.2. Tuples Hide Meaning
A tuple does not communicate:

- domain intent  
- field meaning  
- invariants  
- correctness geometry  

A named struct does.

### 3.3. Tuples Are Not Self‑Describing
Prax Junior requires:

> **Self‑describing return types.**

Tuples are not self‑describing.  
Named structs are.

### 3.4. Tuples Encourage Positional Reasoning
Positional reasoning is fragile and nondeterministic.  
Named fields are explicit and deterministic.

---

## 4. The Correct Pattern: Named Structs

### 4.1. Define a Local Struct Inside the Function
The struct is local to the function and invisible outside.

```d
struct Parts
{
    int numerator;
    int denominator;
}
```

### 4.2. Return an Instance of the Struct
```d
return Parts(numerator: n, denominator: d);
```

### 4.3. The Caller Uses Named Fields
```d
auto parts = divide(10, 3);
int n = parts.numerator;
int d = parts.denominator;
```

This is:

- explicit  
- deterministic  
- sealed  
- drift‑proof  
- domain‑clear  

---

## 5. Why Named Structs Are Required

### 5.1. They Are Self‑Describing
Fields have names.  
Names communicate meaning.

### 5.2. They Are Drift‑Proof
If the struct changes shape:

- callers break loudly  
- not silently  
- not nondeterministically  

This is correctness.

### 5.3. They Are Domain‑Aligned
A struct is a domain:

- `Fraction`  
- `Integer_Pairs`  
- `GetoptResult`  
- `Parts`  
- `Tokenization`  

Domains carry invariants.  
Tuples do not.

### 5.4. They Preserve Purity
Returning a struct is pure.  
Mutating an `out` parameter is not.

### 5.5. They Preserve Determinism
Named structs eliminate:

- aliasing  
- hidden mutation  
- positional drift  
- nondeterministic reasoning  

---

## 6. Doctrine Summary

- Returning multiple values must use **named structs**.  
- `out` is forbidden.  
- `ref` is forbidden.  
- tuples are forbidden.  
- positional fields are forbidden.  
- mutation‑based returns are forbidden.  
- named fields are required.  
- self‑describing domains are required.  
- sealed‑domain determinism is required.

**Named structs are the only correct way  
to return multiple values in Prax Junior.**

---

## 7. Developer Experience (DX)  
### Initial Pain, Long‑Term Gain

Prax Junior enforces named structs and named fields because correctness, clarity, and determinism outweigh convenience.

### 7.1. Developers Will Resist at First
New developers often react negatively:

- “This is too verbose.”  
- “Why can’t I just return a tuple?”  
- “Why do I have to name every field?”  
- “This feels like Eiffel or Ada.”  
- “Positional arguments are faster to write.”  

This reaction is normal.  
It comes from habit, not correctness.

### 7.2. Developers Will Appreciate It Later
Once developers begin **maintaining** Prax Junior code, the reaction flips:

- “This is so much clearer.”  
- “I always know what each field means.”  
- “Refactoring is safe — nothing breaks silently.”  
- “Named fields prevent bugs.”  
- “I never want to go back to positional returns.”  

Named structs eliminate:

- positional drift  
- silent breakage  
- ambiguous meaning  
- hidden mutation  
- fragile reasoning  

### 7.3. The Emotional Arc Is Predictable
1. **Day 1:** “This is strict.”  
2. **Day 10:** “This is consistent.”  
3. **Day 100:** “This is the only sane way to write correctness‑grade code.”

### 7.4. Prax Junior Optimizes for Maintenance, Not Convenience
Prax Junior is a **correctness language**, not a convenience language.

It prioritizes:

- clarity  
- determinism  
- sealed‑domain reasoning  
- auditability  
- long‑term maintainability  

Short‑term developer comfort is not a design goal.

Named structs feel strict at first.  
They feel *correct* forever.

### 7.5. Explicit Struct Names Eliminate Auto‑Complete Gone Mad
Modern IDEs often try to “help” by flooding the screen with:

- giant auto‑complete menus  
- intrusive hint panels  
- inferred suggestions  
- overload lists  
- type guesses  

When constructing structs positionally, IDEs cannot know your intent.  
So they explode with noise.

It feels like:

> **Using a machete to cut your way through a jungle of auto‑complete suggestions.**

Named struct construction shuts all of that down.

When you write:

```d
Parts(numerator: n, denominator: d);
```

the IDE knows:

- exactly which field you are typing  
- exactly what type belongs there  
- exactly what completion is relevant  

This eliminates:

- suggestion storms  
- hint spam  
- inference noise  
- auto‑complete chaos  

Explicit names turn the jungle into a clear path.

---

###### End of Document <repo:integer_division_domain/coding_rules/15_use_named_structs_to_return_multiple_values.md>
