module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(username: params[:username])

        if user&.authenticate(params[:password])
          access_token, refresh_token = load_token(user)

          token = Token.create!(user:, access_token:, refresh_token:)

          res(token, message: "Login successful", as: :list)
        else
          render_error(message: "Wrong username or password!", status: :unauthorized)
        end
      end

      def refresh
        refresh_token = params[:refresh_token]
        token_record = Token.active.find_by(refresh_token:)

        if token_record
          decoded = JsonWebToken.decode(refresh_token)

          if decoded && decoded[:user_id] == token_record.user_id
            access_token, refresh_token = load_token(token_record.user)

            token_record.update!(access_token:, refresh_token:)

            res(token_record, message: "Refresh successful")
          else
            render_error(message: "Refresh token invalid!", status: :unauthorized)
          end
        else
          render_error(message: "Refresh token not found!", status: :unauthorized)
        end
      end

      def logout
        access_token = request.headers["Authorization"]&.split(" ")&.last
        token_record = Token.active.find_by(access_token:)

        if token_record
          token_record.update!(deleted_at: Time.current)

          res({}, message: "Logout successful")
        else
          render_error(message: "Token invalid!", status: :unauthorized)
        end
      end

      private

      def load_token(user)
        User.generate_tokens(user).values_at(:access_token, :refresh_token)
      end
    end
  end
end
