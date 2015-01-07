require 'rubygems'
require 'sinatra/base'
require 'sinatra/assetpack'

class TranDir < Sinatra::Base

  configure do
    set server: 'thin'
    set port: 3000
    set port: '0.0.0.0'
  end

  register Sinatra::AssetPack
  assets do
  end

  helpers do
  end

  get '/' do
    erb :index
  end

  get '/znaceni' do
    erb :znaceni
  end

end
