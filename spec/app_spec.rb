require_relative './spec_helper.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET /" do
  it "should render JSON" do
    data = api :get, '/'

    assert_equal 200, last_response.status

    keys = %w(family secret mmdd)
    assert_equal keys, data.keys
  end
end

describe "GET /:mm/:dd" do

  it "should accept a date" do
    data = api :get, '/04/22'

    assert_equal 200, last_response.status

    assert_equal '0422', data['mmdd']
  end

  it "should return 404 for invalid dates" do
    data = api :get, '/04/31'

    assert_equal 404, last_response.status
  end
end
