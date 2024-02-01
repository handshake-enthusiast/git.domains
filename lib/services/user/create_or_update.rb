# frozen_string_literal: true

class User
  class CreateOrUpdate
    attr_reader :access_token

    def initialize(access_token:)
      @access_token = access_token
    end

    def call
      user = User.find(id)
      if user.nil?
        user = User.create(id:, login:, access_token:)
        Varo::AddRecordJob.perform_async(login)
        if user_response['public_repos'].zero?
          user.update(had_github_pages: false)
        else
          User::UpdateGithubPagesInfoJob.perform_async(user.id)
        end
      else
        user.update(access_token:)
      end
      user
    end

    private

    def user_response
      @user_response ||= GithubAPI::REST::User.new(access_token:).call[:body]
    end

    def id
      @id ||= user_response['id']
    end

    def login
      @login ||= user_response['login']
    end
  end
end
