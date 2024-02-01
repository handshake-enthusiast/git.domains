# frozen_string_literal: true

module GithubAPI
  module REST
    class RepoContent < Base
      def initialize(access_token:, owner:, repo:, path: nil)
        super(access_token:)
        @owner = owner
        @repo = repo
        @path = path
      end

      private

      # https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28#get-repository-content
      def path
        "/repos/#{@owner}/#{@repo}/contents/#{@path}"
      end
    end
  end
end
