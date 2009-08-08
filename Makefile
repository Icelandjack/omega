MAIN             = Main
EXEC             = omega.exe
GHC              = ghc
GHCI             = ghci
GHC_FLAGS        = -auto-all  $(GHC_FLAGS_COMMON)
GHCI_FLAGS       = $(GHC_FLAGS_COMMON)
GHC_FLAGS_COMMON = -fglasgow-exts -XUndecidableInstances
HUGS             = hugs
HUGS_FLAGS       = -98 -P:../Lib:../Lib/Parser

.PHONY: all tests clean manual

all: *.hs
	$(GHC) $(GHC_FLAGS) -o $(EXEC) --make $(MAIN)

%: %.hs *.hs
	$(GHC) $(GHC_FLAGS) --make $*

ghci-%: %.hs
	$(GHCI) $(GHCI_FLAGS) $*

hugs-%: %.hs
	$(HUGS) $(HUGS_FLAGS) $*

tests: all
	./$(EXEC) -tests ../tests

clean:
	rm -f *.hi *.o *.prof

manual: all
	./$(EXEC) -manual ../doc
	$(MAKE) -C ../doc -f `pwd`/Makefile OmegaManual.ps

OmegaManual.ps: version.tex OmegaManual.tex
	latex OmegaManual.tex
	bibtex.exe OmegaManual
	latex OmegaManual.tex && latex OmegaManual.tex
	dvips.exe OmegaManual
