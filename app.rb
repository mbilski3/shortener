# frozen_string_literal: true

require 'sinatra'
require 'securerandom'
require 'redis'

configure do
  uri = URI.parse(ENV['REDIS_URL'])
  $redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
end

get '/' do
  erb :index
end

post '/' do
  @rand = SecureRandom.hex(4)
  $redis.set(@rand, params[:url])
  erb :result
end

get '/:rand' do
  redirect $redis.get(params[:rand])
end
