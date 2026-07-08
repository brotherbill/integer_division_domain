###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05b_pipeline_foreign_account_invalid.md>

# 05b — Pipeline Case: Foreign Account (Invalid)  
## Full Baton Geometry: ND → D → ND

### Abbreviations  
**ND** — *Non‑Deterministic world*: networks, databases, clocks, outages, concurrency, external dependencies.  
**D** — *Deterministic world*: sealed‑domain legality, business rules, invariants, pure logic.

---

## Purpose
This page demonstrates the complete pipeline for a **Foreign Account** legality failure.  
The baton passes are explicit, sovereign, and SoC‑pure:

**ND → D → ND**

ND and D never mix.  
ND prepares.  
D decides.  
ND finalizes.

This page starts from the top and shows every baton handoff.

---

### Intended Transaction  
The customer intends to transfer **$100** from their **CHECKING** account to their **SAVINGS** account.  
ND captures this intent exactly as stated, without evaluating legality or ownership.

---

# 1. ND Ingress  
ND captures the operator’s intent exactly as stated.

### Ingress Shape

```
{
    "batonId":              6789,
    "customerId":           "C123",
    "sourceAccountId":      "A555",
    "destinationAccountId": "A666",
    "amountCents":          10000
}
```

### Baton Leaving ND Stage 1 → Entering ND Stage 2  
ND Stage 1 only captures.  
The baton is unchanged.

**Baton: ND → ND**

```
{
    "batonId":              6789,
    "customerId":           "C123",
    "sourceAccountId":      "A555",
    "destinationAccountId": "A666",
    "amountCents":          10000
}
```

---

# 2. ND Acquisition  
ND gathers all external dependencies and produces a raw snapshot.

**Baton: ND → ND**

```
{
    "batonId": 6789,

    "customerRecord": {
        "customerId":  "C123",
        "name":        "Alice Example",
        "status":      "Active",
        "jurisdiction":"Domestic"
    },

    "sourceAccountRecord": {
        "accountId":        "A555",
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
        "accountId":        "A666",
        "type":             "Savings",
        "ownerCustomerId":  "C456",
        "balanceDollars":   9000.00,
        "flags": {
            "active": true,
            "fraud":  false
        },
        "jurisdiction":     "Foreign"
    },

    "transferIntent": {
        "amountCents":         10000,
        "sourceAccountId":     "A555",
        "destinationAccountId":"A666"
    },

    "systemMetadata": {
        "acquisitionTimestamp": "2026-07-07T14:22:00Z",
        "retryCount":           1,
        "dataSources": [
            "core-banking-db",
            "customer-service-api",
            "account-ledger-service"
        ],
        "warnings": [
            "destination jurisdiction mismatch",
            "owner mismatch"
        ]
    }
}
```

---

# 3. ND Reality Validation  
ND ensures structural coherence only.

**Baton: ND → ND**

```
{
    "batonId": 6789,
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
    "batonId": 6789,

    "customerId":              "C123",

    "sourceAccountId":         "A555",
    "sourceBalanceCents":      250000,
    "sourceJurisdiction":      "Domestic",
    "sourceOwnedByCustomer":   true,
    "sourceAccountActive":     true,

    "destinationAccountId":    "A666",
    "destinationBalanceCents": 900000,
    "destinationJurisdiction": "Foreign",
    "destinationOwnedByCustomer": false,
    "destinationAccountActive":   true,

    "transferAmountCents":     10000,

    "flags": {
        "fraud": false
    }
}
```

---

# 5. ND Readiness Gate  
ND confirms all sealed‑domain inputs are present and hands the baton to D.

**Baton: ND → D**

```
{
    "batonId":                 6789,
    "customerId":              "C123",
    "sourceAccountId":         "A555",
    "destinationAccountId":    "A666",
    "sourceBalanceCents":      250000,
    "destinationBalanceCents": 900000,
    "transferAmountCents":     10000,
    "sourceJurisdiction":      "Domestic",
    "destinationJurisdiction": "Foreign",
    "ownership": {
        "sourceOwnedByCustomer":      true,
        "destinationOwnedByCustomer": false
    },
    "flags": {
        "sourceAccountActive":      true,
        "destinationAccountActive": true,
        "fraud":                    false
    }
}
```

---

# 6. D Legality Classification  
(See jurisdiction legality rules in:  
`sealed_domain_jurisdiction_rules.md`)

D evaluates legality deterministically:

- Destination account is **foreign**  
- Foreign accounts are **outside the sealed domain**  
- Cross‑jurisdiction transfers are **not allowed**

> **Legality = Invalid (ForeignAccount)**

**Baton: D → ND**

```
{
    "batonId": 6789,
    "legality": "Invalid",
    "reason":   "ForeignAccount"
}
```

---

# 7. ND Finalization  
ND receives the legality classification.

Because legality is **Invalid**, ND performs nondeterministic finalization:

- logs the invalid attempt  
- records the sealed‑domain reason  
- updates audit trails  
- returns a stable error to the caller  

And critically:

> **The entire pipeline is an effective NOP.  
> No money moves.  
> No accounts drift.  
> No partial mutation occurs.  
> No reconciliation is required.**

The baton is **retired**.

**Final Baton: ND → Retired**

```
{
    "batonId": 6789,
    "legality": "Invalid",
    "finalResult": "Invalid (ForeignAccount)",
    "effectiveOutcome": "NOP"
}
```

---

# 8. Summary of Baton Passes

```
ND ingress
→ ND acquisition
→ ND reality validation
→ ND normalization
→ ND readiness gate
→ D legality (Invalid: ForeignAccount)
→ ND finalization (NOP)
→ ND → Retired
```

ND and D remain fully disjoint.  
Legality is deterministic.  
Execution is nondeterministic but safe.  
No drift.  
No partial mutation.  
No reconciliation.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05b_pipeline_foreign_account_invalid.md>
