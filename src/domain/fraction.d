// Start of Document /</repo:integer_division_domain/src/domain/fraction.d/>

module domain.fraction;

struct Fraction
{
    int numerator;
    int denominator;

    static @safe pure nothrow @nogc
    Fraction make (in int a_numerator, in int a_denominator)
    {
        return Fraction (a_numerator, a_denominator);
    }

    @safe pure nothrow @nogc
    int quotient () const
    {
        return numerator / denominator;
    }

    @safe pure nothrow @nogc
    int remainder () const
    {
        return numerator % denominator;
    }

    invariant 
    {
        assert (denominator != 0, "Denominator must not be zero.");
    }
}

// End of Document /</repo:integer_division_domain/src/domain/fraction.d/>
