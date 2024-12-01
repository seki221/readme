
class DatesController < ApplicationController
  def show
    if params[:date].present?
      begin
        @date = Date.parse(params[:date])
      rescue ArgumentError
        @date = Date.today
      end
    else
      @date = Date.today
    end
end
