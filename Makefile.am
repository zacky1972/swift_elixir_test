AUTOMAKE_OPTIONS = subdir-objects
ACLOCAL_AMFLAGS = -I m4

lib_LTLIBRARIES = priv/libnif.la
priv_libnif_la_SOURCES = native/libnif.c

if OSX
priv_libnif_la_LIBADD = $(LIBOBJS) native/caller.lo
native/caller.lo: native/caller.m native/caller.h
	$(LIBTOOL) --mode=compile xcrun clang -c $(OBJC_FLAGS) $(CFLAGS) -o $@ $<
endif

if OSX
priv_libnif_la_CFLAGS = -DOSX $(CFLAGS) $(ERL_CFLAGS)
else
priv_libnif_la_CFLAGS = $(CFLAGS) $(ERL_CFLAGS)
endif

priv_libnif_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic
