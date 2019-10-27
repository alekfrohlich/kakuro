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

.PHONY: zinho \
		cpp haskell scheme \
		clean veryclean

export APP = kakuro

export BOARDNUM  = $(TEST)
export LANG 	 = $(MAKECMDGOALS)

export SRCDIR   = $(CURDIR)/src
export TESTDIR  = $(CURDIR)/test_cases
export BOARDDIR = $(TESTDIR)/boards
export LANGDIR  = $(TESTDIR)/languages

## Sanity checks

# Target language not chosen.
ifeq ($(MAKECMDGOALS), )
$(error Missing target, \
	choose one of the following: cpp, haskel, scheme)
endif

# Test case not set.
ifneq ($(MAKECMDGOALS), clean)
ifndef TEST
$(error TEST is not set)
endif
endif

zinho:
	cd $(TESTDIR) && $(MAKE) zinho

cpp: zinho 
	cd $(SRCDIR) && $(MAKE) cpp

haskell: zinho
	cd $(SRCDIR) && $(MAKE) haskell

scheme: zinho
	cd $(SRCDIR) && $(MAKE) scheme

clean:
	cd $(SRCDIR) && $(MAKE) clean
	cd $(TESTDIR) && $(MAKE) clean

veryclean:
	cd $(SRCDIR) && $(MAKE) clean
