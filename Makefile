SRC=$(wildcard *.md)
CSS=$(SRC:.md=.css)
PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
LATEX_TEMPLATE=./default.latex

all:  pre copycss $(PDFS) $(HTML)
pre:  outdir clean
pdf:  clean $(PDFS)
html: pre copycss $(HTML)

%.html: %.md
	python resume.py html $(GRAVATAR_OPTION) < $< | pandoc -t html -c resume.css -o out/$@

%.pdf:  %.md
	python resume.py tex < $< | pandoc $(PANDOCARGS) --variable subparagraph --template=$(LATEX_TEMPLATE) -H header.tex -o out/$@

copycss:
	cp $(CSS) out/ 

clean:
	rm -f out/* 

outdir:
	mkdir -p out