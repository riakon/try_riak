require 'sinatra'
require 'sinatra/json'
require 'optparse'
require 'coffee-script'
require 'slim'

# p ARGV

set :public_folder, File.dirname(__FILE__) + '/static'

Dir.glob('views/*.coffee').each do |cs|
  cn = cs.scan(/([^\/]*?)\.coffee/).first.first
  get "/js/#{cn}.js" do
    content_type "text/javascript"
    coffee cn.to_sym
  end
end
Dir.glob('views/*.scss').each do |cs|
  cn = cs.scan(/([^\/]*?)\.scss/).first.first
  get "/css/#{cn}.css" do
    content_type "text/css"
    scss cn.to_sym
  end
end

get "/" do
  slim :index
end

# use the session to connect to their own server
get "/message.json" do
  content_type "application/json"

  message = params[:message].to_s.strip

  json({message:''}) and return if message == ''

  base_url = 'http://206.125.175.38:8091'
  resp_message = {message: riak_req(base_url, message)}

  json resp_message
end

def riak_req(url, command)
  parse(command)
  `curl -s -X#{command} 2>&1`
end

def parse(command)
  command
end
