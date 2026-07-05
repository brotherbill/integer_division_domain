module domain.classifier;

import domain.integer_pairs : Integer_Pairs;
import domain.fraction      : Fraction;
import domain.invalid       : Invalid;
import domain.classified    : Classified;

@safe pure nothrow @nogc
Classified classify (Integer_Pairs input)
{
    Classified result;

    if (input.y != 0)
    {
        result.kind = Classified.Kind.Fraction;
        result.fraction = Fraction (numerator: input.x,
                                    denominator: input.y);
    }
    else
    {
        result.kind = Classified.Kind.Invalid;
        result.invalid = Invalid (message: "Denominator cannot be zero.");
    }

    return result;
}
