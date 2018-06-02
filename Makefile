HTMLSRC = $(wildcard *.html.md)
PDFSRC = $(wildcard *.pdf.md)
PDFS=$(PDFSRC:.html.md=.pdf)
HTML=$(HTMLSRC:.pdf.md=.html)
CSS=$(HTMLSRC:.html.md=.css)
LATEX_TEMPLATE=./default.latex
all:   pre copycss $(PDFS) $(HTML)
pre:   outdir clean
pdf:   pre $(PDFS)
html:  pre copycss $(HTML)

%.html: %.md
	python resume.py html $(GRAVATAR_OPTION) < $< | pandoc -t html -c $(CSS) -o out/$@

%.pdf:  %.md
	python resume.py tex < $< | pandoc $(PANDOCARGS) --variable subparagraph --template=$(LATEX_TEMPLATE) -H header.tex -o out/$@

ifeq ($(OS),Windows_NT)
  # on Windows
  RM = cmd //C del
else
  # on Unix
  RM = rm -f
endif

copycss:
	cp $(CSS) out/ 
	
clean:
	$(RM) *.html *.pdf out/*
	
outdir:
	mkdir -p out