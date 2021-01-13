class ApplicationController < ActionController::Base
  before_action :load_github_api

  def load_github_api
    json = GithubService.get_contributors
    @contributors = json.map do |contributor_data|
      Contributor.new(contributor_data)
    end
  end

end
