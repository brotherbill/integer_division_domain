# vm

**vm** means **Vending Machine**.

A Vending Machine is a sealed, stateless D module that performs a single transformation from one domain shape to another. It has no authority, no lifecycle, no shared state, and no semantic burden. It is a pure tool.

In Prax, every vm is required to be:

- **@safe** — all memory operations are provably safe.
- **pure** — no access to global state; output depends only on input.
- **nothrow** — no exceptions are ever thrown.
- **@nogc** (when applicable) — no garbage collection allocations.
- **final switch** (when applicable) — all enum cases must be handled.
- **private imports** — only the symbols required for the transformation.
- **deterministic** — same input always produces same output.

A vm:

- accepts a legal domain input,
- produces a legal domain output or a formatted view,
- never performs I/O,
- never mutates external state,
- never throws exceptions,
- never allocates unless explicitly allowed,
- never interprets meaning beyond its sealed transformation.

Examples:

- `command_line_tokens_vm` — transforms raw CLI tokens into domain meaning.
- `fraction_vm` — transforms a Classified domain value into a CLI‑ready string.

The term **vm** is always interpreted as **Vending Machine**, never Virtual Machine.
