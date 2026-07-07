###### Start of Document \<repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/02_nd_plus_d_diner.md\>

# 02 — The ND + D Diner (Non‑Deterministic + Deterministic Diner)

## Purpose
This document explains how a diner operates when **non‑deterministic preparation** is separated from **deterministic execution**.

This is the Prax Junior model.

The reader should think:
> “This is clean.  
> This is disciplined.  
> This is scalable.  
> This is how enterprise systems *should* run.”

---

# 1. The ND World — Preparation Only

The ND world handles **everything that is unpredictable**:

- utilities  
- equipment  
- staffing  
- supplies  
- ingredients  
- readiness  
- mise en place  

But the ND world **does not cook**.

It only prepares.

### ND Preparation Checklist
Before any cooking begins:

1. Grill is hot.  
2. Grill is clean.  
3. Oils/butter are ready.  
4. Power is on.  
5. Hash browns bag is ready.  
6. Sausage bag is ready.  
7. Plate is ready.  
8. Spatulas ready.

Only when **all prerequisites are satisfied** does the D world begin.

---

# 2. The D World — Deterministic Execution Only

Once everything is ready, the grill master enters the deterministic world.

### Deterministic Recipe
1. Drop hash browns.  
2. Drop sausage.  
3. Wait 60 seconds.  
4. Transfer to plate.  
5. Place plate on warming table.  
6. Ring the bell.  
7. **Clean the grill** (so it is ready for the next order).

This recipe is:
- simple  
- predictable  
- repeatable  
- sealed‑domain  
- deterministic  

If the recipe has a mistake, it will be the **same mistake every time** — predictable and fixable.

---

# 3. Why This Model Works

## A. ND Failures Do Not Corrupt the D World
If the ND world fails:
- diner cannot operate  
- customer waits  
- no food poisoning  
- no corrupted orders  
- no inconsistent outcomes  

This is like:
- database down  
- network down  
- service unavailable  

It is an outage, not a disaster.

---

## B. D Failures Are Predictable and Fixable
If the D world fails:
- the recipe is wrong  
- the mistake is consistent  
- the fix is obvious  
- the correction is permanent  

This is like:
- business rule bug  
- deterministic logic error  

It is fixable, not catastrophic.

---

# 4. Why ND + D Diner Scales to Enterprise Systems

Enterprise systems need:
- predictability  
- correctness  
- consistency  
- sealed‑domain reasoning  
- deterministic business rules  

The ND + D diner model provides exactly that.

ND world:
- handles chaos  
- handles infrastructure  
- handles preparation  
- handles readiness  

D world:
- handles business rules  
- handles value creation  
- handles deterministic logic  
- handles correctness  

This is Prax Junior.

###### End of Document \<repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/02_nd_plus_d_diner.md\>
