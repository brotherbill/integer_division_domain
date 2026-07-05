// Start of Document /</repo:integer_division_domain/src/domain/fraction.d/>

module domain.fraction;

struct Fraction
{
    int numerator;
    int denominator;

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
}

// End of Document /</repo:integer_division_domain/src/domain/fraction.d/>
