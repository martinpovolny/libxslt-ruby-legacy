
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = .
topdir = $(rubylibdir)/$(arch)
hdrdir = $(rubylibdir)/$(arch)
VPATH = $(srcdir)
prefix = $(DESTDIR)/usr
exec_prefix = $(prefix)
sitedir = $(prefix)/local/lib/site_ruby
rubylibdir = $(libdir)/ruby/$(ruby_version)
builddir = $(ac_builddir)
archdir = $(rubylibdir)/$(arch)
sbindir = $(exec_prefix)/sbin
compile_dir = $(DESTDIR)/tmp/ruby1.8-1.8.0+preview2/build-tree/ruby-1.8.1
datadir = $(prefix)/share
includedir = $(prefix)/include
infodir = $(prefix)/info
top_builddir = $(ac_top_builddir)
sysconfdir = $(DESTDIR)/etc
mandir = $(datadir)/man
libdir = $(exec_prefix)/lib
sharedstatedir = $(prefix)/com
oldincludedir = $(DESTDIR)/usr/include
sitearchdir = $(sitelibdir)/$(sitearch)
bindir = $(exec_prefix)/bin
localstatedir = $(DESTDIR)/var
sitelibdir = $(sitedir)/$(ruby_version)
libexecdir = $(exec_prefix)/libexec

CC = gcc
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static

CFLAGS   = -fPIC -g -Wall-Wall -g -O2 -fPIC -I/usr/include/libxml2 -I/usr/include/libxml2
CPPFLAGS = -I. -I$(topdir) -I$(hdrdir) -I$(srcdir) -DHAVE_ZLIB_H 
CXXFLAGS = $(CFLAGS) 
DLDFLAGS =  -lexslt -L/usr/lib -lxslt -lxml2 -lz -lpthread -lm -L/usr/lib -lxml2 -lz -lpthread -lm  
LDSHARED = gcc -shared
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = ruby1.8
RUBY_SO_NAME = $(RUBY_INSTALL_NAME)
arch = i386-linux
sitearch = i386-linux
ruby_version = 1.8
RUBY = ruby1.8
RM = $(RUBY) -run -e rm -- -f
MAKEDIRS = $(RUBY) -run -e mkdir -- -p
INSTALL_PROG = $(RUBY) -run -e install -- -vpm 0755
INSTALL_DATA = $(RUBY) -run -e install -- -vpm 0644

#### End of system configuration section. ####


LIBPATH =  -L"$(libdir)" -L"/usr/lib"
DEFFILE = 

CLEANFILES = 
DISTCLEANFILES = 

target_prefix = /xml
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED) -lxslt -lxml2 -lz -lm  -lpthread -ldl -lcrypt -lm  -lc
OBJS = libxslt.o ruby_xslt_stylesheet.o ruby_xslt_transform_context.o
TARGET = libxslt
DLLIB = $(TARGET).so
STATIC_LIB = $(TARGET).a

RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR    = $(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(sitearchdir)$(target_prefix)

CLEANLIBS     = "$(TARGET).{lib,exp,il?,tds,map}" $(DLLIB)
CLEANOBJS     = "*.{o,a,s[ol],pdb,bak}"

all:		$(DLLIB)
static:		$(STATIC_LIB)

clean:
		@$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean:	clean
		@$(RM) Makefile extconf.h conftest.* mkmf.log
		@$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)

realclean:	distclean
install: $(RUBYARCHDIR)
install: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB) $(RUBYARCHDIR)
	@$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
$(RUBYARCHDIR):
	@$(MAKEDIRS) $(RUBYARCHDIR)

site-install: install

.SUFFIXES: .c .cc .m .cxx .cpp .C .o

.cc.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $<

.cpp.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $<

.cxx.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $<

.C.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $<

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $<

$(DLLIB): $(OBJS)
	@-$(RM) $@
	$(LDSHARED) $(DLDFLAGS) $(LIBPATH) -o $(DLLIB) $(OBJS) $(LOCAL_LIBS) $(LIBS)

$(STATIC_LIB): $(OBJS)
	$(AR) cru $@ $(OBJS)
	@-ranlib $(DLLIB) 2> /dev/null || true

