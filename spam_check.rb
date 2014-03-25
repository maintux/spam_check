require 'sinatra'
require 'digest/sha1'
require 'json'

before do
  error 401 unless env['HTTP_AUTHORIZATION'].eql?("Token token=\"#{Digest::SHA1.hexdigest('RequestToken')}\"")
end

post '/filter' do
  content_type :json
  if request.accept?('application/json')
    if params[:email] and not params[:email].eql?""
      params[:email] = params[:email].gsub(' ','+')
      score = `echo #{params[:email]} | base64 -d | spamassassin -t | grep X-Spam-Status | cut -d' ' -f3 | cut -d= -f2`.to_f
      return {:success => true, :score => score }.to_json
    else
      return {:success => false, :message => 'Invalid Email' }.to_json
    end
  else
    return {:success => false, :message => 'Invalid Request' }.to_json
  end
end
