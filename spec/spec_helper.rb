# encoding: UTF-8

ENV['RACK_ENV'] = 'test'

require 'bundler'

Bundler.setup
Bundler.require

require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'

require_relative '../app'

class MiniTest::Spec
  include Rack::Test::Methods

  def api(method, path, params: {})
    response = send(method, path, params)
    if response.status == 200 && json = response.body
      return JSON.parse(response.body)
    end

    nil
  end
end

