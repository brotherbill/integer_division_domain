// Start of Document /</repo:integer_division_domain/src/utility/prompt_for_int.d/>

module utility.prompt_for_int;

import std.stdio : readln, write, writeln;
import std.string : strip;

// UL-grade parser
@safe pure nothrow @nogc
bool try_parse_int(string input, out int result)
{
    size_t start = 0;
    size_t end   = input.length;

    while (start < end && (input[start] == ' ' || input[start] == '\t'))
        ++start;

    while (end > start && (input[end - 1] == ' ' || input[end - 1] == '\t'))
        --end;

    if (start == end)
        return false;

    bool negative = false;
    size_t i = start;

    if (input[i] == '-')
    {
        negative = true;
        ++i;
        if (i == end)
            return false;
    }
    else if (input[i] == '+')
    {
        ++i;
        if (i == end)
            return false;
    }

    int value = 0;

    for (; i < end; ++i)
    {
        char c = input[i];

        if (c < '0' || c > '9')
            return false;

        int digit = c - '0';

        int newValue = value * 10 + digit;
        if (newValue < value)
            return false;

        value = newValue;
    }

    result = negative ? -value : value;
    return true;
}

// ------------------------------------------------------------
// These MUST be in this module so app.d can import them
// ------------------------------------------------------------

struct Prompt_Result
{
    bool has_value;
    int  value;
};

Prompt_Result prompt_for_int(string prompt = "Enter an integer")
{
    while (true)
    {
        write(prompt, " (or type 'q' to quit): ");

        string input = readln().strip();

        if (input == "q" || input == "Q")
            return Prompt_Result(false, 0);

        int parsed;
        if (try_parse_int(input, parsed))
            return Prompt_Result(true, parsed);

        writeln("Invalid integer. Type 'q' to quit or try again.");
    }
}

// End of Document /</repo:integer_division_domain/src/utility/prompt_for_int.d/>
