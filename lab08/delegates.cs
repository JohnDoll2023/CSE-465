using System;
using System.Collections.Generic;

namespace cse465 {
    class DelegatesExample {
        public delegate R Function<R, T>(T value);
        public delegate R BinaryFunction<R, T1, T2>(T1 arg1, T2 arg2);

        public static List<R> Map<R, T>(List<T> theList, Function<R, T> f) {
            // TODO:   implement the map operation, which you 
            //         should be familiar with already from scheme
            //         But use a loop -- not recursion!
            List<R> result = new List<R>();

            foreach (T elem in theList) {
              result.Add(f(elem));
            }
            
            return result;
        }


        public static R FoldLeft<R, T>(List<T> values, BinaryFunction<R, T, R> f, R init) {
            // TODO: Implement the Fold Left 
            //       You should be familar with it from scheme
            //       In case you arent -- it is this pseudocode:
            //
            //       for each item in the list, in reverse order:
            //           init = f(item, init)
            //       return init
            
            return init;
        }


        public static void printIfEven(int x) {
            if ((x % 2) == 0) {
                Console.WriteLine($"{x,-6} - Even");
            } else {
                Console.WriteLine($"{x,-6} - Odd");
            }
        }

        public static void printIfPositive(int x) {
            if (x > 0) {
                Console.WriteLine($"{x,-6} - Positive");
            } else if (x < 0) {
                Console.WriteLine($"{x,-6} - Negative");
            } else {
                Console.WriteLine($"{x,-6} - Zero");
            }
        }

        delegate void NumberHandler(int x);

        public static void Main() {
            List<string> values = new List<string>(Console.ReadLine().Split(','));
            Console.WriteLine($"Read in: {string.Join(",", values)}");
            List<int> numbers = Map<int, string>(values, Int32.Parse);
            Console.WriteLine($"To Int: {string.Join(",", numbers)}");

            // Cube each number using a lambda expression
            numbers = Map<int, int>(numbers, (x) => x*x*x );
            Console.WriteLine($"Cubed: {string.Join(",", numbers)}");

   
            NumberHandler handler = null;      
            // TODO -- add printIfEvens to the delegate `handler`
            handler = printIfEven;
            // TODO -- add printIfPositive to the delegate `handler`
            handler += printIfPositive;
            // This demonstrates the way delegate can be used as callbacks in C#
            foreach (int n in numbers) {
                if (handler != null){
                    handler(n);
                }
            }    

        }

    }
}
