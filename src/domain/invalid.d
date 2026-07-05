// Start of Document /</repo:integer_division_domain/src/domain/invalid.d/>

module domain.invalid;

struct Invalid
{
    string message;

    static @safe pure nothrow @nogc
    Invalid make (in string a_message)
    {
        return Invalid (a_message);   
    }

    invariant 
    {
        assert (0 < message.length, "Invalid message must not be empty.");
    }
}

// End of Document /</repo:integer_division_domain/src/domain/invalid.d/>
