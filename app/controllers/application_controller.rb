class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, unless: :devise_controller?
  before_filter :load_realm!, unless: :devise_controller?
  before_filter :periods
  before_filter :clean_search_filter

  private

  def filter_and_pagination(model_class)
    @filters = model_class.order('created_at DESC').current_realm(@current_realm.id).search(params[:q])
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

  def load_realm!
    # try loading realm from param
    if params.has_key? :selected_realm
      @current_realm = Realm.active.find_by_slug params[:selected_realm]
      head :not_acceptable if @current_realm.nil?
    end

    # if realm not loaded and realm in session available
    if @current_realm.nil? and session.has_key?(:selected_realm)
      @current_realm = Realm.active.find_by_slug session[:selected_realm]
    end

    # if still nil, try loading default
    if @current_realm.nil?
      @current_realm = Realm.active.first
      head :service_unavailable if @current_realm.nil?
    end

    unless @current_realm.nil?
      session[:selected_realm] = @current_realm.slug
      logger.debug " -- REALM: #{@current_realm.inspect}"
    end
  end
end
