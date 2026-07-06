// Start of Document /</repo:integer_division_domain/src/domain/classifier.d/>

module domain.classifier;

import domain.integer_pairs          : Integer_Pairs;
import domain.positive_integer_pairs : Positive_Integer_Pairs;

import domain.fraction   : Fraction;
import domain.invalid    : Invalid;
import domain.classified : Classified;
import domain.fail_catalog : Fail_Code;   // <-- Required import

// ------------------------------------------------------------
// Classifier for Integer_Pairs
// ------------------------------------------------------------
// Domain rule:
//   - A denominator equal to zero produces an Invalid specimen.
//   - A denominator not equal to zero produces a Fraction specimen.
//   - Fraction is meaningful if and only if kind == Kind.Fraction.
//   - Invalid  is meaningful if and only if kind == Kind.Invalid.

@safe pure nothrow @nogc
Classified classify (in Integer_Pairs a_pair)
{
    Classified result;

    // Neutral initialization: no accidental meaning.
    result.kind = Classified.Kind.Invalid;

    // Partition based solely on equality, respecting banned operators.
    if (a_pair.y == 0)
    {
        result.kind = Classified.Kind.Invalid;
        result.invalid = Invalid.make (Fail_Code.zero_denominator);
    }
    else
    {
        result.kind = Classified.Kind.Fraction;
        result.fraction = Fraction.make (
            a_numerator:   a_pair.x,
            a_denominator: a_pair.y
        );
    }

    return result;
}

// ------------------------------------------------------------
// Classifier for Positive_Integer_Pairs
// ------------------------------------------------------------
// Domain rule:
//   - Positive_Integer_Pairs guarantees that the denominator is a strictly
//     positive integer by construction (no relational operators required).
//   - Therefore: classification is Fraction if and only if kind == Kind.Fraction.
//   - Invalid is impossible by construction.

@safe pure nothrow @nogc
Classified classify(in Positive_Integer_Pairs a_pair)
{
    Classified result;

    // Only one meaningful partition exists for this domain.
    result.kind = Classified.Kind.Fraction;

    result.fraction = Fraction.make (
        a_numerator:   a_pair.x,
        a_denominator: a_pair.y
    );

    return result;
}

// End of Document /</repo:integer_division_domain/src/domain/classifier.d/>
