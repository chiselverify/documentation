DOC=chisel-verify-jnl

.PHONY: all
all:
	pdflatex -shell-escape $(DOC)
	bibtex $(DOC)
	pdflatex -shell-escape $(DOC)
	pdflatex -shell-escape $(DOC)
