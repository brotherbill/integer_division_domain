// Start of Document /</repo:integer_division_domain/src/vm/fraction_vm.d/>

module vm.fraction_vm;

import domain.classified : Classified;
import domain.fraction   : Fraction;
import utility.int_to_decimal : int_to_decimal;

enum prefixQ = "quotient: ";
enum prefixR = ", remainder: ";

@safe pure nothrow @nogc
size_t fraction_vm (in Classified a_classified, scope char[] a_buf)
{
    const Fraction f = a_classified.fraction;
    return buildFractionMessage(f, a_buf);
}

@safe pure nothrow @nogc
size_t writeMessageComponents(
    scope char[] a_buf,
    in    size_t a_pos,
    in    string a_prefix,
    scope const(char)[] a_digits,
    in    size_t a_dlen)
{
    size_t pos = a_pos;

    foreach (c; a_prefix)
    {
        a_buf[pos] = c;
        pos = pos + 1;
    }

    foreach (i; 0 .. a_dlen)
    {
        a_buf[pos] = a_digits[i];
        pos = pos + 1;
    }

    return pos;
}

/// Insert commas into a digit buffer.
/// Example: "1000" → "1,000"
@safe pure nothrow @nogc
size_t add_commas(scope const(char)[] a_src, size_t a_len, scope char[] a_dst)
{
    size_t firstGroup = a_len % 3;
    if (firstGroup == 0)
    {
        firstGroup = 3;
    }

    size_t pos = 0;
    size_t i   = 0;

    // First group (no comma)
    for (; i < firstGroup; ++i)
    {
        a_dst[pos] = a_src[i];
        pos = pos + 1;
    }

    // Remaining groups (comma + 3 digits)
    while (i < a_len)
    {
        a_dst[pos] = ',';
        pos = pos + 1;

        // FIX: increment i immediately after writing each digit

        // digit 1
        a_dst[pos] = a_src[i];
        pos = pos + 1;
        i = i + 1;

        // digit 2
        if (i < a_len)
        {
            a_dst[pos] = a_src[i];
            pos = pos + 1;
            i = i + 1;
        }

        // digit 3
        if (i < a_len)
        {
            a_dst[pos] = a_src[i];
            pos = pos + 1;
            i = i + 1;
        }
    }

    return pos;
}

@safe pure nothrow @nogc
size_t buildFractionMessage(const Fraction f, scope char[] buf)
{
    // Raw digit buffers
    char[32] qraw;
    char[32] rraw;

    size_t qrawLen = int_to_decimal(f.quotient,  qraw[]);
    size_t rrawLen = int_to_decimal(f.remainder, rraw[]);

    // Comma-formatted buffers
    char[32] qfmt;
    char[32] rfmt;

    size_t qlen = add_commas(qraw[], qrawLen, qfmt[]);
    size_t rlen = add_commas(rraw[], rrawLen, rfmt[]);

    const size_t needed =
        prefixQ.length + qlen +
        prefixR.length + rlen;

    assert(needed <= buf.length, "fraction_vm: buffer too small");

    size_t pos = 0;

    pos = writeMessageComponents(buf, pos,
                                 prefixQ,
                                 qfmt[], qlen);

    pos = writeMessageComponents(buf, pos,
                                 prefixR,
                                 rfmt[], rlen);

    return pos;
}

// End of Document /</repo:integer_division_domain/src/vm/fraction_vm.d/>
