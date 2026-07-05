module domain.classified;

import domain.fraction : Fraction;
import domain.invalid  : Invalid;

// To support @safe, we need to initialize the struct with default values and not use unions internally.
// This is because invalid has a string, with ptr, and @safe doesn't allow unions with non-trivial types.  
// So we use a struct with two fields, and only one is valid at a time, depending on the kind.
struct Classified
{
    enum Kind { Fraction, Invalid }

    Kind kind;

    Fraction fraction;   // always valid when kind == Fraction
    Invalid  invalid;    // always valid when kind == Invalid
}
