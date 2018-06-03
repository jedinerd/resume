HTMLSRC = $(wildcard *.html.md)
PDFSRC = $(wildcard *.pdf.md)
MAINSRC = $(wildcard *.main)
PDFS=$(PDFSRC:.pdf.md=.pdf)
HTML=$(HTMLSRC:.html.md=.html)
CSS=$(HTMLSRC:.html.md=.css)
LATEX_TEMPLATE=./default.latex
all:   pre copycss $(PDFS) $(HTML)
pre:   outdir clean
pdf:   pre $(PDFS)
html:  pre copycss $(HTML)

%.html: %.html.md
	cat $< $(MAINSRC) >> html.md
	python resume.py html $(GRAVATAR_OPTION) < html.md | pandoc -t html -c $(CSS) -o out/$@

%.pdf:  %.pdf.md
	cat $< $(MAINSRC) >> pdf.md
	python resume.py tex < pdf.md | pandoc $(PANDOCARGS) --variable subparagraph --template=$(LATEX_TEMPLATE) -H header.tex -o out/$@

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
	$(RM) *.html *.pdf out/* html.md pdf.md
outdir:
	mkdir -p out