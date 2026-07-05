// Start of Document /</repo:integer_division_domain/src/domain/classifier.d/>

module domain.classifier;

import domain.integer_pairs : Integer_Pairs;
import domain.fraction      : Fraction;
import domain.invalid       : Invalid;
import domain.classified    : Classified;

@safe pure nothrow @nogc
Classified classify (in Integer_Pairs a_pair)
{
    Classified result;

    if (a_pair.y != 0)
    {
        result.kind = Classified.Kind.Fraction;
        result.fraction = Fraction.make (a_numerator: a_pair.x, a_denominator: a_pair.y);
    }
    else
    {
        result.kind = Classified.Kind.Invalid;
        result.invalid = Invalid.make (a_message: "Denominator cannot be zero.");
    }

    return result;
}
// End of Document /</repo:integer_division_domain/src/domain/classifier.d/>
