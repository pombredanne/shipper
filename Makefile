# Makefile for the shipper project

VERS=$(shell sed <shipper.spec -n -e '/Version: \(.*\)/s//\1/p')

MANDIR=$(DESTDIR)/usr/share/man/man1
BINDIR=$(DESTDIR)/usr/bin

DOCS    = README COPYING shipper.xml shipper.1
SOURCES = shipper buildrpms Makefile $(DOCS) shipper.spec

all: shipper-$(VERS).tar.gz

install: shipper.1
	cp shipper buildrpms rpm2lsm $(BINDIR)
	gzip <shipper.1 >$(MANDIR)/shipper.1.gz

shipper.1: shipper.xml
	xmlto man shipper.xml
shipper.html: shipper.xml
	xmlto html-nochunks shipper.xml

shipper-$(VERS).tar.gz: $(SOURCES)
	@mkdir shipper-$(VERS)
	@cp $(SOURCES) shipper-$(VERS)
	@tar -czf shipper-$(VERS).tar.gz shipper-$(VERS)
	@rm -fr shipper-$(VERS)

dist: shipper-$(VERS).tar.gz

release: shipper-$(VERS).tar.gz shipper.html rpm2lsm.html
	shipper; rm -f CHANGES SHIPPER* *.html *.1

