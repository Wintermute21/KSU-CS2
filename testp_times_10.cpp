/*  BigInt Test Program
 *
 * Tests: times_10
 */

//===========================================================================
#include "bigint.h"

#include <iostream>
#include <string>
#include <cassert>
using std::cerr;
using std::cout;
using std::string;

//===========================================================================
int main ()
{
    // test times 10 arb 0
    {
        // Setup fixture
        const int    ARB_A    = 5;
        const int    PWR_A    = 0;
        const string RESULT_A = "5";

        BigInt arb(ARB_A);

        // Test
        arb.times_10(PWR_A);

        // Verfiy
        assert(arb.to_string() == RESULT_A);
    }

    // test times 10 arb 1
    {
        // Setup fixture
        const int    ARB_B    = 44;
        const int    PWR_B    = 1;
        const string RESULT_B = "440";

        BigInt arb(ARB_B);

        // Test
        arb.times_10(PWR_B);

        // Verfiy
        assert(arb.to_string() == RESULT_B);
    }

    // test times 10 arb 4
    {
        // Setup fixture
        const int    ARB_C    = 987;
        const int    PWR_C    = 4;
        const string RESULT_C = "9870000";

        BigInt arb(ARB_C);

        // Test
        arb.times_10(PWR_C);

        // Verfiy
        assert(arb.to_string() == RESULT_C);
    }

    // test times 10 arb 10
    {
        // Setup fixture
        const string ARB_D    = "12345678901234567890";
        const int    PWR_D    = 10;
        const string RESULT_D = ARB_D +"0000000000";

        BigInt arb(ARB_D);

        // Test
        arb.times_10(PWR_D);

        // Verfiy
        assert(arb.to_string() == RESULT_D);
    }

    // test times 10 0 0
    {
        // Setup fixture
        const int    ARB_E    = 0;
        const int    PWR_E    = 0;
        const string RESULT_E = "0";

        BigInt arb(ARB_E);

        // Test
        arb.times_10(PWR_E);

        // Verfiy
        assert(arb.to_string() == RESULT_E);
    }

    // test times 10 0 1
    {
        // Setup fixture
        const int    ARB_F    = 0;
        const int    PWR_F    = 1;
        const string RESULT_F = "0";

        BigInt arb(ARB_F);

        // Test
        arb.times_10(PWR_F);

        // Verfiy
        assert(arb.to_string() == RESULT_F);
    }

}

