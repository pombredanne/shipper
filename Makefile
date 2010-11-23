# Makefile for the shipper project

VERS=$(shell sed <shipper -n -e '/^version=\(.*\)/s//\1/p')

MANDIR=$(DESTDIR)/usr/share/man/man1
BINDIR=$(DESTDIR)/usr/bin

DOCS    = README COPYING shipper.xml shipper.1
SOURCES = shipper .shipper Makefile $(DOCS) control shipper-logo.png

all: shipper-$(VERS).tar.gz

install: shipper.1
	cp shipper $(BINDIR)
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

clean:
	rm -f *.1 *.tar.gz *.rpm *.tar.gz SHIPPER.* *.html

version:
	echo $(VERS)

dist: shipper-$(VERS).tar.gz

release: shipper-$(VERS).tar.gz shipper.html
	shipper -u -m -t; make clean

