require File.dirname(__FILE__) + '/spec_helper'

describe "rack-redirect" do
  it 'redirects from http://example.org to http://www.example.org/' do
    get '/'
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
