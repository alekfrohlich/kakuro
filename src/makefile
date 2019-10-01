.PHONY: clean

APP = kakuro

HC = ghc
CC = g++

HTARGETS = kakuro.hs
CTARGETS = kakuro.cpp

HDEPS = test.hs
CDEPS = kakuro.hpp test.hpp

haskell: $(HTARGETS) $(HDEPS)
	$(HC) $(HTARGETS) $(HDEPS) -o $(APP)
	@rm test.hs

test.hs:
	@cp ../test_cases/test$(TEST).hs test.hs

cpp: $(CTARGETS) $(CDEPS)
	$(CC) $(CTARGETS) $(CDEPS) -o $(APP)
	@rm test.hpp

test.hpp:
	@cp ../test_cases/test$(TEST).hpp test.hpp

clean:
	@rm -f *.o *.hi $(APP)