# frozen_string_literal: true

require_relative 'constants'
require 'net/http'
require 'json'

require_relative 'db/init'
require_relative 'helpers/github_helpers'
require_relative 'models/user'
require_relative 'services/github/oauth/access_token'
require_relative 'services/github_api/rest/base'
require_relative 'services/github_api/rest/user'
require_relative 'services/github_api/rest/repo'
require_relative 'services/github_api/rest/repo_content'
require_relative 'services/user/create_or_update'
require_relative 'services/user/update_github_pages_info'
require_relative 'services/varo/add_record'

require 'sidekiq'
require_relative 'sidekiq/user/update_github_pages_info_job'
require_relative 'sidekiq/varo/add_record_job'
