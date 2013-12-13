$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require 'vote'
require 'erubis'

set :erb, :escape_html => true

get '/' do
  @vote = Vote.new
  erb :vote
end

post '/' do
  @vote = Vote.new.tap do |v|
    v.name   = params[:name]
    v.reason = params[:reason]
  end

  if @vote.valid?
    @vote.save
    erb :voted
  else
    logger.warn "Invalid vote: '#{@vote.name}' '#{@vote.reason}'"
    erb :vote
  end
end

get '/ranking' do
  @votes = Vote.list
  erb :ranking
end
