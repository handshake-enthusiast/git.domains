# frozen_string_literal: true

require './app'
require 'sidekiq/web'

use Rack::Session::Cookie, secret: SESSION_SECRET, httponly: true, secure: true, same_site: :lax, max_age: 86_400
use Rack::Protection
use Rack::Protection::SessionHijacking

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  Rack::Utils.secure_compare(Digest::SHA256.hexdigest(username), Digest::SHA256.hexdigest(SIDEKIQ_WEB_USERNAME)) &
    Rack::Utils.secure_compare(Digest::SHA256.hexdigest(password), Digest::SHA256.hexdigest(SIDEKIQ_WEB_PASSWORD))
end

run Rack::URLMap.new(
  '/' => Sinatra::Application,
  '/sidekiq' => Sidekiq::Web
)
