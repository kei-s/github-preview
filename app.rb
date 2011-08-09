require 'sinatra/base'
require 'haml'
require 'github/markup'

class Preview < Sinatra::Base
  set :views,  File.dirname(__FILE__) + '/views'
  set :public, File.dirname(__FILE__) + '/public'
  get '/' do
    haml :index
  end

  post '/render' do
    format = params[:format]
    data = params[:data]
    GitHub::Markup.render("tmp.#{format}", data)
  end
end
