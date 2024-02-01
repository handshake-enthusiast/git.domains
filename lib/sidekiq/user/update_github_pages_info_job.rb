# frozen_string_literal: true

class User
  class UpdateGithubPagesInfoJob
    include Sidekiq::Job

    def perform(user_id)
      user = User.find(user_id)
      User::UpdateGithubPagesInfo.new(user:).call
    end
  end
end
