# redirect www/ftp/mail/etc on this host to the www. domain
require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib', 'app')

run EY::Solo::Rack::Redirect.new
