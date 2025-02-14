# frozen_string_literal: true

module API
  module V1
    class SessionsController < APIController
      before_action :require_login, except: :create

      def create
        user = User.create!
        session = user.sessions.create! user_agent: request.user_agent
        render json: session
      end

      def show
        render json: current_session
      end

      def update
        user = nil
        if params[:email].present?
          email = params.require(:email)
          password = params.require(:password)
          user = User.find_by(email: email)&.authenticate(password)
        elsif params[:facebook_token].present?
          user = User.authenticate_facebook(params[:facebook_token])
        end
        if user
          current_user.migrate_to(user)
          current_session.update! user: user
          render json: current_session
        else
          head :unprocessable_entity
        end
      end
    end
  end
end
