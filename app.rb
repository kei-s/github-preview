require 'bundler/setup'
require 'sinatra/base'
require 'haml'
require 'github/markup'

class Preview < Sinatra::Base
  set :views,  File.dirname(__FILE__) + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'
  get '/' do
    haml :index
  end

  post '/render' do
    format = params[:format]
    data = params[:data]
    GitHub::Markup.render("tmp.#{format}", data)
  end

  get '/help/:format' do
    format = params[:format]
    file = "help/help.#{format}"
    GitHub::Markup.render(file, File.read(file))
  end
end
