// Start of Document /</repo:integer_division_domain/src/domain/integer_pairs.d/>

module domain.integer_pairs;

// ------------------------------------------------------------
// Integer_Pairs Domain
// ------------------------------------------------------------
// Meaning rule:
//   - Integer_Pairs is the contender domain.
//   - All ordered pairs (x, y) of integers are meaningful.
//   - No invariants apply; every specimen is valid.
//   - Classification determines whether the specimen becomes
//     Fraction or Invalid in downstream domains.

struct Integer_Pairs
{
    int x;
    int y;

    // ------------------------------------------------------------
    // Constructor (domain vending)
    // ------------------------------------------------------------
    @safe pure nothrow @nogc
    static Integer_Pairs make (in int a_x, in int a_y)
    {
        return Integer_Pairs (x: a_x, y: a_y);
    }

    // ------------------------------------------------------------
    // Invariant
    // ------------------------------------------------------------
    invariant
    {
        // Integer_Pairs is meaningful if and only if (x, y) are integers.
        // This invariant is always satisfied; no constraints apply.
    }
}

// End of Document /</repo:integer_division_domain/src/domain/integer_pairs.d/>
