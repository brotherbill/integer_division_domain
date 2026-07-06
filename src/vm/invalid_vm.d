// Start of Document /</repo:integer_division_domain/src/vm/invalid_vm.d/>

module vm.invalid_vm;

import domain.classified : Classified;
import domain.invalid    : Invalid;

// ------------------------------------------------------------
// Purpose:
//   VM-level renderer for Invalid inside a Classified value.
//   Produces a deterministic, human-readable error message:
//
//       "error: <message>"
//
//   Invariants:
//   - @safe, pure, nothrow, @nogc.
//   - No allocations, no Phobos beyond domain imports.
//   - Not a domain, not a classifier, not part of meaning geometry.
//   - Operates only on already-classified Invalid values.
//   - Uses caller-owned buffer; asserts on insufficient capacity.
//   - Every write is assert-guarded to enforce UL-grade safety.
// ------------------------------------------------------------

@safe pure nothrow @nogc
size_t invalid_vm(in Classified classified, scope char[] buffer)
{
    const Invalid inv = classified.invalid;

    enum prefix = "error: ";

    // Total bytes required for prefix + message.
    const size_t needed = prefix.length + inv.message.length;

    // VM invariant: caller must supply a buffer large enough.
    assert(needed <= buffer.length,
           "invalid_vm: buffer too small for error message");

    size_t pos = 0;

    // Write prefix.
    foreach (c; prefix)
    {
        assert(pos < buffer.length);
        buffer[pos] = c;
        pos = pos + 1;
    }

    // Write message.
    foreach (c; inv.message)
    {
        assert(pos < buffer.length);
        buffer[pos] = c;
        pos = pos + 1;
    }

    // Number of bytes written.
    return pos;
}

// End of Document /</repo:integer_division_domain/src/vm/invalid_vm.d/>
