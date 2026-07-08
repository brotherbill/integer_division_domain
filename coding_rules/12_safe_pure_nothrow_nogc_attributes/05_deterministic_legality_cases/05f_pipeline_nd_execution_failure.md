###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05f_pipeline_nd_execution_failure.md>

# 05f — Pipeline Case: ND Execution Failure (Invalid)  
## Full Baton Geometry: ND → D → ND

### Abbreviations  
**ND** — *Non‑Deterministic world*: networks, databases, clocks, outages, concurrency, external dependencies.*  
**D** — *Deterministic world*: sealed‑domain legality, business rules, invariants, pure logic.*

---

## Purpose  
This page demonstrates a pipeline where:

- ND prepares the baton  
- D evaluates legality and returns **Valid**  
- ND attempts execution  
- ND **fails** due to nondeterministic external conditions  
- The final result is **Invalid (ExecutionFailure)**  
- The entire pipeline is an **effective NOP**  
- No partial mutation occurs  
- No drift occurs  
- No reconciliation is required  

This case surprises many engineers because ND execution failure **does not** sink Prax Jr.  
The sealed‑domain legality decision remains sovereign, and ND failure is handled safely.

---

### Intended Transaction  
The customer intends to transfer **$100** from their **CHECKING** account to their **SAVINGS** account.  
ND captures this intent exactly as stated.

---

# 1. ND Ingress  
ND captures the operator’s intent exactly as stated.

### Ingress Shape

```
{
    "batonId":              9999,
    "customerId":           "C123",
    "sourceAccountId":      "A100",
    "destinationAccountId": "A200",
    "amountCents":          10000
}
```

### Baton Leaving ND Stage 1 → Entering ND Stage 2  
ND Stage 1 only captures.  
The baton is unchanged.

**Baton: ND → ND**

```
{
    "batonId":              9999,
    "customerId":           "C123",
    "sourceAccountId":      "A100",
    "destinationAccountId": "A200",
    "amountCents":          10000
}
```

---

# 2. ND Acquisition  
ND gathers all external dependencies and produces a raw snapshot.

**Baton: ND → ND**

```
{
    "batonId": 9999,

    "customerRecord": {
        "customerId":  "C123",
        "name":        "Alice Example",
        "status":      "Active",
        "jurisdiction":"Domestic"
    },

    "sourceAccountRecord": {
        "accountId":        "A100",
        "type":             "Checking",
        "ownerCustomerId":  "C123",
        "balanceDollars":   2500.00,
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
    },

    "transferIntent": {
        "amountCents":         10000,
        "sourceAccountId":     "A100",
        "destinationAccountId":"A200"
    },

    "systemMetadata": {
        "acquisitionTimestamp": "2026-07-07T17:00:00Z",
        "retryCount":           0,
        "dataSources": [
            "core-banking-db",
            "customer-service-api",
            "account-ledger-service"
        ],
        "warnings": []
    }
}
```

---

# 3. ND Reality Validation  
ND ensures structural coherence only.

**Baton: ND → ND**

```
{
    "batonId": 9999,
    "customerRecord": { ... },
    "sourceAccountRecord": { ... },
    "destinationAccountRecord": { ... },
    "transferIntent": { ... },
    "systemMetadata": { ... }
}
```

---

# 4. ND Normalization  
ND shapes raw data into sealed‑domain inputs.

**Baton: ND → ND**

```
{
    "batonId": 9999,

    "customerId":              "C123",

    "sourceAccountId":         "A100",
    "sourceBalanceCents":      250000,
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

---

# 5. ND Readiness Gate  
ND confirms all sealed‑domain inputs are present and hands the baton to D.

**Baton: ND → D**

```
{
    "batonId":                 9999,
    "customerId":              "C123",
    "sourceAccountId":         "A100",
    "destinationAccountId":    "A200",
    "sourceBalanceCents":      250000,
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
D evaluates legality deterministically:

- Ownership: OK  
- Jurisdiction: OK  
- Activity: OK  
- Fraud: OK  
- Funds: OK  

All sealed‑domain legality checks pass.

> **Legality = Valid (AuthorizedDomesticTransfer)**

**Baton: D → ND**

```
{
    "batonId": 9999,
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

But ND encounters a nondeterministic failure:

- database outage  
- network timeout  
- ledger write failure  
- concurrency lock failure  

ND cannot complete execution.

ND produces:

```
{
    "batonId": 9999,
    "executionStatus": "Failed",
    "failureReason":   "NDExecutionFailure"
}
```

---

# 8. ND Finalization  
ND receives the legality classification (**Valid**) but execution fails.

Because ND execution failed:

- **no money moves**  
- **no accounts drift**  
- **no partial mutation occurs**  
- **no ledger entries are written**  
- **no audit‑trail mutations occur**  
- **no state changes of any kind occur**  
- **the baton is retired without execution**  

The pipeline’s net effect is:

> **A perfect NOP — despite legality being Valid.**

ND logs the failure and returns a stable error to the caller.

**Final Baton: ND → Retired**

```
{
    "batonId": 9999,
    "legality": "Valid",
    "execution": "Failed",
    "finalResult": "Invalid (ExecutionFailure)",
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
→ ND execution failure
→ ND finalization (NOP)
→ ND → Retired
```

ND and D remain fully disjoint.  
Legality is deterministic.  
Execution is nondeterministic.  
Failure is safe.  
No drift.  
No partial mutation.  
No reconciliation.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05f_pipeline_nd_execution_failure.md>
