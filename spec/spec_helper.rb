ENV['RACK_ENV'] ||= 'test'
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'app')
require 'spec'
require 'rack/test'

Spec::Runner.configure do |config|
  def app
    @app ||= Rack::Builder.new do
      run EY::Solo::Rack::Redirect.new
    end
  end
  config.include(Rack::Test::Methods)
end
