# Github Preview

## App on Heroku
[http://github-preview.herokuapp.com/](http://github-preview.herokuapp.com/)

## Preview script
Put this into your path at e.g. `~/bin/github-preview` and `chmod +x` it.<br/>
Then `github-preview someproject/Readme.markdown`


    #!/usr/bin/env ruby
    # open a given markdown file via github preview app
    raise "gime a file!!" unless ARGV[0]

    require 'cgi'
    content = File.read(ARGV[0])
    url = 'http://github-preview.herokuapp.com/'

    exec "open '#{url}/?text=#{CGI.escape content}&format=markdown'"

## Local development

    bundle
    bundle exec rspec spec
    bundle exec thin start
    open http://localhost:3000
