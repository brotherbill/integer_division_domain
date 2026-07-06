// Start of Document /</repo:integer_division_domain/src/domain/positive_integer_pairs.d/>

module domain.positive_integer_pairs;

// ------------------------------------------------------------
// Positive_Integer_Pairs Domain
// ------------------------------------------------------------
// Meaning rule:
//   - This is an enhanced domain: a strict subset of Integer_Pairs.
//   - A specimen is meaningful only when both x and y are strictly positive.
//   - No diagnostics or source values are captured. Raw values that fail
//     positivity are rejected at construction time and never stored.
//     This prevents leaking malformed data into sealed domains, avoids
//     partial meaning ("invalid but inspectable"), and ensures the VM
//     never branches on garbage. Only valid specimens enter the domain.

struct Positive_Integer_Pairs
{
    int x;
    int y;

    // ------------------------------------------------------------
    // Constructor (domain vending)
    // ------------------------------------------------------------
    static @safe pure nothrow @nogc
    Positive_Integer_Pairs make (in int a_x, in int a_y)
    {
        // Positivity expressed using allowed operators (<, <=).
        // No diagnostics; invariant failure is the only enforcement.
        assert (0 < a_x, "positive_integer_pairs_make_x_positive");
        assert (0 < a_y, "positive_integer_pairs_make_y_positive");

        return Positive_Integer_Pairs (x: a_x, y: a_y);
    }

    // ------------------------------------------------------------
    // Invariant
    // ------------------------------------------------------------
    invariant
    {
        // Meaningful if and only if both coordinates are strictly positive.
        assert (0 < x, "positive_integer_pairs_invariant_x_positive");
        assert (0 < y, "positive_integer_pairs_invariant_y_positive");
    }
}

// End of Document /</repo:integer_division_domain/src/domain/positive_integer_pairs.d/>
