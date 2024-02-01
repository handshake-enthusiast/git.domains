# frozen_string_literal: true

module GithubHelpers
  def create_repo_url(login)
    'https://github.com/new?' \
      "owner=#{login}&" \
      "template_owner=#{TEMPLATE_OWNER}&" \
      "template_name=#{TEMPLATE_NAME}&" \
      "name=#{login}.github.io&" \
      "description=My+#{login}.#{DOMAIN}+site&" \
      'visibility=public'
  end

  def create_cname_file_url(login, branch)
    "https://github.com/#{login}/#{login}.github.io/new/#{branch || 'main'}" \
      "?filename=CNAME&value=#{login}.#{DOMAIN}"
  end
end
