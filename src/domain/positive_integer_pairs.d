// Start of Document /</repo:integer_division_domain/src/domain/positive_integer_pairs.d/>

module domain.positive_integer_pairs;

struct Positive_Integer_Pairs
{
    int x;
    int y;

    static @safe pure nothrow @nogc
    Positive_Integer_Pairs make(in int a_x, in int a_y)
    {
        // Enhanced-domain invariants
        assert(0 < a_x, "Positive_Integer_Pairs.make: 0 < a_x must be > 0");
        assert(0 < a_y, "Positive_Integer_Pairs.make: 0 < a_y must be > 0");

        return Positive_Integer_Pairs(x: a_x, y: a_y);
    }

    invariant
    {
        assert(x > 0, "Positive_Integer_Pairs: 0 < x");
        assert(y > 0, "Positive_Integer_Pairs: 0 < y");
    }
}

// End of Document /</repo:integer_division_domain/src/domain/positive_integer_pairs.d/>
