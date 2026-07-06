// Start of Document /</repo:integer_division_domain/src/utility/prompt_for_int.d/>

module utility.prompt_for_int;

import std.stdio : readln, write, writeln;

// ------------------------------------------------------------
// Purpose:
//   UL-grade integer input utility for CLI programs.
//   - Provides deterministic parsing of user-supplied text into an int.
//   - No allocations beyond readln(), no Phobos helpers except I/O.
//   - No exceptions, no GC involvement, no diagnostics beyond assert.
//   - Not a domain, not a classifier, not part of meaning geometry.
//   - Used only in CLI-facing layers, never inside VM or domain code.
//
//   This module contains:
//     1. try_parse_int() — UL-grade parser for decimal integers.
//     2. Prompt_Result   — sealed struct for prompt_for_int() return.
//     3. prompt_for_int() — CLI loop that repeatedly prompts user.
//
//   Failure modes:
//     - try_parse_int() returns false for invalid input.
//     - prompt_for_int() returns has_value=false when user quits.
//     - No runtime error handling; correctness enforced by caller discipline.

// ------------------------------------------------------------
// UL-grade integer parser
// ------------------------------------------------------------

@safe pure nothrow @nogc
bool try_parse_int(in string input, out int result)
{
    // Manual whitespace trim (no strip).
    size_t start = 0;
    size_t end   = input.length;

    while (start < end &&
           (input[start] == ' ' || input[start] == '\t'))
    {
        start += 1;
    }

    while (start < end &&
           (input[end - 1] == ' ' || input[end - 1] == '\t'))
    {
        end -= 1;
    }

    // Empty after trimming → invalid.
    if (start == end)
    {
        return false;
    }

    bool negative = false;
    size_t i      = start;

    // Optional sign.
    const char first = input[i];
    if (first == '-')
    {
        negative = true;
        i = i + 1;
        if (i == end)
        {
            return false;
        }
    }
    else if (first == '+')
    {
        i = i + 1;
        if (i == end)
        {
            return false;
        }
    }

    int value = 0;

    // Parse digits, allowing commas and underscores.
    for (; i < end; i = i + 1)
    {
        const char c = input[i];

        if (c == ',' || c == '_')
        {
            continue; // Skip formatting characters.
        }

        // Reject non-digits.
        if (!('0' <= c && c <= '9'))
        {
            return false;
        }

        const int digit = c - '0';

        // Overflow check.
        const int newValue = (value * 10) + digit;
        if (newValue < value)
        {
            return false;
        }

        value = newValue;
    }

    result = negative ? -value : value;
    return true;
}

// ------------------------------------------------------------
// Prompt_Result — sealed return type for prompt_for_int()
// ------------------------------------------------------------

struct Prompt_Result
{
    bool has_value; // true → valid integer supplied
    int  value;     // meaningful only when has_value=true
}

// ------------------------------------------------------------
// CLI prompt loop
// ------------------------------------------------------------

Prompt_Result prompt_for_int(string prompt = "Enter an integer")
{
    while (true)
    {
        write(prompt, " (or type 'q' to quit): ");

        // readln() allocates; allowed only in CLI layer.
        string input = readln();

        // Manual trim of newline.
        if (input.length > 0 && input[$ - 1] == '\n')
        {
            input = input[0 .. $ - 1];
        }

        // Quit command.
        if (input == "q" || input == "Q")
        {
            return Prompt_Result(false, 0);
        }

        int parsed;
        if (try_parse_int(input, parsed))
        {
            return Prompt_Result(true, parsed);
        }

        writeln("Invalid integer. Type 'q' to quit or try again.");
    }
}

// End of Document /</repo:integer_division_domain/src/utility/prompt_for_int.d/>
