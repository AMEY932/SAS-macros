SAS2POD = /home/friendly/bin/sas2pod
SPOD2HTML = /home/friendly/bin/spod2html
SPOD2LATEX = /home/friendly/bin/spod2latex
XREF = /home/friendly/SCS/sasmac/.xref
MENU = /home/friendly/SCS/sasmac/.menu2

# Server dir under which macro goes
# relative to $serverbase = '/ftp/sas/macros/';
# e.g., SDIR=color
SDIR =
IDIR = $(if $(SDIR),-d $(SDIR))
UPDATE=

# -------------  rules  ------------------
.SUFFIXES: .sas .pod .html .tex
.PRECIOUS: %.pod

# create a pod file from a sas file
%.pod: %.sas
	$(SAS2POD) $*
   
%.html: %.pod
	$(SPOD2HTML) $(IDIR) -xm $*
        ifneq ($(strip $(UPDATE)),)
#	-@grep -vq $* $(XREF) && echo 'Need to update' $(XREF) 'with' $*.xref
#	-@grep -vq $* $(MENU) && echo 'Need to update' $(MENU) 'with' $*.menu
	-@grep -vq $* $(XREF) && cat $*.xref >> $(XREF)
	-@grep -vq $* $(MENU) && cat $*.menu >> $(MENU)
	-@echo  Updated $(XREF) $(MENU)
	-@echo Run installmac $* here to install, then edit macmenu2.js
        endif
	
%.tex: %.pod
	$(SPOD2LATEX) $*

#%.pod: %.sas
#	$(SPOD2HTML) $*
#	$(SAS2POD) $*

update:
	
   
rdist:
	rdist saspsyc
	rdist sas6140
	rdist sas3030
