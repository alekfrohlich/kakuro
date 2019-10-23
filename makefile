export APP = kakuro

export SRCDIR   = $(CURDIR)/src
export TESTDIR = $(CURDIR)/test_cases
export TEMPLDIR = $(TESTDIR)/templates

cpp:
	cd $(SRCDIR) && $(MAKE) cpp

haskell:
	cd $(SRCDIR) && $(MAKE) haskell

scheme:
	cd $(SRCDIR) && $(MAKE) scheme