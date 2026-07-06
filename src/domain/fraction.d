// Start of Document /</repo:integer_division_domain/src/domain/fraction.d/>

module domain.fraction;

import domain.fail_catalog : Fail_Code, fail_message;

// ------------------------------------------------------------
// Fraction Domain
// ------------------------------------------------------------
// Meaning rule:
//   - A Fraction specimen is meaningful if and only if denominator != 0.
//   - The classifier guarantees this invariant before construction.
//   - quotient() and remainder() rely on this meaning rule.
//   - No defensive checks appear here; correctness is by construction.

struct Fraction
{
    int numerator;
    int denominator;

    // ------------------------------------------------------------
    // Constructor (domain vending)
    // ------------------------------------------------------------
    static @safe pure nothrow @nogc
    Fraction make (in int a_numerator, in int a_denominator)
    {
        // Classifier ensures denominator != 0.
        return Fraction (numerator:   a_numerator,
                         denominator: a_denominator);
    }

    // ------------------------------------------------------------
    // Quotient (pure meaning)
    // ------------------------------------------------------------
    @safe pure nothrow @nogc
    int quotient () const
    {
        // Safe because denominator != 0 by invariant.
        return numerator / denominator;
    }

    // ------------------------------------------------------------
    // Remainder (pure meaning)
    // ------------------------------------------------------------
    @safe pure nothrow @nogc
    int remainder () const
    {
        // Safe because denominator != 0 by invariant.
        return numerator % denominator;
    }

    // ------------------------------------------------------------
    // Invariant (meaning invariant using SSOT fail message)
    // ------------------------------------------------------------
    invariant
    {
        // Meaningful if and only if denominator != 0.
        assert (denominator != 0,
                fail_message (Fail_Code.zero_denominator));
    }
}

// End of Document /</repo:integer_division_domain/src/domain/fraction.d/>
