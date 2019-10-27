# MIT License
# 
# Copyright (c) 2019 Alek Frohlich, Nicolas Goeldner
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# This program solves kakuro boards using backtracking.


.PHONY: clean

CC  = g++
HC  = ghc
SCM = chezscheme9.5

CPPDEPS = $(APP).hpp test.hpp
HSDEPS  = $(APP).hs test.hs
SCMDEPS = $(APP).scm test.scm

ZINHO = $(TESTDIR)/zinho

cpp: $(APP).cpp $(CPPDEPS)
	$(CC) $< -o $(APP)
	./$(APP)
	@rm -f test.cpp

haskell: $(HSDEPS)
	$(HC) $^ -o $(APP)
	./$(APP)
	@rm -f test.hs

scheme: $(SCMDEPS)
	$(SCM) --script $^
	@rm -f test.scm

# Build test dependencies.
test.hpp:
	$(ZINHO) $(BOARDDIR)/$(BOARDNUM)
	mv $(TESTDIR)/test test.hpp 

test.hs:
	$(ZINHO) $(BOARDDIR)/$(BOARDNUM)
	mv $(TESTDIR)/test test.hs

test.scm:
	$(ZINHO) $(BOARDDIR)/$(BOARDNUM)
	mv $(TESTDIR)/test test.scm

clean:
	@rm -f $(APP)
	@rm -f *.o
	@rm -f *.hi