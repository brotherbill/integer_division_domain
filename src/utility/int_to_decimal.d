// Start of Document /</repo:integer_division_domain/src/utility/int_to_decimal.d/>

module utility.int_to_decimal;

// ------------------------------------------------------------
// Purpose:
//   UL-grade integer-to-decimal formatter.
//   - Pure, deterministic, @nogc conversion of an int into a caller-owned buffer.
//   - No allocations, no Phobos, no diagnostics beyond assert.
//   - Not a domain, not a classifier, not part of meaning geometry.
//   - Used only for decimal rendering in VM and utility layers.

@safe pure nothrow @nogc
size_t int_to_decimal(in int value, char[] buf)
{
    // Handle zero explicitly
    if (value == 0)
    {
        assert(buf.length > 0);
        buf[0] = '0';
        return 1;
    }

    const bool negative = value < 0;
    uint v = negative ? cast(uint)(-value) : cast(uint)value;

    size_t pos = 0;

    // Write digits in reverse order
    while (v > 0)
    {
        assert(pos < buf.length);
        const uint digit = v % 10;
        buf[pos] = cast(char)('0' + digit);
        pos += 1;
        v /= 10;
    }

    // Add minus sign if needed
    if (negative)
    {
        assert(pos < buf.length);
        buf[pos] = '-';
        pos += 1;
    }

    // Reverse digits
    for (size_t i = 0; i < pos / 2; ++i)
    {
        const char tmp = buf[i];
        buf[i] = buf[pos - 1 - i];
        buf[pos - 1 - i] = tmp;
    }

    return pos;
}

// End of Document /</repo:integer_division_domain/src/utility/int_to_decimal.d/>
