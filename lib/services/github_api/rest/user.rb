# frozen_string_literal: true

module GithubAPI
  module REST
    class User < Base
      private

      # https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28#get-the-authenticated-user
      def path
        '/user'
      end
    end
  end
end
