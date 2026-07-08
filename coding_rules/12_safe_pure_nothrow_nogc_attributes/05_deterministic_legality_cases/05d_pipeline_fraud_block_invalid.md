###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05d_pipeline_fraud_block_invalid.md>

# 05d — Pipeline Case: Fraud Block (Invalid)  
## Full Baton Geometry: ND → D → ND

### Abbreviations  
**ND** — *Non‑Deterministic world*: networks, databases, clocks, outages, concurrency, external dependencies.*  
**D** — *Deterministic world*: sealed‑domain legality, business rules, invariants, pure logic.*

---

## Purpose  
This page demonstrates the complete pipeline for a **Fraud‑Blocked Transfer**.  
The baton passes are explicit, sovereign, and SoC‑pure:

**ND → D → ND**

ND and D never mix.  
ND prepares.  
D decides.  
ND finalizes.

This case is **Invalid**, and therefore the entire pipeline is **NOP other than logs**.

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
    "batonId":              7777,
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
    "batonId":              7777,
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
    "batonId": 7777,

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
            "fraud":  true        // FRAUD FLAG SET
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
        "acquisitionTimestamp": "2026-07-07T16:00:00Z",
        "retryCount":           0,
        "dataSources": [
            "core-banking-db",
            "customer-service-api",
            "account-ledger-service"
        ],
        "warnings": [
            "source account fraud flag"
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
    "batonId": 7777,
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
    "batonId": 7777,

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
        "fraud": true
    }
}
```

---

# 5. ND Readiness Gate  
ND confirms all sealed‑domain inputs are present and hands the baton to D.

**Baton: ND → D**

```
{
    "batonId":                 7777,

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
        "fraud":                    true
    }
}
```

---

# 6. D Legality Classification  
(See jurisdiction legality rules in:  
`sealed_domain_jurisdiction_rules.md`)

D evaluates legality deterministically:

- Ownership: OK  
- Jurisdiction: OK  
- Activity: OK  
- Fraud flag: **NOT OK**  
- Amount: OK  

FraudFlag = **true** is a sealed‑domain legality blocker.

> **Legality = Invalid (FraudBlock)**

**Baton: D → ND**

```
{
    "batonId": 7777,
    "legality": "Invalid",
    "reason":   "FraudBlock"
}
```

---

# 7. ND Finalization  
ND receives the legality classification.

Because legality is **Invalid**, the entire pipeline is an **effective NOP**:

- logs the fraud‑blocked attempt  
- records the sealed‑domain reason  
- updates audit trails  
- returns a stable error to the caller  
- ensures no partial execution  
- ensures no corruption  
- ensures no drift  

The baton is **retired**.

**Final Baton: ND → Retired**

```
{
    "batonId": 7777,
    "legality": "Invalid",
    "finalResult": "Invalid (FraudBlock)",
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
→ D legality (Invalid: FraudBlock)
→ ND finalization (NOP)
→ ND → Retired
```

ND and D remain fully disjoint.  
Legality is deterministic.  
Execution is nondeterministic but safe.  
No partial execution.  
No drift.  
No reconciliation.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05d_pipeline_fraud_block_invalid.md>
