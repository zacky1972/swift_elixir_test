AUTOMAKE_OPTIONS = subdir-objects
ACLOCAL_AMFLAGS = -I m4

if EXIST_FOUNDATION
OBJC_FLAGS += -DEXIST_FOUNDATION
SWIFT_FLAGS += -DEXIST_FOUNDATION
endif
if WORK_NSLOG
OBJC_FLAGS += -DWORK_NSLOG
SWIFT_FLAGS += -DWORK_NSLOG
endif

lib_LTLIBRARIES = priv/libnif.la
priv_libnif_la_SOURCES = native/libnif.c

if ALLOSX
priv_libnif_la_LIBADD = $(LIBOBJS) native/caller.lo native/ExampleClass.lo

native/caller.lo: native/caller.m native/caller.h native/ExampleClass-Swift.h
	$(LIBTOOL) --mode=compile xcrun clang -c $(OBJC_FLAGS) $(CFLAGS) -o $@ $<

native/ExampleClass.lo: native/ExampleClass.swift
	$(LIBTOOL) --mode=compile ./swiftc_wrapper $(SWIFT_FLAGS) -emit-object -parse-as-library $< -o $@ 

native/ExampleClass-Swift.h: native/ExampleClass.swift
	xcrun swiftc $(SWIFT_FLAGS) $< -emit-objc-header -emit-objc-header-path $@
endif

if ALLOSX
priv_libnif_la_CFLAGS = -DALLOSX $(CFLAGS) $(ERL_CFLAGS)
else
priv_libnif_la_CFLAGS = $(CFLAGS) $(ERL_CFLAGS)
endif

if ALLOSX
priv_libnif_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic -L`xcrun --show-sdk-path`/usr/lib/swift -undefined dynamic_lookup
else
priv_libnif_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic
endif
