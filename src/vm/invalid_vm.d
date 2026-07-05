module vm.invalid_vm;

import domain.classified : Classified;
import domain.invalid    : Invalid;

@safe pure nothrow @nogc
size_t invalid_vm (Classified input, scope char[] buffer)
{
    const Invalid inv = input.invalid;

    // Build the message we want to write
    enum prefix = "error: ";
    const size_t needed = prefix.length + inv.message.length;

    // Assert that the buffer is large enough
    assert(needed <= buffer.length,
           "invalid_vm: buffer too small for error message");

    // Write prefix
    size_t pos = 0;
    foreach (i, c; prefix)
    {
        buffer[pos] = c;
        pos = pos + 1;
    }

    // Write message
    foreach (i, c; inv.message)
    {
        buffer[pos] = c;
        pos = pos + 1;
    }

    return pos; // number of bytes written
}
