class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, unless: :devise_controller?
  before_filter :periods

  private

  def periods
    @periods = {"Heute" => "today", "Gestern" => "yesterday", "Die letzten 7 Tage" => "past_week", "Die letzten 14 Tage" => "past_fortnight"}
  end

  def created_at_eq
    if params[:q].present? && params[:q].any? && params[:q][:created_at_eq].in?(@periods.values)
      @period_value = params[:q][:created_at_eq]
    else
      @period_value = ''
    end
    @period_value
  end
end
