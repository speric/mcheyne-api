require 'sinatra'
require 'json'

PLAN = JSON.parse(File.read('plan.json')).freeze

get '/' do
  content_type :json

  mmdd = Time.now.strftime("%m%d")

  {
    "#{mmdd}" => PLAN[mmdd]
  }.to_json
end
