###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05b_pipeline_foreign_account_invalid.md>

# 05b — Pipeline Case: Foreign Account (Invalid)  
## Full Baton Geometry: ND → D → ND → D → ND

### Abbreviations  
**ND** — *Non‑Deterministic world*: networks, databases, clocks, outages, concurrency, external dependencies.  
**D** — *Deterministic world*: sealed‑domain legality, business rules, invariants, pure logic.

---

## Purpose
This page demonstrates the complete pipeline for a **Foreign Account** legality failure.  
The baton passes are explicit, sovereign, and SoC‑pure:

**ND → D → ND → D → ND**

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
The request enters the system from the nondeterministic world.  
ND does not interpret legality.  
ND does not run business rules.  
ND only captures the operator’s intent.

### Ingress Shape (with platoon‑formation comments)

```
{
    "batonId":              6789,   // Unique baton identity for this request.
    "customerId":           "C123", // Captured identity only; ND does not validate.
    "sourceAccountId":      "A555", // Customer's CHECKING account (intent only).
    "destinationAccountId": "A666", // Some other customer's SAVINGS account (intent only).
    "amountCents":          10000   // Raw ingress amount in cents; ND does not interpret or normalize.
}
```

### Intent of the Transaction  
The customer is attempting to **move funds from A555 to A666**.  
ND records this intent *exactly as stated*, without evaluating legality, ownership, or jurisdiction.

### Baton Leaving ND Stage 1 → Entering ND Stage 2  
ND Stage 1 has only one responsibility: **capture**.  
Therefore, the baton leaving Stage 1 is **identical** to the ingress shape.

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
ND gathers all external dependencies:

- customer record  
- source account  
- destination account  
- balances  
- flags  
- configuration  
- ownership metadata  
- jurisdiction metadata  

ND handles outages, retries, missing data, and nondeterministic delays.  
ND produces a **raw snapshot**.

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
        "ownerCustomerId":  "C456",      // belongs to someone else
        "balanceDollars":   9000.00,
        "flags": {
            "active": true,
            "fraud":  false
        },
        "jurisdiction":     "Foreign"    // nondeterministic metadata
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
ND ensures the snapshot is structurally coherent:

- all required records exist  
- no contradictory raw data  
- no missing fields  
- no malformed structures  

ND does **not** validate legality, ownership, or business rules.  
ND only ensures the world is coherent enough for deterministic evaluation.

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

# 4. ND Normalization  
ND shapes raw data into sealed‑domain inputs:

- dollars → cents  
- external IDs preserved as canonical strings  
- irrelevant fields removed  
- structural invariants enforced  
- jurisdiction metadata preserved  

Normalization is **pure ND shaping**.  
No business rules.  
No legality.  
No sealed‑domain decisions.

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
        "fraudFlag": false
    }
}
```

---

# 5. ND Readiness Gate  
ND asks:

> **“Do we have everything the D world needs to run deterministically?”**

For this case, the answer is **yes**.

ND hands the baton to D.

### Baton Leaving ND Stage 5 → Entering D  
This is the **sealed‑domain input baton**:

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
        "fraudFlag":                false
    }
}
```

---

# 6. D Legality Classification  
(See jurisdiction legality rules in:  
`sealed_domain_jurisdiction_rules.md`)

D receives the sealed‑domain inputs.

D evaluates legality using deterministic rules:

- Does the source account belong to the customer?  
- Does the destination account belong to the customer?  
- Are both accounts domestic?  
- Are both accounts within the sealed domain?  
- Are cross‑jurisdiction transfers allowed?  

In this case:

> **Destination account is foreign.  
> Foreign accounts are outside the sealed domain.  
> Legality classification = Invalid.**

D returns:

**Baton: D → ND**

```
{
    "batonId": 6789,
    "legality": "Invalid",
    "reason":   "ForeignAccount"
}
```

D does **not** execute.  
D does **not** mutate.  
D does **not** touch the world.

---

# 7. ND Finalization  
ND receives the legality classification.

ND performs nondeterministic finalization:

- logs the invalid attempt  
- records the sealed‑domain reason  
- updates audit trails  
- returns a stable error to the caller  
- ensures no partial execution  
- ensures no corruption  
- ensures no drift  

Because the legality classification is **Invalid**, the **entire pipeline is NOP (No Operation)** other than logging and audit‑trail recording.

No transfer takes place.  
No state changes occur.  
No baton is propagated forward.  
The baton is **retired** at this point.

ND finalization is nondeterministic but **safe**:

- no money moves  
- no accounts drift  
- no partial transactions  
- no reconciliation required

---

# 8. Summary of Baton Passes

```
ND ingress
→ ND acquisition
→ ND reality validation
→ ND normalization
→ ND readiness gate
→ D legality (Invalid: ForeignAccount)
→ ND finalization
```

ND and D remain fully disjoint.  
Legality is determined deterministically.  
Execution is nondeterministic but safe.  
No stone is left unturned.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05b_pipeline_foreign_account_invalid.md>
