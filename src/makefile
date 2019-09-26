APP = kakuro

HC = ghc
CC = g++

HTARGETS = main.hs
CTARGETS = kakuro.cpp

haskell: $(TARGETS)
	$(HC) $(TARGETS) -o $(APP)

cpp: $(CTARGETS)
	$(CC) $(CTARGETS) -o $(APP)


.PHONY: clean

clean:
	@rm -f *.o *.hi $(APP)
