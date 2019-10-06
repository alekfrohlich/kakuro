# kakuro

Kakuro is a cross-word like puzzle, here we present two board solvers, one written in C++, another in Haskell. Details about the rules can be found [here](https://www.conceptispuzzles.com/index.aspx?uri=puzzle/kakuro/rules).

## Running kakuro

To run kakuro, you must first choose an implementation and then a test case. There are two implementations, one in C++ and one in Haskell. For the former, five tests are available (#1 through #5), for the latter, only two have been implemented (#1 and #5).

Test cases are located under the `test_cases` directory and are copies of some of those found at [this site](https://www.janko.at/Raetsel/Kakuro/index.htm).

After choosing the desired test, simply change directory to `src` and run:

```
$ make <implementation> TEST=<number> 
```

where implementation can be 'cpp' or 'haskell' and number can vary between 1 and 5.

Here's an example where we build haskell's first test case:

```
$ make haskell TEST=1
```

Now, after building the test suite, run the generated executable, name the same (kakuro) for any combination of test cases and implementations:

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

