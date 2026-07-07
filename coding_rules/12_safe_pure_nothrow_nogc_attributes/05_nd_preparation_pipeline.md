###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_nd_preparation_pipeline.md>

# 05 — ND Preparation Pipeline  
## The ND World’s Responsibilities, Boundaries, and Baton Geometry

## Purpose
This page defines the **Non‑Deterministic (ND) Preparation Pipeline** — the part of a Prax Junior system that interacts with the real world, stabilizes it, and prepares deterministic inputs for the D world.

This page is **pure ND doctrine**.  
It contains **no D legality**, **no business rules**, and **no scenario outcomes**.  
ND and D remain fully disjoint.

Pipeline examples live in:

```
05_deterministic_legality_cases/
```

---

# 1. What the ND World Is

The ND world is everything that is **not deterministic**:

- networks  
- databases  
- file systems  
- clocks  
- concurrency  
- outages  
- missing data  
- stale configuration  
- external dependencies  

ND is the world of **reality**, not **legality**.  
ND is the world of **effects**, not **rules**.  
ND is the world of **change**, not **invariants**.  
ND is the world of **uncertainty**, not **sealed domains**.

---

# 2. What the ND World Must Never Do

ND is **prohibited** from:

- running business rules  
- deciding legality  
- deciding ownership  
- deciding limits  
- deciding fraud  
- deciding account status  
- deciding whether a transfer is allowed  
- mutating sealed‑domain state  
- performing deterministic logic  

In NYC waiter terms:

> **“Not my table.”**

ND does not touch D’s table.  
ND does not cross‑serve.  
ND does not classify legality.

ND prepares.  
D decides.

---

# 3. ND’s Responsibilities

ND has exactly five responsibilities:

### **1. Ingress**  
Capture the request from the outside world.

### **2. Acquisition**  
Gather all external dependencies needed for deterministic execution.

### **3. Reality Validation**  
Ensure the snapshot is structurally coherent.

### **4. Normalization**  
Shape raw ND data into sealed‑domain inputs.

### **5. Readiness Gate**  
Ensure the D world has everything it needs to run deterministically.

ND does **not** decide legality.  
ND does **not** execute business rules.  
ND does **not** mutate sealed‑domain state.

ND prepares.  
D decides.  
ND executes.  
D never touches the world.

---

# 4. ND Pipeline Stages

## Stage 1 — Ingress (ND)
ND receives the request.  
ND does not interpret it.  
ND does not validate legality.  
ND only captures.

## Stage 2 — Acquisition (ND)
ND gathers:

- customer record  
- accounts  
- balances  
- limits  
- flags  
- configuration  
- reference data  

ND interacts with the real world.  
ND handles outages, retries, missing data, and nondeterminism.

## Stage 3 — Reality Validation (ND)
ND ensures:

- all required records exist  
- no contradictory raw data  
- snapshot is coherent  

ND does **not** validate legality.  
ND does **not** validate ownership.  
ND does **not** validate business rules.

## Stage 4 — Normalization (ND)
ND converts raw data into sealed‑domain inputs:

- dollars → cents  
- IDs → internal IDs  
- irrelevant fields removed  
- structural invariants enforced  

Normalization is **pure ND shaping**.  
No business rules.  
No legality.  
No sealed‑domain decisions.

## Stage 5 — Readiness Gate (ND)
ND asks:

> **“Do we have everything the D world needs to run deterministically?”**

If **no** → ND rejects.  
If **yes** → ND hands the baton to D.

This is the ND → D baton pass.

---

# 5. Baton Geometry

The ND baton passes are:

1. **ND ingress → ND acquisition**  
2. **ND acquisition → ND reality validation**  
3. **ND reality validation → ND normalization**  
4. **ND normalization → ND readiness gate**  
5. **ND readiness gate → D legality** *(in the pipeline examples)*  
6. **D legality → ND execution** *(in the pipeline examples)*  
7. **ND execution → ND finalization** *(in the pipeline examples)*  

This page covers **only the ND baton passes**.  
All D baton passes live in the pipeline examples.

---

# 6. ND’s Role in Deterministic Systems

ND protects the D world by:

- stabilizing reality  
- removing nondeterminism  
- shaping inputs  
- ensuring readiness  
- preventing partial execution  
- preventing corruption  
- preventing drift  
- preventing sealed‑domain violations  

ND ensures:

> **“Do not start business rules until everything is ready.”**

This is the diner analogy:

- ND prepares the kitchen  
- ND checks utilities  
- ND checks supplies  
- ND checks staff  
- ND checks equipment  
- ND ensures readiness  

Only then does the grill master (D world) run deterministic logic.

---

# 7. ND Failure Is Safe

If ND fails:

- no money moves  
- no accounts drift  
- no partial transactions  
- no reconciliation  
- no corruption  

ND failure causes **outages**, not **damage**.

This is the ATM analogy:

> **All or nothing.  
> Never partial.**

---

# 8. ND and the Four Attributes

ND may use:

- GC  
- exceptions  
- side effects  
- external dependencies  

D must be:

- `@safe`  
- `pure`  
- `nothrow`  
- `@nogc`  

ND is nondeterministic.  
D is deterministic.

ND interacts with the world.  
D interacts with sealed‑domain data.

ND prepares.  
D decides.  
ND executes.

---

# 9. Summary

- ND is the nondeterministic world.  
- ND prepares reality for deterministic execution.  
- ND is prohibited from business rules.  
- ND is prohibited from legality.  
- ND is prohibited from sealed‑domain decisions.  
- ND performs ingress, acquisition, validation, normalization, readiness.  
- ND hands the baton to D only when ready.  
- ND resumes after D returns its classification.  
- ND failure is safe.  
- ND protects deterministic execution.  
- ND protects atomicity.  
- ND protects certification.  

This page is the doctrinal parent.  
Pipeline examples live in:

```
05_deterministic_legality_cases/
```

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_nd_preparation_pipeline.md>
