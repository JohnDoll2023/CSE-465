using System;

namespace Params {
    class Program {
        // TODO: Write a static 'swap' method
        //       The method takes two parameters and excahnges their values. 
        public static void Swap(ref int a, ref int b) {
            int tmp = a;
            a = b;
            b = tmp;
        }


        // TODO: Write a static bool TryParseInt  function that 
        //       returns true of it successfully reads an integer from
        //       the Console and fals otherwise.  The integer should be
        //       returned via a parameter to the function. 
        //       
        //       Use Console.ReadLine to read a string
        //       Use Int32.Parse to convert the strin to an integer
        //       Use a Try/Catch block to handle one of the documented exceptions
        //       Please refer to the docs for Int32.Parse to see the list of exceptions to handle. 
        public static bool TryParseInt(out int value) {
            try {
                value = Int32.Parse(Console.ReadLine());
                return true;
            } catch (Exception) {
                value = -1;
                return false;
            }
        }


        public static void Main() {
            int a=0, b=0;
            
            Console.WriteLine();
            Console.Write("Please enter a number for a: ");
            while (!TryParseInt(out a)) //<-- You will need to change something here
            { 
                Console.WriteLine();
                Console.WriteLine("ERROR - Invalid number.");
                Console.Write("Please enter a number for a:");
            }
            Console.WriteLine();
            Console.WriteLine($"a has been set to {a}");
            Console.WriteLine();
            Console.Write("Please enter number for b : ");
            while (!TryParseInt(out b)) { //<-- You will need to change somehing here
                Console.WriteLine();
                Console.WriteLine("ERROR - Invalid number.");
                Console.Write("Please enter a number for b:");
            }
            Console.WriteLine();
            Console.WriteLine($"b has been set to {b}");
            Console.WriteLine();
            Console.WriteLine($"Before: a={a, -6} and b={b,-6}");
            
            Swap(ref a, ref b); //<-- You will need to make a change to this line

            Console.WriteLine($"After : a={a, -6} and b={b,-6}");
        }
    }
}
