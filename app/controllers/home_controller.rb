class HomeController < ApplicationController
  # skip_before_action :require_login, only: %i[top]

  def top
    @planners = Planner.order(created_at: :desc).limit(5)
  end

end