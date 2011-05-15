#!/usr/local/bin/ruby -w

CVSROOT = ENV['CVSROOT'] || ":ext:#{ENV['USER']}@cvs.rubynet.org:/opt/cvsroot/rubynet"
REPO    = 'modules/xml/libxslt'

dir = "ruby-libxslt-0.03-" + Time.now.strftime('%Y%m%d')

print "Checking out..."
$stdout.flush
`cvs -d #{CVSROOT} export -r HEAD -d #{dir} #{REPO}`
puts "done."

print "Tar'ing up..."
$stdout.flush
`tar -cvpf #{dir}.tar #{dir}`
puts "done."

print "gzip'ing..."
$stdout.flush
`gzip -9 -f -c #{dir}.tar > #{dir}.tar.gz`
puts "done."

print "bzip'ing..."
$stdout.flush
`bzip2 -9 -f #{dir}.tar`
puts "done."

print "md5'ing..."
$stdout.flush
`/sbin/md5 #{dir}.tar.bz2 > #{dir}.tar.bz2.md5`
`/sbin/md5 #{dir}.tar.gz > #{dir}.tar.gz.md5`
puts "done."

print "scp'ing..."
$stdout.flush
print `scp -q #{dir}.tar.bz2     ssh.rubynet.org:/www/rubynet/www.rubynet.org/docs/modules/xml/libxslt/`
print `scp -q #{dir}.tar.bz2.md5 ssh.rubynet.org:/www/rubynet/www.rubynet.org/docs/modules/xml/libxslt/`
print `scp -q #{dir}.tar.gz      ssh.rubynet.org:/www/rubynet/www.rubynet.org/docs/modules/xml/libxslt/`
print `scp -q #{dir}.tar.gz.md5  ssh.rubynet.org:/www/rubynet/www.rubynet.org/docs/modules/xml/libxslt/`
puts "done."

print "Cleaning up..."
$stdout.flush
`rm -rf #{dir} #{dir}.tar.bz2 #{dir}.tar.bz2.md5 #{dir}.tar.gz #{dir}.tar.gz.md5`
puts "done."

puts ""
puts "bzip2"
puts "http://www.rubynet.org/modules/xml/libxslt/#{dir}.tar.bz2"
puts "http://www.rubynet.org/modules/xml/libxslt/#{dir}.tar.bz2.md5"
puts ""
puts "gzip"
puts "http://www.rubynet.org/modules/xml/libxslt/#{dir}.tar.gz"
puts "http://www.rubynet.org/modules/xml/libxslt/#{dir}.tar.gz.md5"
