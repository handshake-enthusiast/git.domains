# frozen_string_literal: true

class User
  class UpdateGithubPagesInfo
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def call
      if repo_response[:status] == 200 && repo_response[:body]['has_pages'] == true
        user.update(had_github_pages: true, had_custom_domain:, default_branch:)
      else
        user.update(had_github_pages: false)
      end
    end

    private

    def repo_response
      @repo_response ||= GithubAPI::REST::Repo.new(access_token:, owner:, repo:).call
    end

    def contents_response
      @contents_response ||= GithubAPI::REST::RepoContent.new(access_token:, owner:, repo:, path: 'CNAME').call
    end

    def had_custom_domain
      contents_response[:status] == 200
    end

    def default_branch
      repo_response[:body]['default_branch']
    end

    def access_token
      @access_token ||= user.access_token
    end

    def owner
      @owner ||= user.login
    end

    def repo
      @repo ||= "#{user.login}.github.io"
    end
  end
end
