# frozen_string_literal: true

module GithubAPI
  module REST
    class Repo < Base
      def initialize(access_token:, owner:, repo:)
        super(access_token:)
        @owner = owner
        @repo = repo
      end

      private

      # https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository
      def path
        "/repos/#{@owner}/#{@repo}"
      end
    end
  end
end
