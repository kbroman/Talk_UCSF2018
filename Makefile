R_OPTS=--no-save --no-restore --no-init-file --no-site-file # --vanilla, but without --no-environ

STEM = rqtl2

FIGS = Figs/causal_network.pdf Figs/pleiotropy_network.pdf Figs/scale_fig1.pdf Figs/batches_fig1.pdf

$(STEM).pdf: $(STEM).tex header.tex $(FIGS)
	xelatex $<

web: $(STEM).pdf
	scp $(STEM).pdf broman-10.biostat.wisc.edu:Website/presentations/$(STEM).pdf

Figs/causal_network.pdf: R/causal_network.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"

Figs/pleiotropy_network.pdf: R/pleiotropy_network.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"

Figs/scale_fig1.pdf: R/scale_fig.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"

Figs/batches_fig1.pdf: R/batches_fig.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"
