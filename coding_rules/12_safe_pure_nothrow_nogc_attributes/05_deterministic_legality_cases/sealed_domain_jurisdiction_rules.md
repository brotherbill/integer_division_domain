###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/sealed_domain_jurisdiction_rules.md>

# Sealed‑Domain Legality Rules — Jurisdiction  
## Deterministic Legality Engine (D‑World)

These rules define how the sealed‑domain legality engine evaluates jurisdiction.  
They are **pure**, **deterministic**, **fully documented**, and **never sourced from ND**.

ND provides **facts**.  
D provides **rules**.  
No mixing.

---

# 1. Foreign Accounts Are Outside the Sealed Domain
```
ForeignAccountsAreOutsideSealedDomain = true
```
Any account whose jurisdiction is `"Foreign"` is considered **outside** the sealed domain.  
Such accounts cannot participate in sealed‑domain legality evaluation.

---

# 2. Cross‑Jurisdiction Transfers Are Not Allowed
```
CrossJurisdictionTransfersAllowed = false
```
Transfers where:
- `sourceJurisdiction = "Domestic"`
- `destinationJurisdiction = "Foreign"`

are **always illegal** within the sealed domain.

---

# 3. Both Accounts Must Be Domestic
```
BothAccountsMustBeDomestic = true
```
A legal transfer requires:
```
sourceJurisdiction      == "Domestic"
destinationJurisdiction == "Domestic"
```

---

# 4. Destination Account Must Belong to the Customer
```
DestinationOwnedByCustomerRequired = true
```
Even if jurisdictions match, legality requires:
```
destinationOwnedByCustomer == true
```

---

# 5. Source Account Must Belong to the Customer
```
SourceOwnedByCustomerRequired = true
```
The customer must own the source account.

---

# 6. Deterministic Evaluation Guarantee
All rules in this file are:

- sealed‑domain  
- deterministic  
- replayable  
- auditable  
- sovereign  
- SoC‑pure  

ND cannot override these rules.  
ND cannot inject policy.  
ND cannot influence legality.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/sealed_domain_jurisdiction_rules.md>
