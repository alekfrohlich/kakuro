# kakuro

Kakuro is a cross-word like puzzle, here we present some implementations of board solvers in different languages. Details about the rules can be found [here](https://www.conceptispuzzles.com/index.aspx?uri=puzzle/kakuro/rules).

## Running kakuro

To run kakuro, you must first choose an implementation and then a test case. There are four implementations, one in C++, one in Haskell, one in Scheme and one in Prolog. Currently three test cases are available: 2. 91 and 287.

Test cases are located under `test_cases/boards` and are copies of some of those found at [this site](https://www.janko.at/Raetsel/Kakuro/index.htm).

After choosing the desired test, simply run:

```
$ make <implementation> TEST=<number> 
```

where implementation can be 'cpp', 'haskell' or 'scheme' and number can be 2, 91 or 287.

Here's an example where we build the first test case:

```
$ make prolog TEST=91
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
