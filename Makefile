export VERSION = 0.0.1
export TOPDIR = $(shell pwd)
export DISTDIR = $(TOPDIR)/foresight-user-guide-$(VERSION)
export prefix = /usr
export sysconfdir = /etc
export bindir = $(prefix)/bin
export datadir = $(prefix)/share
export libdir = $(prefix)/lib
export mandir = $(prefix)/share/man

bin_files = foresight-user-guide
extra_files = \
	foresight-user-guide.desktop \
	foresight-icon.png \
	Makefile \
	NEWS \
	COPYING \
	TODO \
	README 
doc_files = \
	guide/*

dist_files = $(bin_files) $(extra_files) $(doc_files)

.PHONY: clean dist install 

install-mkdirs:
	mkdir -p $(DESTDIR)$(bindir)
	mkdir -p $(DESTDIR)$(mandir)/man1
	mkdir -p $(DESTDIR)$(datadir)/foresight-user-guide/help/C/figures
	mkdir -p $(DESTDIR)$(datadir)/applications
	mkdir -p $(DESTDIR)$(datadir)/pixmaps

install: install-mkdirs
	install -m 755 foresight-user-guide $(DESTDIR)$(bindir)
	install -m 755 guide/*.xml $(DESTDIR)$(datadir)/foresight-user-guide/help/C/
	install -m 755 guide/figures/*.png $(DESTDIR)$(datadir)/foresight-user-guide/help/C/figures/
	install -m 755 foresight-user-guide.desktop $(DESTDIR)$(datadir)/applications/
	install -m 644 foresight-icon.png $(DESTDIR)$(datadir)/pixmaps/

#dist: $(dist_files)
dist:
#	if ! grep "^Changes in $(VERSION)" NEWS > /dev/null 2>&1; then \
#		echo "no NEWS entry"; \
#		exit 1; \
#	fi
	rm -rf $(DISTDIR)
	mkdir $(DISTDIR)
	for f in $(dist_files); do \
		mkdir -p $(DISTDIR)/`dirname $$f`; \
		cp -a $$f $(DISTDIR)/$$f; \
	done; \
	tar cjf $(DISTDIR).tar.bz2 `basename $(DISTDIR)`

distcheck: dist
