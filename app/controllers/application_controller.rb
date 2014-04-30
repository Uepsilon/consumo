class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, unless: :devise_controller?
  before_filter :periods
  before_filter :clean_search_filter

  private

  def filter_and_pagination(model_class)
    @filters = model_class.order('created_at DESC').search(params[:q])
    result = @filters.result(distinct: true).paginate(page: params[:page])
    result = result.send(created_at_eq) unless created_at_eq.blank?

    result
  end

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

  def clean_search_filter
    if not params[:q].present?
      params[:q] = nil
    end
  end
end
