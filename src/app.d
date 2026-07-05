// Start of Document /</repo:integer_division_domain/src/app.d/>

module app;

import std.stdio  : writeln;
import std.format : format;

import utility.prompt_for_int : prompt_for_int, Prompt_Result;

import domain.integer_pairs : Integer_Pairs;
import domain.classifier    : classify;
import vm.fraction_vm       : fraction_vm;
import vm.invalid_vm        : invalid_vm;

// main has no attributes because it performs I/O
void main ()
{
    Prompt_Result num = prompt_for_int ("Enter numerator");
    if (!num.has_value)
    {
        writeln ("User quit. Closing app.");
        return;
    }

    Prompt_Result den = prompt_for_int ("Enter denominator");
    if (!den.has_value)
    {
        writeln ("User quit. Closing app.");
        return;
    }

    Integer_Pairs input = Integer_Pairs (x: num.value,
                                         y: den.value);

    auto classified = classify (input);

    final switch (classified.kind)
    {
        case typeof (classified.kind).Fraction:
        {
            char[128] buf;
            size_t n = fraction_vm (classified, buf[]);
            writeln (buf[0 .. n]);
            break;
        }

        case typeof (classified.kind).Invalid:
        {
            char[128] buf;
            size_t n = invalid_vm (classified, buf[]);
            writeln (buf[0 .. n]);
            break;
        }
    }

    writeln ("Done.");
}

// End of Document /</repo:integer_division_domain/src/app.d/>