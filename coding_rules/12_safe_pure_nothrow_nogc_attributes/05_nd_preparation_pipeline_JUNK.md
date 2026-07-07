###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_nd_preparation_pipeline.md>

# 05 — Non‑Deterministic (ND) Preparation Pipeline  
## How the ND World Sets the Stage for Deterministic Execution

## Purpose
This document defines the **Non‑Deterministic (ND) Preparation Pipeline** — the part of a Prax Junior system that deals with the messy, unpredictable ND world and delivers clean, ready‑to‑use inputs to the Deterministic (D) world.

To make this concrete, we follow **one simple example** through every stage:

> **Customer wants to transfer $100 from Checking → Savings.**

This example shows exactly how the ND pipeline prepares the world so the D world can run deterministically.

---

# 1. The ND World’s Job

The ND world is responsible for **everything nondeterministic**:

- networks  
- databases  
- file systems  
- clocks  
- concurrency  
- outages  
- missing data  
- broken dependencies  

And critically:

> **The ND world is prohibited from running business rules.  
> In NYC waiter terms: “Not my table.”**

Just as a waiter in a New York restaurant will not serve another waiter’s section —  
because it breaks workflow, accountability, and tip ownership —  
the ND world must never cross‑serve into the D world.

ND’s job is to:

1. **discover reality**  
2. **stabilize reality**  
3. **prepare inputs**  
4. **verify readiness**  
5. **delegate business‑rule execution to the D world**

The D world only runs when everything is ready.

---

# 2. The Concrete Example

We follow this request:

> **Transfer $100 from Checking → Savings.**

The business rule is simple.  
The world around it is not.

The ND pipeline must prepare everything before the D world can run deterministic transfer logic.

---

# 3. Stage 1 — Ingress (ND)  
### Talking to the ND World

Ingress receives the request:

```json
POST /transfer
{
    "customerId": "C123",
    "fromAccount": "CHK-001",
    "toAccount": "SAV-002",
    "amount": 100
}
```

Ingress is pure ND:

- request may be malformed  
- customerId may be missing  
- amount may be invalid  
- network may be slow  
- message may be duplicated  

Ingress does **not** run business rules.  
Ingress only **captures** the request.

---

# 4. Stage 2 — Acquisition (ND)  
### Gathering ND Dependencies

The ND pipeline gathers everything the D world will need:

- load customer record  
- load checking account  
- load savings account  
- load account statuses  
- load daily transfer limits  
- load fraud flags  
- load configuration  
- load reference data  

All of this is ND:

- database may be down  
- records may be missing  
- services may be slow  
- configuration may be stale  

Example acquisition:

```text
customer = DB.getCustomer("C123")
checking = DB.getAccount("CHK-001")
savings  = DB.getAccount("SAV-002")
limits   = DB.getTransferLimits("C123")
flags    = DB.getFraudFlags("C123")
```

If any acquisition fails, **D world does not run**.

---

# 5. Stage 3 — Validation (Split ND / D)  
### ND Validates Reality, D Validates Legality

Validation is split between ND and D responsibilities.

## 5.1 ND‑side validation (ND)

ND ensures **reality is coherent** before any D‑side legality is considered:

- **all required records exist**  
- **no contradictory raw data exists**  
- **snapshot is structurally coherent**  

ND does **not** validate ownership.  
ND does **not** validate business‑rule invariants.  
ND does **not** validate legality.

If ND validation fails:
- request is rejected  
- D world is not invoked  
- business rules are not run  

## 5.2 D‑side validation (D)

Once ND has delivered a coherent snapshot, the D world validates **business‑rule legality** over a sealed domain:

- **accounts belong to the customer**  
- **accounts are active**  
- **amount is positive**  
- **amount is within limits**  
- **no fraud flags block the transfer**

Ownership is a **legality predicate**, not a reality predicate.  
Therefore ownership is D’s table.

The D world classifies the request into one of several legality outcomes.  
We show four representative cases, but **Invalid** is a domain containing many possible illegal states.

### 1. Invalid — Foreign Account (example of many invalid cases)
The account does not belong to the customer.  
This is one of many possible illegal business cases.

- D returns: **Invalid("Foreign account")**  
- ND does not execute the transfer  
- ND reports the reason  
- ND touches **none** of the foreign account’s balances

### 2. Authorized — Transfer Legal
All legality predicates pass.

- D returns: **Authorized**  
- ND proceeds to execute the transfer  
- ND performs all state mutation, ledger updates, commits, and external effects  
- D performs **no** execution, **no** mutation, **no** IO — only authorization

### 3. Invalid — Fraud Block
A fraud flag prohibits the transfer.

- D returns: **Invalid("Fraud block")**  
- ND does not execute the transfer  
- ND reports the reason

### 4. Invalid — Insufficient Funds (Business Rule)
The account balance is insufficient *according to the sealed snapshot*.

- D returns: **Invalid("Insufficient funds")**  
- ND does not execute the transfer  
- ND reports the reason  
- ND charges **no fee** (nice‑banking world)

---

### ND‑Execution Failure After Authorization

Even when D returns **Authorized**, ND may still fail during execution.

Example:
- One millisecond after D authorization, the spouse withdraws rent money.
- ND attempts the transfer.
- SQL Server rejects the transaction: **insufficient funds**.

This is correct and expected.

- D was correct — the snapshot was legal at classification time  
- ND was correct — the world changed  
- SQL Server was correct — atomicity preserved  
- No corruption occurs  
- No partial transfer occurs  
- ND reports the execution failure

This is how modern systems must behave.

---

### ND’s Role Relative to 5.2

**ND has no part in 5.2.**  
5.2 is **pure D**, and this is D’s place to shine.

ND resumes **after** D returns its legality classification, beginning again in Stage 6 (execution) with the result of 5.2.

---

# 6. Stage 4 — Normalization (ND)  
### Shaping Inputs for the D World

Normalization converts raw ND data into **clean, sealed‑domain inputs**.

Example normalization:

```text
NormalizedTransferInput:
{
    customerId: "C123",
    fromAccountId: "CHK-001",
    toAccountId: "SAV-002",
    amountCents: 10000,
    fromBalanceCents: 250000,
    toBalanceCents: 50000
}
```

Normalization:
- removes irrelevant fields  
- converts dollars → cents  
- resolves internal IDs  
- enforces structural invariants  
- shapes data for deterministic execution  

Normalization does **not**:
- call external services  
- read the clock  
- allocate GC memory  
- run business rules  

---

# 7. Stage 5 — Readiness Check (ND)  
### Gate to the D World

The readiness check asks:

> “Do we have *everything* the D world needs to run deterministically?”

Checklist:

- all records present  
- all balances loaded  
- ND‑side invariants satisfied  
- D‑side legality checkable  
- all fields normalized  
- no missing data  
- no unresolved dependencies  

If **any** item fails:
- reject request  
- do not run business rules  
- do not enter the D world  

If **all** items pass:
- D world is invoked  
- deterministic transfer logic runs  
- no ND interaction occurs during D execution  

---

# 8. Diner Analogy — ND Preparation Pipeline

ND pipeline:
- checks utilities  
- checks equipment  
- checks staff  
- checks supplies  
- prepares mise en place  

Only when everything is ready does the grill master:

1. drop hash browns  
2. drop sausage  
3. wait 60 seconds  
4. plate food  
5. move to warming table  
6. ring bell  
7. clean grill  

ND pipeline ensures:

> “Do not start cooking until everything is ready.”

Prax Junior ND pipeline ensures:

> “Do not start business rules until everything is ready.”

---

# 9. ATM vs Diner — Why Partial Transactions Are Forbidden  
## ND Chaos vs Deterministic Business Rules

ATMs enforce:

> **Atomicity.  
> All or nothing.  
> No partial transactions.**

Diners violate invariants with partial plates.

Prax Junior forbids diner‑style partial business rules.

---

# 10. ND Pipeline Failure Is Safe

If ND fails:
- no money moves  
- no accounts drift  
- no reconciliation is needed  

ND failure causes **outages**, not **corruption**.

---

# 11. ND Pipeline and the Four Attributes

ND may use:
- GC  
- exceptions  
- side effects  
- external dependencies  

D must be:
- `@safe pure nothrow @nogc`  
- deterministic  
- sealed‑domain  
- invariant‑driven  

---

# 12. Summary

- ND talks to the world.  
- ND gathers, checks, prepares.  
- ND is **prohibited** from business rules — “Not my table.”  
- Validation is **split**: ND validates reality; D validates legality.  
- **Ownership is a legality predicate and belongs to D.**  
- D classifies into: Foreign Account, Authorized, Fraud Block, Insufficient Funds.  
- ND executes transfers only when D authorizes.  
- ND may still fail during execution — this is correct and safe.  
- Enterprise systems must behave like **ATMs**, not **diners**.  
- This is Prax Junior’s architecture.

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_nd_preparation_pipeline.md>
