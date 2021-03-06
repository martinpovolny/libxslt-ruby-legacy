#!/usr/local/bin/ruby -w

require 'xml/libxml'
require '../libxslt'

xslt = XML::XSLT.file('fuzface.xsl')
xslt.doc = XML::Document.file('fuzface.xml')
s = xslt.parse
s.apply

File.open('fuzface.html', 'w') do |f|
  s.save(f)
end

s.print
