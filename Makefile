LASTNAME	= chotard
FIRSTNAME	= alexis

export CV	= ${LASTNAME}_${FIRSTNAME}_cv
export CVFR	= ${CV}_fr
export CVEN	= ${CV}_en

export SRCDIR	= ${PWD}/src
export OUTDIR	= ${PWD}/output
export VIEWER	= zathura

all:: fr en fr_tech

fr en fr_tech::
	mkdir -p ${OUTDIR}
	docker run --rm -v ${SRCDIR}:/var/sources -v ${OUTDIR}:/var/output horgix/moderntimeline:latest xelatex --output-directory /var/output ${CV}_$@.tex
	docker run --rm -v ${OUTDIR}:/var/output busybox chown `id -u`:`id -g` /var/output/ -R
	ln -s -f ${OUTDIR}/${CV}_$@.pdf .

fredit::
	${EDITOR} ${SRCDIR}/${CVFR}.tex
enedit::
	${EDITOR} ${SRCDIR}/${CVEN}.tex

frdisplay::
	${VIEWER} ${CVFR}.pdf
endisplay::
	${VIEWER} ${CVEN}.pdf

clean::
	rm -f ${OUTDIR}/*.{aux,log,out}

distclean:: clean
	rm -rf *.pdf ${OUTDIR}

nuke:: distclean
