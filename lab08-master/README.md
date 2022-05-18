# Lab 8

**Topics:**
 - Parameter passing in C# (`ref`, `out`)
 - Delegates

## Description
- Complete the implementation of `parameters.cs` so that the output matches the expected results. This will invove specifing the parameter passing modes in a few places. 
- Complete the implementation of `delegates.cs` so that the output matches the expected results. This will involve implementing a `Map` function in C#, ad `FoldLeft` function, and it will involve using _Multicast_ delegates to process a list of numbers. 

## Checking Your Results
You can check your results by typing 
```
make check
```
You can check individual parts by typing
```
make check-parameters
```
or
```
make check-delegates
```

You can see the output of a program by typing
```
make delegates.output
icdiff delegates.output delegates.expected
``` 

