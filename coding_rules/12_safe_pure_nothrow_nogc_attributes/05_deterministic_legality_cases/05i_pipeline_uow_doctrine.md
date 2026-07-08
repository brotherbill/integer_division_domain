###### Start of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05i_pipeline_uow_doctrine.md>

# 05i — Why Each Baton Pass Is a Separate UOW
## The Doctrine of Granular, Deterministic, Machine‑Grade Units of Work

This page explains **why every baton pass in the ND→D→ND pipeline is its own Unit of Work (UOW)**, and **why the early ND stages must never be collapsed into a monolithic step**.

### Abbreviations  
**ND** — *Non‑Deterministic world*: networks, databases, clocks, outages, concurrency, external dependencies.*  
**D** — *Deterministic world*: sealed‑domain legality, business rules, invariants, pure logic.*

This doctrine is required for:

- sealed‑domain clarity  
- certifiable correctness  
- nondeterministic isolation  
- drift‑proof behavior  
- auditor‑grade replayability  
- atomicity guarantees  
- deterministic legality readiness  

Each baton pass is sovereign.  
Each baton pass is atomic.  
Each baton pass is a complete UOW.

---

# 1. What a UOW Is  
A **Unit of Work (UOW)** is:

- a small, self‑contained task  
- with a clear start  
- a clear end  
- a clear baton handoff  
- and no hidden dependencies  

A UOW must be:

- **restartable**  
- **auditable**  
- **deterministic** (in D)  
- **nondeterministic‑safe** (in ND)  

A UOW is not a “step.”  
It is a **sealed correctness boundary**.

---

# 2. Why Each Baton Pass Must Be Its Own UOW  
The ND→D→ND pipeline is not a workflow.  
It is a **world‑boundary geometry**.

Each baton pass crosses:

- a nondeterministic boundary  
- a deterministic boundary  
- a sealed‑domain boundary  
- a correctness boundary  
- an atomicity boundary  

These boundaries cannot be merged.

### If you merge boundaries, you lose:

- ND/D separation  
- sealed‑domain legality  
- nondeterministic isolation  
- atomicity guarantees  
- drift‑proof behavior  
- audit clarity  
- certifiability  

Each baton pass is a UOW because **each baton pass is a world change**.

---

# 3. Why Early ND Stages Cannot Be Collapsed  
ND ingress, ND acquisition, ND reality validation, ND normalization, and ND readiness gate are **five different nondeterministic worlds**.

They must not be collapsed because:

### **1. They depend on different external systems**  
- ingress: operator intent or external trigger  
- acquisition: databases, networks  
- validation: structural coherence  
- normalization: sealed‑domain shaping  
- readiness: completeness guarantees  

Collapsing them fuses nondeterministic dependencies.

### **2. They have different failure modes**  
- ingress failure  
- acquisition outage  
- validation mismatch  
- normalization error  
- readiness incompleteness  

A monolith hides these failures.

### **3. They produce different baton shapes**  
Each ND stage transforms the baton.  
A monolith hides baton geometry.

### **4. They must be restartable independently**  
If ND acquisition fails, you restart acquisition — not ingress.  
If ND normalization fails, you restart normalization — not acquisition.

A monolith forces full restart and destroys atomicity guarantees.

---

# 4. Why Automated Systems Require Granular UOWs  
Automated ND→D→ND systems require **granular Units of Work** because each baton pass crosses a **distinct nondeterministic or deterministic world boundary**. These boundaries must be isolated to prevent correctness collapse.

Granular UOWs are required for:

- nondeterministic isolation  
- atomic baton transformation  
- deterministic legality readiness  
- precise failure classification  
- replayability  
- drift‑proof geometry  
- sealed‑domain correctness  

---

### **4.1. Each ND stage touches different nondeterministic dependencies**  
Automated systems interact with:

- networks  
- databases  
- clocks  
- caches  
- external services  
- concurrency primitives  

Each ND stage touches a different subset of nondeterministic dependencies.  
Collapsing them fuses nondeterministic worlds and destroys isolation.

---

### **4.2. Each ND stage has distinct failure modes**  
Machines must classify failures precisely:

- acquisition failure  
- validation failure  
- normalization failure  
- readiness failure  

A monolithic ND block hides failure boundaries and prevents deterministic classification.

---

### **4.3. Each baton transformation must be atomic**  
Automated systems require atomic baton shaping:

- ingress → acquisition  
- acquisition → validation  
- validation → normalization  
- normalization → readiness  

If these transformations are fused, atomicity is lost and partial baton mutation becomes possible.

---

### **4.4. Automated replay requires UOW boundaries**  
Replay engines must be able to:

- replay ND ingress  
- replay ND acquisition  
- replay ND validation  
- replay ND normalization  
- replay ND readiness  
- replay D legality  
- replay ND execution  

Replay is impossible if early ND stages are fused.

---

### **4.5. ND→D→ND geometry requires discrete vertices**  
The pipeline is a graph:

```
ND1 → ND2 → ND3 → ND4 → ND5 → D → ND6 → ND7
```

Each vertex is a correctness boundary.  
Collapsing vertices collapses geometry.

---

### **4.6. Automated systems require deterministic baton shape at each boundary**  
Machines must verify baton shape at each UOW boundary:

- completeness  
- coherence  
- sealed‑domain compatibility  
- deterministic legality readiness  

A monolith hides baton shape evolution.

---

# 5. Why Auditors Require Granular UOWs  
Auditors must see:

- each baton pass  
- each world boundary  
- each sealed‑domain input  
- each nondeterministic dependency  
- each legality decision  
- each execution attempt  
- each failure classification  
- each retirement event  

A monolithic ND block hides:

- nondeterministic dependencies  
- correctness boundaries  
- atomicity guarantees  
- failure modes  
- replayability geometry  

Granular UOWs produce **auditor‑grade truth**.

---

# 6. Why Certifiability Requires Granular UOWs  
Safety‑critical systems (finance, aviation, medical, industrial) require:

- deterministic legality  
- nondeterministic isolation  
- atomic execution  
- sealed domains  
- replayability  
- drift‑proof behavior  

Certifiers must see:

- ND ingress UOW  
- ND acquisition UOW  
- ND validation UOW  
- ND normalization UOW  
- ND readiness UOW  
- D legality UOW  
- ND execution UOW  
- ND finalization UOW  

A monolith cannot be certified.

---

# 7. Why Geometry Requires Granular UOWs  
The ND→D→ND pipeline is a **geometric structure**, not a workflow.

Each baton pass is a vertex.  
Each UOW is an edge.  
The pipeline is a graph.

If you collapse edges:

- geometry collapses  
- correctness collapses  
- determinism collapses  
- nondeterministic isolation collapses  
- sealed‑domain clarity collapses  

Granular UOWs preserve geometry.

---

# 8. Summary  
Each baton pass is a UOW because:

- each baton pass crosses a world boundary  
- each baton pass has unique nondeterministic dependencies  
- each baton pass has unique failure modes  
- each baton pass must be restartable  
- each baton pass must be auditable  
- each baton pass must be certifiable  
- each baton pass must preserve sealed‑domain clarity  
- each baton pass must preserve drift‑proof behavior  

Monolithic early ND steps destroy:

- correctness  
- safety  
- auditability  
- certifiability  
- geometry  
- atomicity guarantees  

Granular UOWs are not optional.  
They are **the doctrine**.

---

###### End of Document <repo:integer_division_domain/coding_rules/12_safe_pure_nothrow_nogc_attributes/05_deterministic_legality_cases/05i_pipeline_uow_doctrine.md>
