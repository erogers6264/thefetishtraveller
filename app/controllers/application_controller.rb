# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include Localizable
  include RemoteNavigation

  skip_forgery_protection
  layout "application"

  rescue_from StandardError do |error|
    raise error unless request.format.turbo_stream?

    close_modal
    replace :main, with: "errors/error", error: error
    default_render
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user&.admin?
  end

  def active_admin?
    params[:controller] =~ /^admin\//i
  end

  helper_method :current_user
  def current_user
    @current_user ||= session[:user_id].presence.then { |id| User.find_by(id: id) }.tap { |user| Sentry.set_user(user ? { username: user.slug } : {}) }
  end

  def message_verifier
    @message_verifier ||= ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def require_profile
    require_login
    redirect_to onboarding_path if current_user && !current_user.onboarded?
  end

  def paginated(scope, per: 10)
    scope = scope.page(params[:page]).per(per)
    replace "next-page-link", with: "components/pagination", items: scope, partial: params[:partial] if params[:page].to_i > 1
    scope
  end
end
