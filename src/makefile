.PHONY: clean
.PHONY: cpp

APP = kakuro

HC = ghc
CC = g++

HTARGETS = kakuro.hs
CTARGETS = kakuro.cpp

CDEPS = kakuro.hpp test.hpp

cpp: $(CTARGETS) $(CDEPS)
	$(CC) $(CTARGETS) $(CDEPS) -o $(APP) --debug
	@rm test.hpp

haskell: $(HTARGETS)
	$(HC) $(HTARGETS) -o $(APP)

test.hpp:
	@cp ../test_cases/test$(TEST).hpp test.hpp

clean:
	@rm -f *.o *.hi $(APP)