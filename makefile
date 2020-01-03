# ***********************************************
#        ToraNova's bib makefile template
#        mailto:chia_jason96@live.com
# ***********************************************

# TODO: change filename
# Do not include the .tex name
# FILENAME = proposal
FILENAME = thesis

# specify phony targets
.PHONY: all clean read tt

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

# this is for ting's stupid old Make version 4.1
# for version 4.2.1, do make clean && make
tt:
	rm -f ${FILENAME}.dvi
	rm -f ${FILENAME}.ps
	rm -f ${FILENAME}.pdf
	rm -f ${FILENAME}.log
	rm -f ${FILENAME}.out
	rm -f ${FILENAME}.toc
	rm -f ${FILENAME}.aux
	rm -f ${FILENAME}.bbl
	rm -f ${FILENAME}.blg
	rm -f ${FILENAME}.bcf
	rm -f ${FILENAME}.lot
	rm -f ${FILENAME}.lof
	rm -f ${FILENAME}.ist
	rm -f ${FILENAME}.idx
	rm -f ${FILENAME}.glsdefs
	rm -f ${FILENAME}.glo
	rm -f ${FILENAME}.ent
	rm -f ${FILENAME}.acn
	pdflatex ${FILENAME}.tex
	biber ${FILENAME}
	pdflatex ${FILENAME}.tex
