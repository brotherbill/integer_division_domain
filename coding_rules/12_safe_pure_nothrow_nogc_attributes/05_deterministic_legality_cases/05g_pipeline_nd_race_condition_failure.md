###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05g_pipeline_nd_race_condition_failure.md>

# 05g — Pipeline Case: ND Race Condition Failure (Invalid)  
## Full Baton Geometry: ND → D → ND

### Abbreviations  
**ND** — *Non‑Deterministic world*: networks, databases, clocks, outages, concurrency, external dependencies.*  
**D** — *Deterministic world*: sealed‑domain legality, business rules, invariants, pure logic.*

---

## Purpose  
This page demonstrates a **race‑condition legality failure**:

- ND prepares the baton  
- D evaluates legality and returns **Valid**  
- A concurrent nondeterministic event occurs in the real world (spouse withdraws rent money)  
- ND attempts execution  
- ND receives **Insufficient Funds** from the database  
- ND resolves the pipeline as **Invalid (RaceConditionFailure)**  
- The entire pipeline is an **effective NOP**  
- No partial mutation occurs  
- No drift occurs  
- No reconciliation is required  

This case is surprising because legality was **Valid**, yet ND execution fails due to a nondeterministic race.  
Prax Jr handles this safely.

---

### Intended Transaction  
The customer intends to transfer **$100** from their **CHECKING** account to their **SAVINGS** account.  
ND captures this intent exactly as stated.

---

# 1. ND Ingress  
ND captures the operator’s intent exactly as stated.

```
{
    "batonId":              4444,
    "customerId":           "C123",
    "sourceAccountId":      "A100",
    "destinationAccountId": "A200",
    "amountCents":          10000
}
```

**Baton: ND → ND**

```
{
    "batonId":              4444,
    "customerId":           "C123",
    "sourceAccountId":      "A100",
    "destinationAccountId": "A200",
    "amountCents":          10000
}
```

---

# 2. ND Acquisition  
ND gathers all external dependencies.

Source account has **$1,500 available**, enough for the transfer.

```
{
    "sourceAccountRecord": {
        "accountId":        "A100",
        "type":             "Checking",
        "ownerCustomerId":  "C123",
        "balanceDollars":   1500.00,
        "flags": {
            "active": true,
            "fraud":  false
        },
        "jurisdiction":     "Domestic"
    },

    "destinationAccountRecord": {
        "accountId":        "A200",
        "type":             "Savings",
        "ownerCustomerId":  "C123",
        "balanceDollars":   9000.00,
        "flags": {
            "active": true,
            "fraud":  false
        },
        "jurisdiction":     "Domestic"
    }
}
```

**Baton: ND → ND**

---

# 3. ND Reality Validation  
ND ensures structural coherence only.

**Baton: ND → ND**

---

# 4. ND Normalization  
ND shapes raw data into sealed‑domain inputs.

```
{
    "batonId": 4444,

    "customerId":              "C123",

    "sourceAccountId":         "A100",
    "sourceBalanceCents":      150000,   // $1,500
    "sourceJurisdiction":      "Domestic",
    "sourceOwnedByCustomer":   true,
    "sourceAccountActive":     true,

    "destinationAccountId":    "A200",
    "destinationBalanceCents": 900000,
    "destinationJurisdiction": "Domestic",
    "destinationOwnedByCustomer": true,
    "destinationAccountActive":   true,

    "transferAmountCents":     10000,

    "flags": {
        "fraudFlag": false
    }
}
```

**Baton: ND → ND**

---

# 5. ND Readiness Gate  
ND confirms all sealed‑domain inputs are present.

**Baton: ND → D**

```
{
    "batonId":                 4444,
    "customerId":              "C123",
    "sourceAccountId":         "A100",
    "destinationAccountId":    "A200",

    "sourceBalanceCents":      150000,
    "destinationBalanceCents": 900000,
    "transferAmountCents":     10000,

    "sourceJurisdiction":      "Domestic",
    "destinationJurisdiction": "Domestic",

    "ownership": {
        "sourceOwnedByCustomer":      true,
        "destinationOwnedByCustomer": true
    },

    "flags": {
        "sourceAccountActive":      true,
        "destinationAccountActive": true,
        "fraudFlag":                false
    }
}
```

---

# 6. D Legality Classification  
All sealed‑domain checks pass:

- Ownership: OK  
- Jurisdiction: OK  
- Activity: OK  
- Fraud: OK  
- Funds: OK  

> **Legality = Valid (AuthorizedDomesticTransfer)**

**Baton: D → ND**

```
{
    "batonId": 4444,
    "legality": "Valid",
    "reason":   "AuthorizedDomesticTransfer"
}
```

---

# 7. ND Execution Attempt  
ND attempts nondeterministic execution:

- debit source  
- credit destination  
- write ledger entry  
- update audit trail  

But **one millisecond earlier**, the spouse withdraws rent money.

Source account balance drops from **$1,500 → $75**.

ND attempts debit of 10000 cents.

Database rejects the debit:

```
{
    "error": "InsufficientFunds",
    "currentBalanceCents": 7500
}
```

ND cannot complete execution.

ND produces:

```
{
    "batonId": 4444,
    "executionStatus": "Failed",
    "failureReason":   "RaceConditionFailure"
}
```

---

# 8. ND Finalization  
ND receives legality = **Valid**, but execution fails due to a nondeterministic race.

Because ND execution failed:

- no money moves  
- no accounts drift  
- no partial mutation occurs  
- no ledger entries are written  
- no audit‑trail mutations occur  
- no state changes of any kind occur  
- the baton is retired without execution  

The pipeline’s net effect is:

> **A perfect NOP — despite legality being Valid.**

ND logs the failure and returns a stable error to the caller.

**Final Baton: ND → Retired**

```
{
    "batonId": 4444,
    "legality": "Valid",
    "execution": "Failed",
    "finalResult": "Invalid (RaceConditionFailure)",
    "effectiveOutcome": "NOP"
}
```

---

# 9. Summary of Baton Passes

```
ND ingress
→ ND acquisition
→ ND reality validation
→ ND normalization
→ ND readiness gate
→ D legality (Valid)
→ ND execution race‑condition failure
→ ND finalization (NOP)
→ ND → Retired
```

ND and D remain fully disjoint.  
Legality is deterministic.  
Execution is nondeterministic.  
Race‑condition failure is safe.  
No drift.  
No partial mutation.  
No reconciliation.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05g_pipeline_nd_race_condition_failure.md>
