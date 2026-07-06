// Start of Document /</repo:integer_division_domain/src/domain/fail_catalog.d/>

module domain.fail_catalog;

// ------------------------------------------------------------
// Fail Catalog (SSOT for domain failures)
// ------------------------------------------------------------
// Purpose:
//   - This file defines the Single Source of Truth (SSOT) for all
//     domain failure codes used by meaning domains.
//   - Domain failures represent failures of specimen meaning,
//     discovered exclusively by the classifier.
//   - Each fail code has a stable, domain-neutral message.
//   - No business prose, no diagnostics, no commentary.
//   - Only failures that actually occur in classifier partitions
//     belong here.

enum Fail_Code : int
{
    zero_denominator         = 1,
    numerator_out_of_range   = 2,
    denominator_out_of_range = 3,
    // Add new codes only when classifier partitions require them.
}

@safe pure nothrow @nogc
string fail_message (in Fail_Code a_code)
{
    // SSOT: every numbered fail message lives here.
    // Messages are stable, domain-neutral identifiers.

    final switch (a_code)
    {
        case Fail_Code.zero_denominator:
            return "zero_denominator";

        case Fail_Code.numerator_out_of_range:
            return "numerator_out_of_range";

        case Fail_Code.denominator_out_of_range:
            return "denominator_out_of_range";
    }
}

// End of Document /</repo:integer_division_domain/src/domain/fail_catalog.d/>
