// Start of Document /</repo:integer_division_domain/test/vm/fraction_vm_tests.d/>

module test.vm.fraction_vm_tests;

import integer_division_domain.vm.fraction_vm        : fraction_vm;
import integer_division_domain.domain.classified     : Classified;
import integer_division_domain.domain.fraction       : Fraction;
import integer_division_domain.utility.int_to_decimal: int_to_decimal;

void simple_division_should_render_correctly ()
{
    // Arrange
    Classified c = Classified (Fraction (10, 2));
    char[64] buf;

    // Act
    size_t len = fraction_vm (c, buf[]);

    // Assert
    assert (buf[0 .. len] == "quotient: 5, remainder: 0");
}

void large_numbers_should_insert_underbars ()
{
    // Arrange
    Classified c = Classified (Fraction (1234567, 3)); // quotient = 411522, remainder = 1
    char[64] buf;

    // Act
    size_t len = fraction_vm (c, buf[]);

    // Assert
    assert (buf[0 .. len] == "quotient: 411_522, remainder: 1");
}

void negative_numerator_should_render_correctly ()
{
    // Arrange
    Classified c = Classified (Fraction (-100, 7)); // quotient = -14, remainder = -2
    char[64] buf;

    // Act
    size_t len = fraction_vm (c, buf[]);

    // Assert
    assert (buf[0 .. len] == "quotient: -14, remainder: -2");
}

void negative_denominator_should_render_correctly ()
{
    // Arrange
    Classified c = Classified (Fraction (100, -7)); // quotient = -14, remainder = 2
    char[64] buf;

    // Act
    size_t len = fraction_vm (c, buf[]);

    // Assert
    assert (buf[0 .. len] == "quotient: -14, remainder: 2");
}

void large_remainder_should_insert_underbars ()
{
    // Arrange
    Classified c = Classified (Fraction (5000, 2000)); // quotient = 2, remainder = 1000
    char[64] buf;

    // Act
    size_t len = fraction_vm (c, buf[]);

    // Assert
    assert (buf[0 .. len] == "quotient: 2, remainder: 1_000");
}

void insufficient_buffer_should_trigger_assert ()
{
    // Arrange
    Classified c = Classified (Fraction (1000, 2));
    char[8] tiny;
    bool caught = false;

    // Act
    try
    {
        fraction_vm (c, tiny[]);
    }
    catch (AssertError)
    {
        caught = true;
    }

    // Assert
    assert (caught);
}

unittest
{
    simple_division_should_render_correctly ();
    large_numbers_should_insert_underbars ();
    negative_numerator_should_render_correctly ();
    negative_denominator_should_render_correctly ();
    large_remainder_should_insert_underbars ();
    insufficient_buffer_should_trigger_assert ();
}

// End of Document /</repo:integer_division_domain/test/vm/fraction_vm_tests.d/>
