// Start of Document /</repo:integer_division_domain/src/utility/int_to_decimal.d/>

module utility.int_to_decimal;

// Return value is length of buffer used. If buffer is too small, the function will assert.
@safe pure nothrow @nogc
size_t int_to_decimal(in int value, char[] buf)
{
    // Handle zero explicitly
    if (value == 0)
    {
        assert(0 < buf.length);
        buf[0] = '0';
        return 1;
    }

    bool negative = value < 0;
    uint v = negative ? cast(uint)(-value) : cast(uint)value;  // Absolute value as unsigned integer

    size_t pos = 0;

    // Write digits in reverse order
    while (0 < v)
    {
        assert(pos < buf.length);
        buf[pos] = cast(char)('0' + (v % 10));
        pos = pos + 1;
        v = v / 10;
    }

    // Add minus sign if needed
    if (negative)
    {
        assert(pos < buf.length);
        buf[pos] = '-';
        pos = pos + 1;
    }

    // Reverse digits
    foreach (i; 0 .. pos / 2)
    {
        auto tmp = buf[i];
        buf[i] = buf[pos - 1 - i];
        buf[pos - 1 - i] = tmp;
    }

    return pos;
}

// End of Document /</repo:integer_division_domain/src/utility/int_to_decimal.d/>