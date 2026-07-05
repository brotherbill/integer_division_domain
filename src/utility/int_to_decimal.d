module utility.int_to_decimal;

@safe pure nothrow @nogc
size_t int_to_dec(int value, char[] buf)
{
    // Handle zero explicitly
    if (value == 0)
    {
        assert(buf.length >= 1);
        buf[0] = '0';
        return 1;
    }

    bool negative = value < 0;
    uint v = negative ? cast(uint)(-value) : cast(uint)value;

    size_t pos = 0;

    // Write digits in reverse order
    while (v > 0)
    {
        assert(pos < buf.length);
        buf[pos++] = cast(char)('0' + (v % 10));
        v /= 10;
    }

    // Add minus sign if needed
    if (negative)
    {
        assert(pos < buf.length);
        buf[pos++] = '-';
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
