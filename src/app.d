module app;

import std.stdio  : writeln;
import std.format : format;

import utility.prompt_for_int : prompt_for_int, PromptResult;

void main()
{
    PromptResult num = prompt_for_int("Enter numerator");
    if (!num.hasValue)
    {
        writeln("User quit. Closing app.");
        return;
    }

    PromptResult den = prompt_for_int("Enter denominator");
    if (!den.hasValue)
    {
        writeln("User quit. Closing app.");
        return;
    }

    writeln("Numerator:   ", format("%,d", num.value));
    writeln("Denominator: ", format("%,d", den.value));

    writeln("Done.");
}
