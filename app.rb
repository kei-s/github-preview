require 'sinatra/base'
require 'haml'

class Preview < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views'
  get '/' do
    haml :index
  end
end
