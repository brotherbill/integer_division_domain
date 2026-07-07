###### Start of Document \<repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/04_business_rules_are_d.md\>

# 04 — Business Rules Are Deterministic  
## Why All Business Logic Must Live in the D World

## Purpose
This document explains **why business rules must be deterministic**, why they must live entirely in the **D world**, and why mixing ND and D logic is the root cause of catastrophic enterprise failures.

This is the chapter that makes the reader say:

> “Oh.  
> Business rules *must* be deterministic.  
> There is no alternative.”

---

# 1. What Business Rules Actually Are

Business rules are:
- the value of the system  
- the meaning of the system  
- the correctness of the system  
- the promises made to customers  
- the guarantees made to regulators  
- the logic that must never be wrong  

Business rules determine:
- how money moves  
- how inventory moves  
- how accounts update  
- how orders process  
- how claims adjudicate  
- how payments settle  
- how balances reconcile  

Business rules are the **heart** of the enterprise.

They must be:
- correct  
- consistent  
- predictable  
- repeatable  
- auditable  
- sealed‑domain  
- deterministic  

Anything less is unacceptable.

---

# 2. Why Business Rules Cannot Live in the ND World

The ND world is:
- unpredictable  
- unstable  
- chaotic  
- nondeterministic  
- failure‑prone  
- infrastructure‑dependent  

The ND world includes:
- networks  
- databases  
- file systems  
- clocks  
- concurrency  
- parallelism  
- outages  
- broken equipment  
- missing supplies  
- staff not showing up  

This world is **not safe** for business rules.

### ND World Failure Consequences
If business rules run in the ND world:
- money disappears  
- orders duplicate  
- inventory corrupts  
- payments misapply  
- accounts drift  
- reconciliation teams activate  
- customers feel pain  
- regulators investigate  
- auditors panic  

This is catastrophic.

This is why enterprise systems fail.

---

# 3. The D World Is the Only Safe Place for Business Rules

The D world is:
- deterministic  
- sealed‑domain  
- predictable  
- disciplined  
- controlled  
- stable  

The D world:
- does not start until everything is ready  
- does not depend on external state  
- does not depend on infrastructure  
- does not depend on time  
- does not depend on concurrency  
- does not depend on the world  

The D world runs the same way every time.

### D World Failure Consequences
If business rules run in the D world:
- mistakes are consistent  
- mistakes are reproducible  
- mistakes are fixable  
- mistakes are obvious  
- mistakes are permanent fixes  

This is safe.

This is correct.

This is Prax Junior.

---

# 4. The Diner Analogy: Business Rules Are the Recipe

In the diner analogy:

- ND world = preparation  
- D world = cooking  
- business rules = the recipe  

The recipe is deterministic:
1. drop hash browns  
2. drop sausage  
3. wait 60 seconds  
4. transfer to plate  
5. place on warming table  
6. ring bell  
7. **clean grill**  

This recipe is the same every time.

If the recipe is wrong:
- the mistake is consistent  
- the mistake is reproducible  
- the mistake is fixable  

This is exactly how business rules must behave.

---

# 5. Why Mixing ND and D Logic Corrupts Business Rules

When ND logic and D logic are mixed:
- business rules depend on infrastructure  
- business rules depend on timing  
- business rules depend on concurrency  
- business rules depend on availability  
- business rules depend on external state  

This guarantees:
- partial writes  
- partial reads  
- inconsistent state  
- corrupted balances  
- duplicated orders  
- lost money  
- reconciliation departments  
- customer pain  

This is the ND diner.  
This is the ND enterprise.  
This is failure.

---

# 6. The Four Attributes Protect Business Rules

Prax Junior uses the four attributes to enforce D‑world discipline:

### `@safe`  
Eliminates memory shenanigans.  
Business rules cannot corrupt memory.

### `pure`  
Eliminates external dependencies.  
Business rules cannot depend on the world.

### `nothrow`  
Eliminates exceptions.  
Business rules cannot drift.

### `@nogc`  
Eliminates GC pauses.  
Business rules cannot stall.

Together, these attributes guarantee that business rules run:
- cleanly  
- deterministically  
- predictably  
- safely  
- repeatably  

Every single time.

---

# 7. Business Rules Must Be Deterministic

This is the unavoidable conclusion:

> **Business rules must be deterministic.  
> They must live in the D world.  
> They must be protected from the ND world.**

If business rules are deterministic:
- correctness is guaranteed  
- consistency is guaranteed  
- auditing is trivial  
- testing is trivial  
- reasoning is trivial  
- reconciliation disappears  
- customer pain disappears  

This is Prax Junior.

---

# 8. Summary

- Business rules are the heart of the enterprise.  
- They must be correct every time.  
- They cannot live in the ND world.  
- They must live in the D world.  
- ND world failures cause outages, not corruption.  
- D world failures are consistent and fixable.  
- Mixing ND and D logic guarantees catastrophic failure.  
- The four attributes protect business rules.  
- Deterministic business rules eliminate 90% of enterprise defects.  
- This is Prax Junior.

###### End of Document \<repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/04_business_rules_are_d.md\>
