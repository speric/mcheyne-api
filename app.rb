require 'sinatra'
require 'json'

PLAN = JSON.parse(File.read('plan.json')).freeze

get '/' do
  content_type :json

  mmdd = Time.now.strftime("%m%d")

  deliver mmdd
end

get '/:mm/:dd' do
  mm = params[:mm].rjust(2, '0')
  dd = params[:dd].rjust(2, '0')

  deliver(mm + dd)
end

def deliver(mmdd)
  data = PLAN[mmdd]

  halt(404) unless data

  data.merge(
    mmdd: mmdd
  ).to_json
end
