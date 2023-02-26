# frozen_string_literal: true

module Auth
  class SessionsController < ApplicationController
    skip_before_action :check_logged_in, only: %i[new create]

    def new; end

    def create
      user = User.find_or_create_by(email: omniauth_params.info.email) do |new_user|
        new_user.name = omniauth_params.info.name
      end

      session[:user_id] = user.id

      redirect_to root_path
    end

    def destroy
      session.delete(:user_id)

      redirect_to root_path
    end

    private

    def omniauth_params
      request.env['omniauth.auth']
    end
  end
end
