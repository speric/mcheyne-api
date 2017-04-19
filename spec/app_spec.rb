require_relative './spec_helper.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "my example app" do
  it "should render JSON" do
    data = api :get, '/'

    assert_equal 200, last_response.status

    keys = %w(family secret mmdd)
    assert_equal keys, data.keys
  end
end
