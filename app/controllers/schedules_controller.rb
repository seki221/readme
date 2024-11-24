class SchedulesController < ApplicationController
  def index
  end

  def new
    @schedule = Schedule.new
  end
end
