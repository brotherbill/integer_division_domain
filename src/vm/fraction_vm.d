// Start of Document /</repo:integer_division_domain/src/vm/fraction_vm.d/>

module vm.fraction_vm;

import domain.classified      : Classified;
import domain.fraction        : Fraction;
import utility.int_to_decimal : int_to_decimal;

enum prefixQ = "quotient: ";
enum prefixR = ", remainder: ";

// ------------------------------------------------------------
// Purpose:
//   VM-level renderer for Fraction inside a Classified value.
//   Produces a single, human-readable message of the form:
//
//     "quotient: 1_234, remainder: 56"
//
//   Invariants:
//   - @safe, pure, nothrow, @nogc.
//   - No allocations, no Phobos beyond utility dependencies.
//   - Not a domain, not a classifier, not part of meaning geometry.
//   - Operates only on already-classified Fraction values.
//   - Uses caller-owned buffer; asserts if buffer is too small.
// ------------------------------------------------------------

@safe pure nothrow @nogc
size_t fraction_vm (in Classified a_classified, scope char[] a_buf)
{
    const Fraction f = a_classified.fraction;
    return buildFractionMessage (f, a_buf);
}

// ------------------------------------------------------------
// writeMessageComponents
//   Append a prefix and a digit slice into the buffer.
//   This is a small VM helper, not a domain utility.
// ------------------------------------------------------------

@safe pure nothrow @nogc
size_t writeMessageComponents (
    scope char[]        a_buf,
    in    size_t        a_pos,
    in    string        a_prefix,
    scope const(char)[] a_digits,
    in    size_t        a_dlen)
{
    size_t pos = a_pos;

    foreach (c; a_prefix)
    {
        assert (pos < a_buf.length);
        a_buf[pos] = c;
        pos = pos + 1;
    }

    foreach (i; 0 .. a_dlen)
    {
        assert (pos < a_buf.length);
        a_buf[pos] = a_digits[i];
        pos = pos + 1;
    }

    return pos;
}

// ------------------------------------------------------------
// add_underbars
//   Insert underbars into a digit buffer.
//   Example: "1000" → "1_000"
//
//   Assumes:
//   - a_src[0 .. a_len] contains only digits.
//   - a_dst has sufficient capacity.
//   - No sign characters; sign handled by int_to_decimal().
//
//   This is a VM-level formatting helper, not a domain rule.
// ------------------------------------------------------------

@safe pure nothrow @nogc
size_t add_underbars (scope const(char)[] a_src, size_t a_len, scope char[] a_dst)
{
    size_t firstGroup = a_len % 3;
    if (firstGroup == 0)
    {
        firstGroup = 3;
    }

    size_t pos = 0;
    size_t i   = 0;

    for (; i < firstGroup; ++i)
    {
        assert (pos < a_dst.length);
        a_dst[pos] = a_src[i];
        pos = pos + 1;
    }

    while (i < a_len)
    {
        assert (pos < a_dst.length);
        a_dst[pos] = '_';
        pos = pos + 1;

        assert (pos < a_dst.length);
        a_dst[pos] = a_src[i];
        pos = pos + 1;
        i = i + 1;

        if (i < a_len)
        {
            assert (pos < a_dst.length);
            a_dst[pos] = a_src[i];
            pos = pos + 1;
            i = i + 1;
        }

        if (i < a_len)
        {
            assert (pos < a_dst.length);
            a_dst[pos] = a_src[i];
            pos = pos + 1;
            i = i + 1;
        }
    }

    return pos;
}

// ------------------------------------------------------------
// buildFractionMessage
//   Render a Fraction into the caller-owned buffer as:
//
//     "quotient: <q>, remainder: <r>"
//
//   Steps:
//   - Convert quotient and remainder to raw decimal digits.
//   - Apply underbar formatting to each.
//   - Verify buffer capacity.
//   - Write prefix + formatted digits for both components.
// ------------------------------------------------------------

@safe pure nothrow @nogc
size_t buildFractionMessage (const Fraction f, scope char[] buf)
{
    char[32] qraw;
    char[32] rraw;

    const size_t qrawLen = int_to_decimal (f.quotient,  qraw[]);
    const size_t rrawLen = int_to_decimal (f.remainder, rraw[]);

    char[32] qfmt;
    char[32] rfmt;

    const size_t qlen = add_underbars (qraw[], qrawLen, qfmt[]);
    const size_t rlen = add_underbars (rraw[], rrawLen, rfmt[]);

    const size_t needed =
        prefixQ.length + qlen +
        prefixR.length + rlen;

    assert (needed <= buf.length, "fraction_vm: buffer too small");

    size_t pos = 0;

    pos = writeMessageComponents (buf, pos,
                                  prefixQ,
                                  qfmt[], qlen);

    pos = writeMessageComponents (buf, pos,
                                  prefixR,
                                  rfmt[], rlen);

    return pos;
}

// End of Document /</repo:integer_division_domain/src/vm/fraction_vm.d/>
