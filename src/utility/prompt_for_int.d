// Start of Document /</repo:integer_division_domain/src/utility/prompt_for_int.d/>

module utility.prompt_for_int;

import std.stdio : readln, write, writeln;
import std.string : strip;

@safe pure nothrow @nogc
bool try_parse_int (in string input, out int result)
{
    // Trim whitespace manually (no strip)
    size_t start = 0;
    size_t end   = input.length;

    while (start < end && (input[start] == ' ' || input[start] == '\t'))
    {
        start = start + 1;
    }

    while (start < end && (input[end - 1] == ' ' || input[end - 1] == '\t'))
    {
        end = end - 1;
    }

    if (start == end)
    {
        return false;
    }

    bool   negative = false;
    size_t i        = start;

    if (input[i] == '-')
    {
        negative = true;
        i = i + 1;
        if (i == end)
        {
            return false;
        }
    }
    else if (input[i] == '+')
    {
        i = i + 1;
        if (i == end)
        {
            return false;
        }
    }

    int value = 0;

    for (; i < end; ++i)
    {
        char c = input[i];

        // Accept commas and underscores
        if (c == ',' || c == '_')
        {
            continue;
        }

        // Reject anything except digits
        if (c < '0' || c > '9')
        {
            return false;
        }
        int digit = c - '0';

        // Overflow check
        int newValue = value * 10 + digit;
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
