// Start of Document /</repo:integer_division_domain/src/app.d/>

module app;

import std.stdio                     : readln, writeln;
import std.string                    : strip;

import domain.classifier             : classify;
import domain.classified             : Classified;
import domain.integer_pairs          : Integer_Pairs;
import domain.positive_integer_pairs : Positive_Integer_Pairs;
import utility.prompt_for_int        : prompt_for_int, Prompt_Result;
import vm.fraction_vm                : fraction_vm;
import vm.invalid_vm                 : invalid_vm;

// ------------------------------------------------------------
// Purpose:
//   Top-level CLI application for the integer_division_domain.
//
// Layer:
//   - This file belongs to the UI layer.
//   - It performs I/O, so it has no UL attributes (@nogc, pure, etc.).
//   - It is allowed to allocate (readln), trim (strip), and print.
//
// Responsibilities:
//   - Prompt user for domain selection.
//   - Prompt user for numerator and denominator.
//   - Construct the correct contender domain object.
//   - Invoke the classifier.
//   - Dispatch to the correct VM renderer.
//   - Print the VM-rendered message.
//
// Invariants:
//   - All domain construction and classification is delegated to domain modules.
//   - All rendering is delegated to VM modules.
//   - UI layer performs no domain logic and no VM logic.
// ------------------------------------------------------------
void main ()
{
    writeln ("Choose domain:");
    writeln ("1 = integer_pairs (default)");
    writeln ("2 = positive_integer_pairs");

    string user_choice  = readln ().strip;
    bool   use_positive = (user_choice == "2");

    // Prompt for numerator
    Prompt_Result num = prompt_for_int (prompt: "Enter numerator");
    if (!num.has_value)
    {
        writeln ("User quit. Closing app.");
        return;
    }

    // Prompt for denominator
    Prompt_Result den = prompt_for_int (prompt: "Enter denominator");
    if (!den.has_value)
    {
        writeln ("User quit. Closing app.");
        return;
    }

    // Domain dispatch
    if (use_positive)
    {
        run_positive_integer_pairs (a_num: num.value, a_den: den.value);
    }
    else
    {
        run_integer_pairs (a_num: num.value, a_den: den.value);
    }

    writeln ("Done.");
}

// ------------------------------------------------------------
// run_integer_pairs
//
// Purpose:
//   Execute the integer_pairs domain pipeline.
//
// Steps:
//   - Construct Integer_Pairs contender.
//   - Classify into Fraction or Invalid.
//   - Dispatch to the correct VM renderer.
//   - Print the rendered message.
//
// Invariants:
//   - UI layer does not inspect invariants or domain rules.
//   - Classification result determines VM dispatch.
//   - Buffer is caller-owned and sized for VM output.
// ------------------------------------------------------------
void run_integer_pairs (in int a_num, in int a_den)
{
    Integer_Pairs contender = Integer_Pairs.make (a_x: a_num, a_y: a_den);
    Classified classified =  classify (a_pair: contender);

    final switch (classified.kind)
    {
        case Classified.Kind.Fraction:
        {
            char[128] buf;
            size_t n = fraction_vm (a_classified: classified, a_buf: buf[]);
            writeln (buf[0 .. n]);
            break;
        }

        case Classified.Kind.Invalid:
        {
            char[128] buf;
            size_t n = invalid_vm (classified: classified, buffer: buf[]);
            writeln (buf[0 .. n]);
            break;
        }
    }
}

// ------------------------------------------------------------
// run_positive_integer_pairs
//
// Purpose:
//   Execute the positive_integer_pairs domain pipeline.
//
// Additional UI-layer rule:
//   - Prevent domain assertion by validating numerator and denominator
//     before constructing Positive_Integer_Pairs.
//
// Steps:
//   - Validate > 0 in UI layer.
//   - Construct Positive_Integer_Pairs contender.
//   - Classify (always Fraction for this domain).
//   - Render via fraction_vm.
//   - Print the rendered message.
//
// Invariants:
//   - UI layer performs only minimal validation.
//   - Domain invariants remain enforced inside the domain struct.
// ------------------------------------------------------------
void run_positive_integer_pairs (in int a_num, in int a_den)
{
    // UI-layer validation to prevent domain assertion
    if (a_num <= 0 || a_den <= 0)
    {
        writeln ("Both numerator and denominator must be > 0 for positive_integer_pairs.");
        return;
    }

    Positive_Integer_Pairs contender = Positive_Integer_Pairs.make (a_x: a_num, a_y: a_den);
    Classified classified = classify (a_pair: contender);

    char[128] buf;
    size_t n = fraction_vm (a_classified: classified, a_buf: buf[]);
    writeln (buf[0 .. n]);
}

// End of Document /</repo:integer_division_domain/src/app.d/>
