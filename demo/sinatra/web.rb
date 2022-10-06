require 'sinatra'
set :bind, '0.0.0.0'

get '/ping' do
  'PONG'
end
