# ***********************************************
#        ToraNova's bib makefile template
#        mailto:chia_jason96@live.com
# ***********************************************

# TODO: change filename
# Do not include the .tex name
# FILENAME = proposal
FILENAME = thesis

# specify phony targets
.PHONY: all clean read

all: ${FILENAME}.pdf

read: ${FILENAME}.pdf
	zathura ${FILENAME}.pdf &

#biber ${FILENAME}
# BIBER (BibLaTeX) user
#pdflatex -shell-escape ${FILENAME}.tex
${FILENAME}.pdf: ${FILENAME}.tex
	pdflatex ${FILENAME}.tex
	biber ${FILENAME}
	pdflatex ${FILENAME}.tex

clean:
	rm -f ${FILENAME}.{dvi,ps,pdf,log,out,toc,aux,bbl,blg,bcf,lot,lof,ist,idx,glsdefs,glo,ent,acn}
