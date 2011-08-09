require 'sinatra/base'

class Preview < Sinatra::Base
  get '/' do
    'hi'
  end
end
