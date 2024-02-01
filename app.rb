# frozen_string_literal: true

require 'sinatra'
require './lib/initializer'

set :session_secret, SESSION_SECRET
helpers GithubHelpers

get '/' do
  @cta_link =
    if session[:user_id]
      '/domain'
    else
      "https://github.com/login/oauth/authorize?client_id=#{GITHUB_OAUTH_CLIENT_ID}"
    end
  erb :landing
end

get '/github/callback' do
  redirect to('/domain') if session[:user_id]
  token_data = Github::OAuth::AccessToken.new(code: params['code']).call[:body]

  if token_data.key?('access_token')
    user = User::CreateOrUpdate.new(access_token: token_data['access_token']).call
    session[:user_id] = user.id
    session[:user_login] = user.login
    redirect to('/domain')
  else
    erb "Unable to exchange code #{params['code']} for token."
  end
end

get '/domain' do
  redirect to('/') unless session[:user_id]

  @login = session[:user_login]
  erb :domain
end

get '/hosting' do
  redirect to('/') unless session[:user_id]

  user = User.find(session[:user_id])
  @login = user.login
  @had_github_pages = user.had_github_pages
  @had_custom_domain = user.had_custom_domain
  @default_branch = user.default_branch

  erb :hosting
end

get '/access' do
  redirect to('/') unless session[:user_id]

  @login = session[:user_login]
  erb :access
end

get '/success' do
  redirect to('/') unless session[:user_id]

  @login = session[:user_login]
  erb :success
end
