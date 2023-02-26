# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :check_logged_in

  private

  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end
  helper_method :current_user

  def check_logged_in
    return if current_user

    redirect_to new_auth_session_path
  end
end
