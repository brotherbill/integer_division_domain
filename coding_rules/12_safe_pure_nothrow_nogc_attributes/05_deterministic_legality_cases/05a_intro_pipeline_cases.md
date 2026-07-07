###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05a_intro_pipeline_cases.md>

# 05a — Introduction to Deterministic Legality Pipeline Cases  
## Why These Pages Exist and How They Must Be Read

## Purpose
This page introduces the **deterministic legality pipeline cases**.  
Each case demonstrates the full baton geometry:

**ND → D → ND → D → ND**

Each page is sovereign.  
Each page starts from the top.  
Each page shows every baton pass.  
Each page keeps ND and D fully disjoint.

This introduction explains **why** the cases are split, **how** they are structured, and **what** the reader should expect.

---

# Intended Transaction (Control Experiment)

All pipeline cases in this folder model the **same intended transaction**:

> The customer intends to transfer **$100** from their **CHECKING** account to their **SAVINGS** account.

This invariant intent is the **control experiment** that allows:

- ND ingress to remain identical  
- ND acquisition to remain identical  
- ND reality validation to remain identical  
- ND normalization to remain identical  
- ND readiness gate to remain identical  

Only **D’s legality classification** changes.

By holding the intended transaction constant, each pipeline case becomes a **legality lens** on the same ND→D→ND baton geometry.  
This is required for:

- sealed‑domain clarity  
- deterministic comparison  
- auditor‑friendly structure  
- certifiable documentation  
- no hidden assumptions  
- no cross‑page dependency  

Every pipeline page begins with a short sovereign intent block, and the summary page reinforces it.

---

# 1. Why These Cases Are Split Into Separate Pages

The original 05 page attempted to show:

- ND ingress  
- ND acquisition  
- ND validation  
- D legality  
- ND execution  
- ND failure modes  
- multiple legality outcomes  

All in one place.

This violated **Separation of Concerns (SoC)**.

To restore clarity and determinism, each legality outcome is now placed in its own sovereign page.  
This ensures:

- no ND/D mixing  
- no drift  
- no cross‑contamination  
- no hidden baton passes  
- no scenario overlap  
- no ambiguity  

Each page is **clean and tight**.

---

# 2. What These Pages Demonstrate

Each pipeline case demonstrates:

### **1. ND Ingress**  
The request enters the system.

### **2. ND Acquisition**  
ND gathers all external dependencies.

### **3. ND Reality Validation**  
ND ensures the snapshot is structurally coherent.

### **4. ND Normalization**  
ND shapes raw data into sealed‑domain inputs.

### **5. ND Readiness Gate**  
ND ensures the D world has everything required for deterministic legality evaluation.

### **6. D Legality Classification**  
D decides legality.  
D does not execute.  
D does not mutate.  
D does not touch the world.

### **7. ND Execution or ND Finalization**  
ND resumes after D returns its classification.  
ND performs all real‑world effects.  
ND handles all nondeterminism.  
ND ensures atomicity.

Every baton pass is explicit.

---

# 3. Why ND and D Must Be Disjoint

ND is the nondeterministic world:

- networks  
- databases  
- clocks  
- outages  
- concurrency  
- external dependencies  

D is the deterministic world:

- sealed domains  
- legality  
- business rules  
- invariants  
- pure logic  

ND prepares.  
D decides.  
ND executes.

They must never mix.

These pipeline pages enforce this doctrine.

---

# 4. Structure of the Pipeline Case Folder

The folder contains:

```
05a_intro_pipeline_cases.md
05b_pipeline_foreign_account_invalid.md
05c_pipeline_authorized_transfer.md
05d_pipeline_fraud_block_invalid.md
05e_pipeline_insufficient_funds_invalid.md
05f_pipeline_nd_execution_failure.md
05g_summary_pipeline_cases.md
```

Each page is sovereign.  
Each page starts from ND ingress.  
Each page ends with ND finalization.  
Each page shows the full baton geometry.

---

# 5. How to Read These Pages

Read each page as a **complete pipeline**, not a fragment.

Each page:

- begins at ingress  
- proceeds through ND stages  
- hands the baton to D  
- receives D’s classification  
- resumes ND execution or ND finalization  
- ends cleanly  

No page assumes prior steps.  
No page hides baton passes.  
No page mixes ND and D responsibilities.

---

# 6. What the Reader Should Expect

By the end of the pipeline case set, the reader will understand:

- how ND and D cooperate without mixing  
- how legality is determined deterministically  
- how execution is performed nondeterministically  
- how atomicity is preserved  
- how sealed‑domain invariants are protected  
- how ND failure is safe  
- how deterministic systems avoid corruption  
- how Prax Junior achieves certifiable behavior  

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05a_intro_pipeline_cases.md>
