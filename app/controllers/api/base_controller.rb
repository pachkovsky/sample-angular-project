class Api::BaseController < ApplicationController
  before_filter :authenticate_user!

  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_not_found


  def current_user
    @current_user ||= current_session.try(&:user)
  end
  helper_method :current_user

  protected
  def authenticate_user!
    unless current_user
      render json: nil, status: :unauthorized
    end
  end

  def current_session
    @current_session ||= Session.where(token: session_token).first
  end

  def session_token
    request.headers['X-Toptal-Secret']
  end

  def render_not_found
    render json: nil, status: :not_found
  end
end
