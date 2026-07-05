// Start of Document /</repo:integer_division_domain/src/domain/integer_pairs.d/>

module domain.integer_pairs;

struct Integer_Pairs
{
    int x;
    int y;

    @safe pure nothrow @nogc
    static Integer_Pairs make (in int a_x, in int a_y)
    {
        return Integer_Pairs (x: a_x, y: a_y);
    }

    invariant 
    {
        // No invariants.  All integer pairs are valid.
    }
}

// End of Document /</repo:integer_division_domain/src/domain/integer_pairs.d/>
