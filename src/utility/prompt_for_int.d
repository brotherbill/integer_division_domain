module utility.prompt_for_int;

import std.algorithm.searching : canFind;
import std.conv   : to;
import std.format : format;
import std.stdio  : readln, write, writeln;
import std.string : strip;

struct PromptResult
{
    bool hasValue;  // true if the user provided a valid integer, false if they quit
    int  value;     // The integer value provided by the user, valid only if hasValue is true.  0 otherwise.
}

private bool tryParseInt(string input, out int result)
{
    input = input.strip;

    if (input.canFind('.'))
        return false;   // Reject floating-point numbers

    // Remove commas and underscores from the input
    string cleaned;
    foreach (c; input)
    {
        if (c == ',' || c == '_')
            continue;
        cleaned = cleaned ~ c;
    }

    try
    {
        result = to!int(cleaned);
        return true;  // Successfully parsed an integer, in range of int
    }
    catch (Exception)
    {
        return false;  // Parsing failed, likely due to out-of-range value or garbage input
    }
}

PromptResult prompt_for_int(string prompt)
{
    while (true)
    {
        write(prompt, " (or type 'q' to quit): ");

        string input = readln().strip;

        if (input == "q" || input == "Q")
            return PromptResult(false, 0);  // User chose to quit

        int parsed;
        if (tryParseInt(input, parsed))
            return PromptResult(true, parsed);

        writeln("Invalid integer. Type 'q' to quit or try again.");
    }
}
