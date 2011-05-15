#!/usr/local/bin/ruby -w

# $Id: extconf.rb,v 1.1.1.1 2004/01/05 07:38:25 xpovolny Exp $
#
# See the LICENSE file for copyright and distribution information

require "mkmf"

$LIBPATH.push(Config::CONFIG['libdir'])

def crash(str)
  print(" extconf failure: %s\n", str)
  exit 1
end

dir_config('xml2')
dir_config('xslt')


unless have_library('m', 'atan')
  crash('need libm')
end

unless have_library("z", "inflate")
  crash("need zlib")
else
  $defs.push('-DHAVE_ZLIB_H')
end

unless have_library("xml2", "xmlXPtrNewRange")
  crash(<<EOL)
need libxml2.

        Install the library or try one of the following options to extconf.rb:

        --with-xml2-dir=/path/to/libxml2
        --with-xml2-lib=/path/to/libxml2/lib
        --with-xml2-include=/path/to/libxml2/include
EOL
end

unless have_library('xslt','xsltApplyStylesheet')
  crash(<<EOL)
need libxslt.

        Install the library or try one of the following options to extconf.rb:

        --with-xslt-dir=/path/to/libxslt
        --with-xslt-lib=/path/to/libxslt/lib
        --with-xslt-include=/path/to/libxslt/include
EOL
end

$LDFLAGS << ' -lexslt'
$LDFLAGS << ' ' + `xslt-config --libs`.chomp
$LDFLAGS << ' ' + `xml2-config --libs`.chomp

$CFLAGS << ' ' + `xslt-config --cflags`.chomp
$CFLAGS << ' ' + `xml2-config --cflags`.chomp
$CFLAGS = '-g -Wall' + $CFLAGS


create_header()
create_makefile("xml/libxslt")
