APP = kakuro

HC = ghc

TARGETS = main.hs

all: $(TARGETS)
	$(HC) $(TARGETS) -o $(APP)

.PHONY: clean

clean:
	@rm -f *.o *.hi $(APP)