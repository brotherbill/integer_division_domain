// Start of Document /</repo:integer_division_domain/src/domain/invalid.d/>

module domain.invalid;

import domain.fail_catalog : Fail_Code, fail_message;

// ------------------------------------------------------------
// Invalid Domain
// ------------------------------------------------------------
// Meaning rule:
//   - Invalid represents specimens that cannot enter any valid domain.
//   - Invalid is meaningful if and only if it carries a numbered fail code.
//   - The message is derived from the SSOT fail catalog.
//   - No prose, no diagnostics, no developer commentary.
//   - Invalid intentionally does not capture the source value that failed.
//     Raw, malformed, or out-of-range values are confined to the classifier
//     boundary and discarded there. This prevents leaking unvalidated data
//     into sealed domains, avoids partial meaning ("invalid but inspectable"),
//     and keeps the VM from branching on garbage. Invalid carries only the
//     meaning of failure (code + message), never the failing element itself.

struct Invalid
{
    int    code;
    string message;

    // ------------------------------------------------------------
    // Constructor (domain vending)
    // ------------------------------------------------------------
    static @safe pure nothrow @nogc
    Invalid make (in Fail_Code a_code)
    {
        return Invalid (code: cast(int) a_code,
                        message: fail_message (a_code));
    }

    // ------------------------------------------------------------
    // Invariant
    // ------------------------------------------------------------
    invariant
    {
        // Invalid is meaningful if and only if message is non-empty.
        assert (message.length != 0,
                "invalid_message_must_not_be_empty");
    }
}

// End of Document /</repo:integer_division_domain/src/domain/invalid.d/>
