// Start of Document /</repo:integer_division_domain/src/vm/fraction_vm.d/>

module vm.fraction_vm;

import domain.classified : Classified;
import domain.fraction   : Fraction;
import utility.int_to_decimal : int_to_decimal;

@safe pure nothrow @nogc
size_t fraction_vm (Classified input, scope char[] buffer)
{
    const Fraction f = input.fraction;

    // Build the message components
    enum prefixQ = "quotient: ";
    enum prefixR = ", remainder: ";

    // Convert quotient and remainder to decimal text
    // We must do this manually to stay @nogc
    char[32] qbuf;
    char[32] rbuf;

    size_t qlen = int_to_decimal (f.quotient,  qbuf[]);
    size_t rlen = int_to_decimal (f.remainder, rbuf[]);

    // Compute total length needed
    const size_t needed =
        prefixQ.length + qlen +
        prefixR.length + rlen;

    // Assert buffer is large enough
    assert(needed <= buffer.length, "fraction_vm: buffer too small");

    size_t pos = 0;

    // Write prefixQ
    foreach (c; prefixQ)
    {
        buffer[pos] = c;
        pos = pos + 1;  
    }

    // Write quotient digits
    foreach (i; 0 .. qlen)
    {
        buffer[pos] = qbuf[i];
        pos = pos + 1;
    }

    // Write prefixR
    foreach (c; prefixR)
    {
        buffer[pos] = c;
        pos = pos + 1;
    }

    // Write remainder digits
    foreach (i; 0 .. rlen)
    {
        buffer[pos] = rbuf[i];
        pos = pos + 1;
    }

    return pos;
}

// End of Document /</repo:integer_division_domain/src/vm/fraction_vm.d/>
