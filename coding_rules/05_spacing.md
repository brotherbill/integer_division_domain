###### Start of Document \<repo:integer_division_domain/coding_rules/05_spacing.md\>

# 05 — Spacing Discipline

## Purpose
Spacing is part of Prax Junior’s cognitive geometry.  
It improves readability, prevents drift, and ensures deterministic formatting.  
Spacing rules are mechanical and must be followed exactly.

---

# 1. Space Before Parentheses in Calls and Declarations
All function **calls** and **declarations** must have a space before the opening parenthesis.

Correct:
assert (true);
compute_sum (a_x, a_y);
void compute_sum (in int a_x, in int a_y);

Incorrect:
assert(true);
compute_sum(a_x, a_y);
void compute_sum(in int a_x, in int a_y);

This rule applies uniformly to:
- calls  
- declarations  
- constructors  
- static makers  
- domain operations  
- VM operations  

There is no exception.

---

# 2. Space Before Parentheses in Control Flow
Control flow keywords must also have a space before the opening parenthesis.

Correct:
if (a < b)
while (done == false)
for (i = 0; i < n; i = i + 1)

Incorrect:
if(a < b)
while(done == false)
for(i = 0; i < n; i = i + 1)

---

# 3. Space Around Operators
Binary operators must have one space on each side.

Correct:
a = b + c;
x = y < z;
total = a_value + b_value;

Incorrect:
a=b+c;
x=y<z;
total=a_value+b_value;

Unary operators do not receive surrounding spaces.

Correct:
i = i + 1;
j = -k;

Incorrect:
j = - k;

---

# 4. No Extra Spaces
Spacing must be exact.  
No additional spaces may be inserted.

Incorrect:
assert  (true);
compute_sum  (a_x, a_y);
if  (a < b)

Spacing must be:
- single  
- deterministic  
- consistent  

---

# 5. Platoon Formation
When aligning multiple variable declarations, spacing must be consistent.

Rule:
**There must be 0 or 1 spaces between the longest name and its operator or value.**

Correct:
int    a_count   = 0;
double a_average = 0.0;
bool   a_ready   = true;

Incorrect:
int     a_count        = 0;      // too many spaces
double  a_average=0.0;           // too many spaces in gap 1, missing required spacing
bool    a_ready    =    true;    // inconsistent spacing

Platoon formation is optional but recommended for clarity.

## Right‑Adjusted Numbers, Left‑Adjusted Words
When platoon formation is used:

- names are left‑adjusted  
- operators align in the same column  
- numbers are right‑adjusted  
- decimal points align in the same column  
- strings / words remain left‑adjusted  

Correct (numbers right‑adjusted, words left‑adjusted):
int    a_count =   25;
int    b_count =    7;
int    c_count = -300;
string name    = "Bo";

Correct (decimal alignment):
double a_x =   3.14;
double b_x =  12.7;
double c_x =  -0.5;

Incorrect:
double a_x = 3.14;     // misaligned decimal
double b_x = 12.7;     // misaligned decimal

---

# 6. Spacing in Imports
Import spacing must be exact and visible.  
Examples must not rely on invisible trailing spaces.

Correct (platoon formation):
import std.stdio  : writeln;
import std.string : toUpper;

Incorrect (jagged columns):
import std.stdio : writeln;
import std.string : toUpper;

Trailing spaces are forbidden, but examples must never rely on invisible differences.

---

# 7. Summary

- Calls and declarations both get a space before parentheses.  
- Control flow gets a space before parentheses.  
- Operators get one space on each side.  
- Unary operators get no surrounding spaces.  
- No extra spaces anywhere.  
- Platoon formation: 0 or 1 spaces after longest name.  
- Numbers right‑adjusted, words left‑adjusted.  
- Decimal points align.  
- Imports: flat, itemized, visible spacing only.  
- No invisible trailing-space examples.  
- Spacing is deterministic and sealed-domain.

###### End of Document \<repo:integer_division_domain/coding_rules/05_spacing.md\>
