R_OPTS=--no-save --no-restore --no-init-file --no-site-file # --vanilla, but without --no-environ

STEM = rqtl2

FIGS = Figs/scale_fig1.pdf \
	   Figs/batches_fig1.pdf \
	   Figs/rqtl_lines_code.pdf \
	   Figs/rqtl2_scan.pdf \
	   Figs/congenic.pdf

$(STEM).pdf: $(STEM).tex header.tex $(FIGS)
	xelatex $<

web: $(STEM).pdf
	scp $(STEM).pdf broman-10.biostat.wisc.edu:Website/presentations/$(STEM)_ucsf2018.pdf

Figs/scale_fig1.pdf: R/scale_fig.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"

Figs/batches_fig1.pdf: R/batches_fig.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"

Figs/rqtl_lines_code.pdf: R/colors.R Data/lines_code_by_version.csv R/rqtl_lines_code.R
	cd R;R CMD BATCH rqtl_lines_code.R

Data/lines_code_by_version.csv: Perl/grab_lines_code.pl Data/versions.txt
	cd Perl;grab_lines_code.pl

Figs/rqtl2_scan.pdf: R/rqtl2_figs.R R/colors.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"

Figs/congenic.pdf: R/congenic_fig.R
	cd $(<D);R $(R_OPTS) -e "source('$(<F)')"
