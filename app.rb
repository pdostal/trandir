require 'rubygems'
require 'sinatra'

configure dset :server, 'thin'
  set port: 3000
  set port: '0.0.0.0'
enhelpers do
enget '/' derb :index
enget '/znaceni' derb :znaceni
end
