.PHONY: clean

CC  = g++
HC  = ghc
SCM = guile -s

CPPDEPS = $(wildcard *.hpp)
HSDEPS  = $(wildcard *.hs)
SCMDEPS = $(wildcard *.scm)

ZINHO = $(TESTDIR)/zinho

cpp: $(APP).cpp $(CPPDEPS)
	$(CC) $< -o $(APP)
	@rm -f test.cpp

haskell: $(HSDEPS)
	$(HC) $< -o $(APP)
	@rm -f test.hs

scheme: $(SCMDEPS)
	$(SCM) $<
	@rm -f test.scm

# Build test dependencies.
## integrate makes.
test.cpp:
	$(ZINHO) $(TEST)
	mv $(TESTDIR) test.cpp

test.hs:
	$(ZINHO) $(TEST)
	mv $(TESTDIR) test.cpp

test.scm:
	$(ZINHO) $(TEST)
	mv $(TESTDIR) test.cpp

clean:
	@rm -f $(APP)
	@rm -f *.o
	@rm -f *.hi