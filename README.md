# kakuro

Kakuro is a cross-word like puzzle, here we present some implementations of board solvers in different languages. Details about the rules can be found [here](https://www.conceptispuzzles.com/index.aspx?uri=puzzle/kakuro/rules).

## Running kakuro

To run kakuro, you must first choose an implementation and then a test case. There are three implementations, one in C++, one in Haskell and one in Scheme. Currently two test cases are available: 2 and 91.

Test cases are located under `test_cases/boards` and are copies of some of those found at [this site](https://www.janko.at/Raetsel/Kakuro/index.htm).

After choosing the desired test, simply change directory to `src` and run:

```
$ make <implementation> TEST=<number> 
```

where implementation can be 'cpp', 'haskell' or 'scheme' and number can be 2 or 91.

Here's an example where we build the first test case:

```
$ make scheme TEST=2
```

Now, after building the test suite, run the generated executable (for compiled languages), named the same (kakuro) for any combination of test cases and implementations:

```
$ ./kakuro
```

The solved board shall be printed back into the console.

```
******
*98*29
*32514
**193*
*13842
*37*68
```

Here '*' represent black positions, whose value don't constitute the answer.
