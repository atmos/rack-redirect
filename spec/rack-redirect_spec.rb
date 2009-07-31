require File.dirname(__FILE__) + '/spec_helper'
require 'pp'

describe "rack-redirect" do
  describe "with a value of 'www'" do
    def app
      @app ||= Rack::Builder.new do
        use Rack::EY::Solo::DomainRedirect do |app|
          app.prefix = 'www'
        end
        run lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Hello there, gorgeous'] ] }
      end
    end
    it 'forwards on from http://www.example.org to the next app' do
      get '/', {}, {'SERVER_NAME' => 'www.example.org'}
      last_response.body.should eql("Hello there, gorgeous")
    end

    it 'redirects from http://example.org to http://www.example.org/' do
      get '/'
      last_response['Location'].should eql('http://www.example.org/')
    end

    it 'redirects from http://wwww.example.org to http://www.example.org/' do
      get '/', {}, {'SERVER_NAME' => 'wwww.example.org'}
      last_response['Location'].should eql('http://www.example.org/')
    end

    it 'redirects from http://alpha.example.com to http://www.example.org/' do
      get '/', {}, {'SERVER_NAME' => 'alpha.example.org'}
      last_response['Location'].should eql('http://www.example.org/')
    end

    it 'redirects from http://example.org/nate to http://www.example.org/nate' do
      get '/nate'
      last_response['Location'].should eql('http://www.example.org/nate')
    end

    it 'redirects from http://example.org/nate?trip_id=42 to http://www.example.org/nate?trip_id=42' do
      get '/nate', :trip_id => 42
      last_response['Location'].should eql('http://www.example.org/nate?trip_id=42')
    end
  end
  describe "without specifying a prefix" do
    def app
      @app ||= Rack::Builder.new do
        use Rack::EY::Solo::DomainRedirect
        run lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Hello there, gorgeous'] ] }
      end
    end
    it 'forwards on requests from http://example.org to the next app' do
      get '/', {}, {'SERVER_NAME' => 'example.org'}
      last_response.body.should eql("Hello there, gorgeous")
    end

    it 'redirects from http://alpha.example.com to http://example.org/' do
      get '/', {}, {'SERVER_NAME' => 'alpha.example.org'}
      last_response['Location'].should eql('http://example.org/')
    end

    it 'redirects from http://alpha.example.org/nate to http://example.org/nate' do
      get '/nate', {}, {'SERVER_NAME' => 'alpha.example.org'}
      last_response['Location'].should eql('http://example.org/nate')
    end

    it 'redirects from http://alpha.example.org/nate?trip_id=42 to http://example.org/nate?trip_id=42' do
      get '/nate', {:trip_id => 42}, {'SERVER_NAME' => 'alpha.example.org'}
      last_response['Location'].should eql('http://example.org/nate?trip_id=42')
    end
  end
end
