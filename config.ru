# redirect www/ftp/mail/etc on this host to the www. domain
require File.join(File.dirname(__FILE__), 'lib', 'rack-redirect')

run EY::Solo::Rack::Redirect.new
