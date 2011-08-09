require 'sinatra/base'
require 'haml'

class Preview < Sinatra::Base
  set :views,  File.dirname(__FILE__) + '/views'
  set :public, File.dirname(__FILE__) + '/public'
  get '/' do
    haml :index
  end
end
