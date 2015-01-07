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
    serve '/js', :from => 'public/js'
    serve '/css', :from => 'public/css'
    serve '/css/skeleton', :from => 'public/css/skeleton/css'

    js :application, [
      'js/*.js'
    ]

    css :application, [
      '/css/skeleton/*.css',
      '/css/*.css'
    ]

    js_compression :jsmin
    css_compression :sass
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
